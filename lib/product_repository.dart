import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:isolate';
import 'package:http/http.dart' as http;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paralelos2/client_provider.dart';
import 'package:paralelos2/product_entity.dart';

final productRepositoryProvider = Provider<ProductRepository>(
    (ref) => ProductRepository(ref.read(httpClientProvider)));

class ProductRepository {
  final http.Client httpClient;

  ProductRepository(this.httpClient);

  Future<List<Product>?> fetchAll() async {
    try {
      const urlBase = 'http://localhost:5000/products';
      int result = 0;
      for (int i = 0; i < 100000000; i++) {
        result = result + i;
      }
      print(result);

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
          Future.delayed(Duration(seconds: 5));
          return productos;
        }
        Future.delayed(Duration(seconds: 5));
        return null;
      } else {
        Future.delayed(Duration(seconds: 5));
        return null;
      }
    } on TimeoutException {
      Future.delayed(Duration(seconds: 5));
      return null;
    } catch (error, stack) {
      log("****** ProductRepository.fetchAll ******",
          error: error, stackTrace: stack);
      Future.delayed(Duration(seconds: 5));
      return null;
    }
  }

  Future<void> fetchAllIsolate(SendPort sendPort) async {
    try {
      const urlBase = 'http://localhost:5000/products';
      int result = 0;
      for (int i = 0; i < 100000000; i++) {
        result = result + i;
      }
      print(result);

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

          sendPort.send(productos);
        }
        sendPort.send(null);
      } else {
        sendPort.send(null);
      }
    } on TimeoutException {
      sendPort.send(null);
    } catch (error, stack) {
      log("****** ProductRepository.fetchAll ******",
          error: error, stackTrace: stack);
      sendPort.send(null);
    }
  }
}
