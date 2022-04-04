
import 'package:hive_app/model/my_models.dart';

abstract class LocalStorageServices{
 Future<void> veriKaydet(UserInformation userInformation);
 Future<UserInformation> veriOku();
 
}