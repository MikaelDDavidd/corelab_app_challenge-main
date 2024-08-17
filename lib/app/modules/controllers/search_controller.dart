import 'package:corelab_app_challenge/app/data/firebase/http/http_client.dart';
import 'package:corelab_app_challenge/app/data/firebase/repositories/products_repository.dart';
import 'package:corelab_app_challenge/app/data/models/product_model.dart';
import 'package:corelab_app_challenge/app/data/stores/products_store.dart';
import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SearchLogicController with ChangeNotifier {
  List<String> _searchHistory = [];
  List<String> get searchHistory => _searchHistory;
  String query = "";
  List<Product> searchResults = <Product>[];
  bool noResultsFound = false;

  final ProductsStore store = ProductsStore(
    repository: ProductsRepository(
      client: HttpClient(),
    ),
  );

  SearchLogicController() {
    _onInit(); // Calls initialization method
    _loadSearchHistory(); // Loads search history from local storage
  }

  // Initialization method
  void _onInit() {
    store.getProducts().then((_) {
      notifyListeners(); // Ensures UI is updated after loading products
    }).catchError((error) {
      Logger().e("Error loading products: $error");
      searchResults = store.data.value;
      notifyListeners();
    });
  }

  // Handles changes in the search query
  void onQueryChanged(String query) {
    this.query = query;
    searchResults = store.data.value
        .where((product) => product.name.toLowerCase().contains(query.toLowerCase()))
        .toList();
    noResultsFound = searchResults.isEmpty;
    notifyListeners(); // Notifies the UI that search results have been updated
  }

  // Adds a search term to the history
  void addSearchTerm(String term) async {
    if (!_searchHistory.contains(term)) {
      _searchHistory.insert(0, term);
      if (_searchHistory.length > 10) {
        _searchHistory.removeLast();
      }
      await _saveSearchHistory();
      notifyListeners();
    }
  }

  // Clears the search history
  void clearSearchHistory() async {
    _searchHistory.clear();
    await _saveSearchHistory();
    notifyListeners();
  }

  // Initiates a search from a term in the history
  void searchFromHistory(String term) {
    onQueryChanged(term);
    addSearchTerm(term);
  }

  // Loads the search history from local storage
  Future<void> _loadSearchHistory() async {
    final prefs = await SharedPreferences.getInstance();
    _searchHistory = prefs.getStringList('searchHistory') ?? [];
    notifyListeners();
  }

  // Saves the search history to local storage
  Future<void> _saveSearchHistory() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList('searchHistory', _searchHistory);
  }
}