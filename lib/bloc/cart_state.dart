part of 'cart_bloc.dart';

@immutable
abstract class CartState {
  final List<CartItem> cartItems;

  const CartState({required this.cartItems});
}

class CartInitial extends CartState {
  const CartInitial() : super(cartItems: const []);
}

class CartUpdated extends CartState {
  const CartUpdated({required List<CartItem> cartItems}) : super(cartItems: cartItems);
}
