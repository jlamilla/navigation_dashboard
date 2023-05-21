import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:navigation_dashboard/config/providers/image_provider.dart';
import 'package:navigation_dashboard/ui/constants/images.dart';
import 'package:navigation_design/atoms/nd_image.dart';

class ImageCustomProduct extends ConsumerWidget {
  
  const ImageCustomProduct({Key? key, this.create, required this.action}) : super(key: key);
  final bool? create;
  final bool action;
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final createView = create ?? false;
    final imgProvider = ref.watch(photoProvider);
    final photo = ref.watch(photoURLProvider);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: action ? () => ref.read(photoProvider.notifier).pickImage() : null,
            child: Center(
              child: SizedBox(
                    height: 510,
                    width: 420,
                child:
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: imgProvider != null 
                        ? Image.network(imgProvider.path)
                        : createView
                        ? const OurAssetImage(assetName: Images.noPhoto, placeholder: Images.loading,)
                        : photo.isNotEmpty 
                        ? OurNetworkImage(url: photo, placeholder: Images.loading)
                        : const OurAssetImage(assetName: Images.noPhoto, placeholder: Images.loading,)
                )
              ),
            ),
          ),
    );
  }
}