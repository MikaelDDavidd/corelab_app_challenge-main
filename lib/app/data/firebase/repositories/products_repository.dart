import 'dart:convert';
import 'package:corelab_app_challenge/app/data/firebase/http/exeptions.dart';
import 'package:corelab_app_challenge/app/data/firebase/http/http_client.dart';
import 'package:corelab_app_challenge/app/data/models/product_model.dart';
import 'package:logger/logger.dart';

abstract class iProducts {
  Future<List<Product>> getProducts();
}

class ProductsRepository implements iProducts {
  final IHttpClient client;

  ProductsRepository({required this.client});

  @override
  Future<List<Product>> getProducts() async {
    Logger().d('Fetching audios from Firebase Realtime Database...');
    final response = await client.get(
        url: 'https://correlab-challenge-default-rtdb.firebaseio.com/.json');

    if (response.statusCode == 200) {
      final List<Product> audios = [];
      final body = jsonDecode(response.body);

      body['data'].map((item) {
        final Product audio = Product.fromJson(item);
        audios.add(audio);
      }).toList();
      return audios;
    } else if (response.statusCode == 404) {
      throw NotFoundException('A url informada não é válida');
    } else {
      throw Exception('não foi possivel carregar os produtos');
    }
  }
}
