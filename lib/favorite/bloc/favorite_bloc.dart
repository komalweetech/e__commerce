import 'package:flutter_bloc/flutter_bloc.dart';
import '../../home/data/models/product_model.dart';

// Events
abstract class FavoriteEvent {}

class AddToFavorite extends FavoriteEvent {
  final Product product;
  AddToFavorite(this.product);
}

class RemoveFromFavorite extends FavoriteEvent {
  final Product product;
  RemoveFromFavorite(this.product);
}

// States
class FavoriteState {
  final List<Product> favorites;
  FavoriteState(this.favorites);
}

// Bloc
class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  FavoriteBloc() : super(FavoriteState([])) {
    on<AddToFavorite>((event, emit) {
      final currentFavorites = List<Product>.from(state.favorites);
      if (!currentFavorites.contains(event.product)) {
        currentFavorites.add(event.product);
        emit(FavoriteState(currentFavorites));
      }
    });

    on<RemoveFromFavorite>((event, emit) {
      final currentFavorites = List<Product>.from(state.favorites);
      currentFavorites.remove(event.product);
      emit(FavoriteState(currentFavorites));
    });
  }
} 