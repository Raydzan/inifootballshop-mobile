import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import '../models/product.dart';
import 'product_detail.dart';

class AllProductsPage extends StatefulWidget {
  const AllProductsPage({super.key});

  @override
  State<AllProductsPage> createState() => _AllProductsPageState();
}

class _AllProductsPageState extends State<AllProductsPage> {
  String _searchQuery = '';
  String? _selectedCategory;

  Future<List<Product>> fetchAllProducts(CookieRequest request) async {
    final response = await request.get("http://localhost:8000/json/");
    return (response as List<dynamic>)
        .map((e) => Product.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();

    return Scaffold(
      appBar: AppBar(title: const Text('All Products')),
      body: Column(
        children: [
          //  Search bar
          Padding(
            padding: const EdgeInsets.all(8),
            child: TextField(
              decoration: const InputDecoration(
                hintText: 'Cari produk berdasarkan nama...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  _searchQuery = value.toLowerCase();
                });
              },
            ),
          ),
          // Filter kategori
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              children: [
                const Text('Kategori: '),
                const SizedBox(width: 8),
                DropdownButton<String>(
                  value: _selectedCategory,
                  hint: const Text('Semua'),
                  items: const ['Jersey', 'Sepatu', 'Bola', 'Aksesori']
                      .map(
                        (c) => DropdownMenuItem(
                      value: c,
                      child: Text(c),
                    ),
                  )
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedCategory = value;
                    });
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          // Daftar produk
          Expanded(
            child: FutureBuilder<List<Product>>(
              future: fetchAllProducts(request),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('Belum ada produk.'));
                }

                final products = snapshot.data!;
                final filtered = products.where((p) {
                  final matchName = _searchQuery.isEmpty ||
                      p.name.toLowerCase().contains(_searchQuery);
                  final matchCategory = _selectedCategory == null ||
                      p.category == _selectedCategory;
                  return matchName && matchCategory;
                }).toList();

                if (filtered.isEmpty) {
                  return const Center(
                    child: Text('Tidak ada produk yang cocok.'),
                  );
                }

                return ListView.builder(
                  itemCount: filtered.length,
                  itemBuilder: (_, index) {
                    final p = filtered[index];
                    return Card(
                      child: ListTile(
                        title: Text(p.name),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Rp ${p.price} • ${p.category ?? "-"}'),
                            const SizedBox(height: 4),
                            Text(
                              p.description ?? '-',
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => ProductDetailPage(product: p),
                            ),
                          );
                        },
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
