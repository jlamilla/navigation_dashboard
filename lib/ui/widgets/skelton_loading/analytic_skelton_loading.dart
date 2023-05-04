import 'package:flutter/material.dart';
import 'package:navigation_dashboard/ui/widgets/skelton_loading/skeleton.dart';
import 'package:navigation_design/tokens/colors.dart';

class AnalyticSkeltonLoading extends StatelessWidget {

  const AnalyticSkeltonLoading({Key? key, this.crossAxisCount = 4, this.childAspectRatio = 1.4, required this.itemCount,}) : super(key: key);

  final int crossAxisCount;
  final double childAspectRatio;
  final int itemCount;
  
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: itemCount,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              crossAxisSpacing: 16.0,
              mainAxisSpacing: 16.0,
              childAspectRatio: childAspectRatio
            ), 
            itemBuilder: (_, __) => const _NewsCardSkelton(),
          );
  }
}

class _NewsCardSkelton extends StatelessWidget {
  
  const _NewsCardSkelton({Key? key}) : super(key: key);
  
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
            children: const[
              Skeleton(width: 80,),
              CircleSkeleton()
            ],
          ),
          const Skeleton()
        ],
      ),
    );
  }
}