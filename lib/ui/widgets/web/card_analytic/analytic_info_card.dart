import 'package:flutter/material.dart';
import 'package:navigation_dashboard/domain/models/analytic/analytic_data_model.dart';
import 'package:navigation_design/tokens/colors.dart';

class AnalyticInfoCard extends StatelessWidget {
  
  const AnalyticInfoCard({Key? key, required this.info}) : super(key: key);
  
  final AnalyticData info;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      decoration: BoxDecoration(
        color: white,
        borderRadius: BorderRadius.circular(10)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("${info.count}", style: const TextStyle(
                color: black,
                fontSize: 18,
                fontWeight: FontWeight.w800
              ),),
              /*Container(
                padding: const EdgeInsets.all(8.0),
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  color: info.color!.withOpacity(0.1),
                  shape: BoxShape.circle
                ),
                child: Icon(info.icon, color: info.color,),
              )*/
            ],
          ),
          Text(
            info.title!, 
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle( 
              color: black,
              fontSize: 15, 
              fontWeight: FontWeight.w600),
            )
        ],
      ),
    );
  }
}