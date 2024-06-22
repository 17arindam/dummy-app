import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dummy_meals_app/modal/recipe_modal.dart';
import 'package:flutter/foundation.dart';

part 'meals_event.dart';
part 'meals_state.dart';

class MealsBloc extends Bloc<MealsEvent, MealsState> {
  MealsBloc() : super(MealsInitial(dummyRecipes: [
    Recipe(name: 'Palak Paneer', imgurl: 'https://myfoodstory.com/wp-content/uploads/2017/01/Easy-Palak-Paneer-1.jpg'),
    Recipe(name: 'Burger', imgurl: 'https://simplehomeedit.com/wp-content/uploads/2024/03/Homemade-Beef-Burgers-4.webp')
  ])) {
    on<AddRecipe>((event, emit) {
      emit(MealsUpdated(updatedRecipes: [...state.recipes, event.recipe]));
    });
  }
}
