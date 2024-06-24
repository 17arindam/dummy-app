import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dummy_meals_app/modal/recipe_modal.dart';
import 'package:dummy_meals_app/bloc/cart_bloc.dart';
import 'package:dummy_meals_app/modal/cart_item.dart';

class RecipeCard extends StatelessWidget {
  final Recipe recipe;

  const RecipeCard({Key? key, required this.recipe}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Stack(
            alignment: Alignment.bottomCenter,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  recipe.imgurl,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  height: 200,
                ),
              ),
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                color: Colors.black54,
                child: Text(
                  recipe.name,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          BlocBuilder<CartBloc, CartState>(
            builder: (context, state) {
              int quantity = state.cartItems
                  .firstWhere(
                    (item) => item.recipe.name == recipe.name,
                    orElse: () => CartItem(recipe: recipe, quantity: 0),
                  )
                  .quantity;

              return quantity > 0
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          icon: Icon(Icons.remove),
                          onPressed: () {
                            if (quantity > 0) {
                              context.read<CartBloc>().add(
                                    UpdateCartItem(
                                      CartItem(
                                        recipe: recipe,
                                        quantity: quantity - 1,
                                      ),
                                    ),
                                  );
                            }
                          },
                        ),
                        Text(
                          quantity.toString(),
                          style: TextStyle(fontSize: 18),
                        ),
                        IconButton(
                          icon: Icon(Icons.add),
                          onPressed: () {
                            context.read<CartBloc>().add(
                                  UpdateCartItem(
                                    CartItem(
                                      recipe: recipe,
                                      quantity: quantity + 1,
                                    ),
                                  ),
                                );
                          },
                        ),
                      ],
                    )
                  : ElevatedButton(
                      onPressed: () {
                        context.read<CartBloc>().add(
                              UpdateCartItem(
                                CartItem(recipe: recipe, quantity: 1),
                              ),
                            );
                        ScaffoldMessenger.of(context).clearSnackBars();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('${recipe.name} added to cart'),
                          ),
                        );
                      },
                      child: Text('Add to Cart'),
                    );
            },
          ),
        ],
      ),
    );
  }
}
