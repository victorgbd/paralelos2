import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paralelos2/client_provider.dart';
import 'package:paralelos2/product_entity.dart';

final productRepositoryProvider = Provider<ProductRepository>(
    (ref) => ProductRepository(ref.read(httpClientProvider), ref));

class ProductRepository {
  final http.Client httpClient;
  final Ref ref;

  ProductRepository(this.httpClient, this.ref);

  Future<List<Product>?> fetchAll() async {
    try {
      const urlBase = 'http://localhost:5000/products';

      var response = await httpClient
          .post(
            Uri.parse(urlBase),
          )
          .timeout(const Duration(seconds: 10));

      if (response.statusCode >= 200 && response.statusCode < 300) {
        final data = json.decode(response.body);
        if (data != null) {
          final productos = <Product>[];

          for (final node in data) {
            productos.add(
              Product.fromJson(Map.from(node)),
            );
          }
          return productos;
        }
        return null;
      } else {
        return null;
      }
    } on TimeoutException {
      return null;
    } catch (error, stack) {
      log("****** ProductRepository.fetchAll ******",
          error: error, stackTrace: stack);
      return null;
    }
  }
}
