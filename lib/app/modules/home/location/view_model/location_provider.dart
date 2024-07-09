import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

import '../../../../helpers/loading_overlay.dart';
import '../../../../utils/prefferences.dart';

class LocationProvider extends ChangeNotifier {
  /*...........Location.............*/

  final searchbarText = TextEditingController();
  String location = 'Choose a location';

  double longitude = 0.0;
  double latitude = 0.0;
  String country = '';
  String street = '';
  String state = '';
  String selectedLocation = '';
  String postalCode = '';
  String subLocality = '';

  Position? currentPosition;
  String currentAddress = "Location";
  String? choosedLocation;

  String currentcountry = '';

  Future<Position> determinePosition({required BuildContext context}) async {
    LocationPermission permission;

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        double defaultLatitude = 20.5937;
        double defaultLongitude = 78.9629;
        await getAddressFromLatLng(
            latitude: defaultLatitude,
            longitude: defaultLongitude,
            context: context);
        return Position(
          latitude: defaultLatitude,
          longitude: defaultLongitude,
          timestamp: DateTime.now(),
          accuracy: 0.0,
          altitude: 0.0,
          altitudeAccuracy: 0.0,
          heading: 0.0,
          speed: 0.0,
          speedAccuracy: 0.0,
          headingAccuracy: 0.0,
        );
      }
    }
    if (permission == LocationPermission.deniedForever) {
      double defaultLatitude = 20.5937;
      double defaultLongitude = 78.9629;
      await getAddressFromLatLng(
          latitude: defaultLatitude,
          longitude: defaultLongitude,
          context: context);
      return Position(
        latitude: defaultLatitude,
        longitude: defaultLongitude,
        timestamp: DateTime.now(),
        accuracy: 0.0,
        altitude: 0.0,
        altitudeAccuracy: 0.0,
        heading: 0.0,
        speed: 0.0,
        speedAccuracy: 0.0,
        headingAccuracy: 0.0,
      );
    }
    LoadingOverlay.of(context).show();

    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.best,
    );
    await getAddressFromLatLng(
        latitude: position.latitude,
        longitude: position.longitude,
        context: context);
    LoadingOverlay.of(context).hide();
    return position;
  }

  getLocation({context}) async {
    final pos = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);
    longitude = pos.longitude;
    latitude = pos.latitude;

    await getAddressFromLatLng(
        latitude: latitude, longitude: longitude, context: context);
  }

  getZipCodeLocation({context}) async {
    List<Location> locations = await locationFromAddress(searchbarText.text);

    // Display location information
    if (locations.isNotEmpty) {
      latitude = locations.first.latitude;
      longitude = locations.first.longitude;
      getAddressFromLatLng(
          latitude: latitude, longitude: longitude, context: context);
      searchbarText.clear();
      notifyListeners();
    } else {
      searchbarText.clear();
      notifyListeners();
    }
    notifyListeners();
  }

  getAddressFromLatLng(
      {required double latitude,
      required double longitude,
      required context}) async {
    try {
      List<Placemark> p = await placemarkFromCoordinates(latitude, longitude);

      Placemark place = p[0];

      String locality = place.locality.toString();
      currentAddress = locality;
      AppPref.country = place.country.toString();

      country = place.country.toString();
      street = (place.name ?? '') + (place.street ?? '');
      state = place.administrativeArea ?? "";
      postalCode = place.postalCode ?? "";
      subLocality = place.subLocality ?? '';
    } finally {
      notifyListeners();
    }
  }
}
