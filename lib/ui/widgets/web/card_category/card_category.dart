import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:navigation_dashboard/config/providers/analytic_data_provider.dart';
import 'package:navigation_dashboard/infrastructure/helpers/app_screen.dart';
import 'package:navigation_dashboard/infrastructure/helpers/responsive.dart';
import 'package:navigation_dashboard/ui/widgets/skelton_loading/analytic_skelton_loading.dart';
import 'package:navigation_dashboard/ui/widgets/web/card_category/card_category_info.dart';

class CardCategory extends StatelessWidget {
  
  const CardCategory({Key? key, required this.data}) : super(key: key);
  final List data;
  
  @override
  Widget build(BuildContext context) {
    return Responsive(
      mobile: CardCategoryGridView(
        width: AppScreen.getWidthSize < 650 ? 2 : 4,
        positionedCount: AppScreen.getWidthSize < 650 ? 2 : 1.5, 
        positionedTitle: AppScreen.getWidthSize < 650 ? 2 : 1.5, 
        data: data,
      ),
      tablet: CardCategoryGridView(
        data: data
        ),
      desktop: CardCategoryGridView(
        positionedCount: AppScreen.getWidthSize < 1400 ? 50 : 57, 
        positionedTitle: AppScreen.getWidthSize < 1400 ? 110 : 112,
        width: AppScreen.getWidthSize < 1400 ? 300 : 320,
        data: data,
      ),
    );
  }
}

class CardCategoryGridView extends StatelessWidget {

  const CardCategoryGridView({Key? key, this.width = 270, this.positionedCount = 45, this.positionedTitle = 85, required this.data,}) : super(key: key);

  final double width;
  final double positionedCount;
  final double positionedTitle;
  final List data;
  
  @override
  Widget build(BuildContext context) {

    return  Consumer(
      builder: (BuildContext context, WidgetRef ref, __) { 
          final analyticDataAsync = ref.watch(analyticDataProvider(data));
          return analyticDataAsync.when(
            data: (analyticData){
              return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: analyticData.length,
                  itemBuilder: (context, index) => SizedBox(
                        width: width,
                        child: CardCategoryInfo(info: analyticData[index], positionedCount: positionedCount, positionedTitle: positionedTitle)
                      ),
                );
            }, 
            error: (_, __) => const Text('No se logro cargar la información'), 
            loading: ()=> const AnalyticSkeltonLoading(itemCount: 4,),
          );
      },);
  }
}