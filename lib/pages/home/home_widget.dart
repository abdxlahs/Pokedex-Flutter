import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:pokedex/models/database_helper.dart';
import 'package:pokedex/models/CardUI.dart';


class HomeWidget extends StatefulWidget {
  const HomeWidget({Key? key}) : super(key: key);

  @override
  _HomeWidgetState createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  late Future<List<Map<String, dynamic>>> _data;
  late Future<List<Map<String, dynamic>>> _types;
  late Future<List<Map<String, dynamic>>> _custom;
  
  @override
  void initState() {
    super.initState();
    _data = DatabaseHelper.instance.customQuery('SELECT * FROM Pokemon');
    _types = DatabaseHelper.instance.customQuery('SELECT * FROM Types');

    
                                                        
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("Pokèdex"),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>> (
        future: _data,
        builder: (BuildContext context, AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }
            final data = snapshot.data!;
            return ListView.builder (
              itemCount: data.length,
              itemBuilder: (BuildContext context, int index) {
                var type2=data[index]['type2'];
                print(type2);
                if(type2 == null ){
                  type2 = 0;
                }
                return MyPokemonCard (
                  name: data[index]['name'].toString(),
                  id: data[index]['id'].toString(),
                  imageUrl:data[index]['image_url'].toString(),
                  type: data[index]['type1'],
                  type2: type2
                  // Replace 'columnName' with the actual column name from your table
                );
              },
              
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}