import 'package:flutter/material.dart';
import 'package:pet_door_user/controllers/db_service.dart';
import 'package:pet_door_user/provider/user_provider.dart';
import 'package:pet_door_user/widgets/appbar.dart';
import 'package:pet_door_user/widgets/colors.dart';
import 'package:provider/provider.dart';

class UpdateProfile extends StatefulWidget {
  const UpdateProfile({super.key});

  @override
  State<UpdateProfile> createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    _nameController.text = userProvider.name;
    _emailController.text = userProvider.email;
    _addressController.text = userProvider.address;
    _phoneController.text = userProvider.phone;

    return Scaffold(
      backgroundColor: bgr,
      appBar: CustomAppBar(title: ("Update Profile")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Name
              _buildTextField(
                controller: _nameController,
                label: "Name",
                hint: "Enter your name",
                isReadOnly: false,
                icon: Icons.person, // Added icon
              ),
              SizedBox(height: 16.0),

              // Email
              _buildTextField(
                controller: _emailController,
                label: "Email",
                hint: "Email",
                isReadOnly: true,
                icon: Icons.email, // Added icon
              ),
              SizedBox(height: 16.0),

              // Address
              _buildTextField(
                controller: _addressController,
                label: "Address",
                hint: "Enter your address",
                isReadOnly: false,
                maxLines: 3,
                icon: Icons.home, // Added icon
              ),
              SizedBox(height: 16.0),

              // Phone
              _buildTextField(
                controller: _phoneController,
                label: "Phone",
                hint: "Enter your number",
                isReadOnly: false,
                keyboardType: TextInputType.phone,
                validator: _phoneValidator,
                icon: Icons.phone, // Added icon
              ),
              SizedBox(height: 16.0),

              SizedBox(
                height: 60,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _updateProfile,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40.0, vertical: 14.0),
                    elevation: 8,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    backgroundColor: Colors.teal.shade800,
                    shadowColor: Colors.teal.shade400,
                  ),
                  child: Text(
                    "Update Profile",
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    bool isReadOnly = false,
    int maxLines = 1,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
    IconData? icon,
  }) {
    return TextFormField(
      controller: controller,
      readOnly: isReadOnly,
      maxLines: maxLines,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: icon != null
            ? Icon(icon, color: Theme.of(context).primaryColor)
            : null, // Icon in the text field
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(color: Colors.grey.shade400),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide:
              BorderSide(color: Theme.of(context).primaryColor, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(color: Colors.red, width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(
            horizontal: 20, vertical: 16), // Padding for the text field
      ),
      validator: validator ??
          (value) => value!.isEmpty ? "$label cannot be empty." : null,
    );
  }

  // Phone number validator
  String? _phoneValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "Phone cannot be empty.";
    } else if (value.length != 10) {
      return "Phone number must be 10 digits";
    } else if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
      return "Phone number must contain only digits.";
    }
    return null;
  }

  // Method to update profile
  Future<void> _updateProfile() async {
    if (formKey.currentState!.validate()) {
      var data = {
        "name": _nameController.text,
        "email": _emailController.text,
        "address": _addressController.text,
        "phone": _phoneController.text
      };
      await DbService().updateUserData(extraData: data);
      Navigator.pop(context);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Profile Updated")));
    }
  }
}
