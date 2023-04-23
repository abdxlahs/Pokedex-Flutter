import 'package:flutter/material.dart';



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

class PokemonTypes extends StatefulWidget {
  List<String> typename;
  PokemonTypes({required this.typename});

  @override
  _PokemonTypesState createState() => _PokemonTypesState();
}

class _PokemonTypesState extends State<PokemonTypes> {
  // Define your widget state variables here
  

  
  @override
  void initState() {
    super.initState();
    // Initialize state variables here
  }

  @override
  void dispose() {
    // Clean up resources here
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
  return Scaffold(
    body: FutureBuilder(
      future: showModalBottomSheet(
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
              itemCount: widget.typename.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor:getAvatarColor('${widget.typename[index]}') ),
                    onPressed: () => null,
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 12),
                      child: Center(
                        child: Text(
                          '${widget.typename[index]}',
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
      ),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasData) {
          return snapshot.data;
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    ),
  );
}

}




  



