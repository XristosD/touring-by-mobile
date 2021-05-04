import 'package:device_info/device_info.dart';

class DeviceInfoService {
  final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

  Future<String> deviceName() async {
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    String deviceName = androidInfo.model;
    return deviceName;
  }

}