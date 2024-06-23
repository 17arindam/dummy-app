import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:dummy_meals_app/modal/cart_item.dart';
import 'package:dummy_meals_app/modal/recipe_modal.dart';
import 'package:meta/meta.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartInitial()) {
    on<UpdateCartItem>(
      (event, emit) {
        emit(
        CartUpdated(cartItems: [...state.cartItems, event.cartItem]),
      );
      print(state.cartItems);
      } 
    );
  }
}
