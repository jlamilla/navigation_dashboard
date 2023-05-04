import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:navigation_dashboard/config/providers/analytic_data_provider.dart';
import 'package:navigation_dashboard/infrastructure/helpers/app_screen.dart';
import 'package:navigation_dashboard/infrastructure/helpers/responsive.dart';
import 'package:navigation_dashboard/ui/widgets/web/card_analytic/analytic_info_card.dart';
import 'package:navigation_dashboard/ui/widgets/skelton_loading/analytic_skelton_loading.dart';

class AnalyticCards extends StatelessWidget {
  
  const AnalyticCards({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Responsive(
      mobile: AnalyticInfoCardGridView(
        crossAxisCount: AppScreen.getWidthSize < 650 ? 2 : 4,
        childAspectRatio: AppScreen.getWidthSize < 650 ? 2 : 1.5,
      ),
      tablet: const AnalyticInfoCardGridView(),
      desktop: AnalyticInfoCardGridView(
        childAspectRatio: AppScreen.getWidthSize < 1400 ? 1.5 : 2.1,
      ),
    );
  }
}

class AnalyticInfoCardGridView extends ConsumerWidget {

  const AnalyticInfoCardGridView({Key? key, this.crossAxisCount = 4, this.childAspectRatio = 1.4,}) : super(key: key);

  final int crossAxisCount;
  final double childAspectRatio;
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final analyticDataAsync = ref.watch(analyticDataProvider(null));
    return  analyticDataAsync.when(
      data: (analyticData){
        return GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: analyticData.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              crossAxisSpacing: 16.0,
              mainAxisSpacing: 16.0,
              childAspectRatio: childAspectRatio
            ), 
            itemBuilder: (context, index) => AnalyticInfoCard(info: analyticData[index]),
          );
      }, 
      error: (_, __) => const Text('No se logro cargar la información'), 
      loading: ()=> AnalyticSkeltonLoading(itemCount: 4, childAspectRatio: childAspectRatio, crossAxisCount: crossAxisCount,),
    );
  }
}