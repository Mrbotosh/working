import 'package:hive_app/model/my_models.dart';
import 'package:hive_app/services/local_storage_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceservices implements LocalStorageServices{
  late final SharedPreferences preferences;
  SharedPreferenceservices(){
    init();
  }
  Future<void> init()async{
     final preferences = await SharedPreferences.getInstance();
  }
  
 @override
  Future <void> veriKaydet(UserInformation userInformation) async {
    
    final name = userInformation.isim;
    preferences.setString("isim", name);
    preferences.setBool("medeni", userInformation.evliMi);
    preferences.setInt("cinsiyet", userInformation.cinsiyet.index);
    preferences.setStringList("renk", userInformation.renk);
  }
  
  @override
  Future<UserInformation> veriOku() async{
   
    var _isim= preferences.getString("isim") ?? "";
   var _evliMi = preferences.getBool("medeni") ?? true;
    var _cinsiyet = Cinsiyet.values[preferences.getInt("cinsiyet") ?? 0];
    var _renk = preferences.getStringList("renk") ?? <String>[];
    return UserInformation(_isim, _cinsiyet, _renk, _evliMi);
  }

}