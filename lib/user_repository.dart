import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:isolate';
import 'package:http/http.dart' as http;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paralelos2/providers/client_provider.dart';
import 'package:paralelos2/user_entity.dart';

final userRepositoryProvider = Provider<UserRepository>(
    (ref) => UserRepository(ref.read(httpClientProvider)));

class UserRepository {
  final http.Client httpClient;

  UserRepository(this.httpClient);

  Future<List<User>?> fetchAll() async {
    try {
      const urlBase = 'http://172.20.10.6:5000/users';
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
          final users = <User>[];

          for (final node in data) {
            users.add(
              User.fromJson(Map.from(node)),
            );
          }
          Future.delayed(const Duration(seconds: 5));
          return users;
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
      log("****** UserRepository.fetchAll ******",
          error: error, stackTrace: stack);
      Future.delayed(const Duration(seconds: 5));
      return null;
    }
  }

  Future<void> fetchAllIsolate(SendPort sendPort) async {
    try {
      const urlBase = 'http://172.20.10.6:5000/users';
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
          final users = <User>[];

          for (final node in data) {
            users.add(
              User.fromJson(Map.from(node)),
            );
          }

          sendPort.send(users);
        }
        sendPort.send(null);
      } else {
        sendPort.send(null);
      }
    } on TimeoutException {
      sendPort.send(null);
    } catch (error, stack) {
      log("****** UserRepository.fetchAll ******",
          error: error, stackTrace: stack);
      sendPort.send(null);
    }
  }

  Future<void> create(
      String nombre, String user, String password, String rol) async {
    try {

      const urlBase = 'http://172.20.10.6:5000/users';
      // int result = 0;
      // for (int i = 0; i < 100000000; i++) {
      //   result = result + i;
      // }
      // print(result);

      var response = await httpClient.post(
        Uri.parse(urlBase),
        body: {
          "NombreUsuario": user,
          "Contraseña": password,
          "NombreCompleto": nombre,
          "Rol": rol
        },
      ).timeout(const Duration(seconds: 10));


      final data = json.decode(response.body);
      if (data != null) {
        log(data['message']);
      }
    } on TimeoutException {
      return;
    } catch (error, stack) {
      log("****** UserRepository.create ******",
          error: error, stackTrace: stack);
      return;
    }
  }
}
