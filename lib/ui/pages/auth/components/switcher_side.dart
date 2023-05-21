import 'package:flutter/material.dart';
import 'package:navigation_dashboard/ui/constants/images.dart';
import 'package:navigation_design/atoms/nd_image.dart';

class SwitcherSide extends StatefulWidget {
  const SwitcherSide({
    Key? key,
    required Animation<double> animation,
    required this.containerWidth,
    required this.welcomeText,
    required AnimationController controller,
    required this.width,
    required this.alignText,
  }) : _animation = animation, _controller = controller, super(key: key);

  final Animation<double> _animation;
  final double containerWidth;
  final double welcomeText;
  final AnimationController _controller;
  final double width;
  final double alignText;

  @override
  SwitcherSideState createState() => SwitcherSideState();
}

class SwitcherSideState extends State<SwitcherSide> {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment(widget._animation.value, 0.0),
      child: Container(
        height: MediaQuery.of(context).size.height,
        width:
            MediaQuery.of(context).size.width * 0.37 + widget.containerWidth,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: const AssetImage('../assets/images/3410506.jpg'),
            fit: BoxFit.cover,
            alignment: Alignment(widget._animation.value, 0.0),
          ),
        ),
        clipBehavior: Clip.hardEdge,
        child: SizedBox(
          width: 300.0,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                children: [
                  Align(
                    alignment: Alignment(widget.welcomeText, -0.35),
                    child: SizedBox(
                      width: 350.0,
                      height: 300.0,
                      child: Column(
                        children: [
                          const OurAssetImage(assetName: Images.logoWithTextWhite, placeholder: Images.logoWithTextWhite,),
                          Text(
                            widget._animation.value > 0.0
                                ? '¿Ya restableciste tu contraseña?'
                                : '¿Has olvidado tu contraseña?',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 18.0,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    if (widget._controller.isCompleted) {
                      widget._controller.reverse();
                    } else {
                      widget._controller.forward();
                    }
                  });
                },
                child: Container(
                  height: 60.0,
                  width: widget.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30.0),
                    border:
                        Border.all(color: Colors.white, width: 2.0),
                  ),
                  child: Center(
                    child: Stack(
                      children: [
                        Align(
                          alignment: Alignment(widget.alignText, 0.0),
                          child: Opacity(
                            opacity: (widget._animation.value < 0.0)
                                ? widget._animation.value.abs()
                                : 0.0,
                            child: const Text(
                              'RESTABLECER',
                              style: TextStyle(
                                fontSize: 17.0,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment(widget.alignText, 0.0),
                          child: Opacity(
                            opacity: (widget._animation.value > 0.0)
                                ? widget._animation.value.abs()
                                : 0.0,
                            child: const Text(
                              'INGRESAR',
                              style: TextStyle(
                                fontSize: 15.0,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}