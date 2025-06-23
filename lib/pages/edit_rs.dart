import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:rumahsakit_api/model/model_rs.dart'; // ganti sesuai path modelmu

class EditRs extends StatefulWidget {
  final ModelRs rs;
  const EditRs({super.key, required this.rs});

  @override
  State<EditRs> createState() => _EditRsState();
}

class _EditRsState extends State<EditRs> {
  final _formKey = GlobalKey<FormState>();

  final _namaController = TextEditingController();
  final _alamatController = TextEditingController();
  final _noTelpController = TextEditingController();
  final _typeController = TextEditingController();
  final _latController = TextEditingController();
  final _lngController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _namaController.text = widget.rs.nama;
    _alamatController.text = widget.rs.alamat;
    _noTelpController.text = widget.rs.noTelp;
    _typeController.text = widget.rs.type;
    _latController.text = widget.rs.lat.toString();
    _lngController.text = widget.rs.lng.toString();
  }

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
      final response = await http.put(
        Uri.parse('http://192.168.192.246:8000/api/rs/${widget.rs.id}'),
        headers: {
          'Content-Type': 'application/json',
          'x-api-key': 'reqres-free-v1', // opsional
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

      if (response.statusCode == 200 || response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Data rumah sakit berhasil diperbarui')),
        );
        Navigator.pop(context, true);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Gagal update: ${response.statusCode}')),
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
        title: const Text('Edit Rumah Sakit'),
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 30),
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
                  labelText: 'Tipe RS',
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
                      onPressed: _simpanRs,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.lightGreenAccent,
                      ),
                      child: const Text(
                        'Simpan Perubahan',
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
