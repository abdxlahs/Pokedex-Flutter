import 'package:flutter/material.dart';

class BasicInfo extends StatefulWidget {
  String id;
  String imageURL;
  String name;
  String type1;
  String type2;
  Color color;
  BasicInfo({required this.id ,required this.imageURL, required this.name, required this.type1, required this.type2 , required this.color});
  @override
  _BasicInfoState createState() => _BasicInfoState();
}

class _BasicInfoState extends State<BasicInfo> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: widget.color,
      child:Stack(
            
            children: [
              Container(
                height: 140.0,
                decoration: new BoxDecoration(
                color: widget.color,
                boxShadow: [
                  new BoxShadow(blurRadius: 20.0)
                ],
                borderRadius: new BorderRadius.vertical(
                bottom: new Radius.elliptical(
                  MediaQuery.of(context).size.width, 100.0)),
                ),
              ),
              Column(
                children: [
                  Center(
                    child: CircleAvatar(
                        backgroundColor: widget.color,
                        backgroundImage: NetworkImage(widget.imageURL),
                        radius: 65,
                    ),
                  ),
                  SizedBox(height: 30,),
                  Center(child: Text(widget.name.toUpperCase() ,style:TextStyle(fontWeight: FontWeight.bold ,fontSize: 25,color: Colors.black)),),
                  SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Color(0xFF3366FF), // Blue color
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                        child: Text(
                          widget.type1,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      SizedBox(width: 30),
                      widget.type2 != '0'
                      ? Container(
                        decoration: BoxDecoration(
                          color: Color(0xFF33CC99), // Green color
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                        child: Text(
                          widget.type2,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      )
                      : SizedBox(),
                    ],
                  ),
                
                ]
                  ),
                 ]
                 ),
      // Widget contents go here
    );
  }
}
