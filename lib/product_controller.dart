import 'dart:isolate';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paralelos2/product_entity.dart';
import 'package:paralelos2/product_repository.dart';

final productControllerProvider =
    StateNotifierProvider.autoDispose<ProductController, ProductState>(
        (ref) => ProductController(ref.read(productRepositoryProvider), ref));

class ProductState {
  final List<Product> products;
  final bool isLoading;
  final String? errorMessage;
  const ProductState({
    this.products = const [],
    this.isLoading = false,
    this.errorMessage,
  });
  ProductState get empty => const ProductState();

  ProductState copyWith({
    List<Product>? products,
    bool? isLoading,
    String? errorMessage,
  }) {
    return ProductState(
      products: products ?? this.products,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

class ProductController extends StateNotifier<ProductState> {
  final ProductRepository _repository;
  final Ref ref;
  ProductController(
    this._repository,
    this.ref,
  ) : super(const ProductState());
  Future<void> fetchAll() async {
    state = state.empty.copyWith(isLoading: true);
    final result = await _repository.fetchAll();
    if (result == null) {
      state = state.empty.copyWith(errorMessage: null, isLoading: false);
      return;
    }

    final products = result;
    state = state.empty.copyWith(products: products, isLoading: false);
  }

  Future<void> fetchAllIsolate() async {
    state = state.empty.copyWith(isLoading: true);
    final resultPort = ReceivePort();
    await Isolate.spawn(
      _repository.fetchAllIsolate,
      resultPort.sendPort,
    );
    resultPort.listen((result) {
      if (result == null) {
        state = state.empty.copyWith(errorMessage: null, isLoading: false);
        return;
      }

      final products = result;
      state = state.empty.copyWith(products: products, isLoading: false);
    });
  }
}
