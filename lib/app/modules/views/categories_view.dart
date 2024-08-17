import 'package:flutter/material.dart';
import 'package:corelab_app_challenge/app/data/utilities/app_colors.dart';

class CategoriesView extends StatelessWidget {
  final List<String> categories = [
    'Anestésicos e Agulhas Gengival',
    'Biossegurança',
    'Descartáveis',
    'Dentística e Estética',
    'Ortodontia',
    'Endodontia',
    'Periféricos e Peças de Mão',
    'Moldagem',
    'Prótese',
    'Cimentos',
    'Instrumentos',
    'Cirurgia e Periodontia',
    'Radiologia',
  ];

  CategoriesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: ListView.builder(
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return Container(
            decoration: BoxDecoration(color: AppColors.secondaryColor),
            margin: const EdgeInsets.symmetric(vertical: 1),
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: ListTile(
              title: Text(
                categories[index],
                style: TextStyle(
                  color: AppColors.primaryColor,
                  fontSize: 18,
                ),
              ),
              onTap: () {
                // TODO: Add logic when a category is tapped
              },
            ),
          );
        },
      ),
    );
  }
}