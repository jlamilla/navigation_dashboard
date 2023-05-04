
import 'package:fluent_ui/fluent_ui.dart';
import 'package:navigation_dashboard/ui/constants/images.dart';

class CardImageBackground extends StatelessWidget {
  const CardImageBackground({ super.key, required this.color, });

  final Color? color;

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
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        )
      ),
      width: double.infinity,
      child: Image.asset(Images.mask, fit: BoxFit.cover,),
    );
  }
}