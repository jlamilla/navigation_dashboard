import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'image_buttom_custom.dart';

class SelectImageOptionsScreen extends StatelessWidget {

  final Function(ImageSource source, BuildContext context) onTap;
  const SelectImageOptionsScreen({ Key? key, required this.onTap,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Stack(
        alignment: AlignmentDirectional.topCenter,
        clipBehavior: Clip.none,
        children: [
          Positioned(
            top: -35,
            child: Container(
              width: 50,
              height: 6,
              margin: const EdgeInsets.only(bottom: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(2.5),
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Column(children: [
            SelectPhoto(
              onTap: () => onTap(ImageSource.gallery, context),
              icon: Icons.image,
              textLabel: 'Buscar en tu galería',
            ),
            const SizedBox(
              height: 40,
            ),
            SelectPhoto(
              onTap: () => onTap(ImageSource.camera, context),
              icon: Icons.camera_alt_outlined,
              textLabel: 'Usar cámara',
            ),
          ])
        ],
      ),
    );
  }
}
