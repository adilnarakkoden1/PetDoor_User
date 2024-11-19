import 'package:flutter/material.dart';

class CustomSearchField extends StatelessWidget {
  final String hintText;
  final ValueChanged<String> onChanged;

  const CustomSearchField({
    Key? key,
    required this.hintText,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onChanged,
      decoration: InputDecoration(
        labelText: hintText,
        labelStyle: TextStyle(color: Colors.black),
        prefixIcon: Icon(Icons.search, color: Colors.grey),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: BorderSide(color: Colors.black),
        ),
      ),
    );
  }
}

class CustomFilterDialog extends StatelessWidget {
  final String selectedCategory;
  final ValueChanged<String?> onCategoryChanged;
  final VoidCallback onReset;
  final VoidCallback onApply;

  const CustomFilterDialog({
    Key? key,
    required this.selectedCategory,
    required this.onCategoryChanged,
    required this.onReset,
    required this.onApply,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      title: Text(
        "Filter Options",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Color(0xFF2D4059),
        ),
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            DropdownButtonFormField<String>(
              isExpanded: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.grey),
                ),
                filled: true,
                fillColor: Colors.grey[200],
              ),
              value: selectedCategory.isEmpty ? null : selectedCategory,
              hint: Text("Select Category"),
              items: [
                DropdownMenuItem(value: "dog", child: Text("Dog")),
                DropdownMenuItem(value: "cat", child: Text("Cat")),
                DropdownMenuItem(value: "rabbit", child: Text("Rabbit")),
                DropdownMenuItem(value: "bird", child: Text("bird")),
              ],
              onChanged: onCategoryChanged,
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: onReset,
          child: Text("Reset Filter"),
        ),
        TextButton(
          onPressed: onApply,
          child: Text("Apply Filter"),
        ),
      ],
    );
  }
}
