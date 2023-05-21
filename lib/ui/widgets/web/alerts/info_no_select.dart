import 'package:fluent_ui/fluent_ui.dart';
import 'package:navigation_dashboard/ui/constants/strings.dart';

class InfoNoSelect extends StatelessWidget {
  const InfoNoSelect({
    super.key, 
    required this.acton, 
    required this.title, 
    required this.content, 
    required this.icon,
  });
  final Function()? acton;
  final String title;
  final String content;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 100,
        child: InfoBar(
          title: const Text(Strings.helpAlert, style: TextStyle(fontSize: 20),),
          content: Text(content, style: const TextStyle(fontSize: 20),),
          severity: InfoBarSeverity.info,
          action: SizedBox(
            width: 100,
            height: 60,
            child: Button(
              onPressed: acton,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children:[
                  Icon(icon, size: 20,),
                  const SizedBox(width: 10,),
                  Text(title, style: const TextStyle(fontSize: 15),),
                ],
              )
            ),
          )
        ),
      ),
    );
  }
}