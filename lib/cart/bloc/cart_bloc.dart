import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/models/cart_item.dart';
import '../../home/data/models/product_model.dart';

// Events
abstract class CartEvent {}

class AddToCart extends CartEvent {
  final Product product;
  final int quantity;

  AddToCart({
    required this.product,
    this.quantity = 1,
  });
}

class RemoveFromCart extends CartEvent {
  final CartItem item;
  RemoveFromCart(this.item);
}

class UpdateQuantity extends CartEvent {
  final CartItem item;
  final int quantity;

  UpdateQuantity(this.item, this.quantity);
}

// States
class CartState {
  final List<CartItem> items;
  final double totalAmount;
  final int itemCount;

  CartState(this.items)
      : totalAmount = items.fold(0, (sum, item) => sum + (item.product.price * item.quantity)),
        itemCount = items.fold(0, (sum, item) => sum + item.quantity);

  bool get isEmpty => items.isEmpty;
}

// Bloc
class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartState([])) {
    on<AddToCart>((event, emit) {
      final currentItems = List<CartItem>.from(state.items);
      // Check if product already exists in cart
      final existingItemIndex = currentItems.indexWhere(
        (item) => item.product.id == event.product.id,
      );

      if (existingItemIndex != -1) {
        // Update quantity if product exists
        currentItems[existingItemIndex] = CartItem(
          product: event.product,
          quantity: currentItems[existingItemIndex].quantity + event.quantity,
        );
      } else {
        // Add new item if product doesn't exist
        currentItems.add(CartItem(
          product: event.product,
          quantity: event.quantity,
        ));
      }
      emit(CartState(currentItems));
    });

    on<RemoveFromCart>((event, emit) {
      final currentItems = List<CartItem>.from(state.items);
      currentItems.remove(event.item);
      emit(CartState(currentItems));
    });

    on<UpdateQuantity>((event, emit) {
      final currentItems = List<CartItem>.from(state.items);
      final index = currentItems.indexOf(event.item);
      if (index != -1) {
        if (event.quantity <= 0) {
          currentItems.removeAt(index);
        } else {
          currentItems[index] = CartItem(
            product: event.item.product,
            quantity: event.quantity,
          );
        }
      }
      emit(CartState(currentItems));
    });
  }
} 