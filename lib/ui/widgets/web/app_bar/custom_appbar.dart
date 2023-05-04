import 'package:fluent_ui/fluent_ui.dart';
import 'package:navigation_dashboard/infrastructure/helpers/app_screen.dart';
import 'package:navigation_dashboard/ui/widgets/web/app_bar/profile_info.dart';
import 'package:navigation_dashboard/ui/widgets/web/app_bar/search_field.dart';
import 'package:navigation_design/tokens/colors.dart';

class CustomAppBar extends StatelessWidget {
  
  const CustomAppBar({Key? key, required this.titleSearch}) : super(key: key);
  final String titleSearch;
  
  @override
  Widget build(BuildContext context) {
    return  SearchField(title: titleSearch, message: '',);
        //const ProfileInfo()
      
  }
}