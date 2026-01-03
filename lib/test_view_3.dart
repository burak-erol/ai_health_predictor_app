import 'package:flutter/material.dart';
import 'test_view_4.dart';

class TestView3 extends StatefulWidget {
  const TestView3({
    super.key,
    required this.userHealthData,
    required this.vitaminD,
  });

  final List<double> userHealthData;
  final double vitaminD;

  @override
  State<TestView3> createState() => _TestView3State();
}

class _TestView3State extends State<TestView3> {
  final _formKey = GlobalKey<FormState>();

  // Kontrolcüler
  final TextEditingController fastingBloodSugarController =
      TextEditingController();
  final TextEditingController threeMonthSugarController =
      TextEditingController();
  final TextEditingController insulinResistanceController =
      TextEditingController();
  final TextEditingController tshController = TextEditingController();
  final TextEditingController freeT3Controller = TextEditingController();
  final TextEditingController freeT4Controller = TextEditingController();
  final TextEditingController hashimotoMarkerController =
      TextEditingController();

  // Bilgi metinleri sözlüğü
  final Map<String, String> _infoTexts = {
    'Açlık Kan Şekeri':
        'En az 8-12 saatlik açlık sonrası ölçülen şeker seviyesidir. Diyabet taramasında ilk bakılan değerdir.\n\nTest Sonuçlarınız arasında böyle bir parametre yoksa, sonucun doğruluğu için lütfen 70 - 110 aralığında bir değer giriniz.',
    '3 Aylık Şeker':
        'HbA1c testi. Kan şekerinizin son 2-3 aydaki ortalama seviyesini gösteren en güvenilir diyabet takip parametresidir.\n\nTest Sonuçlarınız arasında böyle bir parametre yoksa, sonucun doğruluğu için lütfen 4.0 - 6.0 aralığında bir değer giriniz.',
    'İnsülin Direnci':
        'HOMA-IR olarak da bilinir. Vücudunuzun kan şekerini düzenlemek için ürettiği insüline karşı ne kadar dirençli olduğunu gösterir.\n\nTest Sonuçlarınız arasında böyle bir parametre yoksa, sonucun doğruluğu için lütfen 6 - 14 aralığında bir değer giriniz.',
    'TSH':
        'Tiroid bezinizi uyaran hormondur. Tiroidin az mı yoksa çok mu çalıştığını anlamak için hipofiz bezinden salgılanır.\n\nTest Sonuçlarınız arasında böyle bir parametre yoksa, sonucun doğruluğu için lütfen 1.0 - 3.0 aralığında bir değer giriniz.',
    'Serbest T3':
        'Tiroid bezinden salgılanan aktif hormondur. Metabolizma hızı ve enerji kullanımı üzerinde doğrudan etkilidir.\n\nTest Sonuçlarınız arasında böyle bir parametre yoksa, sonucun doğruluğu için lütfen 2.7 - 4.3 aralığında bir değer giriniz.',
    'Serbest T4':
        'Tiroid bezinin ana salgı ürünüdür. Vücut fonksiyonlarının düzenli çalışması için gerekli temel hormondur.\n\nTest Sonuçlarınız arasında böyle bir parametre yoksa, sonucun doğruluğu için lütfen 0.8 - 1.6 aralığında bir değer giriniz.',
    'Haşimato Belirteci':
        'Tiroid antikorları (Anti-TPO/Tg). Bağışıklık sisteminin kendi tiroid bezine karşı savunma oluşturup oluşturmadığını gösterir.\n\nTest Sonuçlarınız arasında böyle bir parametre yoksa, sonucun doğruluğu için lütfen 0 (Negatif) aralığında bir değer giriniz.',
  };

  @override
  void dispose() {
    fastingBloodSugarController.dispose();
    threeMonthSugarController.dispose();
    insulinResistanceController.dispose();
    tshController.dispose();
    freeT3Controller.dispose();
    freeT4Controller.dispose();
    hashimotoMarkerController.dispose();
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
            border: const OutlineInputBorder(
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
        title: const Text('Sağlık Verileri Girişi - 3'),
        centerTitle: true,
        backgroundColor: Color(0xFFF5F7FA),
        titleTextStyle: TextStyle(
          fontSize: height < 700 ? 18 : 20,
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
      body: Center(
        child: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.all(20.0),
            children: [
              _buildField(
                controller: fastingBloodSugarController,
                label: 'Açlık Kan Şekeri Değeri',
                infoTitle: 'Açlık Kan Şekeri',
              ),
              _buildField(
                controller: threeMonthSugarController,
                label: '3 Aylık Şeker Değeri (HbA1c)',
                infoTitle: '3 Aylık Şeker',
              ),
              _buildField(
                controller: insulinResistanceController,
                label: 'İnsülin Direnci (HOMA-IR)',
                infoTitle: 'İnsülin Direnci',
              ),
              _buildField(
                controller: tshController,
                label: 'Tiroid Uyarıcı Hormon (TSH)',
                infoTitle: 'TSH',
              ),
              _buildField(
                controller: freeT3Controller,
                label: 'Serbest T3 Değeri',
                infoTitle: 'Serbest T3',
              ),
              _buildField(
                controller: freeT4Controller,
                label: 'Serbest T4 Değeri',
                infoTitle: 'Serbest T4',
              ),
              _buildField(
                controller: hashimotoMarkerController,
                label: 'Haşimato Belirteci (Anti-TPO)',
                infoTitle: 'Haşimato Belirteci',
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
                        double.parse(fastingBloodSugarController.text),
                        double.parse(threeMonthSugarController.text),
                        double.parse(insulinResistanceController.text),
                        double.parse(tshController.text),
                        double.parse(freeT3Controller.text),
                        double.parse(freeT4Controller.text),
                        double.parse(hashimotoMarkerController.text),
                      ];
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => TestView4(
                            userHealthData: userHealthData,
                            vitaminD: widget.vitaminD,
                          ),
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Lütfen gerekli alanları doldurun.'),
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
                        'Sonraki Sayfa',
                        style: TextStyle(
                          fontSize: height < 700 ? 16 : 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black54,
                          letterSpacing: 3.0,
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
    );
  }
}
