import 'package:flutter/material.dart';
import 'package:pokedex/index.dart';
import 'package:sliding_clipped_nav_bar/sliding_clipped_nav_bar.dart';
import '../pages/moves.dart';
import 'Base_stats.dart';

class Bottom_navigation_bar extends StatefulWidget {
   String id;
  String imageURL;
  String name;
  String type1;
  String type2;
  Color color;
  int  selectedIndex;
  Bottom_navigation_bar({required this.id ,required this.imageURL, required this.name, required this.type1, required this.type2 , required this.color ,required this.selectedIndex});
  @override
  _Bottom_navigation_barState createState() => _Bottom_navigation_barState();
}

class _Bottom_navigation_barState extends State<Bottom_navigation_bar> {
  @override
  Widget build(BuildContext context) {
    return Container(
     child: SlidingClippedNavBar.colorful(
        backgroundColor: Colors.white,
        onButtonPressed: (index) {
          setState(() {
            widget.selectedIndex = index;

            if (index == 0){
              Navigator.push(
              context,
              MaterialPageRoute(builder: (context) =>  HomeWidget() ),
             );
            }
            if (index == 1){
              Navigator.push(
              context,
              MaterialPageRoute(builder: (context) =>  BaseStatistics(id: widget.id, name: widget.name, type1: widget.type1, type2: widget.type2,
              imageURL: widget.imageURL, color: widget.color) ),
             );
            }

            if (index == 2){
              Navigator.push(
              context,
              MaterialPageRoute(builder: (context) =>  Moves(id: widget.id, imageURL: widget.imageURL, name: widget.name, type1: widget.type1, type2: widget.type2, color: widget.color) )
             );
            }

          }
          );
        
        },
        iconSize: 30,
        selectedIndex: widget.selectedIndex,
        barItems: [
          BarItem(
            icon: Icons.home ,
            title: 'Home',
            activeColor: Colors.black,
            inactiveColor: Colors.red,
          ),
          BarItem(
            icon: Icons.query_stats ,
            title: 'Stats',
            activeColor: Colors.black,
            inactiveColor: Colors.red,
          ),
          BarItem(
            icon: Icons.attractions_sharp ,
            title: 'Moves',
            activeColor: Colors.amber,
            inactiveColor: Colors.red,
          ),
          // BarItem(
          //   icon: Icons.search_rounded,
          //   title: 'Search',
          //   activeColor: Colors.red,
          //   inactiveColor: Colors.green,
          // ),
         /// Add more BarItem if you want
        ],
      ),
      
    );
  }
}
