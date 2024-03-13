import 'package:flutter/material.dart';
import 'package:network_info_plus/network_info_plus.dart';
import 'package:permission_handler/permission_handler.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: Check());
  }
}

class Check extends StatefulWidget {
  const Check({super.key});

  @override
  State<Check> createState() => _CheckState();
}

class _CheckState extends State<Check> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('BSSID Example'),
        ),
        body: Center(
          child: ElevatedButton(
            onPressed: () async {
              await getBssid();
            },
            child: Text('Get BSSID'),
          ),
        ),
      ),
    );
  }

  Future<void> getBssid() async {
    // Yêu cầu quyền ACCESS_FINE_LOCATION
    var status = await Permission.locationWhenInUse.request();
    if (status.isGranted) {
      NetworkInfo networkInfo = NetworkInfo();
      final wifiBssid = await networkInfo.getWifiBSSID();
      final wifiBroadcast = await networkInfo.getWifiBroadcast();
      final wifiGatewayIP = await networkInfo.getWifiGatewayIP();
      final WifiIP = await networkInfo.getWifiIP();
      final wifiName = await networkInfo.getWifiName();
      final wifiSubmask = await networkInfo.getWifiSubmask();
      final wifiIpv6 = await networkInfo.getWifiIPv6();
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('BSSID Information'),
            content: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('BSSID: $wifiBssid'),
                  Text('Wifi Broadcast: $wifiBroadcast'),
                  Text('Wifi Gateway IP: $wifiGatewayIP'),
                  Text('Wifi IP: $WifiIP'),
                  Text('Wifi Name: $wifiName'),
                  Text('Wifi Submask: $wifiSubmask'),
                  Text('Wifi IPv6: $wifiIpv6'),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Close'),
              ),
            ],
          );
        },
      );
    } else {
      // Người dùng từ chối quyền, xử lý ở đây (ví dụ: hiển thị thông báo)
      // Handle permission denial
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Permission Denied'),
            content: Text(
                'Location permission is required to get BSSID information.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Close'),
              ),
            ],
          );
        },
      );
    }
  }
}
