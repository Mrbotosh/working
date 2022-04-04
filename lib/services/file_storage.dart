import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:hive_app/model/my_models.dart';
import 'package:hive_app/services/local_storage_services.dart';
import 'package:path_provider/path_provider.dart';

class FileStorageServices implements LocalStorageServices {
  _getFilePath() async {
    var FilePath = await getApplicationDocumentsDirectory();
    debugPrint(FilePath.path);
    return FilePath.path;
  }

  FileStorageServices() {
    _createFile();
  }
  Future<File> _createFile() async {
    var file = File(await _getFilePath() + "/info.json");
    return file;
  }

  Future<void> veriKaydet(UserInformation userInformation) async {
    var file = await _createFile();
    await file.writeAsString(jsonEncode(userInformation.tojson()));
  }

  Future<UserInformation> veriOku() async {
    try {
      var file = await _createFile();
      var fileString = await file.readAsString();
      var json = jsonDecode(fileString);
      return UserInformation.fromjson(json);
    } catch (e) {
      debugPrint(e.toString());
    }
    return UserInformation("", Cinsiyet.COCUK, <String>[], true);
  }
}
