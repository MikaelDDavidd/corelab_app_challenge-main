import 'package:corelab_app_challenge/app/data/utilities/app_colors.dart';
import 'package:corelab_app_challenge/app/modules/controllers/home_controller.dart';
import 'package:corelab_app_challenge/app/widgets/circular_load_progress.dart';
import 'package:corelab_app_challenge/app/widgets/custom_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeView extends StatelessWidget {
  final double height;
  final double width;

  const HomeView({
    super.key,
    required this.height,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<HomeController>(context);

    // Defining the height and width for the parent container based on screen size
    final double containerHeight = height * 0.21;
    final double containerWidth = width * 0.9;

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Center(
        child: CircularLoadProgress(
          state: controller.store.isLoading,
          data: controller.store.data,
          error: controller.store.erro,
          itsChild: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    'Últimos Anúncios',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ),
                Column(
                  children: [
                    // Display products added today
                    if (controller.productsAddedToday.isNotEmpty) ...[
                      CustomList(
                        height: containerHeight,
                        width: containerWidth,
                        products: controller.productsAddedToday,
                        period: 'HOJE',
                      ),
                    ],
                    // Display products added yesterday
                    if (controller.productsAddedYesterday.isNotEmpty) ...[
                      CustomList(
                        height: containerHeight,
                        width: containerWidth,
                        products: controller.productsAddedYesterday,
                        period: 'ONTEM',
                      ),
                    ],
                    // Display products added earlier
                    if (controller.productsAddedEarlier.isNotEmpty) ...[
                      CustomList(
                        height: containerHeight,
                        width: containerWidth,
                        products: controller.productsAddedEarlier,
                        period: 'TODOS',
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}