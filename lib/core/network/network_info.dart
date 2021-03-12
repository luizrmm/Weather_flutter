import 'package:cross_connectivity/cross_connectivity.dart';

abstract class NetworkInfo {
  Future<bool> get isConnected;
}

class NetworkInfoImpl implements NetworkInfo {
  final Connectivity connectivity;

  NetworkInfoImpl(this.connectivity);

  Future<bool> get isConnected => connectivity.checkConnection();
}
