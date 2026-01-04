import 'package:flutter/material.dart';
import 'package:health_score_app/health_predictor.dart';
import 'package:health_score_app/result_view.dart';

class TestView4 extends StatefulWidget {
  const TestView4({
    super.key,
    required this.userHealthData,
    required this.vitaminD,
  });

  final List<double> userHealthData;
  final double vitaminD;

  @override
  State<TestView4> createState() => _TestView4State();
}

class _TestView4State extends State<TestView4> {
  final healthPredictor = HealthPredictor();
  final _formKey = GlobalKey<FormState>();

  // Kontrolcüler
  final TextEditingController heartAttackMarkerController =
      TextEditingController();
  final TextEditingController heartFailureController = TextEditingController();
  final TextEditingController badCholesterolController =
      TextEditingController();
  final TextEditingController clottingController = TextEditingController();
  final TextEditingController bloodClottingTimeController =
      TextEditingController();
  final TextEditingController cReactiveProteinController =
      TextEditingController();
  final TextEditingController sedimentationController = TextEditingController();
  final TextEditingController severeInfectionController =
      TextEditingController();
  final TextEditingController rheumatoidFactorController =
      TextEditingController();
  final TextEditingController lupusTestController = TextEditingController();
  final TextEditingController hepatitisBTestController =
      TextEditingController();
  final TextEditingController hivTestController = TextEditingController();

  // Bilgi metinleri sözlüğü
  final Map<String, String> _infoTexts = {
    'Kalp Kriz Markeri':
        'Troponin gibi değerlerdir. Kalp kasında bir hasar veya zorlanma olup olmadığını gösterir.\n\nTest Sonuçlarınız arasında böyle bir parametre yoksa, sonucun doğruluğu için lütfen 0 - 0.04 aralığında bir değer giriniz.',
    'Kalp Yetmezliği':
        'BNP veya NT-proBNP belirteçleridir. Kalbin pompalama gücünü ve kalp üzerindeki baskıyı ölçer.\n\nTest Sonuçlarınız arasında böyle bir parametre yoksa, sonucun doğruluğu için lütfen 30 - 70 aralığında bir değer giriniz.',
    'Kötü Kolesterol':
        'LDL kolesteroldür. Damar duvarlarında birikerek kalp ve damar hastalıkları riskini artıran değerdir.\n\nTest Sonuçlarınız arasında böyle bir parametre yoksa, sonucun doğruluğu için lütfen 60 - 140 aralığında bir değer giriniz.',
    'Pıhtılaşma':
        'D-Dimer gibi testlerdir. Kandaki pıhtı oluşumunu veya pıhtılaşma riskini saptamak için kullanılır.\n\nTest Sonuçlarınız arasında böyle bir parametre yoksa, sonucun doğruluğu için lütfen 100 - 300 aralığında bir değer giriniz.',
    'Pıhtılaşma Süresi':
        'PT, aPTT veya INR değerleridir. Kanın ne kadar sürede pıhtılaştığını ve kan sulandırıcı ihtiyacını gösterir.\n\nTest Sonuçlarınız arasında böyle bir parametre yoksa, sonucun doğruluğu için lütfen 24 - 36 aralığında bir değer giriniz.',
    'CRP':
        'C-Reaktif Protein. Vücuttaki enfeksiyon, iltihaplanma veya doku hasarının genel bir göstergesidir.\n\nTest Sonuçlarınız arasında böyle bir parametre yoksa, sonucun doğruluğu için lütfen 0 - 5 aralığında bir değer giriniz.',
    'Sedimantasyon':
        'Alyuvarların çökme hızıdır. Enfeksiyonlar, romatizmal hastalıklar ve kronik iltihaplanmalarda yükselir.\n\nTest Sonuçlarınız arasında böyle bir parametre yoksa, sonucun doğruluğu için lütfen 0 - 20 aralığında bir değer giriniz.',
    'Ciddi Enfeksiyon':
        'Prokalsitonin gibi spesifik belirteçlerdir. Genellikle ciddi bakteriyel enfeksiyonların veya sepsisin tespitinde kullanılır.\n\nTest Sonuçlarınız arasında böyle bir parametre yoksa, sonucun doğruluğu için lütfen 0 - 0.1 aralığında bir değer giriniz.',
    'Romatoid Faktör':
        'Bağışıklık sisteminin eklemlere saldırdığı romatizmal hastalıkların (RA gibi) taramasında kullanılan bir antikordur.\n\nTest Sonuçlarınız arasında böyle bir parametre yoksa, sonucun doğruluğu için lütfen 0 (Negatif) aralığında bir değer giriniz.',
    'Lupus Testi':
        'ANA gibi otoimmün testlerdir. Bağışıklık sisteminin kendi hücrelerine saldırıp saldırmadığını anlamaya yardımcı olur.\n\nTest Sonuçlarınız arasında böyle bir parametre yoksa, sonucun doğruluğu için lütfen 0 (Negatif) aralığında bir değer giriniz.',
    'Hepatit B':
        'HBsAg veya Anti-HBs gibi testlerdir. Karaciğere saldıran Hepatit B virüsünün varlığını veya bağışıklık durumunu gösterir.\n\nTest Sonuçlarınız arasında böyle bir parametre yoksa, sonucun doğruluğu için lütfen 0 (Negatif) aralığında bir değer giriniz.',
    'HIV':
        'Bağışıklık sistemini etkileyen HIV virüsünün tespiti için yapılan tarama testidir.\n\nTest Sonuçlarınız arasında böyle bir parametre yoksa, sonucun doğruluğu için lütfen 0 (Negatif) aralığında bir değer giriniz.',
  };

  @override
  void initState() {
    super.initState();
    healthPredictor.loadModel();
  }

  @override
  void dispose() {
    heartAttackMarkerController.dispose();
    heartFailureController.dispose();
    badCholesterolController.dispose();
    clottingController.dispose();
    bloodClottingTimeController.dispose();
    cReactiveProteinController.dispose();
    sedimentationController.dispose();
    severeInfectionController.dispose();
    rheumatoidFactorController.dispose();
    lupusTestController.dispose();
    hepatitisBTestController.dispose();
    hivTestController.dispose();
    super.dispose();
  }

  // Bilgi penceresini gösteren yardımcı metod
  void _showInfo(String title) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(_infoTexts[title] ?? 'Bilgi bulunamadı.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Tamam'),
          ),
        ],
      ),
    );
  }

  // TextFormField oluşturan yardımcı metod
  Widget _buildField({
    required TextEditingController controller,
    required String label,
    required String infoTitle,
  }) {
    final height = MediaQuery.sizeOf(context).height;
    final verticalPadding = height < 700 ? 6.0 : 7.0;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: verticalPadding),
      child: Card(
        elevation: 4,
        shadowColor: Color(0xFF18B6B0),
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        child: TextFormField(
          controller: controller,
          keyboardType: TextInputType.number,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Lütfen bu alanı doldurun';
            }
            return null;
          },
          decoration: InputDecoration(
            labelText: label,
            labelStyle: const TextStyle(color: Colors.black87),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(14)),
            ),
            enabledBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(14)),
              borderSide: BorderSide(color: Color(0xFF18B6B0), width: 0.5),
            ),
            focusedBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(14)),
              borderSide: BorderSide(color: Color(0xFF6CCB2E), width: 2.5),
            ),
            suffixIcon: IconButton(
              icon: const Icon(Icons.info_outline, color: Colors.black54),
              onPressed: () => _showInfo(infoTitle),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    final verticalPadding = height < 700 ? 6.0 : 7.0;
    return Scaffold(
      backgroundColor: Color(0xFFF5F7FA),
      appBar: AppBar(
        title: const Text('Sağlık Verileri Girişi - Son'),
        centerTitle: true,
        backgroundColor: Color(0xFFF5F7FA),
        titleTextStyle: TextStyle(
          fontSize: height < 700 ? 16 : 20,
          fontWeight: FontWeight.w500,
          color: Colors.black87,
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            size: height < 700 ? 18 : 24,
            color: Colors.black87,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          Image.asset(
            'assets/logo.png',
            width: width < 700 ? 75 : 75,
            height: height < 700 ? 40 : 75,
          ),
        ],
      ),
      body: SafeArea(
        child: Center(
          child: Form(
            key: _formKey,
            child: ListView(
              padding: const EdgeInsets.all(20.0),
              children: [
                _buildField(
                  controller: heartAttackMarkerController,
                  label: 'Kalp Kriz Markeri Değeri',
                  infoTitle: 'Kalp Kriz Markeri',
                ),
                _buildField(
                  controller: heartFailureController,
                  label: 'Kalp Yetmezliği Değeri',
                  infoTitle: 'Kalp Yetmezliği',
                ),
                _buildField(
                  controller: badCholesterolController,
                  label: 'Kötü Kolesterol Değeri',
                  infoTitle: 'Kötü Kolesterol',
                ),
                _buildField(
                  controller: clottingController,
                  label: 'Pıhtılaşma Değeri',
                  infoTitle: 'Pıhtılaşma',
                ),
                _buildField(
                  controller: bloodClottingTimeController,
                  label: 'Kanın Pıhtılaşma Süresi Değeri',
                  infoTitle: 'Pıhtılaşma Süresi',
                ),
                _buildField(
                  controller: cReactiveProteinController,
                  label: 'C-Reaktif Protein (CRP) Değeri',
                  infoTitle: 'CRP',
                ),
                _buildField(
                  controller: sedimentationController,
                  label: 'Sedimantasyon Değeri',
                  infoTitle: 'Sedimantasyon',
                ),
                _buildField(
                  controller: severeInfectionController,
                  label: 'Ciddi Enfeksiyon Değeri',
                  infoTitle: 'Ciddi Enfeksiyon',
                ),
                _buildField(
                  controller: rheumatoidFactorController,
                  label: 'Romatoid Faktör Değeri',
                  infoTitle: 'Romatoid Faktör',
                ),
                _buildField(
                  controller: lupusTestController,
                  label: 'Lupus Testi Değeri',
                  infoTitle: 'Lupus Testi',
                ),
                _buildField(
                  controller: hepatitisBTestController,
                  label: 'Hepatit B Testi Değeri',
                  infoTitle: 'Hepatit B',
                ),
                _buildField(
                  controller: hivTestController,
                  label: 'HIV Testi Değeri',
                  infoTitle: 'HIV',
                ),
                SizedBox(height: verticalPadding * 2),
                SizedBox(
                  width: double.infinity,
                  height: height < 700 ? 48 : 54,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.zero,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(26),
                      ),
                    ),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        final userHealthData = [
                          ...widget.userHealthData,
                          double.parse(heartAttackMarkerController.text),
                          double.parse(heartFailureController.text),
                          double.parse(badCholesterolController.text),
                          double.parse(clottingController.text),
                          double.parse(bloodClottingTimeController.text),
                          double.parse(cReactiveProteinController.text),
                          double.parse(sedimentationController.text),
                          double.parse(severeInfectionController.text),
                          double.parse(rheumatoidFactorController.text),
                          double.parse(lupusTestController.text),
                          double.parse(hepatitisBTestController.text),
                          double.parse(hivTestController.text),
                          widget.vitaminD,
                        ];

                        final predict = healthPredictor.predict(userHealthData);

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => ResultView(resultMap: predict),
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Lütfen tüm alanları doldurun.'),
                          ),
                        );
                      }
                    },
                    child: Ink(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(26),
                        gradient: const LinearGradient(
                          colors: [Color(0xFF6CCB2E), Color(0xFF18B6B0)],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                      ),
                      child: Container(
                        alignment: Alignment.center,
                        height: height < 700 ? 48 : 54,
                        width: double.infinity,
                        child: Text(
                          'Hesapla',
                          style: TextStyle(
                            fontSize: height < 700 ? 16 : 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black54,
                            letterSpacing: 4.5,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
