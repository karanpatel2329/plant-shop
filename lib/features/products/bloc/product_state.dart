part of 'product_bloc.dart';

@immutable
sealed class ProductState {}

final class ProductInitial extends ProductState {}

final class ProductLoading extends ProductState {}

final class ProductError extends ProductState {
  String errorMessage;
  ProductError({required this.errorMessage});
}

final class ProductLoaded extends ProductState{
  List<Product> products;
  final int selectedCategoryId;
  ProductLoaded({required this.products, required this.selectedCategoryId});
}
