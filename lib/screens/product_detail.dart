import 'package:flutter/material.dart';
import '../models/product.dart';

class ProductDetailPage extends StatelessWidget {
  final Product product;
  const ProductDetailPage({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            if (product.imageUrl.isNotEmpty)
              Image.network(product.imageUrl, height: 180, fit: BoxFit.cover),
            const SizedBox(height: 16),
            Text('Nama: ${product.name}'),
            Text('Harga: Rp ${product.price}'),
            Text('Stok: ${product.stock}'),
            Text('Kategori: ${product.category ?? '-'}'),
            const SizedBox(height: 12),
            Text('Deskripsi:\n${product.description ?? '-'}'),
            const SizedBox(height: 12),
            Text('Pemilik: ${product.user ?? '-'}'),
            const SizedBox(height: 12),
            Text('Dibuat: ${product.createdAt?.toLocal().toString() ?? '-'}'),
          ],
        ),
      ),
    );
  }
}
