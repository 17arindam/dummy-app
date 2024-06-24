import 'package:dummy_meals_app/modal/recipe_modal.dart';

class CartItem {
  final Recipe recipe;
  final int quantity;

  CartItem({
    required this.recipe,
    required this.quantity,
  });

  CartItem copyWith({
    Recipe? recipe,
    int? quantity,
  }) {
    return CartItem(
      recipe: recipe ?? this.recipe,
      quantity: quantity ?? this.quantity,
    );
  }
}
