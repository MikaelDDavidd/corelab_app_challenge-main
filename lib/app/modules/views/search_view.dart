import 'package:corelab_app_challenge/app/modules/controllers/search_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchView extends StatelessWidget {
  const SearchView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<SearchLogicController>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: TextField(
          decoration: const InputDecoration(
            hintText: 'Buscar',
            border: InputBorder.none,
            icon: Icon(Icons.search, color: Colors.grey),
          ),
          onSubmitted: (term) {
            controller.addSearchTerm(term);
            // Trigger the search based on the submitted term
          },
        ),
      ),
      body: controller.searchHistory.isEmpty
          ? const Center(child: Text('Nenhuma pesquisa recente.'))
          : ListView.builder(
              itemCount: controller.searchHistory.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: const Icon(Icons.history),
                  title: Text(controller.searchHistory[index]),
                  onTap: () {
                    // Use the tapped term to start a new search
                  },
                );
              },
            ),
    );
  }
}