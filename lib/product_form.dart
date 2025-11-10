import 'package:flutter/material.dart';
import 'widgets/left_drawer.dart';

class ProductFormPage extends StatefulWidget {
  const ProductFormPage({super.key});
  @override
  State<ProductFormPage> createState() => _ProductFormPageState();
}

class _ProductFormPageState extends State<ProductFormPage> {
  final _formKey = GlobalKey<FormState>();

  String _name = '';
  String _priceStr = '';
  String _description = '';
  String _category = 'Jersey';
  String _thumbnail = '';
  bool _isFeatured = false;

  final _categories = ['Jersey', 'Sepatu', 'Bola', 'Aksesori'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: const Text('Tambah Produk')),
      drawer: const LeftDrawer(),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            TextFormField(
              decoration: _input('Nama Produk', 'Nama Produk'),
              onChanged: (v) => _name = v,
              validator: (v) {
                if (v == null || v.isEmpty) return 'Nama tidak boleh kosong';
                if (v.length < 3) return 'Nama minimal 3 karakter';
                return null;
              },
            ),
            const SizedBox(height: 12),
            TextFormField(
              keyboardType: TextInputType.number,
              decoration: _input('Harga (Rp)', 'Harga'),
              onChanged: (v) => _priceStr = v,
              validator: (v) {
                if (v == null || v.isEmpty) return 'Harga tidak boleh kosong';
                final n = int.tryParse(v);
                if (n == null) return 'Harga harus berupa angka';
                if (n <= 0) return 'Harga harus > 0';
                return null;
              },
            ),
            const SizedBox(height: 12),
            TextFormField(
              maxLines: 4,
              decoration: _input('Deskripsi', 'Deskripsi'),
              onChanged: (v) => _description = v,
              validator: (v) {
                if (v == null || v.isEmpty) return 'Deskripsi tidak boleh kosong';
                if (v.length < 10) return 'Deskripsi minimal 10 karakter';
                return null;
              },
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<String>(
              decoration: _input('Kategori', 'Kategori'),
              value: _category,
              items: _categories.map((c) => DropdownMenuItem(value: c, child: Text(c))).toList(),
              onChanged: (val) => setState(() => _category = val ?? _category),
            ),
            const SizedBox(height: 12),
            TextFormField(
              decoration: _input('URL Thumbnail (opsional)', 'URL Thumbnail'),
              onChanged: (v) => _thumbnail = v,
              validator: (v) {
                if (v == null || v.isEmpty) return null;
                final ok = Uri.tryParse(v)?.hasAbsolutePath ?? false;
                return ok ? null : 'URL tidak valid';
              },
            ),
            const SizedBox(height: 12),
            SwitchListTile(
              title: const Text('Tandai sebagai Produk Unggulan'),
              value: _isFeatured,
              onChanged: (b) => setState(() => _isFeatured = b),
            ),
            const SizedBox(height: 16),
            Align(
              alignment: Alignment.center,
              child: ElevatedButton(
                child: const Text('Save'),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    showDialog(
                      context: context,
                      builder: (ctx) => AlertDialog(
                        title: const Text('Produk berhasil dibuat'),
                        content: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Nama: $_name'),
                              Text('Harga: $_priceStr'),
                              Text('Kategori: $_category'),
                              Text('Unggulan: ${_isFeatured ? 'Ya' : 'Tidak'}'),
                              Text('Thumbnail: ${_thumbnail.isEmpty ? '-' : _thumbnail}'),
                              const SizedBox(height: 8),
                              Text('Deskripsi:\n$_description'),
                            ],
                          ),
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(ctx);
                              _formKey.currentState!.reset();
                              setState(() {
                                _name = _priceStr = _description = _thumbnail = '';
                                _category = _categories.first;
                                _isFeatured = false;
                              });
                            },
                            child: const Text('OK'),
                          ),
                        ],
                      ),
                    );
                  }
                },
              ),
            ),
          ]),
        ),
      ),
    );
  }

  InputDecoration _input(String hint, String label) => InputDecoration(
    hintText: hint,
    labelText: label,
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(6)),
  );
}
