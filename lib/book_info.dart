import 'package:flutter/material.dart';
import 'data.dart'; // data.dart dosyasını içe aktar

class BookInfoPage extends StatelessWidget {
  final Map<String, String> book;

  const BookInfoPage({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    // Tema modunu kontrol et
    final ThemeData theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    // null kontrolü ekleniyor
    final String bookImage = book['gorsel'] ?? 'assets/default_image.png'; // Varsayılan bir görsel
    final String bookTitle = book['ad'] ?? 'Başlık Yok';
    final String bookAuthor = book['yazar'] ?? 'Yazar Bilgisi Yok';
    final String bookDescription = book['aciklama'] ?? 'Açıklama Bilgisi Yok';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Kitap Detayı'),
        backgroundColor: const Color(0xFF2196F3),
      ),
      body: Container(
        color: isDarkMode ? Colors.black : Colors.white, // Arka plan rengini tema moduna göre değiştir
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                bookImage,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(
                    Icons.broken_image,
                    size: 64,
                    color: Colors.grey,
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
            Text(
              bookTitle,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: isDarkMode ? Colors.white : Colors.black, // Metin rengini tema moduna göre değiştir
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Yazar: $bookAuthor',
              style: TextStyle(
                fontSize: 18,
                color: isDarkMode ? Colors.white70 : Colors.black54, // Yazar metnini daha belirgin hale getir
              ),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: isDarkMode ? Colors.grey[800] : Colors.grey[200], // Detay kısmının arka planını ayarla
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                bookDescription,
                style: TextStyle(
                  fontSize: 16,
                  color: isDarkMode ? Colors.white : Colors.black, // Metin rengini tema moduna göre değiştir
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BooksPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kitaplar'),
        backgroundColor: const Color(0xFF2196F3),
      ),
      body: ListView.builder(
        itemCount: books.length,
        itemBuilder: (context, index) {
          final book = books[index];
          return ListTile(
            leading: Image.asset(
              book['gorsel']!,
              width: 50,
              height: 50,
              fit: BoxFit.cover,
            ),
            title: Text(book['ad']!),
            subtitle: Text(book['yazar']!),
            onTap: () {
              // Kitap detay sayfasına geçiş yap
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BookInfoPage(book: book),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
