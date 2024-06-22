

part of 'meals_bloc.dart';

@immutable
abstract class MealsState {
  final List<Recipe> recipes;

  const MealsState({required this.recipes});
}

class MealsInitial extends MealsState {
  const MealsInitial({required List<Recipe> dummyRecipes}) : super(recipes: dummyRecipes);
}

class MealsUpdated extends MealsState {
  const MealsUpdated({required List<Recipe> updatedRecipes}) : super(recipes: updatedRecipes);
}
