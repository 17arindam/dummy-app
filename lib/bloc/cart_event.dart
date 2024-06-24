part of 'cart_bloc.dart';

@immutable
abstract class CartEvent {}

class AddToCart extends CartEvent {
  final Recipe recipe;

  AddToCart(this.recipe);
}

class UpdateCartItem extends CartEvent {
  CartItem cartItem ;

  UpdateCartItem(this.cartItem);
}


