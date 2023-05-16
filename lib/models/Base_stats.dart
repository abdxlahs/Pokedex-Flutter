
import 'package:flutter/material.dart';
import 'package:pokedex/models/BottomBar.dart';
import 'package:pokedex/models/basic_info.dart';
import 'package:pokedex/models/database_helper.dart';
import 'statsbar.dart';
import 'package:sliding_clipped_nav_bar/sliding_clipped_nav_bar.dart';
import 'package:pokedex/pages/moves.dart';




class BaseStatistics extends StatefulWidget {
  String id;
  String name;
  String type1;
  String type2;
  late Future<String> pokedex_entry;
  String imageURL;
  Color color;
  late Future<String> height;
  late Future<String> weight;
  List<String> stats=["hp","speed","defence","attack","sp_defence","sp_attack"];
  List<double> max_statistic=[255,200,250,190,250,194];
  late Future<String> hp,speed,defence,attack,sp_defence,sp_attack;
  late Future<List<Map<String, dynamic>>> Abilitiesdata;


  
  BaseStatistics({required this.id, required this.name, required this.type1 , required this.type2, required this.imageURL ,required this.color});

  @override
  _BaseStatisticsState createState() => _BaseStatisticsState();
}


class _BaseStatisticsState extends State<BaseStatistics> {
  // Declare any variables or properties you need here
  Future<void> _fetchData() async {
    widget.Abilitiesdata = DatabaseHelper.instance.customQuery('select name,description,is_hidden from abilities inner join pokemon_abilities on pokemon_abilities.ability_id = abilities.id where abilities.id in ( select ability_id  from pokemon_abilities where pokemon_abilities.Pokemon_id= "${widget.id}" ) group by name,description');

  }



 
Future<String> _getHp() async{  
      var temp = await DatabaseHelper.instance.customQuery('SELECT hp FROM Pokemon where id = "${widget.id}" ');
      return temp[0]["hp"].toString();
  }
Future<String> _getSpeed() async{  
      var temp = await DatabaseHelper.instance.customQuery('SELECT speed FROM Pokemon where id = "${widget.id}" ');
      return temp[0]["speed"].toString();
  }
Future<String> _getdefence() async{  
      var temp = await DatabaseHelper.instance.customQuery('SELECT defence FROM Pokemon where id = "${widget.id}" ');
      return temp[0]["defence"].toString();
  }
Future<String> _getattack() async{  
      var temp = await DatabaseHelper.instance.customQuery('SELECT attack FROM Pokemon where id = "${widget.id}" ');
      return temp[0]["attack"].toString();
  }
Future<String> _getSpadefence() async{  
      var temp = await DatabaseHelper.instance.customQuery('SELECT sp_defence FROM Pokemon where id = "${widget.id}" ');
      return temp[0]["sp_defence"].toString();
  }
Future<String> _getSpattack() async{  
      var temp = await DatabaseHelper.instance.customQuery('SELECT sp_attack FROM Pokemon where id = "${widget.id}" ');
      return temp[0]["sp_attack"].toString();
  }
Future<String> _getPokedexEntry() async{  
      var temp = await DatabaseHelper.instance.customQuery('SELECT pokedex_entry FROM Pokemon where id = "${widget.id}" ');
      return temp[0]["pokedex_entry"].toString();
    
  }
Future<String> _getPokemonHeight() async{  
      var temp = await DatabaseHelper.instance.customQuery('SELECT height FROM Pokemon where id = "${widget.id}" ');
      return temp[0]["height"].toString();
    
  }
Future<String> _getPokemonWeight() async{  
      var temp = await DatabaseHelper.instance.customQuery('SELECT weight FROM Pokemon where id = "${widget.id}" ');
      return temp[0]["weight"].toString();
    
  }

  @override
   void initState() {
    super.initState();
    super.initState();
    _fetchData();
    widget.hp = _getHp();
    widget.speed = _getSpeed();
    widget.defence = _getdefence();
    widget.attack = _getattack();
    widget.sp_defence = _getSpadefence();
    widget.sp_attack = _getSpattack(); 
    widget.height = _getPokemonHeight();
    widget.weight = _getPokemonWeight();
    widget.pokedex_entry = _getPokedexEntry() ;
    int selectedIndex=0;

    print('Height: ${widget.height}');
  print('Weight: ${widget.weight}');
  print('Pokedex Entry: ${widget.pokedex_entry}');
  }

  @override
  Widget build(BuildContext context) { 

    return FutureBuilder<List<String>>(
    future: Future.wait([widget.pokedex_entry,widget.height,widget.weight,widget.hp, widget.speed, widget.defence, widget.attack, widget.sp_defence, widget.attack ]),
    builder: (BuildContext context, AsyncSnapshot<List<String>> snapshot) {
      if (snapshot.connectionState == ConnectionState.done) {
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }    
    double appBarSize = MediaQuery.of(context).size.height;
    final pokedexEntry=snapshot.data![0];
    final pokemonheight=snapshot.data![1];
    final pokemonweight=snapshot.data![2];
    final hpdata=snapshot.data![3];
    final speeddata=snapshot.data![4];
    final defencedata=snapshot.data![5];
    final attackdata=snapshot.data![6];
    final sp_defencedata=snapshot.data![7];
    final sp_attackdata=snapshot.data![8];
    List <String> bar_data=[hpdata,speeddata,defencedata,attackdata,sp_defencedata,sp_attackdata];
    var selectedIndex=0;
    
   
    return Scaffold(
      backgroundColor: widget.color,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: widget.color,
        elevation: 0.0,
        title: Text("Pokédex"),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child:
              Column(
                children: [
                  BasicInfo(id: widget.id, imageURL: widget.imageURL, name: widget.name, type1: widget.type1, type2: widget.type2, color: widget.color),
                  SizedBox(height: 30,),
                 
                  Card(
                    elevation: 5.0,
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Container(
                      padding: EdgeInsets.all(16.0),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              pokedexEntry,
                              style: TextStyle(
                                      fontSize: 18,
                                      fontFamily: 'Oswald',
                                      fontWeight: FontWeight.bold,  
                                      color: Colors.grey[800]
                                      ),
                            ),
                            SizedBox(height: 10),
                            Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "HEIGHT",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey[600],
                                        ),
                                      ),
                                      SizedBox(height: 8),
                                      Text(
                                        double.parse(pokemonheight).toStringAsFixed(2) + " m",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(width: 24),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "WEIGHT",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey[600],
                                        ),
                                      ),
                                      SizedBox(height: 8),
                                      Text(
                                        double.parse(pokemonweight).toStringAsFixed(2) + " Kg",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                      SizedBox(height: 8),
                                    ],
                                  ),
                                ),
                              ]
                            ),
                          ]
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 15,),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    child: Text(
                      "Base Statistics".toUpperCase(),
                      style: TextStyle(
                fontFamily: 'Oswald',
                fontWeight: FontWeight.bold,  
                color: Colors.grey[800],
                fontSize: 25
                ),
                    ),
                  ),
                  SizedBox(height: 15,),
                  Container(
                    height: 300,
                    child:Card(
                      elevation: 5.0,
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: ListView.builder(
                        itemCount: widget.stats.length,
                        itemBuilder: (BuildContext context, int index) {
                          String statisticMetric = widget.stats[index];
                          return StatsBar(statisticMetric: statisticMetric, max_metric_val: widget.max_statistic[index],
                                          matric_val: double.parse(bar_data[index]), color: widget.color);
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: 8.0,),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    child: Text(
                      "Abilities".toUpperCase(),
                      style: TextStyle(
                fontFamily: 'Oswald',
                fontWeight: FontWeight.bold,  
                color: Colors.grey[800],
                fontSize: 25
                ),
                    ),
                  ),

                  Container(
                    height: 150,
                    child: Card(
                      elevation: 5.0,
                      color: Colors.white,
                      shape:RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ), 
                      child: FutureBuilder<List<Map<String, dynamic>>>(
                                      future: widget.Abilitiesdata,
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
                        
                        return StatsBar(statisticMetric: data[index]['name'], max_metric_val: 1.0, matric_val: data[index]['is_hidden'] == 0 ? 1.0 : 0.5 ,
                         color: widget.color,abilities: true, abilities_description:data[index]['description'] );
                      }
                                      );
                                    } else {
                                      return Center(child: CircularProgressIndicator());
                                    }
                                  },
                                ),
                    ),
                  ),
                  SizedBox(height: 20,),

                ],
            ),
            
          
        
        ),
      ),
      bottomNavigationBar: Bottom_navigation_bar(id: widget.id, imageURL: widget.imageURL, name: widget.name, type1: widget.type1, type2: widget.type2, color: widget.color,selectedIndex: 1,)
    );
    } else {
        return CircularProgressIndicator();
      }
    },
  );
  }

  @override
  void dispose() {
    // Clean up any resources or cancel any active subscriptions here
    super.dispose();
  }
}
