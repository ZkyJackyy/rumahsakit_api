import 'package:flutter/material.dart';
import 'package:rumahsakit_api/model/model_rs.dart';
import 'package:http/http.dart' as http;
import 'package:rumahsakit_api/pages/add_rs.dart';
import 'package:rumahsakit_api/pages/detail_list.dart';
import 'package:rumahsakit_api/pages/detail_map_rs.dart';
import 'package:rumahsakit_api/pages/edit_rs.dart';

class ListRs extends StatefulWidget {
  const ListRs({super.key});

  @override
  State<ListRs> createState() => _ListRsState();
}

class _ListRsState extends State<ListRs> {
  late Future<List<ModelRs>> futureRs;

  Future<List<ModelRs>> getDataRs() async {
    final response = await http.get(
      Uri.parse('http://192.168.192.246:8000/api/rs/'),
      headers: {'x-api-key': 'reqres-free-v1'},
    );

    if (response.statusCode == 200) {
      return modelRsFromJson(response.body);
    } else {
      throw Exception('Gagal memuat data. Status: ${response.statusCode}');
    }
  }

  @override
  void initState() {
    super.initState();
    futureRs = getDataRs();
  }

  Future<void> hapusRS(int id) async {
    final response = await http.delete(
      Uri.parse('http://192.168.192.246:8000/api/rs/$id'),
      headers: {'x-api-key': 'reqres-free-v1'},
    );

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Data Rumah sakit berhasil dihapus')),
      );
      setState(() {
        futureRs = getDataRs();
      });
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Gagal menghapus data')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('List Rumah Sakit'),
      ),
      body: FutureBuilder<List<ModelRs>>(
        future: futureRs,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Tidak ada data dosen'));
          } else {
            final rsList = snapshot.data!;
            return ListView.builder(
              itemCount: rsList.length,
              itemBuilder: (context, index) {
                final rs = rsList[index];
                return Card(
                  color: Colors.white,
                  margin: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(18),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                rs.nama,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),

                            IconButton(
                              icon: const Icon(Icons.edit, color: Colors.blue),
                              onPressed: () async {
                                final result = await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => EditRs(rs: rs),
                                  ),
                                );
                                if (result == true) {
                                  setState(() {
                                    futureRs = getDataRs();
                                  });
                                }
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder:
                                      (ctx) => AlertDialog(
                                        backgroundColor: Colors.white,
                                        title: const Text('Konfirmasi'),
                                        content: const Text(
                                          'Yakin ingin menghapus data ini?',
                                        ),
                                        actions: [
                                          TextButton(
                                            onPressed: () => Navigator.pop(ctx),
                                            child: const Text('Batal'),
                                          ),
                                          ElevatedButton(
                                            onPressed: () {
                                              Navigator.pop(ctx);
                                              hapusRS(
                                                rs.id,
                                              ); // Pastikan ModelDosen punya id
                                            },
                                            child: const Text('Hapus'),
                                          ),
                                        ],
                                      ),
                                );
                              },
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Type: ${rs.type}',
                          style: const TextStyle(fontSize: 14),
                        ),
                        SizedBox(height: 4),
                        Text('Alamat:'),
                        Text(
                          rs.alamat,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'No telp: ${rs.noTelp}',
                          style: const TextStyle(fontSize: 14),
                        ),
                        
                        SizedBox(height: 10,),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DetailRsWithMap(rs: rs,),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                              foregroundColor: Colors.white, // warna teks
                              padding: const EdgeInsets.symmetric(
                                vertical: 16,
                              ), // tinggi tombol
                            ),
                            child: const Text('View Details'),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => TambahRs()),
          );
          if (result == true) {
            // Refresh data
            setState(() {
              futureRs = getDataRs();
            });
          }
        },
        backgroundColor: const Color.fromARGB(255, 247, 220, 126),
        child: const Icon(Icons.add),
      ),
    );
  }
}
