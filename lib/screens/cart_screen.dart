import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dummy_meals_app/bloc/cart_bloc.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Cart',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
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
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(cartItem.recipe.imgurl),
                        ),
                        title: Text(
                          cartItem.recipe.name,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: Icon(Icons.remove),
                              onPressed: () {
                                if (cartItem.quantity > 0)
                                  // Decrement quantity logic
                                  context.read<CartBloc>().add(
                                        UpdateCartItem(
                                          cartItem.copyWith(
                                            quantity: cartItem.quantity - 1,
                                          ),
                                        ),
                                      );
                              },
                            ),
                            Text(cartItem.quantity.toString(),style: TextStyle(fontSize: 15),),
                            IconButton(
                              icon: Icon(Icons.add),
                              onPressed: () {
                                // Increment quantity logic
                                context.read<CartBloc>().add(
                                      UpdateCartItem(
                                        cartItem.copyWith(
                                          quantity: cartItem.quantity + 1,
                                        ),
                                      ),
                                    );
                              },
                            ),
                          ],
                        ),
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
              child: Text(
                'Proceed to Checkout',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
