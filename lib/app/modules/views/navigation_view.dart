import 'package:corelab_app_challenge/app/data/utilities/app_colors.dart';
import 'package:corelab_app_challenge/app/modules/controllers/home_controller.dart';
import 'package:corelab_app_challenge/app/modules/controllers/search_controller.dart';
import 'package:corelab_app_challenge/app/modules/views/announce_view.dart';
import 'package:corelab_app_challenge/app/modules/views/categories_view.dart';
import 'package:corelab_app_challenge/app/modules/views/favorites_view.dart';
import 'package:corelab_app_challenge/app/modules/views/home_view.dart';
import 'package:corelab_app_challenge/app/modules/views/profile_view.dart';
import 'package:corelab_app_challenge/app/modules/views/search_results_view.dart';
import 'package:corelab_app_challenge/app/widgets/search_sugestions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NavigationView extends StatefulWidget {
  const NavigationView({super.key});

  @override
  _NavigationViewState createState() => _NavigationViewState();
}

class _NavigationViewState extends State<NavigationView> {
  bool isSearching = false;
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final HomeController homeController = Provider.of<HomeController>(context);
    final SearchLogicController searchController =
        Provider.of<SearchLogicController>(context);

    // Determine if the device is a tablet or a smartphone
    bool isTablet = MediaQuery.of(context).size.shortestSide >= 600;

    // Determine the orientation
    bool isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;

    // Get screen dimensions
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    // Define size variables based on device type and orientation
    double height;
    double width;
    double appBarHeight;
    double searchFieldHeight;
    double paddingHorizontal;

    if (isTablet) {
      if (isLandscape) {
        height = screenHeight;
        width = screenWidth * 0.4;
        appBarHeight = screenHeight * 0.15;
        searchFieldHeight = screenHeight * 0.075;
        paddingHorizontal = screenWidth * 0.035;
      } else {
        height = screenHeight;
        width = screenWidth * 0.7;
        appBarHeight = screenHeight * 0.1;
        searchFieldHeight = screenHeight * 0.06;
        paddingHorizontal = screenWidth * 0.04;
      }
    } else {
      if (isLandscape) {
        height = screenHeight * 2.0;
        width = screenWidth * 0.4;
        appBarHeight = screenHeight * 0.2;
        searchFieldHeight = screenHeight * 0.1;
        paddingHorizontal = screenWidth * 0.03;
      } else {
        height = screenHeight * 0.95;
        width = screenWidth * 0.95;
        appBarHeight = screenHeight * 0.1;
        searchFieldHeight = screenHeight * 0.06;
        paddingHorizontal = screenWidth * 0.04;
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: homeController.selectedIndex == 1 && !isSearching
          ? AppBar(
              toolbarHeight: appBarHeight,
              backgroundColor: AppColors.backgroundColor,
              elevation: 0,
              titleSpacing: 20,
              centerTitle: false,
              title: const Text(
                'Categorias',
                style: TextStyle(
                  color: Colors.black, // Strong black color
                  fontWeight: FontWeight.bold, // Bold text
                ),
              ),
            )
          : AppBar(
              toolbarHeight: appBarHeight,
              backgroundColor: AppColors.primaryColor,
              elevation: 0,
              leading: isSearching || searchController.query.isNotEmpty
                  ? IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () {
                        // Remove focus from the text field to close the keyboard
                        FocusScope.of(context).unfocus();

                        setState(() {
                          if (isSearching) {
                            isSearching = false;
                            _searchController.clear();
                          } else if (searchController.query.isNotEmpty) {
                            searchController.onQueryChanged('');
                            _searchController.clear();
                            setState(() {});
                          } else {
                            Navigator.of(context).pop();
                          }
                        });
                      },
                    )
                  : null,
              title: Container(
                height: searchFieldHeight,
                padding: EdgeInsets.symmetric(horizontal: paddingHorizontal),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _searchController,
                        onTap: () {
                          setState(() {
                            isSearching = true;
                          });
                        },
                        onChanged: (newQuery) {
                          searchController.onQueryChanged(newQuery);
                        },
                        onSubmitted: (newQuery) {
                          searchController.onQueryChanged(newQuery);
                          searchController.addSearchTerm(newQuery);
                          setState(() {
                            isSearching = false;
                          });
                        },
                        decoration: const InputDecoration(
                          hintText: 'Buscar',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    if (_searchController.text.isNotEmpty)
                      IconButton(
                        icon: const Icon(Icons.close, color: Colors.grey),
                        onPressed: () {
                          FocusScope.of(context).unfocus();
                          _searchController.clear();
                          searchController.onQueryChanged('');
                          setState(() {});
                        },
                      ),
                  ],
                ),
              ),
              actions: searchController.query.isNotEmpty
                  ? [
                      TextButton(
                        onPressed: () {
                          // Logic to open filters
                        },
                        child: const Text(
                          'Filtros',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ]
                  : null,
            ),
      body: isSearching
          ? SearchSuggestions(
              height: height,
              width: width,
              onSuggestionTap: (term) {
                // Set the term in the TextField
                FocusScope.of(context).unfocus();
                _searchController.text = term;
                // Execute the search
                searchController.searchFromHistory(term);
                setState(() {
                  isSearching = false;
                });
              },
            )
          : (homeController.selectedIndex == 1
              ? CategoriesView()
              : searchController.query.isNotEmpty
                  ? SearchResultsView(
                      height: height,
                      width: width,
                      controller: searchController,
                    )
                  : IndexedStack(
                      index: homeController.selectedIndex,
                      children: [
                        HomeView(height: height, width: width),
                        CategoriesView(),
                        const AnnounceView(),
                        const FavoritesView(),
                        const ProfileView(),
                      ],
                    )),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: homeController.selectedIndex,
        onTap: (index) {
          setState(() {
            isSearching = false;
            searchController.onQueryChanged(''); // Clear search when switching tabs
            homeController.selectPage(index);
          });
        },
        selectedItemColor: AppColors.primaryColor,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.grid_view),
            label: 'Categorias',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle_outline),
            label: 'Anunciar',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border),
            label: 'Favoritos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Conta',
          ),
        ],
      ),
    );
  }
}