import 'dart:async';
import 'package:provider/single_child_widget.dart';

import '/flutter_flow/flutter_flow_animations.dart';
import 'package:flutter/material.dart';
import 'package:pokedex/models/database_helper.dart';
import 'package:pokedex/models/myPokemonCardUI.dart';
import 'package:pokedex/pages/Pokemontypes.dart';



class HomeWidget extends StatefulWidget {
  static String Name = '';
  static String imageURL='';
  static String id = '';
  static int type1 =0;
  static int type2 = 0;
  void setImageUrl(String img){
    imageURL = imageURL;

  }


  void setid(String i){
    id = i;
  }
  void setname(String n){
    Name = n;

  }
  void settype1(int t1){
    type1 = t1;
  }
  void settype2(int t2){
    type2 = t2;
  }

  @override
  _HomeWidgetState createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  late Future<List<Map<String, dynamic>>> _data;
  late Future<List<Map<String, dynamic>>> _types;
  late Future<List<Map<String, dynamic>>> _custom;
  late Future<List<Map<String, dynamic>>> name;
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  List<String> typename=[];
  bool _isSortedAlphabetically = false;
  String _sortingCriteria = '';
  String  statistic_val='';
  
  

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    _data = DatabaseHelper.instance.customQuery('SELECT * FROM Pokemon');
    _types = DatabaseHelper.instance.customQuery('SELECT * FROM Types');

    List<Map<String, dynamic>> result = await DatabaseHelper.instance.customQuery('SELECT name FROM Types');
    for (Map<String, dynamic> row in result) {
        this.typename.add(row['name']);
  }
  }


Color getAvatarColor(String typeName) {
  switch (typeName) {
    case 'fire':
      return Color(0xFFF46D5E);
    case 'water':
      return Color(0xFF76BDFE);
    case 'grass':
      return Color(0xFF67C157);
    case 'electric':
      return Color(0xFFF8D030);
    case 'psychic':
      return Color(0xFFF7639A);
    case 'dragon':
      return Color(0xFF7062D1);
    case 'normal':
      return Color(0xFFA8A77A);
    case 'fighting':
      return Color(0xFFC22E28);
    case 'flying':
      return Color(0xFFA891EC);
    case 'poison':
      return Color(0xFFA33EA1);
    case 'ground':
      return Color(0xFFE2BF65);
    case 'rock':
      return Color(0xFFB69E31);
    case 'bug':
      return Color(0xFFA7B723);
    case 'ghost':
      return Color(0xFF735797);
    case 'steel':
      return Color(0xFFB7B9D0);
    case 'fairy':
      return Color(0xFFD685AD);
    case 'dark':
      return Color(0xFF735447);
    case 'ice':
      return Color(0xFF9AD6DF);
    default:
      return Colors.grey;
  }
}
  void settingModalBottomSheet(context,List<String> typename){
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: ListView.builder(
            itemCount: typename.length,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.all(5.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor:getAvatarColor('${typename[index]}') ),
                  onPressed: () {
                    Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) =>  SortTypes(typename:'${typename[index]}' )),);},
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 12),
                    child: Center(
                      child: Text(
                        '${typename[index]}',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
    
}
  void _showSortingBottomSheet(context) {
    List<String> stats=["hp","speed","defence","attack","sp_defence","sp_attack","remove sort by any stats"];
    
    

    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: ListView.builder(
            itemCount: stats.length,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.all(5.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor:Colors.grey ),
                  
                  onPressed: () async {
                    stats[index] != "remove sort by any stats"?
                    setState(() {
                      statistic_val=stats[index];
                    _data = DatabaseHelper.instance.customQuery('SELECT * FROM Pokemon order by "${statistic_val}" DESC');  
                    }):setState(() {
                       statistic_val='';
                      _data = DatabaseHelper.instance.customQuery('SELECT * FROM Pokemon');
                    });
                    
                   },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 12),
                    child: Center(
                      child: Text(
                        '${stats[index]}',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
    


  
}



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text("Pokèdex"),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () async {
             _searchQuery = _searchController.text;
              setState(() {
                _fetchData();
              });
            },
          ),
          IconButton(
          icon: Icon(Icons.sort_by_alpha_outlined),
          onPressed: () async {
                    if (_isSortedAlphabetically) {
                      _data = DatabaseHelper.instance.customQuery('SELECT * FROM Pokemon');
                    } else {
                      _data = DatabaseHelper.instance.customQuery('SELECT * FROM Pokemon order by name ASC');
                    }
                    setState(() {
                      _isSortedAlphabetically = !_isSortedAlphabetically;
                    });
                  },
        ),
        IconButton(
          icon: Icon(Icons.sort_sharp),
          onPressed: () async {
                    if (_isSortedAlphabetically) {
                      _data = DatabaseHelper.instance.customQuery('SELECT * FROM Pokemon');
                    } else {
                      _data = DatabaseHelper.instance.customQuery('SELECT * FROM Pokemon order  by Pokedex_number DESC');
                    }
                    setState(() {
                      _isSortedAlphabetically = !_isSortedAlphabetically;
                    });
                  },
        ),
        ],
      ),
      body: Column(
        children: [
          Padding(
  padding: const EdgeInsets.all(8.0),
  child: Container(
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(32),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.1),
          spreadRadius: 1,
          blurRadius: 5,
          offset: Offset(0, 2),
        ),
      ],
    ),
    child: TextField(
      style: TextStyle(color: Colors.black),
  
      controller: _searchController,
      decoration: InputDecoration(
        fillColor: Colors.black,
        hintText: 'Search Pokèmon by name',
        hintStyle:TextStyle(
                fontFamily: 'Oswald',
                fontWeight: FontWeight.bold,  
                
            ),
        contentPadding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32),
          borderSide: BorderSide.none,
        ),
        suffixIcon: IconButton(
          onPressed: () {
            _searchController.clear();
            setState(() {
              _searchQuery = '';
              _fetchData();
            });
          },
          icon: Icon(Icons.clear),
          color: Colors.grey,
        ),
      ),
    ),
  ),
),
SizedBox(height: 10),
          Row(
            children: [
             ElevatedButton(
  style: ElevatedButton.styleFrom(
    backgroundColor: Colors.grey,
    shadowColor: Colors.black.withOpacity(0.1),
    elevation: 5,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(32),
    ),
    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
  ),
  onPressed: () {
    settingModalBottomSheet(context,this.typename);
  },
    
  child: Text(
                'Sort by types',
              style: TextStyle(
                fontFamily: 'Oswald',
                fontWeight: FontWeight.bold,  
            ),
              ),
            ),


Padding(
  padding: const EdgeInsets.only(left: 100),
  child:   ElevatedButton(
  
    style: ElevatedButton.styleFrom(
  
      backgroundColor: Colors.grey,
  
      shadowColor: Colors.black.withOpacity(0.1),
  
      elevation: 5,
  
      shape: RoundedRectangleBorder(
  
        borderRadius: BorderRadius.circular(32),
  
      ),
  
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
  
    ),
  
    onPressed: () {
   _showSortingBottomSheet(context);
      },
  
      
  
    child: Text(
  
                  'Sort by Statistics',
                  style: TextStyle(
                  fontFamily: 'Oswald',
                  fontWeight: FontWeight.bold,
                  
                ),
                ),
  
              ),
),
            
            ],
          ),
          SizedBox(height: 10),
          Expanded(
            flex: 1,
            child: FutureBuilder<List<Map<String, dynamic>>>(
              future: _data,
              builder: (BuildContext context,
                  AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  }
                  final data = snapshot.data!;
                  final filteredData = data
                      .where((pokemon) =>
                          pokemon['name']
                              .toString()
                              .toLowerCase()
                              .contains(_searchQuery.toLowerCase()))
                      .toList();
                  return ListView.builder(
                    itemCount: filteredData.length,
                    itemBuilder: (BuildContext context, int index) {
                      var type2 = filteredData[index]['type2'];
                      print(type2);
                      if (type2 == null) {
                        type2 = 0;
                      }
                      widget.setname(filteredData[index]['name'].toString()); 
                     widget.setid(filteredData[index]['pokedex_number'].toString());
                     widget.setImageUrl(filteredData[index]['image_url'].toString());
                      widget.settype1(filteredData[index]['type1']);
                      widget.settype2(type2);
                      return MyPokemonCard(
                        name: filteredData[index]['name'].toString(),
                        id: filteredData[index]['pokedex_number'].toString(),
                        imageUrl: filteredData[index]['image_url'].toString(),
                        type: filteredData[index]['type1'],
                        type2: type2,
                        statistic_val: statistic_val 
                      );
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

