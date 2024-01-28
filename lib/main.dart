import 'dart:isolate';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paralelos2/product_controller.dart';
import 'package:paralelos2/product_entity.dart';
import 'package:paralelos2/product_repository.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const ProductView(),
    );
  }
}

class ProductView extends ConsumerStatefulWidget {
  const ProductView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProductViewState();
}

class _ProductViewState extends ConsumerState<ProductView> {
  ProductRepository repo = ProductRepository(http.Client());

  List<Product> productIsolate = [];
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref.read(productControllerProvider.notifier).fetchAll();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final productState = ref.watch(productControllerProvider);
    return Scaffold(
      appBar: AppBar(title: const Text("Productos"), actions: []),
      body: Column(
        children: [
          Image.asset(
            "images/shot-gif.gif",
            height: 125.0,
            width: 125.0,
          ),
          ElevatedButton(
              onPressed: () async {
                ref.read(productControllerProvider.notifier).fetchAll();
              },
              child: const Text("No isolate")),
          Expanded(
            child: productState.isLoading
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemCount: productState.products.length,
                    itemBuilder: (BuildContext context, int index) {
                      final product = productState.products[index];
                      return Card(
                        child: Column(children: [
                          Text(product.productoNombre!),
                          Text(product.precio!)
                        ]),
                      );
                    },
                  ),
          ),
          ElevatedButton(
              onPressed: () async {
                ReceivePort resultPort = ReceivePort();
                await Isolate.spawn(
                  repo.fetchAllIsolate,
                  resultPort.sendPort,
                );

                resultPort.listen((result) {
                  if (result != null) {
                    productIsolate = result;
                  }
                });
              },
              child: const Text("Isolate")),
          Expanded(
            child: Builder(
              builder: (context) {
                return ListView.builder(
                  itemCount: productIsolate.length,
                  itemBuilder: (BuildContext context, int index) {
                    final product = productIsolate[index];
                    return Card(
                      child: Column(children: [
                        Text(product.productoNombre!),
                        Text(product.precio!)
                      ]),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
