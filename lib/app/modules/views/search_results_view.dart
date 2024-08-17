import 'package:corelab_app_challenge/app/modules/controllers/search_controller.dart';
import 'package:corelab_app_challenge/app/widgets/custom_list.dart';
import 'package:flutter/material.dart';

class SearchResultsView extends StatelessWidget {
  final double height;
  final double width;
  final SearchLogicController controller;

  const SearchResultsView({
    super.key,
    required this.height,
    required this.width,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final results = controller.searchResults;
    final double containerHeight = height * 0.15;
    final double containerWidth = width * 0.9;

    // Display a "not found" message if no results were found
    if (controller.noResultsFound) {
      return Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/not_found.png',
                width: width * 0.4, // Adjust size as needed
                height: height * 0.2,
              ),
              const SizedBox(height: 20),
              const Text(
                'Resultado não encontrado',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Não encontramos nenhum resultado parecido com "${controller.query}".',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      );
    }

    // Display the search results in a custom list
    return SingleChildScrollView(
      child: Column(
        children: [
          CustomList(
            height: containerHeight,
            width: containerWidth,
            products: results,
            period: '${results.length} Resultados encontrados',
          ),
        ],
      ),
    );
  }
}