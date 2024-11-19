import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart'; // Import the Lottie package
import 'package:pet_door_user/models/cart_model.dart';
import 'package:pet_door_user/models/productsmodel.dart';
import 'package:pet_door_user/provider/cart_provider.dart';
import 'package:pet_door_user/widgets/appbar.dart';
import 'package:pet_door_user/widgets/colors.dart';
import 'package:provider/provider.dart';

class ViewProduct extends StatefulWidget {
  const ViewProduct({super.key});

  @override
  State<ViewProduct> createState() => _ViewProductState();
}

class _ViewProductState extends State<ViewProduct> {
  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)!.settings.arguments as AnimalModel;

    return Scaffold(
      backgroundColor: bgr,
      appBar: const CustomAppBar(title: "Animal Details"),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                elevation: 8,
                shadowColor: Colors.black26,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(20),
                      ),
                      child: Image.network(
                        arguments.image,
                        height: 300,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(10.0),
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Colors.deepPurpleAccent, Colors.blueAccent],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: const BorderRadius.vertical(
                          bottom: Radius.circular(20),
                        ),
                      ),
                      child: Row(
                        children: [
                          Text(
                            arguments.name,
                            style: const TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const Spacer(),
                          Text(
                            "Breed: ${arguments.breed}",
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 5),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Details",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.teal.shade800,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildIconLabel(
                              Icons.monetization_on, "₹ ${arguments.amount}"),
                          _buildIconLabel(
                              Icons.cake, "Age: ${arguments.age} years"),
                          _buildIconLabel(
                            arguments.gender == 'Male'
                                ? Icons.male
                                : Icons.female,
                            arguments.gender,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),

              // Description
              SizedBox(
                height: 140,
                width: 400,
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Description",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.teal.shade800,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          arguments.description,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Colors.grey.shade700,
                            height: 1.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              Row(
                children: [
                  SizedBox(
                    width: 200,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        print(
                            "Attempting to add product to cart: ${arguments.id}");

                        // Check if the product is already in the cart
                        if (Provider.of<CartProvider>(context, listen: false)
                            .cartUids
                            .contains(arguments.id)) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Item already in cart")),
                          );
                        } else {
                          // Add the item to the cart
                          Provider.of<CartProvider>(context, listen: false)
                              .addToCart(CartModel(
                            productId: arguments.id,
                            quantity: 1,
                          ));
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Added to cart")),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        elevation: 8,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        backgroundColor: Colors.teal.shade800,
                        shadowColor: Colors.teal.shade400,
                      ),
                      child: const Text(
                        'Adopt Now',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const Spacer(),

                  GestureDetector(
                    onTap: () => Navigator.pushNamed(context, "/cart"),
                    child: Lottie.network(
                        'https://lottie.host/23dd02eb-d8f1-4a50-88dd-6a98d0e44a20/FcxyfCGrY3.json',
                        height: 100,
                        width: 100),
                  ), // Add your Lottie animation file
                ],
              ),
              const SizedBox(height: 10), // Extra space at the bottom
            ],
          ),
        ),
      ),
    );
  }

  // Helper method to build icons with labels for details
  Widget _buildIconLabel(IconData icon, String label) {
    return Row(
      children: [
        Icon(icon, color: Colors.teal.shade800),
        const SizedBox(width: 6),
        Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }
}
