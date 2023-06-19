import 'package:location/location.dart';

class LocationService {
  static Future<bool> checkLocationPermission() async {
    var location = Location();

    // İzin durumunu kontrol et
    var permission = await location.hasPermission();

    // Eğer izin verilmişse true döndür
    if (permission == PermissionStatus.granted) {
      return true;
    }

    // Eğer izin reddedilmişse veya kullanıcıdan onay bekliyorsa false döndür
    if (permission == PermissionStatus.denied ||
        permission == PermissionStatus.deniedForever) {
      return false;
    }

    // Eğer izin isteği henüz yapılmamışsa, izin isteği gönder ve sonucunu dön
    var requestedPermission = await location.requestPermission();
    return requestedPermission == PermissionStatus.granted;
  }

  static Future<bool> requestLocationPermission() async {
    var location = Location();
    var permissionStatus = await location.requestPermission();
    return permissionStatus == PermissionStatus.granted;
  }

  static Future<LocationData?> getCurrentLocation() async {
    var location = Location();
    var hasPermission = await checkLocationPermission();

    if (hasPermission) {
      return await location.getLocation();
    }

    return null;
  }
}