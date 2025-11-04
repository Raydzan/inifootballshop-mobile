import 'package:flutter/material.dart';
import 'menu.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'IniFootballShop',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final String npm = '2406432482';
  final String name = 'Moch Raydzan';
  final String kelas = 'D';
  static const double kTileWidth = 220;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('IniFootballShop'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        elevation: 0,
      ),

      body: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 720),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Wrap(
                  spacing: 16,
                  runSpacing: 16,
                  alignment: WrapAlignment.center,
                  children: [
                    SizedBox(
                      width: kTileWidth,
                      child: InfoCard(title: 'NPM', value: npm),
                    ),
                    SizedBox(
                      width: kTileWidth,
                      child: InfoCard(title: 'Name', value: name),
                    ),
                    SizedBox(
                      width: kTileWidth,
                      child: InfoCard(title: 'Class', value: kelas),
                    ),
                  ],
                ),

                SizedBox(height: 24),
                Text(
                  'Selamat datang di IniFootballShop',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 24),

                MenuGrid(tileWidth: kTileWidth),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class InfoCard extends StatelessWidget {
  final String title;
  final String value;
  InfoCard({required this.title, required this.value});
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 4),
            Text(value, textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}
