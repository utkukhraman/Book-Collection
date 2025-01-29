import 'package:flutter/material.dart';
import 'data.dart'; // Kitap verilerini içe aktar
import 'book_info.dart'; // Kitap detay sayfasını içe aktar

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String filterStatus = 'Tümü';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    // Duruma göre kitapları filtrele
    final filteredBooks = books.where((book) {
      if (filterStatus == 'Tümü') {
        return true; // Hepsini göster
      } else if (filterStatus == 'Okundu') {
        return book['durum'] == 1; // Okundu olanları göster
      } else if (filterStatus == 'Okunacak') {
        return book['durum'] == 2; // Okunacak olanları göster
      }
      return false;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil'),
        backgroundColor: const Color(0xFF2196F3),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 20),
          const CircleAvatar(
            radius: 50,
            backgroundImage: AssetImage('assets/images/profile.jpg'),
          ),
          const SizedBox(height: 16),
          const Text(
            'Utku Kahraman',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const Text(
            'Kitap Koleksiyonu Uygulaması Geliştiricisi',
            style: TextStyle(fontSize: 16),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          const Divider(thickness: 1), // Profil ile kitap listesi arasına çizgi ekledim

          // Kitap koleksiyon başlığı ve TabBar
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Kitap Koleksiyonum',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          // TabBar, kitapları filtrelemek için
          TabBar(
            controller: _tabController,
            tabs: const [
              Tab(text: 'Tümü'),
              Tab(text: 'Okundu'),
              Tab(text: 'Okunacak'),
            ],
            onTap: (index) {
              setState(() {
                filterStatus = index == 0
                    ? 'Tümü'
                    : index == 1
                    ? 'Okundu'
                    : 'Okunacak';
              });
            },
          ),

          // Kitapları filtreleyip listele
          Expanded(
            child: ListView.builder(
              itemCount: filteredBooks.length,
              itemBuilder: (context, index) {
                final book = filteredBooks[index];
                final String bookImage = book['gorsel'] ?? 'assets/default_image.png';
                final String bookTitle = book['ad'] ?? 'Başlık Yok';
                final String bookAuthor = book['yazar'] ?? 'Yazar Bilgisi Yok';
                final int bookStatus = book['durum'] ?? 0;

                return ListTile(
                  contentPadding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      bookImage,
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return const Icon(Icons.broken_image, size: 50, color: Colors.grey);
                      },
                    ),
                  ),
                  title: Text(bookTitle),
                  subtitle: Text(bookAuthor),
                  trailing: Text(
                    bookStatus == 1 ? 'Okundu' : 'Okunacak',
                    style: TextStyle(
                      color: bookStatus == 1 ? Colors.green : Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
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
          ),
        ],
      ),
    );
  }
}
