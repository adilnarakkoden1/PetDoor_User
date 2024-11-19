import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pet_door_user/models/cart_model.dart';
import 'package:pet_door_user/models/productsmodel.dart';

class DbService {
  User? user = FirebaseAuth.instance.currentUser;

  // Save user data after creating a new account
  Future saveUserData({required String name, required String email}) async {
    try {
      Map<String, dynamic> data = {
        "name": name,
        "email": email,
      };
      await FirebaseFirestore.instance
          .collection("shop_users")
          .doc(user!.uid)
          .set(data);
    } catch (e) {
      print("Error saving user data: $e");
    }
  }

  // Update user data
  Future updateUserData({required Map<String, dynamic> extraData}) async {
    await FirebaseFirestore.instance
        .collection("shop_users")
        .doc(user!.uid)
        .update(extraData);
  }

  // Read user data
  Stream<DocumentSnapshot> readUserData() {
    return FirebaseFirestore.instance
        .collection("shop_users")
        .doc(user!.uid)
        .snapshots();
  }

  // Read categories
  Stream<QuerySnapshot> readCategories() {
    return FirebaseFirestore.instance
        .collection("animal_categories")
        .snapshots();
  }

  // PRODUCTS
  // Read products by specific categories
  Stream<QuerySnapshot> readProducts(String category) {
    return category.isEmpty
        ? FirebaseFirestore.instance.collection("animal_list").snapshots()
        : FirebaseFirestore.instance
            .collection("animal_list")
            .where("category", isEqualTo: category.toLowerCase())
            .snapshots();
  }

  // Add product to favorites
  Future<void> addProductToFavorites(
      String productId, AnimalModel product) async {
    try {
      await FirebaseFirestore.instance
          .collection("shop_users")
          .doc(user!.uid)
          .collection("favorites")
          .doc(productId)
          .set(product.toJson());
    } catch (e) {
      print("Error adding product to favorites: $e");
    }
  }

  // Remove product from favorites
  Future<void> removeProductFromFavorites(String productId) async {
    try {
      await FirebaseFirestore.instance
          .collection("shop_users")
          .doc(user!.uid)
          .collection("favorites")
          .doc(productId)
          .delete();
    } catch (e) {
      print("Error removing product from favorites: $e");
    }
  }

  // Read user favorites
  Stream<QuerySnapshot> readUserFavorites() {
    return FirebaseFirestore.instance
        .collection("shop_users")
        .doc(user!.uid)
        .collection("favorites")
        .snapshots();
  }

  // CART
  // Read user cart
  Stream<QuerySnapshot> readUserCart() {
    return FirebaseFirestore.instance
        .collection("shop_users")
        .doc(user!.uid)
        .collection("cart")
        .snapshots();
  }

  // Add to cart
  Future addToCart({required CartModel cartData}) async {
    try {
      await FirebaseFirestore.instance
          .collection("shop_users")
          .doc(user!.uid)
          .collection("cart")
          .doc(cartData.productId)
          .update({
        "product_id": cartData.productId,
        "quantity": FieldValue.increment(1),
      });
    } on FirebaseException catch (e) {
      if (e.code == "not-found") {
        await FirebaseFirestore.instance
            .collection("shop_users")
            .doc(user!.uid)
            .collection("cart")
            .doc(cartData.productId)
            .set({
          "product_id": cartData.productId,
          "quantity": 1,
        });
      }
    }
  }

  // Delete item from cart
  Future deleteItemFromCart({required String productId}) async {
    await FirebaseFirestore.instance
        .collection("shop_users")
        .doc(user!.uid)
        .collection("cart")
        .doc(productId)
        .delete();
  }

  // Empty the cart
  Future emptyCart() async {
    await FirebaseFirestore.instance
        .collection("shop_users")
        .doc(user!.uid)
        .collection("cart")
        .get()
        .then((value) {
      for (DocumentSnapshot ds in value.docs) {
        ds.reference.delete();
      }
    });
  }

  // Decrease item count in the cart
  Future decreaseCount({required String productId}) async {
    await FirebaseFirestore.instance
        .collection("shop_users")
        .doc(user!.uid)
        .collection("cart")
        .doc(productId)
        .update({
      "quantity": FieldValue.increment(-1),
    });
  }

  // Fetch products in the cart by document IDs
  Stream<QuerySnapshot> searchProducts(List<String> docIds) {
    if (docIds.isEmpty) {
      // Return an empty stream if no document IDs are provided
      print("No product IDs to fetch.");
      return Stream.fromIterable([]); // Returning an empty stream
    }

    // Firestore has a 10-item limit for `whereIn` queries
    return FirebaseFirestore.instance
        .collection("animal_list")
        .where(FieldPath.documentId, whereIn: docIds.take(10).toList())
        .snapshots();
  }


  // ORDERS
  // create a new order
  Future createOrder({required Map<String, dynamic> data}) async {
    await FirebaseFirestore.instance.collection("shop_orders").add(data);
  }

  // update the status of order
  Future updateOrderStatus(
      {required String docId, required Map<String, dynamic> data}) async {
    await FirebaseFirestore.instance
        .collection("shop_orders")
        .doc(docId)
        .update(data);
  }

  // read the order data of specific user
  Stream<QuerySnapshot> readOrders() {
    return FirebaseFirestore.instance
        .collection("shop_orders")
        .where("user_id", isEqualTo: user!.uid)
        .orderBy("created_at", descending: true)
        .snapshots();
  }

  void reduceQuantity({required String productId, required int quantity}) {}
}
