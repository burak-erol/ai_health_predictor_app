import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:tflite_flutter/tflite_flutter.dart';

class HealthPredictor {
  Interpreter? _interpreter;
  List<String>? _labels;
  List<double>? _means;
  List<double>? _scales;

  // Hastalıkların tıbbi ciddiyet katsayıları (0.0: Hafif, 1.0: Çok Kritik)
  // İndeksler model_metadata.json dosyasındaki sıralama ile birebir aynıdır.
  final Map<int, double> _severityWeights = {
    0: 0.40, // B12 Eksikligi Anemisi
    1: 0.90, // Bobrek Yetmezligi
    2: 0.20, // D Vitamini Eksikligi
    3: 0.85, // DVT/Emboli
    4: 0.50, // Dehidrasyon
    5: 0.40, // Demir Eksikligi Anemisi
    6: 0.70, // Diyabet
    7: 0.60, // Enfeksiyon (Bakteriyel)
    8: 0.50, // Enfeksiyon (Viral)
    9: 0.80, // Hepatit
    10: 0.55, // Hipertiroidi
    11: 0.65, // Hipoglisemi
    12: 0.55, // Hipotiroidi
    13: 0.98, // Kalp Krizi Riski
    14: 0.95, // Kalp Yetmezligi
    15: 0.50, // Karaciger Yaglanmasi
    16: 0.98, // Losemi Suphesi
    17: 0.80, // Lupus (SLE)
    18: 0.85, // PIhtilasma Bozuklugu (Hemofili)
    19: 0.60, // Romatoid Artrit
    20: 0.00, // Saglikli
    21: 0.95, // Siroz
    22: 0.75, // Trombositopeni
  };

  /// Modeli ve gerekli metadata parametrelerini yükler.
  Future<void> loadModel() async {
    try {
      // TFLite modelini yükle
      _interpreter = await Interpreter.fromAsset('assets/health_model.tflite');

      // JSON metadata dosyasını oku
      String jsonString = await rootBundle.loadString(
        'assets/model_metadata.json',
      );
      Map<String, dynamic> metadata = json.decode(jsonString);

      _labels = List<String>.from(metadata['labels']);
      _means = List<double>.from(metadata['mean']);
      _scales = List<double>.from(metadata['scale']);

      print("Sağlık modeli ve geliştirilmiş puanlama sistemi yüklendi.");
    } catch (e) {
      print("Model yükleme hatası: $e");
    }
  }

  /// Verilen ham kan değerlerini işler ve sonuç Map'ini döndürür.
  Map<String, dynamic> predict(List<double> rawInput) {
    if (_interpreter == null || _labels == null) {
      return {
        "label": "Hata",
        "score": 0,
        "status": "Model henüz yüklenmedi.",
        "isHealthy": false,
      };
    }

    // 1. Veri Normalizasyonu (Z-Score)
    var input = List<double>.filled(rawInput.length, 0);
    for (int i = 0; i < rawInput.length; i++) {
      input[i] = (rawInput[i] - _means![i]) / _scales![i];
    }

    // 2. Tensör Hazırlığı
    var inputBuffer = [input];
    var outputBuffer = List<double>.filled(23, 0).reshape([1, 23]);

    // 3. Tahmin İşlemi
    _interpreter!.run(inputBuffer, outputBuffer);
    List<double> results = outputBuffer[0];

    // 4. En Yüksek Olasılıklı Sınıfı Bul (Argmax)
    double maxProb = -1.0;
    int maxIndex = -1;
    for (int i = 0; i < results.length; i++) {
      if (results[i] > maxProb) {
        maxProb = results[i];
        maxIndex = i;
      }
    }

    // 5. Kesinleştirilmiş Sağlık Skoru Mantığı
    String predictedLabel = _labels![maxIndex];
    double finalScore;

    if (predictedLabel == "Saglikli") {
      // Eğer modelin teşhisi "Sağlıklı" ise puan doğrudan 100'dür.
      finalScore = 100.0;
    } else {
      // Eğer bir hastalık teşhisi varsa:
      // Puan = 100 - (Hastalık Olasılığı * Ciddiyet Katsayısı * 100)
      double severity = _severityWeights[maxIndex] ?? 0.5;
      double penalty = (maxProb * severity) * 100;
      finalScore = 100 - penalty;
    }

    // Skoru 0-100 arasına sabitle
    finalScore = finalScore.clamp(0, 100);

    return {
      "label": predictedLabel,
      "score": finalScore.toInt(),
      "confidence": (maxProb * 100).toStringAsFixed(1),
      "status": _getScoreMessage(finalScore),
      "isHealthy": predictedLabel == "Saglikli",
    };
  }

  /// Puan değerine göre kullanıcı dostu durum mesajı döner.
  String _getScoreMessage(double score) {
    if (score >= 95) return "Tebrikler, çok sağlıklı görünüyorsunuz!";
    if (score >= 80) return "Sağlık durumunuz gayet iyi.";
    if (score >= 65)
      return "Genel olarak iyisiniz, ancak değerlerinizi takip edin.";
    if (score >= 45)
      return "Bazı riskli değerler saptandı, yaşam tarzınızı gözden geçirin.";
    if (score >= 25)
      return "Önemli sapmalar var, bir sağlık kuruluşuna başvurmanız önerilir.";
    return "Ciddi risk saptandı, lütfen vakit kaybetmeden muayene olun.";
  }

  /// Kaynakları kapatır.
  void dispose() {
    _interpreter?.close();
  }
}
