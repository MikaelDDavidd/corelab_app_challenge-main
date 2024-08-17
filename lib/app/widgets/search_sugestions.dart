import 'package:corelab_app_challenge/app/data/utilities/app_colors.dart';
import 'package:corelab_app_challenge/app/modules/controllers/search_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchSuggestions extends StatelessWidget {
  final double height;
  final double width;
  final Function(String) onSuggestionTap;

  const SearchSuggestions({
    super.key,
    required this.height,
    required this.width,
    required this.onSuggestionTap,
  });

  @override
  Widget build(BuildContext context) {
    final searchController = Provider.of<SearchLogicController>(context);
    final searchHistory = searchController.searchHistory;

    return searchHistory.isEmpty
        ? const Center(child: Text('Nenhum histórico de pesquisa disponível.'))
        : ListView.builder(
            padding: EdgeInsets.symmetric(vertical: height * 0.02),
            itemCount: searchHistory.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: Icon(Icons.history, color: AppColors.primaryColor),
                title: Text(searchHistory[index]),
                onTap: () {
                  // Usa o callback para lidar com o clique na sugestão
                  onSuggestionTap(searchHistory[index]);
                },
              );
            },
          );
  }
}