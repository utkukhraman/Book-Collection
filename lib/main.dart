import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'book_info.dart';
import 'profile.dart';
import 'add_book.dart';
import 'settings.dart';
import 'data.dart';
import 'search.dart';

void main() {
  runApp(const KitapKoleksiyonuApp());
}

class KitapKoleksiyonuApp extends StatefulWidget {
  const KitapKoleksiyonuApp({super.key});

  @override
  _KitapKoleksiyonuAppState createState() => _KitapKoleksiyonuAppState();
}

class _KitapKoleksiyonuAppState extends State<KitapKoleksiyonuApp> {
  ThemeMode _themeMode = ThemeMode.light;
  int _selectedIndex = 0;

  void _updateThemeMode(ThemeMode themeMode) {
    setState(() {
      _themeMode = themeMode;
    });
  }

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
        textTheme: TextTheme(
          bodyLarge: GoogleFonts.roboto(fontSize: 18, fontWeight: FontWeight.w400),
          bodyMedium: GoogleFonts.roboto(fontSize: 16, fontWeight: FontWeight.w400),
          bodySmall: GoogleFonts.roboto(fontSize: 14, fontWeight: FontWeight.w400),
          titleLarge: GoogleFonts.roboto(fontSize: 20, fontWeight: FontWeight.bold),
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
          title: Text('Kitap Koleksiyonu', style: GoogleFonts.roboto(fontWeight: FontWeight.bold)),
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
                              style: GoogleFonts.roboto(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              book['yazar'] ?? 'Yazar Bilgisi Yok',
                              style: GoogleFonts.roboto(
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
      const SearchPage(),
      const AddBookPage(),
      SettingsPage(onThemeChanged: onThemeChanged),
      const ProfilePage(),
    ];

    return Scaffold(
      body: pages[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: onItemTapped,
        selectedItemColor: const Color(0xFF2196F3),
        unselectedItemColor: Colors.grey,
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
