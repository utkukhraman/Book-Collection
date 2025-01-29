import 'package:flutter/material.dart';
import 'data.dart'; // Kitap verilerini içe aktarıyor

class BookInfoPage extends StatelessWidget {
  final Map<String, dynamic> book;

  const BookInfoPage({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Kitap Detayı'),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildBookImage(book['gorsel']),
            const SizedBox(height: 16),
            _buildBookTitle(book['ad'], isDarkMode),
            const SizedBox(height: 8),
            _buildBookAuthor(book['yazar'], isDarkMode),
            const SizedBox(height: 16),
            _buildBookDescription(book['aciklama'], isDarkMode),
          ],
        ),
      ),
    );
  }

  Widget _buildBookImage(String? imagePath) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Image.asset(
        imagePath ?? 'assets/default_image.png',
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => const Icon(Icons.broken_image, size: 64, color: Colors.grey),
      ),
    );
  }

  Widget _buildBookTitle(String? title, bool isDarkMode) {
    return Text(
      title ?? 'Başlık Yok',
      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: isDarkMode ? Colors.white : Colors.black),
    );
  }

  Widget _buildBookAuthor(String? author, bool isDarkMode) {
    return Text(
      'Yazar: ${author ?? 'Bilinmiyor'}',
      style: TextStyle(fontSize: 18, color: isDarkMode ? Colors.white70 : Colors.black54),
    );
  }

  Widget _buildBookDescription(String? description, bool isDarkMode) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: isDarkMode ? Colors.grey[800] : Colors.grey[200],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        description ?? 'Açıklama bulunamadı.',
        style: TextStyle(fontSize: 16, color: isDarkMode ? Colors.white : Colors.black),
      ),
    );
  }
}

class BooksPage extends StatelessWidget {
  const BooksPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kitaplar'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: books.length,
          itemBuilder: (context, index) {
            final book = books[index];
            return _buildBookTile(context, book);
          },
        ),
      ),
    );
  }

  Widget _buildBookTile(BuildContext context, Map<String, dynamic> book) {
    return ListTile(
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(4),
        child: Image.asset(
          book['gorsel'] ?? 'assets/default_image.png',
          width: 50,
          height: 50,
          fit: BoxFit.cover,
          errorBuilder: (_, __, ___) => const Icon(Icons.broken_image, size: 50, color: Colors.grey),
        ),
      ),
      title: Text(book['ad'] ?? 'Başlık Yok'),
      subtitle: Text(book['yazar'] ?? 'Yazar Bilgisi Yok'),
      onTap: () => _navigateToBookInfo(context, book),
    );
  }

  void _navigateToBookInfo(BuildContext context, Map<String, dynamic> book) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => BookInfoPage(book: book)),
    );
  }
}
