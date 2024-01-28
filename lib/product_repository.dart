import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:isolate';
import 'package:http/http.dart' as http;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paralelos2/providers/client_provider.dart';
import 'package:paralelos2/product_entity.dart';

final productRepositoryProvider = Provider<ProductRepository>(
    (ref) => ProductRepository(ref.read(httpClientProvider)));

class ProductRepository {
  final http.Client httpClient;

  ProductRepository(this.httpClient);

  Future<List<Product>?> fetchAll() async {
    try {
      const urlBase = 'http://10.0.0.5:5000/products';
      int result = 0;
      for (int i = 0; i < 100000000; i++) {
        result = result + i;
      }
      print(result);

      var response = await httpClient
          .get(
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
          Future.delayed(const Duration(seconds: 5));
          return productos;
        }
        Future.delayed(const Duration(seconds: 5));
        return null;
      } else {
        Future.delayed(const Duration(seconds: 5));
        return null;
      }
    } on TimeoutException {
      Future.delayed(const Duration(seconds: 5));
      return null;
    } catch (error, stack) {
      log("****** ProductRepository.fetchAll ******",
          error: error, stackTrace: stack);
      Future.delayed(const Duration(seconds: 5));
      return null;
    }
  }

  Future<void> fetchAllIsolate(SendPort sendPort) async {
    try {
      const urlBase = 'http://10.0.0.5:5000/products';
      int result = 0;
      for (int i = 0; i < 100000000; i++) {
        result = result + i;
      }
      print(result);

      var response = await httpClient
          .get(
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

  Future<bool> signIn(String user, String password) async {
    try {
      const urlBase = 'http://10.0.0.5:5000/login';
      // int result = 0;
      // for (int i = 0; i < 100000000; i++) {
      //   result = result + i;
      // }
      // print(result);

      var response = await httpClient.post(Uri.parse(urlBase), body: {
        "NombreUsuario": user,
        "Contraseña": password
      }).timeout(const Duration(seconds: 10));

      if (response.statusCode >= 200 && response.statusCode < 300) {
        final data = json.decode(response.body);
        if (data != null) {
          Future.delayed(const Duration(seconds: 5));

          return data['message'];
        }
        Future.delayed(const Duration(seconds: 5));
        return false;
      } else {
        Future.delayed(const Duration(seconds: 5));
        return false;
      }
    } on TimeoutException {
      Future.delayed(const Duration(seconds: 5));
      return false;
    } catch (error, stack) {
      log("****** ProductRepository.signIn ******",
          error: error, stackTrace: stack);
      Future.delayed(const Duration(seconds: 5));
      return false;
    }
  }

  Future<void> create(String nombre, String descripcion, double precio,
      int cantidad, int reorden, int categoriaId, int proveedorId) async {
    try {
      const urlBase = 'http://10.0.0.5:5000/products';
      // int result = 0;
      // for (int i = 0; i < 100000000; i++) {
      //   result = result + i;
      // }
      // print(result);

      var response = await httpClient.post(Uri.parse(urlBase), body: {
        "Nombre": nombre,
        "Descripcion": descripcion,
        "Precio": precio,
        "CantidadStock": cantidad,
        "Reorden": reorden,
        "CategoriaID": categoriaId,
        "ProveedorID": proveedorId
      }).timeout(const Duration(seconds: 10));

      final data = json.decode(response.body);
      if (data != null) {
        log(data['message']);
      }
    } on TimeoutException {
      return;
    } catch (error, stack) {
      log("****** ProductRepository.create ******",
          error: error, stackTrace: stack);
      return;
    }
  }
}
