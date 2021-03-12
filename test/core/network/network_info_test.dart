import 'package:flutter_test/flutter_test.dart';
import 'package:cross_connectivity/cross_connectivity.dart';
import 'package:mockito/mockito.dart';
import 'package:teste_flutter/core/network/network_info.dart';

class MockConnectivity extends Mock implements Connectivity {}

void main() {
  NetworkInfoImpl networkInfo;
  MockConnectivity mockConnectivity;

  setUp(() {
    mockConnectivity = MockConnectivity();
    networkInfo = NetworkInfoImpl(mockConnectivity);
  });

  group('isConnected', () {
    test("should forward the call to Connectivity.checkConnection()", () async {
      //arrange

      when(mockConnectivity.checkConnection()).thenAnswer((_) async => true);
      //actual
      final result = await networkInfo.isConnected;
      // arrange
      verify(mockConnectivity.checkConnection());
      expect(result, true);
    });
  });
}
