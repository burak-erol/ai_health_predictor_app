import 'package:flutter/material.dart';

class ResultView extends StatelessWidget {
  const ResultView({super.key, required this.resultMap});

  final Map<String, dynamic> resultMap;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      backgroundColor: Color(0xFFF5F7FA),
      appBar: AppBar(
        title: const Text('Sonucunuz'),
        centerTitle: true,
        backgroundColor: Color(0xFFF5F7FA),
        titleTextStyle: TextStyle(
          fontSize: height < 700 ? 18 : 22,
          fontWeight: FontWeight.w500,
          color: Colors.black87,
        ),
        leading: IconButton(
          icon: Icon(
            size: height < 700 ? 18 : 24,
            Icons.arrow_back,
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: height * 0.5,
              width: width * 0.9,
              padding: const EdgeInsets.all(26),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/logo.png'),
                  fit: BoxFit.cover,
                  opacity: 0.3,
                ),
                borderRadius: BorderRadius.circular(26),
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFF6CCB2E),
                    Color(0xFFF5F7FA),
                    Color(0xFF18B6B0),
                  ],
                  begin: Alignment.bottomRight,
                  end: Alignment.topLeft,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.40),
                    blurRadius: 15,
                    offset: Offset(0, 10),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Tahmin Edilen Hastalık:\n ${resultMap['label']}',
                    style: TextStyle(
                      fontSize: height < 700 ? 16 : 21,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  Text(
                    'Skor: ${resultMap['score']}',
                    style: TextStyle(
                      fontSize: height < 700 ? 16 : 21,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  Text(
                    'Güven Oranı: ${resultMap['confidence']}',
                    style: TextStyle(
                      fontSize: height < 700 ? 16 : 21,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    'Durum: ${resultMap['status']}',
                    style: TextStyle(
                      fontSize: height < 700 ? 14 : 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.1),
              child: Text(
                'Sonuçlar tıbbi testlerin yerini tutmaz.Kendinizi iyi hissetmiyorsanız, değerlerinizi bir doktora kontrol ettirin!',
                style: TextStyle(
                  fontSize: height < 700 ? 12 : 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.black54,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
