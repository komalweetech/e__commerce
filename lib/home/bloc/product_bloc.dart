import 'package:e_commerce/home/bloc/product_event.dart';
import 'package:e_commerce/home/bloc/product_stete.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/repositories/product_repository.dart';



// Bloc
class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepository repository;

  ProductBloc(this.repository) : super(ProductInitial()) {
    on<FetchProducts>((event, emit) async {
      emit(ProductLoading());
      try {
        final products = await repository.getProducts();
        emit(ProductLoaded(products));
      } catch (e) {
        emit(ProductError(e.toString()));
      }
    });
  }
} 