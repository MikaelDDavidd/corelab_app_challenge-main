import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:corelab_app_challenge/app/modules/controllers/home_controller.dart';
import 'package:corelab_app_challenge/app/modules/controllers/search_controller.dart';
import 'package:corelab_app_challenge/app/modules/views/categories_view.dart';
import 'package:corelab_app_challenge/app/modules/views/home_view.dart';
import 'package:corelab_app_challenge/app/modules/views/navigation_view.dart';
import 'package:corelab_app_challenge/app/modules/views/search_results_view.dart';
import 'package:provider/provider.dart';

void main() {
  testWidgets('NavigationView displays HomeView by default', (WidgetTester tester) async {
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => HomeController()),
          ChangeNotifierProvider(create: (_) => SearchLogicController()),
        ],
        child: const MaterialApp(
          home: NavigationView(),
        ),
      ),
    );

    expect(find.byType(HomeView), findsOneWidget);
    expect(find.byType(CategoriesView), findsNothing);
  });

  testWidgets('NavigationView navigates to CategoriesView', (WidgetTester tester) async {
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => HomeController()),
          ChangeNotifierProvider(create: (_) => SearchLogicController()),
        ],
        child: const MaterialApp(
          home: NavigationView(),
        ),
      ),
    );

    // Tap on the Categories BottomNavigationBarItem
    await tester.tap(find.text('Categorias'));
    await tester.pumpAndSettle();

    expect(find.byType(CategoriesView), findsOneWidget);
    expect(find.byType(HomeView), findsNothing);
  });

  testWidgets('Search results display correctly', (WidgetTester tester) async {
    final searchController = SearchLogicController();
    searchController.onQueryChanged('test product');

    await tester.pumpWidget(
      ChangeNotifierProvider<SearchLogicController>.value(
        value: searchController,
        child: MaterialApp(
          home: Scaffold(
            body: SearchResultsView(
              height: 800,
              width: 400,
              controller: searchController,
            ),
          ),
        ),
      ),
    );

    if (searchController.noResultsFound) {
      expect(find.text('Resultado não encontrado'), findsOneWidget);
    } else {
      expect(find.byType(SearchResultsView), findsOneWidget);
    }
  });

testWidgets('CategoriesView displays all categories', (WidgetTester tester) async {
  // Build the CategoriesView widget.
  await tester.pumpWidget(MaterialApp(home: CategoriesView()));

  // Wait for the widget tree to settle.
  await tester.pumpAndSettle();

  // Verify that all categories are displayed.
  final categories = [
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

  for (final category in categories) {
    expect(find.text(category), findsOneWidget);
  }
});

  testWidgets('Search logic adds term to history', (WidgetTester tester) async {
    final searchController = SearchLogicController();

    await tester.pumpWidget(
      ChangeNotifierProvider<SearchLogicController>.value(
        value: searchController,
        child: MaterialApp(
          home: Scaffold(
            body:  SearchResultsView(height: 800, width: 400, controller: SearchLogicController()),
          ),
        ),
      ),
    );

    searchController.addSearchTerm('test term');

    await tester.pumpAndSettle();

    expect(searchController.searchHistory.contains('test term'), isTrue);
  });

  testWidgets('Search history displays correct items', (WidgetTester tester) async {
    final searchController = SearchLogicController();
    searchController.addSearchTerm('test term');

    await tester.pumpWidget(
      ChangeNotifierProvider<SearchLogicController>.value(
        value: searchController,
        child:  MaterialApp(
          home: Scaffold(
            body: CategoriesView(),
          ),
        ),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.text('test term'), findsOneWidget);
  });
}