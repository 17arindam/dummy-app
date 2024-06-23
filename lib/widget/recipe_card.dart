import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dummy_meals_app/modal/recipe_modal.dart';
import 'package:dummy_meals_app/bloc/cart_bloc.dart';
import 'package:dummy_meals_app/modal/cart_item.dart';

class RecipeCard extends StatefulWidget {
  final Recipe recipe;

  const RecipeCard({Key? key, required this.recipe}) : super(key: key);

  @override
  _RecipeCardState createState() => _RecipeCardState();
}

class _RecipeCardState extends State<RecipeCard> {
  int quantity = 0;

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
                  widget.recipe.imgurl,
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
                  widget.recipe.name,
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
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: Icon(Icons.remove),
                onPressed: () {
                  if (quantity > 0) {
                    setState(() {
                      quantity--;
                    });
                    _updateQuantity(context);
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
                  setState(() {
                    quantity++;
                  });
                  _updateQuantity(context);
                },
              ),
            ],
          ),
          ElevatedButton(
            onPressed: () {
              if (quantity > 0) {
                _updateQuantity(context);
                ScaffoldMessenger.of(context).clearSnackBars();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('${widget.recipe.name} added to cart')),
                );
              } else {
                ScaffoldMessenger.of(context).clearSnackBars();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Please select at least one item')),
                );
              }
            },
            child: Text('Add to Cart'),
          ),
        ],
      ),
    );
  }

  void _updateQuantity(BuildContext context) {
    context.read<CartBloc>().add(UpdateCartItem(CartItem(recipe: widget.recipe,quantity: quantity)));
  }
}
