🏥 AI Health Predictor (Yapay Zeka Destekli Sağlık Tahmincisi)

AI Health Predictor, kullanıcıların detaylı kan tahlili ve sağlık verilerini girerek potansiyel sağlık risklerini analiz etmelerini sağlayan, Flutter ile geliştirilmiş bir mobil uygulamadır. Uygulama, cihaz üzerinde çalışan (on-device) bir TensorFlow Lite (TFLite) modeli kullanarak verileri işler ve kullanıcıya bir sağlık skoru ile birlikte olası hastalık tahminleri sunar.
🌟 Özellikler

    Yapay Zeka Destekli Analiz: Eğitilmiş TFLite modeli sayesinde girilen verileri anlık olarak analiz eder.

    Kapsamlı Veri Girişi: 4 farklı aşamada toplam 30+ farklı sağlık parametresi (Hemoglobin, B12, İnsülin Direnci, vb.) işlenir.

    Akıllı Skorlama Sistemi: Hastalıkların tıbbi ciddiyetine göre ağırlıklandırılmış (Severity Weights) özel bir algoritma ile 0-100 arası sağlık skoru hesaplar.

    Kullanıcı Dostu Arayüz: Her bir tıbbi terim için bilgilendirme kutucukları (Tooltip) içerir; böylece kullanıcılar neyi girdiklerini bilirler.

    Eksik Veri Yönetimi: Kullanıcının elinde olmayan veriler için varsayılan ortalama değer önerileri sunar.

    Çevrimdışı Çalışma: Model cihaz üzerinde çalıştığı için internet bağlantısına ihtiyaç duymaz ve veri gizliliği sağlar.

📱 Uygulama Akışı ve Ekranlar

Uygulama 4 ana test ekranı ve bir sonuç ekranından oluşur:

    Temel Kan Değerleri: Hemoglobin, MCV, Lökosit, Trombosit, Ferritin, B12, Folik Asit, D Vitamini.

    Organ Fonksiyonları: Karaciğer enzimleri (ALT, AST, GGT), Böbrek değerleri (Üre, Kreatinin, GFR), Elektrolitler.

    Metabolik & Hormonal Değerler: Şeker (Açlık, HbA1c), İnsülin Direnci, Tiroid (TSH, T3, T4).

    Spesifik Belirteçler: Kalp krizi markerları, Kolesterol, Enfeksiyon (CRP, Sedimantasyon), Bağışıklık testleri (HIV, Hepatit vb.).

    Sonuç Ekranı: Tahmin edilen durum, güven oranı (%), sağlık skoru ve durum değerlendirmesi.

🛠 Kullanılan Teknolojiler ve Paketler

Bu proje aşağıdaki teknolojiler ve Flutter paketleri kullanılarak geliştirilmiştir:

    Flutter: UI Geliştirme Kiti.

    tflite_flutter: TensorFlow Lite modellerini çalıştırmak için.

    flutter_native_splash: Özel açılış ekranı (Splash Screen) için.

    flutter_launcher_icons: Uygulama ikonlarını yapılandırmak için.

🚀 Kurulum ve Çalıştırma

Projeyi yerel ortamınızda çalıştırmak için aşağıdaki adımları izleyin:

    Projeyi Klonlayın:
    Bash
    git clone https://github.com/kullaniciadi/ai_health_predictor.git cd ai_health_predictor


Bağımlılıkları Yükleyin:
Bash

flutter pub get

Varlıkların (Assets) Yüklendiğinden Emin Olun: pubspec.yaml dosyasında assets/ klasörünün tanımlı olduğundan ve health_model.tflite ile model_metadata.json dosyalarının bu klasörde bulunduğundan emin olun.

Uygulamayı Başlatın:
Bash

    flutter run

📂 Proje Yapısı

lib/
├── main.dart             # Uygulamanın giriş noktası ve ana sayfa
├── health_predictor.dart # TFLite model yükleme, tahmin ve skorlama mantığı
├── result_view.dart      # Sonuçların gösterildiği ekran
├── test_view_1.dart      # Veri girişi: Sayfa 1 (Temel Kan)
├── test_view_2.dart      # Veri girişi: Sayfa 2 (Organlar)
├── test_view_3.dart      # Veri girişi: Sayfa 3 (Hormonlar)
└── test_view_4.dart      # Veri girişi: Sayfa 4 (Spesifik Testler)
assets/
├── health_model.tflite   # Eğitilmiş yapay zeka modeli
├── model_metadata.json   # Model için normalizasyon verileri (mean/scale)
└── logo.png              # Uygulama görselleri

⚠️ Yasal Uyarı (Disclaimer)

Bu uygulama yalnızca bilgilendirme ve eğitim amaçlıdır. Kesinlikle tıbbi teşhis veya tedavi yerine geçmez.

    Uygulamanın sunduğu sonuçlar yapay zeka tabanlı bir tahmindir ve hata payı içerebilir.

    Kendinizi iyi hissetmiyorsanız veya değerlerinizde anormallik görüyorsanız lütfen bir sağlık kuruluşuna veya uzman bir doktora başvurunuz.

Geliştiriciler: Burak EROL Berkay SEKİTMEN