import 'package:flutter/material.dart';
import 'package:pet_door_user/container/category_container.dart';
import 'package:pet_door_user/controllers/db_service.dart';
import 'package:pet_door_user/models/productsmodel.dart';
import 'package:pet_door_user/widgets/colors.dart';
import 'package:pet_door_user/widgets/petcardhome.dart';
import 'package:pet_door_user/widgets/search_filter.dart';
import 'package:pet_door_user/widgets/userprofile.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _searchQuery = "";
  String _selectedCategory = "";

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: bgr,
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              UserProfileSection(
                onFilterTap: _showFilterDialog,
              ),
              const SizedBox(height: 30),
              const Text(
                'Categories',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2D4059),
                ),
              ),
              const SizedBox(height: 20),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [Expanded(child: CategoryContainer())],
              ),
              const SizedBox(height: 20),

              // Use CustomSearchField
              CustomSearchField(
                hintText: 'Search Pets',
                onChanged: (value) {
                  setState(() {
                    _searchQuery = value.toLowerCase();
                  });
                },
              ),
              const SizedBox(height: 10),
              const Text(
                'Available Pets',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2D4059),
                ),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: StreamBuilder(
                  stream: DbService().readProducts(_selectedCategory),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List<AnimalModel> products =
                          AnimalModel.fromJsonList(snapshot.data!.docs);

                      // Filter
                      if (_searchQuery.isNotEmpty) {
                        products = products
                            .where((product) => product.name
                                .toLowerCase()
                                .contains(_searchQuery))
                            .toList();
                      }

                      if (products.isEmpty) {
                        return const Center(child: Text("No products found"));
                      } else {
                        return ListView.builder(
                          itemCount: products.length,
                          itemBuilder: (context, index) {
                            final product = products[index];
                            return PetCardWidget(
                              product: product,
                              onFavoriteToggle: () async {
                                setState(() {
                                  product.isFavorite = !product.isFavorite;
                                });

                                if (product.isFavorite) {
                                  await DbService().addProductToFavorites(
                                      product.id, product);
                                } else {
                                  await DbService()
                                      .removeProductFromFavorites(product.id);
                                }
                              },
                            );
                          },
                        );
                      }
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  //filter
  void _showFilterDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return CustomFilterDialog(
          selectedCategory: _selectedCategory,
          onCategoryChanged: (value) {
            setState(() {
              _selectedCategory = value ?? "";
            });
          },
          onReset: () {
            setState(() {
              _selectedCategory = "";
            });
            Navigator.pop(context);
          },
          onApply: () {
            Navigator.pop(context);
          },
        );
      },
    );
  }
}
