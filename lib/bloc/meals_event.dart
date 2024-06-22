

part of 'meals_bloc.dart';

@immutable
abstract class MealsEvent {}

class AddRecipe extends MealsEvent {
  final Recipe recipe;

  AddRecipe(this.recipe);
}
