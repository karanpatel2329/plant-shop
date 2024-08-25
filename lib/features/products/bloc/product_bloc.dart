import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:thence/features/products/models/product_model.dart';

import '../repositories/product_repository.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepository productRepository;

  ProductBloc(this.productRepository) : super(ProductLoading()) {
    on<FetchProducts>((event, emit) async {
      try {
        emit(ProductLoading());
        final products = await productRepository.fetchProducts();
        emit(ProductLoaded(products: products, selectedCategoryId: 0));
      } catch (e) {
        emit(ProductError(errorMessage: "Failed to fetch products"));
      }
    });
    on<SelectCategory>((event, emit) {
      final currentState = state;
      if (currentState is ProductLoaded) {
        emit(ProductLoaded(products: currentState.products, selectedCategoryId: event.categoryId));
      }
    });
  }
}