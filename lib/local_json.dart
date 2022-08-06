import 'dart:convert';

import 'package:flutter/material.dart';

import 'model/araba_model.dart';

class LocalJson extends StatefulWidget {
  const LocalJson({Key? key}) : super(key: key);

  @override
  State<LocalJson> createState() => _LocalJsonState();
}

class _LocalJsonState extends State<LocalJson> {
  String _title = "Local Json Islemleri";
  late final Future<List<Araba>> _listeyiDoldur;
  @override
  void initState() {
    super.initState();
    _listeyiDoldur = arabalarJsonOku();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_title),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _title = "Buton tıklandı";
          });
        },
      ),
      body: FutureBuilder<List<Araba>>(
        future: _listeyiDoldur,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Araba> arabaListesi = snapshot.data!;
            return ListView.builder(
                itemCount: arabaListesi.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(arabaListesi[index].carName),
                    subtitle: Text(arabaListesi[index].country),
                    leading: CircleAvatar(
                      child:
                          Text(arabaListesi[index].model[0].price.toString()),
                    ),
                  );
                });
          } else if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  Future<List<Araba>> arabalarJsonOku() async {
    try {
      String okunanString = await DefaultAssetBundle.of(context)
          .loadString("assets/data/arabalar.json");

      var jsonObject = jsonDecode(okunanString);
      // debugPrint(okunanString);
      // debugPrint("**************");
      // List arabaListesi = jsonObject;

      // debugPrint(arabaListesi[1]["model"][0]["fiyat"].toString());
      // (jsonObject as List).map((e) => debugPrint(e.toString()));

      List<Araba> tumArabalar = (jsonObject as List)
          .map((arabaMap) => Araba.fromMap(arabaMap))
          .toList();

      debugPrint(tumArabalar[1].year.toString());

      return tumArabalar;
    } catch (e) {
      debugPrint(e.toString());
      return Future.error("HATA");
    }
  }
}
