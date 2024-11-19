import 'package:flutter/material.dart';
import 'package:pet_door_user/container/cart_container.dart';
import 'package:pet_door_user/provider/cart_provider.dart';
import 'package:pet_door_user/widgets/appbar.dart';
import 'package:pet_door_user/widgets/colors.dart';
import 'package:provider/provider.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgr,
      appBar: CustomAppBar(title: 'Your Cart'),
      body: Consumer<CartProvider>(
        builder: (context, value, child) {
          if (value.isLoading) {
            return const Center(child: CircularProgressIndicator());
          } else {
            if (value.carts.isEmpty) {
              return Center(child: Text("No items in cart"));
            } else {
              if (value.products.isNotEmpty) {
                return ListView.builder(
                    itemCount: value.carts.length,
                    itemBuilder: (context, index) {
                      print("selected ${value.carts[index].quantity}");
                      return CartContainer(
                          breed: value.products[index].breed,
                          image: value.products[index].image,
                          name: value.products[index].name,
                          new_price: value.products[index].amount,
                          old_price: value.products[index].age,
                          maxQuantity: value.products[index].amount,
                          selectedQuantity: value.carts[index].quantity,
                          productId: value.products[index].id);
                    });
              } else {
                return Text("No items in cart");
              }
            }
          }
        },
      ),
      bottomNavigationBar: Consumer<CartProvider>(
        builder: (context, value, child) {
          if (value.carts.length == 0) {
            return SizedBox();
          } else {
            return Container(
              width: double.infinity,
              height: 60,
              padding: EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Total : ₹${value.totalCost} ",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, "/checkout");
                    },
                    child: Text("Proceed to Checkout"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                    ),
                  )
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
