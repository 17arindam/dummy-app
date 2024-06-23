import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dummy_meals_app/bloc/cart_bloc.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart',style: TextStyle(fontWeight: FontWeight.bold),),
        backgroundColor: Colors.orange,
      ),
      body: Container(
        decoration:const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.orangeAccent, Colors.yellowAccent],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: BlocBuilder<CartBloc, CartState>(
                builder: (context, state) {
                  if (state.cartItems.isEmpty) {
                    return Center(
                      child: Text('Your cart is empty'),
                    );
                  }
                  return ListView.builder(
                    itemCount: state.cartItems.length,
                    itemBuilder: (context, index) {
                      final cartItem = state.cartItems[index];
                      return ListTile(
                        title: Text(cartItem.recipe.name),
                        trailing: Text(cartItem.quantity.toString()),
                      );
                    },
                  );
                },
              ),
            ),
            ElevatedButton(
              onPressed: () {
                
                Navigator.pop(context);
              },
              child: Text('Proceed to Checkout',style: TextStyle(fontWeight: FontWeight.bold),),
            ),
            SizedBox(height: 20), 
          ],
        ),
      ),
    );
  }
}
