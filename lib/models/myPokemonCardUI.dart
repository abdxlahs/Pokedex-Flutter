import 'package:flutter/material.dart';
import 'package:pokedex/models/database_helper.dart';

class MyPokemonCard extends StatefulWidget {
  final String name;
  final String id;
  final String imageUrl;
  final int type;
  final int type2;

  MyPokemonCard({required this.name, required this.id, required this.imageUrl, required this.type, required this.type2 });

  @override
  State<MyPokemonCard> createState() => _MyPokemonCardState();
}

class _MyPokemonCardState extends State<MyPokemonCard> {
  late Future<String> typeName;
  late Future<String> type2Name;

  @override
  void initState() {
    super.initState();
    typeName = _getType() ;
    type2Name= _getsecondType();
    
  }
 
  Future<String> _getType() async {
    var temp = await DatabaseHelper.instance.customQueryWithArgs("select name from Types where id = ?", [widget.type]);
    return temp[0]["name"].toString();
  }

  Future<String> _getsecondType() async {
    if(widget.type2!=0){
    var temp = await DatabaseHelper.instance.customQueryWithArgs("select name from Types where id = ?", [widget.type2]);
    return temp[0]["name"].toString();
    }
    return '0';
  }



  Color getAvatarColor(String typeName) {
    switch (typeName) {
      case 'fire':
      return Color(0xFFFF5722-0x2);
    case 'water':
      return Color(0xFF2196F3);
    case 'grass':
      return Color(0xFF4CAF50);
    case 'electric':
      return Color(0xFFFFEB3B);
    case 'psychic':
      return Color(0xFFF44336);
    case 'dragon':
      return Color(0xFF673AB7);
    case 'normal':
      return Color(0xFF9E9E9E);
    case 'fighting':
      return Color(0xFFD84315);
    case 'flying':
      return Color(0xFF90CAF9);
    case 'poison':
      return Color(0xFF9C27B0);
    case 'ground':
      return Color(0xFF795548);
    case 'rock':
      return Color(0xFF607D8B);
    case 'bug':
      return Color(0xFF8BC34A);
    case 'ghost':
      return Color(0xFF7B1FA2);
    case 'steel':
      return Color(0xFF9E9E9E);
    case 'fairy':
      return Color(0xFFF48FB1);
    case 'dark':
      return Color(0xFF212121);
    case 'ice':
      return Color(0xFF80D8FF);
    default:
      return Color(0xFFFFCB05);
    }
  }

  @override
  Widget build(BuildContext context) {
  return FutureBuilder<List<String>>(
    future: Future.wait([typeName,type2Name]),
    builder: (BuildContext context, AsyncSnapshot<List<String>> snapshot) {
      if (snapshot.connectionState == ConnectionState.done) {
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }
        final typeName = snapshot.data![0];
        final type2Name = snapshot.data![1];
        return Container(
          width: double.infinity,
          height: 300,
          child:Card(
          color: (getAvatarColor(typeName)),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          elevation: 5.0,
          child: Padding(
            padding: EdgeInsets.all(5),
            child: 
            Column(
              children: 
      [
                Align(
                alignment:Alignment.topLeft,
               child: Text(
                  '#${widget.id}',
                  style: TextStyle(fontSize: 20.0,color: Colors.white),
                )
                ),
                Padding(
                  padding: EdgeInsets.only(top:0.5),
                    child: CircleAvatar(
                    backgroundColor: getAvatarColor(typeName),
                    backgroundImage: NetworkImage(widget.imageUrl),
                    radius: 75,
                ),
                ),
                Padding(
                padding:EdgeInsets.only(top:15),
                 child: Text(
                  '${widget.name.toUpperCase()}',
                  style: TextStyle(fontSize: 20.0,color: Colors.white,fontWeight: FontWeight.bold),
                )),
                SizedBox(height: 20.0),
                Padding(
                  padding: EdgeInsets.only(left: 50),
                  child: Row(children: [
                
                    Container(
                    padding:type2Name!='0'? EdgeInsets.symmetric(horizontal: 40.0, vertical: 0.1):EdgeInsets.symmetric(horizontal: 120.0, vertical: 0.1),
                    decoration: BoxDecoration(
                      border: Border.all(
                      color:  Colors.white,
                      width: 2.0,
                      ),
                      color: getAvatarColor(typeName), // Change this to the background color you want
                      borderRadius: BorderRadius.circular(12.0),),
                     
                    child : Text(
                    (typeName ),
                    style: TextStyle(fontSize: 16.0, color: Colors.white),
                  ),),
                
                    Padding(
                      padding: const EdgeInsets.only(left: 30),
                      child: Container(
                      padding: type2Name!='0'? EdgeInsets.symmetric(horizontal: 40.0, vertical: 0.1):EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                      decoration: BoxDecoration(
                        border: Border.all(
                        color: type2Name!='0'? Colors.white : getAvatarColor(typeName),
                        width: 2.0,
                        ),
                        color: getAvatarColor(typeName), // Change this to the background color you want
                        borderRadius: BorderRadius.circular(12.0),),
                       
                      child : Text(
                      (type2Name!='0'?type2Name:'' ),
                      style: TextStyle(fontSize: 16.0, color: Colors.white),
                                      ),),
                    ),
                  ],),
                )
                      
            ]
            ),
          ),
        )
        );
      } else {
        return CircularProgressIndicator();
      }
    },
  );
}
}