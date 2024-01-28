import 'dart:isolate';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paralelos2/providers/product_provider.dart';

import '../product_entity.dart';
import '../product_repository.dart';

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
      ref.read(productNotifierProvider.notifier).fetchAll();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final productState = ref.watch(productNotifierProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Productos"),
      ),
      body: Column(
        children: [
          Image.asset(
            "images/shot-gif.gif",
            height: 125.0,
            width: 125.0,
          ),
          ElevatedButton(
              onPressed: () async {
                ref.read(productNotifierProvider.notifier).fetchAll();
              },
              child: const Text("Hilo principal")),
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
                    setState(() {
                      productIsolate = result;
                    });
                  }
                });
              },
              child: const Text("En hilo secundario")),
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
