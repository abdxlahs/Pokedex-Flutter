import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class StatsBar extends StatefulWidget {
 final String statisticMetric;
  final  Color color;
  double max_metric_val;
  double matric_val;
  bool abilities; // a toggle so that it can be used to show abilities 
  String abilities_description;

  StatsBar({required this.statisticMetric,required this.max_metric_val,required this.matric_val, required this.color , this.abilities=false , this.abilities_description=''});
  @override
  _StatsBarState createState() => _StatsBarState();
}

class _StatsBarState extends State<StatsBar> {
  // Declare any variables or state-related properties here
  bool _showFloatingPullUpCard = false;

  void _toggleFloatingPullUpCard() {
    setState(() {
      _showFloatingPullUpCard = !_showFloatingPullUpCard;
    });
  }

  @override
  void initState() {
    super.initState();
    // Perform any initialization tasks here
  }

  @override
  Widget build(BuildContext context) {
    return  Card(
  elevation: 2.0,
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(10.0),
  ),
  child: Padding(
    padding: EdgeInsets.all(8.0),
    child:widget.abilities == false?  LinearPercentIndicator(
      width: MediaQuery.of(context).size.width - 40,
      animation: true,
      lineHeight: 20.0,
      animationDuration: 2500,
      percent: widget.matric_val / widget.max_metric_val,
      center: Text(
        "${widget.statisticMetric}: ${widget.matric_val.toString()}",
        style: TextStyle(
                fontFamily: 'Oswald',
                fontWeight: FontWeight.bold,  
                color: Colors.grey[800]
                ),
      ),
      progressColor: widget.color,
      barRadius: Radius.circular(20)
    ):  LinearPercentIndicator(
      width: MediaQuery.of(context).size.width - 100,
      animation: true,
      lineHeight: 20.0,
      animationDuration: 2500,
      percent: widget.matric_val / widget.max_metric_val,
      center: Text(
       widget.matric_val == 1 ? "${widget.statisticMetric}" : "${"Hidden: " +"\t\t\t\t"+widget.statisticMetric+"\t\t\t\t\t\t"  }" ,
        style: TextStyle(
                fontFamily: 'Oswald',
                fontWeight: FontWeight.bold,  
                color: Colors.grey[800]
                ),
      ),
      progressColor: widget.color,
      barRadius: Radius.circular(20),
      leading: IconButton(
        icon: Icon(Icons.info),
        onPressed: (){
          showModalBottomSheet(
  context: context,
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
  ),
  backgroundColor: Colors.white,
  elevation: 10.0,
  builder: (context) {
    return Wrap(
      children: [
        ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          title: Text(
            widget.abilities_description,
            style: TextStyle(
                fontFamily: 'Oswald',
                fontWeight: FontWeight.bold,  
                color: Colors.grey[800]
                ),
          ),
        ),
      ],
    );
  },
);

        }
          ),
    
  ),
  )
  
);

  }
@override
  void dispose() {
    // Clean up any resources or subscriptions here
    super.dispose();
  }
}
