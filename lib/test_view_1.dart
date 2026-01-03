import 'package:flutter/material.dart';
import 'test_view_2.dart';

final class TestView extends StatefulWidget {
  const TestView({super.key});

  @override
  State<TestView> createState() => _TestViewState();
}

final class _TestViewState extends State<TestView> {
  final _formKey = GlobalKey<FormState>();

  // Kontrolcüler
  final TextEditingController hemoglobinController = TextEditingController();
  final TextEditingController mcvController = TextEditingController();
  final TextEditingController leukocyteController = TextEditingController();
  final TextEditingController plateletController = TextEditingController();
  final TextEditingController ferritinController = TextEditingController();
  final TextEditingController vitaminB12Controller = TextEditingController();
  final TextEditingController folicAcidController = TextEditingController();
  final TextEditingController dVitaminController = TextEditingController();

  // Bilgi metinleri sözlüğü
  final Map<String, String> _infoTexts = {
    'Hemoglobin':
        'Kandaki oksijeni taşıyan protein miktarıdır. Düşüklüğü anemiye (kansızlık) işaret edebilir.\n\nEğer kan testinizde böyle bir parametre göremediyseniz, testin doğru sonuç vermesi için 12.0 - 16.0 değer aralığında bir sonuç giriniz.',
    'MCV':
        'Ortalama Alyuvar Hacmi. Kırmızı kan hücrelerinin boyutunu gösterir. Anemi türlerini ayırt etmede kullanılır.\n\nEğer kan testinizde böyle bir parametre göremediyseniz, testin doğru sonuç vermesi için 80 - 100 değer aralığında bir sonuç giriniz.',
    'Lökosit':
        'Beyaz kan hücreleridir. Vücudun enfeksiyon ve mikroplarla savaşan savunma sistemidir.\n\nEğer kan testinizde böyle bir parametre göremediyseniz, testin doğru sonuç vermesi için 4.000 - 10.000 değer aralığında bir sonuç giriniz.',
    'Trombosit':
        'Kanın pıhtılaşmasını sağlayan hücrelerdir. Düşüklüğünde kanama eğilimi artar.\n\nEğer kan testinizde böyle bir parametre göremediyseniz, testin doğru sonuç vermesi için 150 - 450 değer aralığında bir sonuç giriniz.',
    'Ferritin':
        'Vücuttaki demir depolarını gösterir. Eksikliği demir eksikliği anemisine yol açar.\n\nEğer kan testinizde böyle bir parametre göremediyseniz, testin doğru sonuç vermesi için 60 - 140 değer aralığında bir sonuç giriniz.',
    'Vitamin B12':
        'Sinir sistemi ve kan hücresi üretimi için hayati öneme sahiptir.\n\nEğer kan testinizde böyle bir parametre göremediyseniz, testin doğru sonuç vermesi için 300 - 700 değer aralığında bir sonuç giriniz.',
    'Folik Asit':
        'Hücre bölünmesi ve kan yapımı için gereklidir. Eksikliği anemiye neden olabilir.\n\nEğer kan testinizde böyle bir parametre göremediyseniz, testin doğru sonuç vermesi için 6 - 14 değer aralığında bir sonuç giriniz.',
    'D Vitamini':
        'Kemik sağlığı ve bağışıklık sistemi için önemlidir.\n\nEğer kan testinizde böyle bir parametre göremediyseniz, testin doğru sonuç vermesi için 20 - 60 değer aralığında bir sonuç giriniz.',
  };

  @override
  void dispose() {
    hemoglobinController.dispose();
    mcvController.dispose();
    leukocyteController.dispose();
    plateletController.dispose();
    ferritinController.dispose();
    vitaminB12Controller.dispose();
    folicAcidController.dispose();
    dVitaminController.dispose();
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
        title: const Text('Sağlık Verileri Girişi'),
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
                controller: hemoglobinController,
                label: 'Hemoglobin Değeri',
                infoTitle: 'Hemoglobin',
              ),
              _buildField(
                controller: mcvController,
                label: 'Ortalama Alyuvar Hacmi (MCV)',
                infoTitle: 'MCV',
              ),
              _buildField(
                controller: leukocyteController,
                label: 'Lökosit (Beyaz Kan)',
                infoTitle: 'Lökosit',
              ),
              _buildField(
                controller: plateletController,
                label: 'Trombosit Değeri',
                infoTitle: 'Trombosit',
              ),
              _buildField(
                controller: ferritinController,
                label: 'Ferritin (Demir Deposu)',
                infoTitle: 'Ferritin',
              ),
              _buildField(
                controller: vitaminB12Controller,
                label: 'Vitamin B12',
                infoTitle: 'Vitamin B12',
              ),
              _buildField(
                controller: folicAcidController,
                label: 'Folik Asit',
                infoTitle: 'Folik Asit',
              ),
              _buildField(
                controller: dVitaminController,
                label: 'D Vitamini',
                infoTitle: 'D Vitamini',
              ),
              SizedBox(height: verticalPadding * 2),
              SizedBox(
                width: double.infinity,
                height: height < 700 ? 48 : 54,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      final userHealthData = [
                        double.parse(hemoglobinController.text),
                        double.parse(mcvController.text),
                        double.parse(leukocyteController.text),
                        double.parse(plateletController.text),
                        double.parse(ferritinController.text),
                        double.parse(vitaminB12Controller.text),
                        double.parse(folicAcidController.text),
                      ];
                      final vitaminD = double.parse(dVitaminController.text);

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => TestView2(
                            userHealthData: userHealthData,
                            vitaminD: vitaminD,
                          ),
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
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(26),
                    ),
                  ),
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
