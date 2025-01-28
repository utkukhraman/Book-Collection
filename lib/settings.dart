import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  final ValueChanged<ThemeMode> onThemeChanged; // Tema değişikliği için bir callback

  const SettingsPage({super.key, required this.onThemeChanged});

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _notificationsEnabled = true; // Bildirim izni varsayılan olarak seçili
  bool _isDarkTheme = false; // Varsayılan tema açık

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ayarlar'),
        backgroundColor: const Color(0xFF2196F3),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Karanlık Tema
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Karanlık Tema',
                  style: TextStyle(fontSize: 18),
                ),
                Switch(
                  value: _isDarkTheme,
                  onChanged: (value) {
                    setState(() {
                      _isDarkTheme = value;
                      widget.onThemeChanged(
                          _isDarkTheme ? ThemeMode.dark : ThemeMode.light);
                    });
                  },
                ),
              ],
            ),
            const Divider(height: 32, thickness: 1),

            // Bildirim İzni
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Bildirimlere İzin Ver',
                  style: TextStyle(fontSize: 18),
                ),
                Switch(
                  value: _notificationsEnabled,
                  onChanged: (value) {
                    setState(() {
                      _notificationsEnabled = value;
                    });
                  },
                ),
              ],
            ),
            const Divider(height: 32, thickness: 1),

            // Versiyon ve Geliştirici Bilgileri
            const Spacer(),
            const Text(
              'Versiyon: 1.0.0',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'Geliştirici: Utku Kahraman',
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 8),
            const Text(
              'Website: utkukahraman.dev',
              style: TextStyle(fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}
