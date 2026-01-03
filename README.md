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

📋 Kapsanan Hastalıklar, Parametreler ve Tıbbi Mantık
 Bu projede kullanılan yapay zeka modeli, NHANES (National Health and Nutrition Examination Survey) veri tabanından elde edilen 48.932 gerçek hasta kaydı üzerinde eğitilmiştir.

    Modelin sınıflandırma mantığı (Labeling Logic), Guyton & Hall Textbook of Medical Physiology ve WHO (Dünya Sağlık Örgütü) kılavuzları referans alınarak oluşturulan kural tabanlı algoritmalarla belirlenmiştir. Aşağıdaki tabloda, modelin tespit edebildiği temel hastalık sınıfları ve bu kararı verirken baz aldığı kritik eşik değerleri yer almaktadır:
        | Parametre | Açıklama | Normal Aralık | Kritik Eşikler ve İlişkili Durumlar |
    | :--- | :--- | :--- | :--- |
    | **HGB** | Hemoglobin | 12.0 - 16.0 | < 11 (Anemi) |
    | **MCV** | Ortalama Alyuvar Hacmi | 80 - 100 | < 75 (Demir Eks.), > 105 (B12 Eks.) |
    | **WBC** | Lökosit (Beyaz Kan) | 4.000 - 10.000 | > 12.000 (Enfeksiyon), > 30.000 (Lösemi Riski) |
    | **PLT** | Trombosit | 150 - 450 | < 100 (Trombositopeni/Siroz) |
    | **Ferritin** | Demir Deposu | 60 - 140 | < 20 (Demir Eksikliği) |
    | **B12** | Vitamin B12 | 300 - 700 | < 150 (B12 Eksikliği) |
    | **Folic_Acid** | Folik Asit | 6 - 14 | *(Düşüklüğü Anemi ile ilişkilendirilir)* |
    | **Vit_D** | D Vitamini | 20 - 60 | < 15 (Eksiklik) |
    | **ALT** | Karaciğer Enzimi | 15 - 35 | > 100 (Hepatit/Yağlanma) |
    | **AST** | Karaciğer Enzimi | 15 - 35 | > 100 (Hepatit) |    
    | **GGT** | Safra Yolu Enzimi | 20 - 40 | > 60 (Yağlanma) |
    | **Bilirubin** | Sarılık Değeri | 0.4 - 1.2 | > 2.0 (Hepatit/Siroz) |
    | **Urea** | Üre | 20 - 40 | > 80 (Böbrek Yetmezliği) |
    | **Creatinine** | Kreatinin | 0.7 - 1.1 | > 2.0 (Böbrek Yetmezliği) |
    | **GFR** | Böbrek Süzme Hızı | 80 - 120 | < 50 (Böbrek Yetmezliği) |
    | **Albumin** | Protein | 3.5 - 5.5 | < 3.0 (Siroz) |
    | **Sodium** | Sodyum | 136 - 144 | > 146 (Dehidrasyon) |
    | **Potassium** | Potasyum | 3.6 - 4.8 | *(Kalp ritmi için kritik)* |
    | **Glucose** | Açlık Kan Şekeri | 70 - 110 | > 180 (Diyabet), < 60 (Hipoglisemi) |
    | **HbA1c** | 3 Aylık Şeker | 4.0 - 6.0 | > 7.0 (Diyabet) |
    | **Insulin** | İnsülin Direnci | 6 - 14 | *(Yüksekliği İnsülin Direnci belirtisidir)* |
    | **TSH** | Tiroid Uyarıcı | 1.0 - 3.0 | > 6 (Hipotiroidi), < 0.3 (Hipertiroidi) |
    | **T3** | Serbest T3 | 2.7 - 4.3 | <2.5(Hipotroid), >5.0(Hipertroid)|
    | **T4** | Serbest T4 | 0.8 - 1.6 | < 0.8 (Hipotroid), > 2.0 (Hipertroid) |
    | **Anti_TPO** | Haşimato Belirteci | 0 (Negatif) | 1 (Pozitif ise Otoimmün Risk) |
    | **Troponin** | Kalp Kriz Markeri | 0 - 0.04 | > 0.5 (Kalp Krizi Riski) |
    | **BNP** | Kalp Yetmezliği | 30 - 70 | > 400 (Kalp Yetmezliği) |
    | **LDL** | Kötü Kolesterol | 60 - 140 | *(Yüksekliği kalp damar riski)* |
    | **D_Dimer** | Pıhtılaşma | 100 - 300 | > 600 (Emboli/DVT) |
    | **aPTT** | Pıhtılaşma Süresi | 24 - 36 | >50 (Hemofili, Pıhtılaşma Bozukluğu)|
    | **CRP** | C-Reaktif Protein | 0 - 5 | > 20 (Bakteriyel Enfeksiyon) |
    | **ESR** | Sedimantasyon | 0 - 20 | > 40 (Romatizma/Lupus) |
    | **Procalcitonin**| Ciddi Enfeksiyon | 0 - 0.1 | > 0.5 (Bakteriyel Sepsis) |
    | **RF** | Romatoid Faktör | 0 (Negatif) | 1 (Romatoid Artrit) |
    | **ANA** | Lupus Testi | 0 (Negatif) | 1 (Lupus) |
    | **HBsAg** | Hepatit B Testi | 0 (Negatif) | 1 (Hepatit B) |
    | **Anti_HIV** | HIV Testi | 0 (Negatif) | 1 (Pozitif) |

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

⚠️ Yasal Uyarı (Disclaimer)

Bu uygulama yalnızca bilgilendirme ve eğitim amaçlıdır. Kesinlikle tıbbi teşhis veya tedavi yerine geçmez.

    Uygulamanın sunduğu sonuçlar yapay zeka tabanlı bir tahmindir ve hata payı içerebilir.

    Kendinizi iyi hissetmiyorsanız veya değerlerinizde anormallik görüyorsanız lütfen bir sağlık kuruluşuna veya uzman bir doktora başvurunuz.

Geliştiriciler: Burak EROL Berkay SEKİTMEN
