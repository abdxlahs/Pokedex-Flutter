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
                  Center(child: Text(widget.name.toUpperCase() ,style:TextStyle(
                    fontSize: 25,
                    fontFamily: 'Oswald',
                    fontWeight: FontWeight.bold,  
                    color: Colors.grey[800]
                ),
                  ),
                  ),
                  SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(10),
                          gradient: LinearGradient(
                            colors:[Color(0xFFB0FFA0), Color(0xFF5BC34D)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Color(0xFF3366FF).withOpacity(0.3),
                              offset: Offset(0, 2),
                              blurRadius: 6,
                            ),
                          ],
                          ),
                        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                        child: Text(
                          widget.type1,
                          style: TextStyle(
                fontFamily: 'Oswald',
                fontWeight: FontWeight.bold,  
                color: Colors.grey[800],
                fontSize: 16,
                ),
                        ),
                      ),
                      SizedBox(width: 30),
                      widget.type2 != '0'
                      ? Container(
                        decoration:BoxDecoration(
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(10),
                          gradient: LinearGradient(
                            colors: [Color(0xFF448AFF), Color(0xFF3366FF)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            stops: [0.1, 0.9], // Adjust the gradient stops as needed
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.3), // Use a darker color for the shadow
                              offset: Offset(0, 2),
                              blurRadius: 6,
                            ),
                          ],
                        ),


                        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                        child: Text(
                          widget.type2,
                          style: TextStyle(
                            fontFamily: 'Oswald',
                            fontWeight: FontWeight.bold,  
                            color: Colors.grey[800],
                            fontSize: 16
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
