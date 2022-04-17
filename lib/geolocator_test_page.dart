import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import './coordinate_widget.dart';

class GeolocatorTestPage extends StatefulWidget {
  const GeolocatorTestPage({Key? key}) : super(key: key);

  @override
  State<GeolocatorTestPage> createState() => _GeolocatorTestPageState();
}

class _GeolocatorTestPageState extends State<GeolocatorTestPage> {
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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Awesome Geolocator',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Geolocator Test'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CoordinateWidget(
                textToDisplay: 'Longitute: ${_position.longitude}'),
            CoordinateWidget(textToDisplay: 'Latitude: ${_position.latitude}'),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.location_on),
          tooltip: 'Aperte para buscar a localização atual',
          onPressed: () async {
            print('Apertou o botão de localização.');

            _setStatePosition();
          },
        ),
      ),
    );
  }
}
