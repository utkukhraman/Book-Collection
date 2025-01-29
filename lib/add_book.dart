import 'package:flutter/material.dart';
import 'data.dart';

class AddBookPage extends StatefulWidget {
  const AddBookPage({super.key});

  @override
  State<AddBookPage> createState() => _AddBookPageState();
}

class _AddBookPageState extends State<AddBookPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _adController = TextEditingController();
  final TextEditingController _yazarController = TextEditingController();
  final TextEditingController _gorselController = TextEditingController();
  final TextEditingController _aciklamaController = TextEditingController();

  @override
  void dispose() {
    _adController.dispose();
    _yazarController.dispose();
    _gorselController.dispose();
    _aciklamaController.dispose();
    super.dispose();
  }

  void _addBook() {
    if (_formKey.currentState!.validate()) {
      final newBook = {
        'ad': _adController.text,
        'yazar': _yazarController.text,
        'gorsel': _gorselController.text,
        'aciklama': _aciklamaController.text,
      };
      setState(() {
        books.add(newBook);  // Kitaplar listesine yeni kitap ekleniyor
      });

      // Başarılı mesajı göster
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Başarılı'),
            content: const Text('Kitap başarıyla eklendi.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Dialog'u kapat
                  _adController.clear(); // Kitap adı text kutusunu temizle
                  _yazarController.clear(); // Yazar adı text kutusunu temizle
                  _gorselController.clear(); // Görsel URL text kutusunu temizle
                  _aciklamaController.clear(); // Açıklama text kutusunu temizle
                },
                child: const Text('Tamam'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kitap Ekle'),
        backgroundColor: Colors.blue, // Mavi renk başlık için
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  controller: _adController,
                  decoration: const InputDecoration(
                    labelText: 'Kitap Adı',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Lütfen kitap adını giriniz.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _yazarController,
                  decoration: const InputDecoration(
                    labelText: 'Yazar',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Lütfen yazar adını giriniz.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _gorselController,
                  decoration: const InputDecoration(
                    labelText: 'Görsel URL',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _aciklamaController,
                  decoration: const InputDecoration(
                    labelText: 'Açıklama',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: _addBook,
                  child: const Text('Ekle'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
