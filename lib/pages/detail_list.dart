import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rumahsakit_api/model/model_rs.dart';

class DetailRsWithMap extends StatelessWidget {
  final ModelRs rs;

  const DetailRsWithMap({super.key, required this.rs});

  @override
  Widget build(BuildContext context) {
    final LatLng position = LatLng(rs.lat, rs.lng);

    return Scaffold(
      appBar: AppBar(
        title: Text(rs.nama),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          // DETAIL SECTION
          Container(
            padding: const EdgeInsets.all(16),
            width: double.infinity,
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  rs.nama,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueAccent,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.local_hospital, size: 20),
                    const SizedBox(width: 6),
                    Text(
                      'Type: ${rs.type}',
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.location_on, size: 20),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        rs.alamat,
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.phone, size: 20),
                    const SizedBox(width: 6),
                    Text(
                      rs.noTelp,
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const Divider(height: 1),

          // GOOGLE MAP SECTION
          Expanded(
            child: GoogleMap(
              initialCameraPosition: CameraPosition(
                target: position,
                zoom: 15.0,
              ),
              markers: {
                Marker(
                  markerId: MarkerId(rs.id.toString()),
                  position: position,
                  infoWindow: InfoWindow(
                    title: rs.nama,
                    snippet: rs.alamat,
                  ),
                ),
              },
            ),
          ),
        ],
      ),
    );
  }
}
