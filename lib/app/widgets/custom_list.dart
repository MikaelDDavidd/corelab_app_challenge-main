import 'package:corelab_app_challenge/app/data/models/product_model.dart';
import 'package:corelab_app_challenge/app/data/utilities/app_colors.dart';
import 'package:corelab_app_challenge/app/widgets/product_container.dart';
import 'package:flutter/material.dart';

class CustomList extends StatelessWidget {
  final double height;
  final double width;
  final String period;
  final List<Product> products;
  const CustomList(
      {super.key,
      required this.height,
      required this.width,
      required this.products,
      required this.period});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: height * 0.3,
          width: width,
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(color: AppColors.tertiaryTextColor),
          child:  Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Text(period),
          ),
        ),
        ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: products.length,
          itemBuilder: (context, index) {
            final product = products[index];
            return ProductContainer(
              height: height,
              width: width,
              product: product,
            );
          },
        ),
      ],
    );
  }
}
