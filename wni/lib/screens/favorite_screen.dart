import 'package:flutter/material.dart';
import 'package:wni/components/round_card.dart';
import 'package:wni/services/post_service.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorite'),
      ),
      body: StreamBuilder(
        stream: PostService.getFavoriteWisataList(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return const Center(
                child: CircularProgressIndicator(),
              );
            default:
              return ListView(
                padding: const EdgeInsets.only(bottom: 80),
                children: snapshot.data!.map((document) {
                  return RoundCard(
                    wisata: document,
                    withBottom: false,
                  );
                }).toList(),
              );
          }
        },
      ),
    );
  }
}
- google_map_screen
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapScreen extends StatefulWidget {
  final String? lat;
  final String? lng;
  const GoogleMapScreen(this.lat, this.lng, {super.key});

  @override
  State<GoogleMapScreen> createState() => _GoogleMapScreenState();
}

class _GoogleMapScreenState extends State<GoogleMapScreen> {
  final Completer<GoogleMapController> _controller = Completer();
  late CameraPosition _cameraPosition;
  late Set<Marker> _markers;
  late MarkerId _markerId;

  @override
  void initState() {
    super.initState();
    _cameraPosition = CameraPosition(
        target: LatLng(
          double.parse(widget.lat.toString()),
          double.parse(widget.lng.toString()),
        ),
        zoom: 15);
    _markers = {};
    _markerId = MarkerId(widget.lat.toString() + widget.lng.toString());
    _markers.add(
      Marker(
          markerId: _markerId,
          position: LatLng(
            double.parse(widget.lat.toString()),
            double.parse(widget.lng.toString()),
          ),
          infoWindow: const InfoWindow(title: 'Your Location', snippet: '...')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Google Map'),
      ),
      body: GoogleMap(
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
        mapType: MapType.normal,
        initialCameraPosition: _cameraPosition,
        markers: _markers,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
          Future.delayed(const Duration(microseconds: 500), () {
            controller.showMarkerInfoWindow(_markerId);
          });
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _goToLocation,
        label: const Text('To YOur Location'),
        icon: const Icon(Icons.directions_car),
      ),
    );
  }

  Future<void> _goToLocation() async {
    final GoogleMapController controller = await _controller.future;
    await controller.animateCamera(
      CameraUpdate.newCameraPosition(
        _cameraPosition,
      ),
    );
  }
}
