import 'package:flutter/material.dart';
import 'test_view_3.dart';

final class TestView2 extends StatefulWidget {
  const TestView2({
    super.key,
    required this.userHealthData,
    required this.vitaminD,
  });

  final List<double> userHealthData;
  final double vitaminD;

  @override
  State<TestView2> createState() => _TestView2State();
}

final class _TestView2State extends State<TestView2> {
  final _formKey = GlobalKey<FormState>();

  // Kontrolcüler
  final TextEditingController altController = TextEditingController();
  final TextEditingController astController = TextEditingController();
  final TextEditingController ggtController = TextEditingController();
  final TextEditingController bilirubinController = TextEditingController();
  final TextEditingController ureController = TextEditingController();
  final TextEditingController creatinineController = TextEditingController();
  final TextEditingController gfrController = TextEditingController();
  final TextEditingController proteinController = TextEditingController();
  final TextEditingController sodiumController = TextEditingController();
  final TextEditingController potassiumController = TextEditingController();

  // Bilgi metinleri sözlüğü
  final Map<String, String> _infoTexts = {
    'ALT':
        'Karaciğer hasarını belirlemek için kullanılan temel enzimdir.\n\nTest Sonuçlarınız arasında böyle bir parametre yoksa, sonucun doğruluğu için lütfen 15-35 aralığında bir değer giriniz.',
    'AST':
        'Karaciğer ve kalp kasında bulunan bir enzimdir, organ hasarını gösterir.\n\nTest Sonuçlarınız arasında böyle bir parametre yoksa, sonucun doğruluğu için lütfen 15-35 aralığında bir değer giriniz.',
    'GGT':
        'Safra yolu hastalıkları ve karaciğer fonksiyonlarını değerlendirmek için kullanılır.\n\nTest Sonuçlarınız arasında böyle bir parametre yoksa, sonucun doğruluğu için lütfen 20-40 aralığında bir değer giriniz.',
    'Bilirubin':
        'Alyuvarların yıkımı sonucu oluşur, sarılık ve karaciğer problemleri için bakılır.\n\nTest Sonuçlarınız arasında böyle bir parametre yoksa, sonucun doğruluğu için lütfen 0.4 - 1.2 aralığında bir değer giriniz.',
    'Üre':
        'Böbreklerin proteini süzme kapasitesini gösteren bir atık maddesidir.\n\nTest Sonuçlarınız arasında böyle bir parametre yoksa, sonucun doğruluğu için lütfen 20 - 40 aralığında bir değer giriniz.',
    'Kreatinin':
        'Kas metabolizması sonucu oluşan ve böbrekler tarafından atılan bir maddedir.\n\nTest Sonuçlarınız arasında böyle bir parametre yoksa, sonucun doğruluğu için lütfen 0.7 - 1.1 aralığında bir değer giriniz.',
    'GFR':
        'Böbreklerin dakikada ne kadar kanı süzdüğünü gösteren en güvenilir böbrek fonksiyon göstergesidir.\n\nTest Sonuçlarınız arasında böyle bir parametre yoksa, sonucun doğruluğu için lütfen 80 - 120 aralığında bir değer giriniz.',
    'Protein':
        'Kandaki toplam protein miktarıdır; karaciğer ve böbrek sağlığı hakkında bilgi verir.\n\nTest Sonuçlarınız arasında böyle bir parametre yoksa, sonucun doğruluğu için lütfen 3.5 - 5.5 aralığında bir değer giriniz.',
    'Sodyum':
        'Vücuttaki sıvı dengesini ve sinir-kas fonksiyonlarını düzenleyen temel elektrolittir.\n\nTest Sonuçlarınız arasında böyle bir parametre yoksa, sonucun doğruluğu için lütfen 136 - 144 aralığında bir değer giriniz.',
    'Potasyum':
        'Kalp ritmi ve kas kasılmaları için kritik öneme sahip bir elektrolittir.\n\nTest Sonuçlarınız arasında böyle bir parametre yoksa, sonucun doğruluğu için lütfen 3.6 - 4.8 aralığında bir değer giriniz.',
  };

  @override
  void dispose() {
    altController.dispose();
    astController.dispose();
    ggtController.dispose();
    bilirubinController.dispose();
    ureController.dispose();
    creatinineController.dispose();
    gfrController.dispose();
    proteinController.dispose();
    sodiumController.dispose();
    potassiumController.dispose();
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
        title: const Text('Sağlık Verileri Girişi - 2'),
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
                controller: altController,
                label: 'Karaciğer Enzimi (ALT)',
                infoTitle: 'ALT',
              ),
              _buildField(
                controller: astController,
                label: 'Karaciğer Enzimi (AST)',
                infoTitle: 'AST',
              ),
              _buildField(
                controller: ggtController,
                label: 'Safra Yolu Enzimi (GGT)',
                infoTitle: 'GGT',
              ),
              _buildField(
                controller: bilirubinController,
                label: 'Sarılık Değeri (Bilirubin)',
                infoTitle: 'Bilirubin',
              ),
              _buildField(
                controller: ureController,
                label: 'Üre Değeri',
                infoTitle: 'Üre',
              ),
              _buildField(
                controller: creatinineController,
                label: 'Kreatinin Değeri',
                infoTitle: 'Kreatinin',
              ),
              _buildField(
                controller: gfrController,
                label: 'Böbrek Süzgeç Hızı (GFR)',
                infoTitle: 'GFR',
              ),
              _buildField(
                controller: proteinController,
                label: 'Protein Değeri',
                infoTitle: 'Protein',
              ),
              _buildField(
                controller: sodiumController,
                label: 'Sodyum Değeri',
                infoTitle: 'Sodyum',
              ),
              _buildField(
                controller: potassiumController,
                label: 'Potasyum Değeri',
                infoTitle: 'Potasyum',
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
                        double.parse(altController.text),
                        double.parse(astController.text),
                        double.parse(ggtController.text),
                        double.parse(bilirubinController.text),
                        double.parse(ureController.text),
                        double.parse(creatinineController.text),
                        double.parse(gfrController.text),
                        double.parse(proteinController.text),
                        double.parse(sodiumController.text),
                        double.parse(potassiumController.text),
                      ];
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => TestView3(
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
