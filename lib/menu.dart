import 'package:flutter/material.dart';
import 'product_form.dart';

class MenuGrid extends StatelessWidget {
  final double tileWidth;
  const MenuGrid({Key? key, this.tileWidth = 220}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Wrap(
        spacing: 16,
        runSpacing: 16,
        alignment: WrapAlignment.center,
        children: [
          MenuButton(
            width: tileWidth,
            label: 'All Products',
            icon: Icons.list_alt,
            color: Colors.blue,
            snackText: 'Kamu telah menekan tombol All Products',
          ),
          MenuButton(
            width: tileWidth,
            label: 'My Products',
            icon: Icons.inventory_2,
            color: Colors.green,
            snackText: 'Kamu telah menekan tombol My Products',
          ),
          MenuButton(
            width: tileWidth,
            label: 'Create Product',
            icon: Icons.add_box,
            color: Colors.red,
            snackText: 'Kamu telah menekan tombol Create Product',
            onPressedCustom: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ProductFormPage()),
              );
            },
          ),
        ],
      ),
    );
  }
}

class MenuButton extends StatelessWidget {
  final double width;
  final String label;
  final IconData icon;
  final Color color;
  final String snackText;
  final VoidCallback? onPressedCustom;

  const MenuButton({
    Key? key,
    required this.width,
    required this.label,
    required this.icon,
    required this.color,
    required this.snackText,
    this.onPressedCustom,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: 100,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        ),
        onPressed: onPressedCustom ?? () {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(snackText)),
          );
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon),
            SizedBox(height: 8),
            Text(label, textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}
