import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class StatsBar extends StatefulWidget {
 final String statisticMetric;
  final  Color color;
  double max_metric_val;
  double matric_val;

  StatsBar({required this.statisticMetric,required this.max_metric_val,required this.matric_val, required this.color});
  @override
  _StatsBarState createState() => _StatsBarState();
}

class _StatsBarState extends State<StatsBar> {
  // Declare any variables or state-related properties here

  @override
  void initState() {
    super.initState();
    // Perform any initialization tasks here
  }

  @override
  Widget build(BuildContext context) {
    return Card(
  elevation: 2.0,
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(10.0),
  ),
  child: Padding(
    padding: EdgeInsets.all(5.0),
    child: LinearPercentIndicator(
      width: MediaQuery.of(context).size.width - 40,
      animation: true,
      lineHeight: 20.0,
      animationDuration: 2500,
      percent: widget.matric_val / widget.max_metric_val,
      center: Text(
        "${widget.statisticMetric}: ${widget.matric_val.toString()}",
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      
      progressColor: widget.color,
      barRadius: Radius.circular(20)
    ),
  ),
);
  
  }

  @override
  void dispose() {
    // Clean up any resources or subscriptions here
    super.dispose();
  }
}
