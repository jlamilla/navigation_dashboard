import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:navigation_dashboard/config/providers/image_provider.dart';
import 'package:navigation_dashboard/config/providers/user_provider.dart';
import 'package:navigation_dashboard/ui/constants/images.dart';
import 'package:navigation_design/atoms/nd_image.dart';
import 'package:navigation_design/tokens/colors.dart';

class ImageCustomUser extends ConsumerWidget {
  
  const ImageCustomUser({Key? key, this.state, required this.action, this.create}) : super(key: key);
  final String? state;
  final bool? create;
  final bool action;
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final imgProvider = ref.watch(photoProvider);
    final photo = ref.watch(photoURLProvider);
    final userState = ref.watch(userColorState);
    final createView = create ?? false;
    return Padding(
      padding: const EdgeInsets.only(left: 30, right: 30, bottom: 80, ),
      child: GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: action ? () => ref.read(photoProvider.notifier).pickImage() : null,
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
                          color: white
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(360),
                          child: imgProvider != null 
                                  ? Image.network(imgProvider.path, width: 300, height: 300,)
                                  : createView
                                  ? OurAssetImage(assetName: userState?.image ?? Images.userInactivate, placeholder: Images.loading, widthImage: 300, heightImage: 300,) 
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