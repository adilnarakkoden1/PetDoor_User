import 'package:flutter/material.dart';
import 'package:pet_door_user/widgets/appbar.dart';
import 'package:pet_door_user/widgets/colors.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgr,
      appBar: const CustomAppBar(
        title: ("About PetDoor"),
      ),
      body: const Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Welcome to PetDoor",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16.0),
              const Text(
                "Your go-to platform for adopting furry friends and finding your perfect pet companion. At PetDoor, we believe that every animal deserves a loving home, and we are committed to connecting passionate pet lovers with animals in need of care and affection.",
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 16.0),
              const Text(
                "Our Mission",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8.0),
              const Text(
                "PetDoor is dedicated to making pet adoption accessible, transparent, and enjoyable. We aim to facilitate a smooth adoption process that prioritizes the well-being of animals while empowering adopters to make informed decisions.",
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 16.0),
              const Text(
                "What We Offer",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8.0),
              const Text(
                "- Wide Selection: Browse through a diverse range of pets available for adoption, including dogs, cats, and other lovable animals.\n"
                "- User-Friendly Interface: Our intuitive design allows users to easily navigate through profiles, view images, and read descriptions of the animals.\n"
                "- Favorites Feature: Save your favorite pets and keep track of the ones you’re interested in.\n"
                "- Secure Adoption Process: Collaborating with local shelters to ensure a safe and responsible adoption experience.\n"
                "- Community Support: Join our community of pet lovers and share your adoption stories.",
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 16.0),
              const Text(
                "Why Choose PetDoor?",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8.0),
              const Text(
                "With our commitment to animal welfare and a seamless adoption experience, PetDoor is more than just an app—it's a community dedicated to helping animals find their forever homes.",
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 16.0),
              const Text(
                "Join us in our mission to make a difference in the lives of animals. Download PetDoor today and take the first step towards finding your new best friend!",
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
