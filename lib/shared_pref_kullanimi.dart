import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive_app/main.dart';
import 'package:hive_app/model/my_models.dart';
import 'package:hive_app/services/file_storage.dart';
import 'package:hive_app/services/local_storage_services.dart';
import 'package:hive_app/services/local_storage_services.dart';
import 'package:hive_app/services/secure_store_servicess.dart';
import 'package:hive_app/services/shared_pref_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefKullanim extends StatefulWidget {
  const SharedPrefKullanim({Key? key}) : super(key: key);

  @override
  State<SharedPrefKullanim> createState() => _SharedPrefKullanimState();
}

class _SharedPrefKullanimState extends State<SharedPrefKullanim> {
  var _secilenCinsiyet = Cinsiyet.KADIN;
  var _secilenRenk = <String>[];
  var _evliMi = false;
  TextEditingController _name = TextEditingController();
  final LocalStorageServices _prefencesService =locator<LocalStorageServices>();
 
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _verileriOku();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Shared Preferences Kullanımı"),
      ),
      body: ListView(
        children: [
          ListTile(
            title: TextField(
              controller: _name,
              decoration: InputDecoration(labelText: "Adınızı Giriniz"),
            ),
          ),
          for (var item in Cinsiyet.values)
            _buildRadioListTiles(describeEnum(item), item),
          for (var item in Renk.values) _buildCheckBoxListTiles(item),
          SwitchListTile(
              title: Text("evli misin?"),
              value: _evliMi,
              onChanged: (evliMi) {
                setState(() {
                  _evliMi = evliMi;
                });
              }),
          TextButton(
            onPressed: () {
              var _userInformation = UserInformation(
                  _name.text, _secilenCinsiyet, _secilenRenk, _evliMi);
              _prefencesService.veriKaydet(_userInformation);
            },
            child: Text("SAVE"),
          ),
        ],
      ),
    );
  }

  Widget _buildRadioListTiles(String title, Cinsiyet value) {
    return RadioListTile(
      title: Text(title),
      value: value,
      groupValue: _secilenCinsiyet,
      onChanged: (Cinsiyet? deger) {
        setState(
          () {
            _secilenCinsiyet = deger!;
          },
        );
      },
    );
  }

  Widget _buildCheckBoxListTiles(Renk renk) {
    return CheckboxListTile(
        title: Text(
          describeEnum(renk),
        ),
        value: _secilenRenk.contains(describeEnum(renk)),
        onChanged: (bool? deger) {
          if (deger == true) {
            _secilenRenk.add(describeEnum(renk));
          } else {
            _secilenRenk.remove(describeEnum(renk));
          }
          setState(() {});
          debugPrint(_secilenRenk.toString());
        });
  }

  void _verileriOku() async {
    var info = await _prefencesService.veriOku();
    _name.text = info.isim;
    _evliMi = info.evliMi;
    _secilenCinsiyet = info.cinsiyet;
    _secilenRenk = info.renk;
    setState(() {});
  }
}
