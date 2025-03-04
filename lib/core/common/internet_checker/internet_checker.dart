import 'package:connectivity_plus/connectivity_plus.dart';

class InternetChecker {
  Future<bool> isConnected() async {
    var result = await Connectivity().checkConnectivity();
    return result != ConnectivityResult.none;
  }
}
