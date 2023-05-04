import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:navigation_dashboard/config/providers/analytic_data_provider.dart';
import 'package:navigation_dashboard/config/providers/image_provider.dart';
import 'package:navigation_dashboard/config/providers/user_provider.dart';
import 'package:navigation_dashboard/ui/constants/images.dart';
import 'package:navigation_design/atoms/nd_image.dart';
import 'package:navigation_design/tokens/colors.dart';

class ImageCustom extends ConsumerWidget {
  
  const ImageCustom({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final imgProvider = ref.watch(photoProvider);
    final photo = ref.watch(photoProvider.notifier).photoURL;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () => ref.read(photoProvider.notifier).pickImage(),
            child: Center(
              child: SizedBox(
                    height: 510,
                    width: 420,
                child:
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: imgProvider != null 
                        ? Image.network(imgProvider.path)
                        : photo.isNotEmpty ? 
                        OurNetworkImage(url: photo, placeholder: Images.loading)
                        : const OurAssetImage(assetName: Images.noPhoto, placeholder: Images.loading,)
                )
              ),
            ),
          ),
    );
  }
}

class ImageCustomCardState extends ConsumerWidget {
  
  const ImageCustomCardState({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final imgProvider = ref.watch(photoProvider);
    final photo = ref.watch(photoProvider.notifier).photoURL;
    final userState = ref.watch(userColorState);
    return Padding(
      padding: const EdgeInsets.only(left: 30, right: 30, bottom: 80, ),
      child: GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () => ref.read(photoProvider.notifier).pickImage(),
            child: SizedBox(
                  height: 480,
                  width: 420,
                  child: Stack(
                    alignment: AlignmentDirectional.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: userState?.color ?? grey,
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
                          child: imgProvider != null 
                                  ? Image.network(imgProvider.path, width: 300, height: 300,)
                                  : photo.isNotEmpty 
                                  ? OurNetworkImage(url: photo, placeholder: Images.loading, widthImage: 300, heightImage: 300,)
                                  : OurAssetImage(assetName: userState?.image ?? Images.userInactivate, placeholder: Images.loading, widthImage: 300, heightImage: 300,) 
                        ),
                      ),
                    ]
                  )
            ),
          ),
    );
  }
}

class ImageCustomCardStateUserOrder extends ConsumerWidget {
  
  const ImageCustomCardStateUserOrder({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final imgProvider = ref.watch(photoProvider);
    final photo = ref.watch(photoProvider.notifier).photoURL;
    final userState = ref.watch(userColorState);
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
                color: userState?.color ?? grey,
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
                child: imgProvider != null 
                        ? Image.network(imgProvider.path, width: 200, height: 200,)
                        : photo.isNotEmpty 
                        ? OurNetworkImage(url: photo, placeholder: Images.loading, widthImage: 200, heightImage: 200,)
                        : OurAssetImage(assetName: userState?.image ?? Images.userInactivate, placeholder: Images.loading, widthImage: 200, heightImage: 200,) 
              ),
            ),
          ]
        ),
      ),
    );
  }
}