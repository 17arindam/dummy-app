import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dummy_meals_app/modal/cart_item.dart';
import 'package:dummy_meals_app/modal/recipe_modal.dart';
import 'package:flutter/foundation.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartInitial()) {
    on<UpdateCartItem>(
      (event, emit) {
        List<CartItem> updatedCartItems = List.from(state.cartItems);

        bool itemExists = false;
        for (int i = 0; i < updatedCartItems.length; i++) {
          if (updatedCartItems[i].recipe.name == event.cartItem.recipe.name) {
            if (event.cartItem.quantity == 0) {
              updatedCartItems.removeAt(i);
            } else {
              updatedCartItems[i] = updatedCartItems[i].copyWith(
                quantity: event.cartItem.quantity,
              );
            }
            itemExists = true;
            break;
          }
        }

        if (!itemExists && event.cartItem.quantity > 0) {
          updatedCartItems.add(event.cartItem);
        }

        emit(CartUpdated(cartItems: updatedCartItems));
        print(state.cartItems);
      }
    );
  }
}
