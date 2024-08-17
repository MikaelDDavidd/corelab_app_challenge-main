import 'package:corelab_app_challenge/app/data/models/product_model.dart';
import 'package:corelab_app_challenge/app/data/utilities/app_colors.dart';
import 'package:corelab_app_challenge/app/widgets/offer_container.dart';
import 'package:flutter/material.dart';

class ProductContainer extends StatelessWidget {
  final double height;
  final double width;
  final Product product;
  const ProductContainer({
    super.key,
    required this.height,
    required this.width,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    final divided = product.price / 2;
    return Container(
      decoration: BoxDecoration(color: AppColors.secondaryColor),
      height: height, // Altura do container pai
      margin:
          EdgeInsets.symmetric(vertical: height * 0.01), // Margem proporcional
      padding: EdgeInsets.symmetric(
          horizontal: width * 0.04), // Padding proporcional
      child: Row(
        children: [
          Image.network(product.url, width: width * 0.3),
          SizedBox(width: width * 0.04), // Espaçamento horizontal proporcional
          SizedBox(
            width: width * 0.6, // Baseado na largura disponível do container
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (product.offer != 0) ...[
                  OfferContainer(
                      height: height * 0.15,
                      width: width * 0.2,
                      text: '${product.offer}% OFF'),
                ],

                Text(
                  product.name,
                  style: TextStyle(fontSize: width * 0.045),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                if (product.firstPrice != null) ...[
                  Text(
                    'R\$ ${product.firstPrice!.toStringAsFixed(2)}',
                    style:
                        const TextStyle(decoration: TextDecoration.lineThrough),
                  ),
                ],
                SizedBox(
                    height: height * 0.01), // Espaçamento vertical proporcional
                Text(
                  'R\$ ${product.price.toStringAsFixed(2)}',
                  style: TextStyle(
                    fontSize: width * 0.04,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Em ate 12x de R\$ ${divided.toStringAsFixed(2)} ',
                  style: TextStyle(color: AppColors.primaryColor),
                ),
                if (product.isNew) ...[
                  const Text('NOVO'),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
