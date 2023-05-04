import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:navigation_dashboard/domain/models/analytic/analytic_data_model.dart';
import 'package:navigation_dashboard/ui/constants/images.dart';
import 'package:navigation_dashboard/ui/widgets/web/card_image/card_image_background.dart';
import 'package:navigation_design/atoms/nd_image.dart';

class CardImage extends ConsumerWidget {
  const CardImage({ super.key, this.userImage, required this.cardInfo,});
  final String? userImage;
  final AnalyticData cardInfo;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Expanded(
      flex: 2,
      child: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          CardImageBackground(color: cardInfo.color,),
          Container(
            padding: const EdgeInsets.only( bottom: 4),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(360),
              child: (userImage != null && userImage!.isNotEmpty) 
                    ? OurNetworkImage(
                        url: userImage!, 
                        placeholder: Images.loading, 
                        widthImage: 130, 
                        heightImage: 130,
                      )
                    : OurAssetImage( 
                        assetName: cardInfo.imageCard!,  
                        placeholder: Images.loading, 
                        widthImage: 130, 
                        heightImage: 130,
                      )   
            ),
          ),
        ]
      ),
    );
  }
}