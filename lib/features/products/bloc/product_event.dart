part of 'product_bloc.dart';

@immutable
sealed class ProductEvent {}


final class FetchProducts extends ProductEvent {}
class SelectCategory extends ProductEvent {
  final int categoryId;
  SelectCategory({required this.categoryId});
}