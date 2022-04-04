import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive_app/model/my_models.dart';
import 'package:hive_app/services/local_storage_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SecureStorageservices implements LocalStorageServices {
  late final FlutterSecureStorage preferences;
  SecureStorageservices(){
    var preferences = FlutterSecureStorage();
  }
  
  Future<void> veriKaydet(UserInformation userInformation) async {
    final name = userInformation.isim;
    await preferences.write(key: "isim", value: name);
    await preferences.write(
        key: "medeni", value: userInformation.evliMi.toString());
    await preferences.write(
        key: "cinsiyet", value: userInformation.cinsiyet.index.toString());
    await preferences.write(
        key: "renk", value: jsonEncode(userInformation.renk));
  }

  Future<UserInformation> veriOku() async {
    var _isim = await preferences.read(key: "isim") ?? "";
    var _evliMiString = await preferences.read(key: "medeni") ?? "false";
    var _evliMi = _evliMiString.toLowerCase() == "true" ? true : false;
    var _cinsiyetString = await preferences.read(key: "cinsiyet") ?? "0";
    var _cinsiyet = Cinsiyet.values[int.parse(_cinsiyetString)];
    var _renkString = await preferences.read(key: "renk");
    var _renk = _renkString == null
        ? <String>[]
        : List<String>.from(jsonDecode(_renkString));
    return UserInformation(_isim, _cinsiyet, _renk, _evliMi);
  }
}
