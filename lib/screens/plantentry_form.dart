import 'package:flutter/material.dart';
import 'package:plantify_mobile/widgets/left_drawer.dart';
import 'package:flutter/services.dart';

class PlantEntryFormPage extends StatefulWidget {
  const PlantEntryFormPage({super.key});

  @override
  State<PlantEntryFormPage> createState() => _PlantEntryFormPageState();
}

class _PlantEntryFormPageState extends State<PlantEntryFormPage> {
  final _formKey = GlobalKey<FormState>();
  String _plantName = '';
  int _plantPrice = 0;
  String _plantWeight = '0';
  String _plantDescription = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'Form Entri Tanaman',
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
      ),
      drawer: const LeftDrawer(),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                decoration: InputDecoration(
                  hintText: "Nama Tanaman",
                  labelText: "Nama Tanaman",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
                onChanged: (String? value) {
                  setState(() {
                    _plantName = value!;
                  });
                },
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return "Nama tanaman tidak boleh kosong";
                  }

                  if (value.trim().isEmpty) {
                    return "Nama tanaman tidak boleh hanya berisi spasi";
                  }

                  if (value.length < 3) {
                    return "Nama tanaman harus lebih dari 3 karakter";
                  }

                  if (value.length > 50) {
                    return "Nama tanaman harus kurang dari 50 karakter";
                  }

                  // Allow letters, spaces, and common punctuation marks
                  if (!RegExp(r'^[a-zA-Z\s.,()]+$').hasMatch(value)) {
                    return "Nama tanaman hanya boleh mengandung huruf, spasi, dan tanda baca umum";
                  }

                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                decoration: InputDecoration(
                  hintText: "Harga Tanaman",
                  labelText: "Harga Tanaman",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
                onChanged: (String? value) {
                  setState(() {
                    _plantPrice = value!.isEmpty ? 0 : int.parse(value);
                  });
                },
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return "Harga tanaman tidak boleh kosong";
                  }

                  final price = int.tryParse(value);
                  if (price == null) {
                    return "Harga harus berupa angka";
                  }

                  if (price < 0) {
                    return "Harga tanaman tidak boleh kurang dari 0";
                  }

                  if (price > 100000000) {
                    // 100 million limit
                    return "Harga tanaman terlalu tinggi";
                  }

                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                decoration: InputDecoration(
                  hintText: "Berat Tanaman (kg)",
                  labelText: "Berat Tanaman (kg)",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(
                      r'^\d*\.?\d{0,2}')), // Allow up to 2 decimal places
                ],
                onChanged: (String? value) {
                  setState(() {
                    _plantWeight = value!;
                  });
                },
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return "Berat tanaman tidak boleh kosong";
                  }

                  final weight = double.tryParse(value);
                  if (weight == null) {
                    return "Berat harus berupa angka";
                  }

                  if (weight <= 0) {
                    return "Berat tanaman harus lebih dari 0";
                  }

                  if (weight > 1000) {
                    // 1000 kg limit
                    return "Berat tanaman terlalu besar";
                  }

                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                decoration: InputDecoration(
                  hintText: "Deskripsi Tanaman",
                  labelText: "Deskripsi Tanaman",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
                maxLines: 3, // Allow multiple lines for description
                onChanged: (String? value) {
                  setState(() {
                    _plantDescription = value!;
                  });
                },
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return "Deskripsi tanaman tidak boleh kosong";
                  }

                  if (value.trim().isEmpty) {
                    return "Deskripsi tidak boleh hanya berisi spasi";
                  }

                  if (value.length < 10) {
                    return "Deskripsi terlalu pendek (minimal 10 karakter)";
                  }

                  if (value.length > 500) {
                    return "Deskripsi terlalu panjang (maksimal 500 karakter)";
                  }

                  return null;
                },
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        Theme.of(context).colorScheme.primary),
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text('Tanaman berhasil tersimpan'),
                            content: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Nama Tanaman: $_plantName'),
                                  Text('Harga Tanaman: $_plantPrice'),
                                  Text('Berat Tanaman: $_plantWeight'),
                                  Text('Deskripsi Tanaman: $_plantDescription'),
                                ],
                              ),
                            ),
                            actions: [
                              TextButton(
                                child: const Text('OK'),
                                onPressed: () {
                                  Navigator.pop(context);
                                  _formKey.currentState!.reset();
                                },
                              ),
                            ],
                          );
                        },
                      );
                    }
                  },
                  child: const Text(
                    "Save",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        )),
      ),
    );
  }
}
