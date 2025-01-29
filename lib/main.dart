import 'package:flutter/material.dart';
import 'book_info.dart';  // Kitap detay sayfası
import 'profile.dart';
import 'add_book.dart';
import 'settings.dart';
import 'data.dart';  // Kitap verilerini içeren dosya
import 'search.dart'; // Arama sayfası

void main() {
  runApp(const KitapKoleksiyonuApp());
}

class KitapKoleksiyonuApp extends StatefulWidget {
  const KitapKoleksiyonuApp({super.key});

  @override
  _KitapKoleksiyonuAppState createState() => _KitapKoleksiyonuAppState();
}

class _KitapKoleksiyonuAppState extends State<KitapKoleksiyonuApp> {
  ThemeMode _themeMode = ThemeMode.light; // Varsayılan tema modu
  int _selectedIndex = 0; // Aktif olan sekme

  void _updateThemeMode(ThemeMode themeMode) {
    setState(() {
      _themeMode = themeMode;
    });
  }

  // Sayfa geçiş fonksiyonu
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: _themeMode,
      theme: ThemeData(
        primaryColor: const Color(0xFF2196F3),
        scaffoldBackgroundColor: const Color(0xFFF5F5F5),
        textTheme: const TextTheme(
          bodyMedium: TextStyle(fontFamily: 'Roboto', fontSize: 16),
        ),
      ),
      darkTheme: ThemeData.dark(),
      home: AnaSayfa(onThemeChanged: _updateThemeMode, selectedIndex: _selectedIndex, onItemTapped: _onItemTapped),
    );
  }
}

class AnaSayfa extends StatelessWidget {
  final Function(ThemeMode) onThemeChanged;
  final int selectedIndex;
  final Function(int) onItemTapped;

  const AnaSayfa({super.key, required this.onThemeChanged, required this.selectedIndex, required this.onItemTapped});

  @override
  Widget build(BuildContext context) {
    List<Widget> pages = [
      Scaffold(
        appBar: AppBar(
          title: const Text('Kitap Koleksiyonu'),
          backgroundColor: const Color(0xFF2196F3),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 0.6,
            ),
            itemCount: books.length,
            itemBuilder: (context, index) {
              final book = books[index];
              return GestureDetector(
                onTap: () {
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
                  child: Column(
                    children: [
                      Expanded(
                        child: ClipRRect(
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(8),
                          ),
                          child: Image.asset(
                            book['gorsel'] ?? 'assets/default_image.png',
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
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              book['ad'] ?? 'Başlık Yok',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              book['yazar'] ?? 'Yazar Bilgisi Yok',
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
      const SearchPage(),  // Arama sayfası
      const AddBookPage(),  // Kitap ekleme sayfası
      SettingsPage(onThemeChanged: onThemeChanged),  // Ayarlar sayfası
      const ProfilePage(),  // Profil sayfası
    ];

    return Scaffold(
      body: pages[selectedIndex], // Aktif sayfayı göster
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: onItemTapped, // Menü öğesine tıklayınca aktif olan sayfayı değiştir
        selectedItemColor: const Color(0xFF2196F3), // Seçilen öğenin rengi
        unselectedItemColor: Colors.grey, // Seçilmemiş öğelerin rengi
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Ana Sayfa',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Ara',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Ekle',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Ayarlar',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profil',
          ),
        ],
      ),
    );
  }
}
