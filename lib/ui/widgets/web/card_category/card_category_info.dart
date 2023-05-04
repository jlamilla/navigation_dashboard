import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:navigation_dashboard/config/providers/drawer_provider.dart';
import 'package:navigation_dashboard/config/providers/search_providers.dart';
import 'package:navigation_dashboard/domain/models/analytic/analytic_data_model.dart';
import 'package:navigation_dashboard/ui/constants/strings.dart';
import 'package:navigation_design/tokens/colors.dart';

class CardCategoryInfo extends ConsumerWidget {
  
  const CardCategoryInfo({Key? key, required this.info, required this.positionedCount, required this.positionedTitle, }) : super(key: key);

  final double positionedCount;
  final double positionedTitle;
  final AnalyticData info;
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0, bottom: 16.0, right: 19.0),
      child: GestureDetector(
        onTap: () {
          final int index = ref.watch(drawerIndexProvider);
          if(index == 1){
            ref.read(searchProductsCategoryProvider.notifier).update((state) => state = info.title!);
          }else if(index == 5){
            ref.read(searchUsersCategoryProvider.notifier).update((state) => state = info.title!);
          }else{
            ref.read(searchOrdersCategoryProvider.notifier).update((state) => state = info.title!);
          }
        },
        child: Container(
          decoration: BoxDecoration(
            color: white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Stack(
            alignment : AlignmentDirectional.centerStart,
            children: [
              CardImageCategoryBackground(color: info.color!, image: info.imageCategory!,),
              Positioned(
                left: positionedCount,
                child: Text(
                  info.count.toString(), 
                  style: const TextStyle(
                    color: black,
                    fontSize: 18, 
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Roboto'
                  ),
                ),
              ),
              Positioned(
                left: positionedTitle,
                child: Text(
                  info.title! != Strings.allStates 
                  ? '${info.title!.toUpperCase()}S'
                  : info.title!.toUpperCase(), 
                  style: const TextStyle(
                    color: black,
                    fontSize: 18.5, 
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Roboto'
                  ),
                ),
              ),
          ]),
        ),
      ),
    );
  }
}

class CardImageCategoryBackground extends StatelessWidget {
  const CardImageCategoryBackground({ super.key, required this.image, required this.color, });

  final Color color;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        border: Border.all(
          color: Colors.transparent,
          width: 0,
          style: BorderStyle.none,
        ),
        borderRadius: const BorderRadius.all(Radius.circular(10))
      ),
      width: double.infinity,
      child: Image.asset(
          image,
          fit: BoxFit.cover,
        ),
    );
  }
}