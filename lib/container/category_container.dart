import 'package:flutter/material.dart';
import 'package:pet_door_user/controllers/db_service.dart';
import 'package:pet_door_user/models/category_model.dart';
import 'package:shimmer/shimmer.dart';

class CategoryContainer extends StatefulWidget {
  const CategoryContainer({super.key});

  @override
  State<CategoryContainer> createState() => _CategoryContainerState();
}

class _CategoryContainerState extends State<CategoryContainer> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: DbService().readCategories(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<CategoryModel> categories =
                CategoryModel.fromJsonList(snapshot.data!.docs)
                    as List<CategoryModel>;
            if (categories.isEmpty) {
              return SizedBox();
            } else {
              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: categories
                      .map((cat) =>
                          CategoryButton(imagepath: cat.image, name: cat.name))
                      .toList(),
                ),
              );
            }
          } else {
            return Shimmer(
                child: Container(
                  height: 90,
                  width: double.infinity,
                ),
                gradient: LinearGradient(
                    colors: [Colors.grey.shade200, Colors.white]));
          }
        });
  }
}

class CategoryButton extends StatefulWidget {
  final String imagepath, name;
  const CategoryButton(
      {super.key, required this.imagepath, required this.name});

  @override
  State<CategoryButton> createState() => _CategoryButtonState();
}

class _CategoryButtonState extends State<CategoryButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, "/specific_products",
          arguments: {"name": widget.name}),
      child: Container(
        margin: EdgeInsets.all(4),
        padding: EdgeInsets.all(4),
        height: 100,
        width: 95,
        decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(20)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.network(
                widget.imagepath,
                height: 60, // Fixed height
                width: 60, // Fixed width
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) {
                    return child;
                  } else {
                    return Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                                (loadingProgress.expectedTotalBytes ?? 1)
                            : null,
                      ),
                    );
                  }
                },
                errorBuilder: (context, error, stackTrace) {
                  return Icon(
                      Icons.error); // Display error icon if image fails to load
                },
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
                "${widget.name.substring(0, 1).toUpperCase()}${widget.name.substring(1)} ")
          ],
        ),
      ),
    );
  }
}
