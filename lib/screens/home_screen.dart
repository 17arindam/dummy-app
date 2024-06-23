import 'package:dummy_meals_app/bloc/meals_bloc.dart';
import 'package:dummy_meals_app/modal/recipe_modal.dart';
import 'package:dummy_meals_app/widget/recipe_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dummy_meals_app/screens/cart_screen.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final TextEditingController nameController = TextEditingController();
  final TextEditingController imgUrlController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Recipe App', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => CartScreen()));
            },
            icon: Icon(Icons.shopping_cart),
          ),
        ],
        backgroundColor: Colors.orange,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.orangeAccent, Colors.yellowAccent],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: BlocBuilder<MealsBloc, MealsState>(
          builder: (context, state) {
            if (state is MealsInitial || state is MealsUpdated) {
              final recipes = state.recipes;
              return ListView.builder(
                itemCount: recipes.length,
                itemBuilder: (context, index) {
                  final recipe = recipes[index];
                  return RecipeCard(recipe: recipe);
                },
              );
            }
            return Center(child: CircularProgressIndicator());
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: () {
          _showAddRecipeModal(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }

  void _showAddRecipeModal(BuildContext context) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: nameController,
                    decoration: InputDecoration(labelText: 'Recipe Name'),
                  ),
                  TextField(
                    controller: imgUrlController,
                    decoration: InputDecoration(labelText: 'Image URL'),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      final name = nameController.text;
                      final imgUrl = imgUrlController.text;
                      if (name.isNotEmpty && imgUrl.isNotEmpty) {
                        final recipe = Recipe(name: name, imgurl: imgUrl);
                        context.read<MealsBloc>().add(AddRecipe(recipe));
                        nameController.clear();
                        imgUrlController.clear();
                        Navigator.of(context).pop();
                      }
                    },
                    child: Text('Add Recipe'),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
