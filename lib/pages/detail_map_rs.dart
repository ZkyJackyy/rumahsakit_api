import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rumahsakit_api/model/model_rs.dart'; // Ganti sesuai lokasi file modelmu

class DetailMapRs extends StatelessWidget {
  final ModelRs rs;

  const DetailMapRs({super.key, required this.rs});

  @override
  Widget build(BuildContext context) {
    final LatLng position = LatLng(rs.lat, rs.lng);

    return Scaffold(
      appBar: AppBar(title: Text(rs.nama)),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: position,
          zoom: 15.0,
        ),
        markers: {
          Marker(
            markerId: MarkerId(rs.id.toString()),
            position: position,
            infoWindow: InfoWindow(title: rs.nama, snippet: rs.alamat),
          ),
        },
      ),
    );
  }
}

