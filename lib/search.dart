import 'package:flutter/material.dart';
import 'book_info.dart';  // Kitap detay sayfası
import 'add_book.dart';   // Kitap ekleme sayfası
import 'data.dart';  // Kitap verilerini içeren dosya

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> _searchResults = [];

  // Arama fonksiyonu
  void _searchBooks() {
    setState(() {
      if (_searchController.text.isEmpty) {
        // Arama kutusu boşsa, tüm kitapları listele
        _searchResults = books;
      } else {
        // Arama kutusu doluysa, kitapları arama kriterine göre filtrele
        _searchResults = books.where((book) {
          String title = book['ad'].toLowerCase();
          String author = book['yazar'].toLowerCase();
          String query = _searchController.text.toLowerCase();
          return title.contains(query) || author.contains(query);
        }).toList();
      }
    });
  }

  @override
  void initState() {
    super.initState();
    // Sayfa ilk yüklendiğinde tüm kitapları listele
    _searchBooks();
  }

  @override
  void dispose() {
    // Sayfa çıktığında arama sonuçlarını sıfırla
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kitap Ara'),
        backgroundColor: const Color(0xFF2196F3),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              onChanged: (value) {
                _searchBooks(); // Arama her değişiklikte yapılır
              },
              decoration: InputDecoration(
                labelText: 'Kitap adı veya Yazar adı',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                prefixIcon: const Icon(Icons.search),
              ),
            ),
            const SizedBox(height: 20),
            // Arama sonuçları
            _searchResults.isNotEmpty
                ? Expanded(
              child: ListView.builder(
                itemCount: _searchResults.length,
                itemBuilder: (context, index) {
                  final book = _searchResults[index];
                  return GestureDetector(
                    onTap: () {
                      // Kitap detay sayfasına yönlendir
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BookInfoPage(book: book),
                        ),
                      );
                    },
                    child: Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: ListTile(
                        leading: Image.asset(
                          book['gorsel'] ?? 'assets/default_image.png',
                          fit: BoxFit.cover,
                          width: 50,
                          height: 50,
                          errorBuilder: (context, error, stackTrace) {
                            return const Icon(
                              Icons.broken_image,
                              size: 50,
                              color: Colors.grey,
                            );
                          },
                        ),
                        title: Text(book['ad'] ?? 'Başlık Yok'),
                        subtitle: Text(book['yazar'] ?? 'Yazar Bilgisi Yok'),
                      ),
                    ),
                  );
                },
              ),
            )
                : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Sonuç bulunamadı.',
                  style: TextStyle(fontSize: 18),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    // Kitap ekleme sayfasına yönlendir
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AddBookPage(),
                      ),
                    );
                  },
                  child: const Text('Kitap Ekle'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
