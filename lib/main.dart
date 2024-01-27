import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paralelos2/product_controller.dart';

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
      appBar: AppBar(title: const Text("Productos")),
      body: productState.isLoading
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
    );
  }
}
