import 'package:flutter/material.dart';
import 'package:pokedex/models/database_helper.dart';
import 'package:pokedex/models/myPokemonCardUI.dart';


class SortTypes extends StatefulWidget {
  String typename;
  SortTypes({required this.typename});

  @override
  _SortTypesState createState() => _SortTypesState();
}

class _SortTypesState extends State<SortTypes> {
  late Future<List<Map<String, dynamic>>> initialization;
  late int typenumber;

  Future<List<Map<String, dynamic>>> _initializeData() async {
    await _getTypeno();
    return await _getPokemon();
  }

  Future<void> _getTypeno() async {
    var temp = await DatabaseHelper.instance.customQuery("SELECT id FROM Types WHERE name = '${widget.typename}'");
     if(temp != null && temp.isNotEmpty && temp[0]["id"] != null) {
            typenumber = temp[0]["id"];
     }
    
  }

  Future<List<Map<String, dynamic>>> _getPokemon() async {
    print("type: " + typenumber.toString());
    
    return await DatabaseHelper.instance.customQuery('SELECT * FROM Pokemon WHERE type1 = "${typenumber}" OR type2 = "${typenumber}" ');
  }

  @override
  void initState() {
    super.initState();
    initialization = _initializeData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.typename),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder<List<Map<String, dynamic>>>(
              future: initialization,
              builder: (BuildContext context,
                  AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  }
                  
                  final data = snapshot.data!;

                  return ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (BuildContext context, int index) {
                      if (data[index] != null ){
                      var type2 = data[index]['type2'];
                      print(type2);
                      if (type2 == null) {
                        type2 = 0;
                      }
                      return MyPokemonCard(
                        name: data[index]['name'].toString(),
                        id: data[index]['id'].toString(),
                        imageUrl: data[index]['image_url'].toString(),
                        type: data[index]['type1'],
                        type2: type2,
                      );
                      }
                    },
                  );
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
  



