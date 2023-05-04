import 'package:flutter/material.dart';
import 'package:navigation_dashboard/ui/widgets/skelton_loading/skeleton.dart';
import 'package:navigation_design/tokens/colors.dart';

class UserGridViewSkelton extends StatelessWidget {

  const UserGridViewSkelton({Key? key, this.crossAxisCount = 3, this.childAspectRatio = 0.8, required this.itemCount,}) : super(key: key);

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
        crossAxisAlignment: CrossAxisAlignment.center,
        children: const [
          CircleSkeleton(size: 120,),
          SizedBox(height: 20,),
          Skeleton(width: 150,),
          SizedBox(height: 10,),
          Skeleton(width: 150,),
          SizedBox(height: 10,),
          Skeleton(width: 150,),
          SizedBox(height: 10,),
          Skeleton(width: 150,),
        ],
      ),
    );
  }
}