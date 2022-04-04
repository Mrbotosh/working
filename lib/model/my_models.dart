// ignore_for_file: constant_identifier_names

import 'package:flutter/foundation.dart';

enum Cinsiyet {
  KADIN,

  ERKEK,
  COCUK,
}
enum Renk {
  SARI,
  YESIL,
  KIRMIZI,
  MAVI,
}

class UserInformation {
  String isim;
  Cinsiyet cinsiyet;
   List<String> renk;
  bool evliMi;
  UserInformation(
    this.isim,
    this.cinsiyet,
    this.renk,
    this.evliMi,
  );
 Map<String,dynamic> tojson(){
   return {
     "isim":isim,
     "cinsiyet":describeEnum(cinsiyet),
     "renk":renk,
     "evliMi":evliMi,
   };
 }
  UserInformation.fromjson(Map<String,dynamic> json)
  : isim=json["isim"],
  cinsiyet=Cinsiyet.values.firstWhere((element) => describeEnum(element).toString()==json["cinsiyet"]),
  renk=List<String>.from(json["renk"]),
  evliMi=json["evliMi"];


}
