import 'package:flutter/material.dart';
import 'package:pet_door_user/models/cart_model.dart';
import 'package:pet_door_user/provider/cart_provider.dart';
import 'package:provider/provider.dart';

class CartContainer extends StatefulWidget {
  final String image, name, productId, breed;
  final int new_price, old_price, maxQuantity, selectedQuantity;

  const CartContainer({
    super.key,
    required this.image,
    required this.breed,
    required this.name,
    required this.productId,
    required this.new_price,
    required this.old_price,
    required this.maxQuantity,
    required this.selectedQuantity,
  });

  @override
  State<CartContainer> createState() => _CartContainerState();
}

class _CartContainerState extends State<CartContainer> {
  int count = 1;

  increaseCount(int max) {
    if (count < max) {
      setState(() => count++);
      Provider.of<CartProvider>(context, listen: false)
          .addToCart(CartModel(productId: widget.productId, quantity: count));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Maximum Quantity reached")),
      );
    }
  }

  decreaseCount() {
    if (count > 1) {
      setState(() => count--);
      Provider.of<CartProvider>(context, listen: false)
          .decreaseCount(widget.productId);
    }
  }

  @override
  void initState() {
    count = widget.selectedQuantity;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 2,
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    widget.image,
                    height: 60,
                    width: 60,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey.shade800,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        widget.breed,
                        style: TextStyle(
                            fontSize: 14, color: Colors.grey.shade600),
                      ),
                    ],
                  ),
                ),
                CircleAvatar(
                  child: IconButton(
                    onPressed: () {
                      Provider.of<CartProvider>(context, listen: false)
                          .deleteItem(widget.productId);
                    },
                    icon: Icon(Icons.delete, color: Colors.red.shade400),
                  ),
                ),
              ],
            ),
            Divider(color: Colors.grey.shade300),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  child: Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.remove, color: Colors.black, size: 18),
                        onPressed: decreaseCount,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 12),
                        child: Text(
                          "$count",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.add, color: Colors.black, size: 18),
                        onPressed: () => increaseCount(widget.maxQuantity),
                      ),
                    ],
                  ),
                ),
                Text(
                  "₹${widget.new_price * count}",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.green.shade700,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
