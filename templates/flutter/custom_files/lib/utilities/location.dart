// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'snackbars.dart';

double getDistance(Position position, double latitude, double longitude) {
  return Geolocator.distanceBetween(
    position.latitude,
    position.longitude,
    latitude,
    longitude,
  );
}

Future<Position> determinePosition(BuildContext context) async {
  bool serviceEnabled;
  LocationPermission permission;

  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    showErrorSnackBar(context, 'Serviço de localização desativado.');
    return Future.error('Serviço de localização desativado.');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await handleGeolocatorPermissionDenied(context);
  }

  if (permission == LocationPermission.deniedForever) {
    showErrorSnackBar(
      context,
      'Permissão de localização negada permanentemente.',
    );
    return Future.error('Permissão de localização negada permanentemente.');
  }

  return await Geolocator.getCurrentPosition();
}

Future<LocationPermission> handleGeolocatorPermissionDenied(
  BuildContext context,
) async {
  LocationPermission permission = await Geolocator.requestPermission();
  if (permission == LocationPermission.denied) {
    showErrorSnackBar(context, 'Permissão de localização negada.');
    return Future.error('Permissão de localização negada.');
  }

  return permission;
}
