import 'package:corelab_app_challenge/app/data/firebase/http/exeptions.dart';
import 'package:corelab_app_challenge/app/data/firebase/repositories/products_repository.dart';
import 'package:corelab_app_challenge/app/data/models/product_model.dart';
import 'package:flutter/foundation.dart';


class ProductsStore {
  final iProducts repository;

  // Variável para indicar se está carregando os dados
  final ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);

  // Variável para armazenar os packs de adesivos
  final ValueNotifier<List<Product>> data =
      ValueNotifier<List<Product>>([]);

  // Variável para armazenar mensagens de erro
  final ValueNotifier<String> erro = ValueNotifier<String>('');

  ProductsStore({required this.repository});

  Future getProducts() async {
    isLoading.value = true;
    try {
      final result = await repository.getProducts();
      data.value = result;
    } on NotFoundException catch (e) {
      erro.value = e.message;
    } catch (e) {
      erro.value = e.toString();
    }
    isLoading.value = false;
  }
}
