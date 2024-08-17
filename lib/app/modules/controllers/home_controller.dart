import 'package:corelab_app_challenge/app/data/firebase/http/http_client.dart';
import 'package:corelab_app_challenge/app/data/firebase/repositories/products_repository.dart';
import 'package:corelab_app_challenge/app/data/models/product_model.dart';
import 'package:corelab_app_challenge/app/data/stores/products_store.dart';
import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeController with ChangeNotifier {
  int _selectedIndex = 0;
  int get selectedIndex => _selectedIndex;
  bool noResultsFound = false;

  final ProductsStore store = ProductsStore(
    repository: ProductsRepository(
      client: HttpClient(),
    ),
  );

  List<Product> productsAddedToday = [];
  List<Product> productsAddedYesterday = [];
  List<Product> productsAddedEarlier = [];

  HomeController() {
    _onInit(); // Calls initialization method
  }

  // Method to change the selected page index
  void selectPage(int index) {
    _selectedIndex = index;
    notifyListeners();
  }

  // Method to get today's date
  DateTime getTodayDate() {
    return DateTime.now();
  }

  // Initialization method
  void _onInit() {
    store.getProducts().then((_) {
      _filterProductsByDate();
      notifyListeners(); // Ensures UI is updated after loading products
      Logger().d("HomeController started and products filtered!");
    }).catchError((error) {
      Logger().e("Error loading products: $error");
    });
  }

  // Method to filter products based on their admission date
  void _filterProductsByDate() {
    final DateTime today = getTodayDate();
    final DateTime yesterday = today.subtract(const Duration(days: 1));

    productsAddedToday = store.data.value.where((product) {
      final DateTime productDate = DateTime.parse(product.admissionDate);
      return productDate.year == today.year &&
          productDate.month == today.month &&
          productDate.day == today.day;
    }).toList();

    productsAddedYesterday = store.data.value.where((product) {
      final DateTime productDate = DateTime.parse(product.admissionDate);
      return productDate.year == yesterday.year &&
          productDate.month == yesterday.month &&
          productDate.day == yesterday.day;
    }).toList();

    productsAddedEarlier = store.data.value.where((product) {
      final DateTime productDate = DateTime.parse(product.admissionDate);
      return productDate.isBefore(yesterday);
    }).toList();

    notifyListeners(); // Notifies listeners of data changes
  }
}