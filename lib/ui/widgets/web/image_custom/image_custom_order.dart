import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:navigation_dashboard/config/providers/order_provider.dart';
import 'package:navigation_dashboard/ui/constants/images.dart';
import 'package:navigation_dashboard/ui/constants/list_element.dart';
import 'package:navigation_design/atoms/nd_image.dart';

class ImageCustomOrder extends ConsumerWidget {
  
  const ImageCustomOrder({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final orderState = ref.watch(orderColorState) ?? CardColorOrderState.orderPending;
    return Padding(
      padding: const EdgeInsets.only(right: 20, left: 20, bottom: 10),
      child: SizedBox(
        height: 240,
        width: 200,
        child: Stack(
          alignment: AlignmentDirectional.center,
          children: [
            Container(
              decoration: BoxDecoration(
                color: orderState.color,
                border: Border.all(
                  color: Colors.transparent,
                  width: 0,
                  style: BorderStyle.none,
                ),
                borderRadius: BorderRadius.circular(10)
              ),
              width: double.infinity,
              child: Image.asset(Images.mask, fit: BoxFit.cover,),
            ),
            Container(
              padding: const EdgeInsets.only( bottom: 4),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(360),
                child: OurAssetImage(
                        assetName: orderState.image , 
                        placeholder: Images.loading, 
                        widthImage: 200, 
                        heightImage: 200,
                      ) 
              ),
            ),
          ]
        ),
      ),
    );
  }
}