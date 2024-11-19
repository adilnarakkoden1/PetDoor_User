import 'package:flutter/material.dart';
import 'package:pet_door_user/controllers/db_service.dart';
import 'package:pet_door_user/models/productsmodel.dart';
import 'package:pet_door_user/views/view_animals.dart';
import 'package:pet_door_user/widgets/appbar.dart';
import 'package:pet_door_user/widgets/colors.dart';

class Favourites extends StatelessWidget {
  const Favourites({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgr,
      appBar: const CustomAppBar(
        title: ('Your Favorites'),
      ),
      body: StreamBuilder(
        stream: DbService().readUserFavorites(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<AnimalModel> favorites =
                AnimalModel.fromJsonList(snapshot.data!.docs);
            if (favorites.isEmpty) {
              return const Center(child: Text('No favorites added yet!!'));
            } else {
              return ListView.builder(
                padding: const EdgeInsets.all(16.0),
                itemCount: favorites.length,
                itemBuilder: (context, index) {
                  final product = favorites[index];
                  return _buildFavoriteCard(product, context);
                },
              );
            }
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  Widget _buildFavoriteCard(AnimalModel product, BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const ViewProduct(),
            settings: RouteSettings(
              arguments: product,
            ),
          ),
        );
      },
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12.0),
                child: Image.network(
                  product.image,
                  height: 80,
                  width: 100,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 16.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.name,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2D4059),
                      ),
                    ),
                    const SizedBox(height: 4.0),
                    Text(
                      'Breed: ${product.breed}',
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 4.0),
                    Text(
                      'Price: ₹${product.amount}',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: () async {
                  // Remove fav
                  await DbService().removeProductFromFavorites(product.id);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('${product.name} removed from favorites'),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
