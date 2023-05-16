import 'package:flutter/material.dart';
import 'package:pokedex/models/BottomBar.dart';
import '../models/basic_info.dart';
import '../models/database_helper.dart';
import 'home/home_widget.dart';

class Moves extends StatefulWidget {
  String id = HomeWidget.id ;
  String imageURL;
  String name;
  String type1;
  String type2;
  Color color;
  bool showTable = false;
  late Future<List<Map<String, dynamic>>> moves;

  Moves({required this.id ,required this.imageURL, required this.name, required this.type1, required this.type2 , required this.color});
  @override
  _MovesState createState() => _MovesState();
}

class _MovesState extends State<Moves>  {
  List<String> buttonLabels = ['level-up', 'machine', 'egg', 'tutor'];

  Future<void> _fetchMovesData() async {
    widget.moves = DatabaseHelper.instance.customQuery('select move.name as move_name,power,accuracy,pp,learnt_at_level,Types.name as type_name,description from move inner join moves_learnt on move.id = moves_learnt.move_id inner join Types on Types.id = move.type where move.id in ( select move_id from moves_learnt where pokemon_id = "${widget.id}" and learnt_from = "level-up" ) group by move.name');

  }

   @override
   void initState() {
    super.initState();
    _fetchMovesData();
  }
  bool _isclicked=false;
  @override
  Widget build(BuildContext context) {
    double height= MediaQuery.of(context).size.height;
    
    return Scaffold(
      backgroundColor: widget.color,
       appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: widget.color,
        elevation: 0.0,
        title: Text("Moves"),
      ),
      body:
      SingleChildScrollView(
        
        child: ConstrainedBox(
          constraints: BoxConstraints(minHeight: height),

          child: Column(
            children: [
            BasicInfo(id: widget.id, imageURL: widget.imageURL, name: widget.name, type1: widget.type1, type2: widget.type2, color: widget.color),
              SizedBox(height: 15,),
              Card(
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: buttonLabels.map((label) {
          return ElevatedButton(
            onFocusChange: (value) => _isclicked =true,
            style: ElevatedButton.styleFrom(
              backgroundColor: widget.color, 
               // text color
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            ),
            onPressed: () {
            
                setState(() {
                
                widget.moves = DatabaseHelper.instance.customQuery('select move.name as move_name,power,accuracy,pp,learnt_at_level,Types.name as type_name,description from move inner join moves_learnt on move.id = moves_learnt.move_id inner join Types on Types.id = move.type where move.id in ( select move_id from moves_learnt where pokemon_id = "${widget.id}" and learnt_from = "$label" ) group by move.name');
                });

                
              
            },
            child: Text(label, style: TextStyle(fontSize: 16)),
          );
              }).toList(),
            ),
          ),
        ),
        SizedBox(height: 15,),
        FutureBuilder<List<Map<String, dynamic>>>(
  future: widget.moves,
  builder: (BuildContext context, AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
    if (snapshot.connectionState == ConnectionState.done) {
      if (snapshot.hasError) {
        return Center(child: Text('Error: ${snapshot.error}'));
      }
      final data = snapshot.data!;
      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columnSpacing: 20,
          headingRowColor: MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
            return Theme.of(context).colorScheme.onPrimary.withOpacity(0.5);  // make headers light grey
          }),
          columns: const <DataColumn>[
            DataColumn(
              label: Text(
                'Move',
                style: TextStyle(fontStyle: FontStyle.italic, fontWeight: FontWeight.bold),
              ),
            ),
            DataColumn(
              label: Text(
                'Power',
                style: TextStyle(fontStyle: FontStyle.italic, fontWeight: FontWeight.bold),
              ),
            ),
            DataColumn(
              label: Text(
                'Accuracy',
                style: TextStyle(fontStyle: FontStyle.italic, fontWeight: FontWeight.bold),
              ),
            ),
            DataColumn(
              label: Text(
                'Type Name',
                style: TextStyle(fontStyle: FontStyle.italic, fontWeight: FontWeight.bold),
              ),
            ),
          ],
          rows: List<DataRow>.generate(
            data.length,
            (index) => DataRow(
              color: MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
                if (index % 2 == 0) {
                  return Theme.of(context).colorScheme.primary.withOpacity(0.1);  // make even rows slightly darker
                }
                return widget.color;  // use default color for odd rows
              }),
              cells: <DataCell>[
                DataCell(Text(data[index]['move_name'])),
                DataCell(Text('${data[index]['power']}')),
                DataCell(Text('${data[index]['accuracy']}')),
                DataCell(Text(data[index]['type_name'])),
              ],
            ),
          ),
        ),
      );
    } else {
      return Center(child: CircularProgressIndicator());
    }
  },
),


        
        
        
        
          ]),
        ),
      ),
      bottomNavigationBar: Bottom_navigation_bar(id: widget.id, imageURL: widget.imageURL, name: widget.name, type1: widget.type1, type2: widget.type2, color: widget.color,selectedIndex: 2,),
      
      // Widget contents go here
    );
  }
}
