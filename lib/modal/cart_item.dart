import 'package:dummy_meals_app/modal/recipe_modal.dart';

class CartItem {
  final Recipe recipe;
  int quantity;

  CartItem({required this.recipe, this.quantity = 0});
}
