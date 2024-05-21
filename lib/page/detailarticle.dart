import 'package:flutter/material.dart';

class DetailArticle extends StatefulWidget {
  @override
  _DetailArticleState createState() => _DetailArticleState();
}

class _DetailArticleState extends State<DetailArticle> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20),
          child: SingleChildScrollView(
            child: Center(
              child: Container(
                width: 400,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset(
                      'assets/dan-meyers-0AgtPoAARtE-unsplash.jpg',
                      width: 400,
                      height: 350,
                      fit: BoxFit.cover,
                    ),
                    const SizedBox(height: 15),
                    const Padding(
                      padding: EdgeInsets.only(top: 5.0),
                      child: Text(
                        'Belajar / Artikel',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    const SizedBox(height: 15),
                    const Text(
                      'Bagaimana Kualitas udara di dalam ruangan bisa mempengaruhi penyebaran covid 19',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(height: 30),
                    const Divider(
                      color: Colors.grey,
                      thickness: 0.8,
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Penulis'.toUpperCase(),
                          style: const TextStyle(
                              fontSize: 16,
                              color: Color.fromARGB(255, 100, 100, 100)),
                        ),
                        Text(
                          'Diterbitkan'.toUpperCase(),
                          style: const TextStyle(
                              fontSize: 16,
                              color: Color.fromARGB(255, 100, 100, 100)),
                        ),
                      ],
                    ),
                    const SizedBox(height: 25),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          'Farras',
                          style: TextStyle(fontSize: 16),
                        ),
                        Text(
                          'May 2024',
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    const Divider(
                      color: Colors.grey,
                      thickness: 0.8,
                    ),
                    const SizedBox(height: 30),
                    const Text(
                      'Agar lebih mudah di pahami, kami telah membuat ringkasan temuan dari berbagai penelitian terkait topik ini. Jika anda ingin membaca naskah asli, tautan ada di bawah halaman',
                      style: TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 40),
                    const Text(
                      'Covid-19 menyebar melalui tranmisi aeresol',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 25),
                    const Text(
                      'Agar lebih mudah di pahami, kami telah membuat ringkasan temuan dari berbagai penelitian terkait topik ini. Jika anda ingin membaca naskah asli, tautan ada di bawah halaman',
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}