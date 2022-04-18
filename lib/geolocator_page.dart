import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'information_block_widget.dart';

class GeolocatorPage extends StatefulWidget {
  const GeolocatorPage({Key? key}) : super(key: key);

  @override
  State<GeolocatorPage> createState() => _GeolocatorPageState();
}

class _GeolocatorPageState extends State<GeolocatorPage> {
  Position _positionAsync = const Position(
    longitude: 0,
    latitude: 0,
    accuracy: 0,
    altitude: 0,
    heading: 0,
    speed: 0,
    speedAccuracy: 0,
    timestamp: null,
  );

  Position _position = const Position(
    longitude: 0,
    latitude: 0,
    accuracy: 0,
    altitude: 0,
    heading: 0,
    speed: 0,
    speedAccuracy: 0,
    timestamp: null,
  );

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission locationPermission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (serviceEnabled == false) {
      return Future.error('É necessário ativar a localização.');
    }

    locationPermission = await Geolocator.checkPermission();
    if (locationPermission == LocationPermission.denied) {
      locationPermission = await Geolocator.requestPermission();

      if (locationPermission == LocationPermission.denied) {
        return Future.error('É necessário permitir o uso da localização.');
      }
    }

    if (locationPermission == LocationPermission.deniedForever) {
      return Future.error(
          'O uso do serviço de localização está negado para sempre. Necessário alterar a configuração manualmente para permitir.');
    }

    Position position = await Geolocator.getCurrentPosition();

    print('Permissão da localização definida como $locationPermission');
    print('Serviço de localização está ativo? $serviceEnabled');
    print('Posição encontrada é $position');

    return position;
  }

  void _setStatePosition() async {
    _positionAsync = await _determinePosition();

    setState(() {
      _position = _positionAsync;
    });
  }

  void _resetCoordinates() {
    setState(() {
      _position = const Position(
        longitude: 0,
        latitude: 0,
        accuracy: 0,
        altitude: 0,
        heading: 0,
        speed: 0,
        speedAccuracy: 0,
        timestamp: null,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Incrível Geolocalizador',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Geolocalizador'),
          actions: [
            IconButton(
              icon: const Icon(Icons.restart_alt_outlined),
              onPressed: _resetCoordinates,
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 80.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              InformationBlockWidget(
                  textToDisplay: 'Longitute: ${_position.longitude}°'),
              const SizedBox(height: 50),
              InformationBlockWidget(
                  textToDisplay: 'Latitude: ${_position.latitude}°'),
              const SizedBox(height: 50),
              InformationBlockWidget(
                  textToDisplay: 'Altitude: ${_position.altitude}m'),
              const SizedBox(height: 50),
              InformationBlockWidget(
                  textToDisplay: 'Precisão: ${_position.accuracy}m'),
            ],
          ),
        ),
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 18.0),
          child: OutlinedButton(
            child: const Text(
              'Pegar Localização',
              style: TextStyle(
                fontSize: 20,
                // color: Colors.white,
              ),
            ),
            onPressed: () async {
              print('Apertou o botão de localização.');

              _setStatePosition();
            },
          ),
        ),
      ),
    );
  }
}
