import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:cloudy_bulletin/infrastructure/controllers/home_controller.dart';

class ConnectivityGuard extends StatefulWidget {
  final Widget child;

  const ConnectivityGuard({super.key, required this.child});

  @override
  State<ConnectivityGuard> createState() => _ConnectivityGuardState();
}

class _ConnectivityGuardState extends State<ConnectivityGuard> {
  bool _hasInternet = true;
  bool _hasLocation = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => checkServices());
  }

  ///
  ///Check both internet and location are available
  ///
  Future<void> checkServices() async {
    final hasInternet = await hasInternetConnection();
    final hasLocation = await Geolocator.isLocationServiceEnabled();

    setState(() {
      _hasInternet = hasInternet;
      _hasLocation = hasLocation;
    });

    if (!hasInternet || !hasLocation) {
      showConnectionPopup();
    } else {
      if (Get.isRegistered<HomeController>()) {
        Get.find<HomeController>().fetchWeatherAndNews();
      }
    }
  }

  ///
  ///check for internet connection
  ///
  Future<bool> hasInternetConnection() async {
    final result = await Connectivity().checkConnectivity();
    if (result == ConnectivityResult.none) return false;

    try {
      final lookup = await InternetAddress.lookup('example.com');
      return lookup.isNotEmpty && lookup[0].rawAddress.isNotEmpty;
    } catch (_) {
      return false;
    }
  }

  void showConnectionPopup() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder:
          (_) => AlertDialog(
            title: Text("Connection Required"),
            content: Text(
              !_hasInternet && !_hasLocation
                  ? 'Please enable Internet and Location services.'
                  : !_hasInternet
                  ? 'Please enable Internet connection.'
                  : 'Please enable Location services.',
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  checkServices();
                },
                child: Text("OK"),
              ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
