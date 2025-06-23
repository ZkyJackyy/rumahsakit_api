import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class TambahRs extends StatefulWidget {
  const TambahRs({super.key});

  @override
  State<TambahRs> createState() => _TambahRsState();
}

class _TambahRsState extends State<TambahRs> {
  final _namaController = TextEditingController();
  final _alamatController = TextEditingController();
  final _noTelpController = TextEditingController();
  final _typeController = TextEditingController();
  final _latController = TextEditingController();
  final _lngController = TextEditingController();

  bool _isLoading = false;

  Future<void> _simpanRs() async {
    if (_namaController.text.isEmpty ||
        _alamatController.text.isEmpty ||
        _noTelpController.text.isEmpty ||
        _typeController.text.isEmpty ||
        _latController.text.isEmpty ||
        _lngController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Semua field wajib diisi')),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final response = await http.post(
        Uri.parse('http://192.168.192.246:8000/api/rs/'), // Ganti sesuai endpoint rumah sakit
        headers: {
          'Content-Type': 'application/json',
          'x-api-key': 'reqres-free-v1', // Hapus jika tidak dipakai di API-mu
        },
        body: json.encode({
          'nama': _namaController.text,
          'alamat': _alamatController.text,
          'no_telp': _noTelpController.text,
          'type': _typeController.text,
          'lat': double.parse(_latController.text),
          'lng': double.parse(_lngController.text),
        }),
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Data rumah sakit berhasil disimpan')),
        );
        Navigator.pop(context, true);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Gagal simpan: ${response.statusCode}')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _namaController.dispose();
    _alamatController.dispose();
    _noTelpController.dispose();
    _typeController.dispose();
    _latController.dispose();
    _lngController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Tambah Rumah Sakit'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20),
              TextField(
                controller: _namaController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Nama RS',
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _alamatController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Alamat',
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _noTelpController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'No Telepon',
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _typeController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Tipe (Umum / Khusus / dll)',
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _latController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Latitude',
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _lngController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Longitude',
                ),
              ),
              const SizedBox(height: 40),
              _isLoading
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.lightGreenAccent,
                      ),
                      onPressed: _simpanRs,
                      child: const Text(
                        'Simpan RS',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
