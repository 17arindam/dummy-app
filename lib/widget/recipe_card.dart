import 'package:flutter/material.dart';
import 'package:dummy_meals_app/modal/recipe_modal.dart';

class RecipeCard extends StatelessWidget {
  final Recipe recipe;

  const RecipeCard({super.key, required this.recipe}) ;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Stack(
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
    );
  }
}
