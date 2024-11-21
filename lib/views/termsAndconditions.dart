import 'package:flutter/material.dart';
import 'package:pet_door_user/widgets/appbar.dart';
import 'package:pet_door_user/widgets/colors.dart';

class Terms extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgr,
      appBar: CustomAppBar(title: 'Terms and Conditions'),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Terms and Conditions',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Last Updated: 13/11/2024',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
            SizedBox(height: 20),
            _buildSectionTitle('1. Acceptance of Terms'),
            _buildSectionContent(
                'By using PetDoor, you agree to these Terms and Conditions, which govern your use of the App, including all associated services, features, and content. Please read these terms carefully before using the App.'),
            _buildSectionTitle('2. Account Registration'),
            _buildSectionContent(
                'To access certain features of the App, such as adopting pets or managing your account, you may need to register for an account. You are responsible for maintaining the confidentiality of your account credentials and agree to notify us immediately of any unauthorized use of your account.'),
            _buildSectionTitle('3. User Responsibilities'),
            _buildSectionContent(
                '- **Accurate Information**: You agree to provide accurate and complete information when registering, updating your profile, or interacting with the app.\n- **Legal Age**: By using PetDoor, you confirm that you are at least 18 years old, or have the consent of a legal guardian if under 18.\n- **No Harmful Content**: You agree not to post or share content that is harmful, offensive, discriminatory, or otherwise violates the rights of others.'),
            _buildSectionTitle('4. Adoption Process'),
            _buildSectionContent(
                '- **Pet Listings**: The pets listed on PetDoor are available for adoption by users who meet the app\'s adoption requirements. PetDoor does not guarantee the availability of a specific pet at any given time.\n- **Adoption Requirements**: Users interested in adopting a pet must meet certain requirements outlined on the App. These requirements may vary depending on the pet’s needs and adoption criteria.\n- **Adoption Fee**: Some pets may require an adoption fee, which is used to cover the cost of care, vaccinations, and other expenses. The fee will be displayed on the pet’s profile page.'),
            _buildSectionTitle('5. Animal Welfare'),
            _buildSectionContent(
                '- **Care and Responsibility**: As an adopter, you agree to provide the pet with a safe and caring environment. You are responsible for the pet’s well-being after the adoption, including proper veterinary care, food, and shelter.\n- **Return of Animals**: If you are unable to care for the adopted pet, you agree to return the animal to the shelter or organization listed on PetDoor in accordance with their return policy.'),
            _buildSectionTitle('6. Payments'),
            _buildSectionContent(
                'All payments for adoption fees or donations are processed securely through the App. You agree to pay all fees associated with your use of the App, including but not limited to adoption fees and any other charges that may apply.'),
            _buildSectionTitle('7. Donations'),
            _buildSectionContent(
                'PetDoor may allow users to make donations to shelters or organizations. Donations are voluntary, and once made, they are non-refundable.'),
            _buildSectionTitle('8. Privacy Policy'),
            _buildSectionContent(
                'Your privacy is important to us. Please review our [Privacy Policy] to understand how your personal data is collected, used, and protected when using PetDoor.'),
            _buildSectionTitle('9. Restrictions on Use'),
            _buildSectionContent(
                'You agree not to use the App for any unlawful or prohibited purposes, including:\n- Engaging in fraudulent activities or misrepresentation.\n- Transmitting malware or viruses.\n- Harassing, threatening, or violating the rights of other users or organizations.\n- Attempting to access restricted areas of the App without authorization.'),
            _buildSectionTitle('10. Content Ownership'),
            _buildSectionContent(
                'All content on the App, including text, images, logos, and trademarks, is owned or licensed by PetDoor and is protected by intellectual property laws. You may not use, copy, modify, or distribute this content without prior written consent.'),
            _buildSectionTitle('11. Termination of Account'),
            _buildSectionContent(
                'PetDoor reserves the right to suspend or terminate your account at its discretion if you violate these Terms and Conditions or engage in activities that harm the App or other users.'),
            _buildSectionTitle('12. Limitation of Liability'),
            _buildSectionContent(
                'To the extent permitted by law, PetDoor and its affiliates will not be held liable for any damages arising out of your use or inability to use the App. This includes, but is not limited to, direct, indirect, incidental, punitive, and consequential damages.'),
            _buildSectionTitle('13. Governing Law'),
            _buildSectionContent(
                'These Terms and Conditions are governed by and construed in accordance with the laws of [your jurisdiction]. Any disputes arising from these Terms will be resolved in the competent courts of [your jurisdiction].'),
            _buildSectionTitle('14. Changes to Terms and Conditions'),
            _buildSectionContent(
                'PetDoor reserves the right to update or modify these Terms and Conditions at any time. All changes will be posted on this page, and the date of the most recent update will be indicated at the top. We encourage you to review these Terms periodically to stay informed of any changes.'),
            _buildSectionTitle('15. Contact Us'),
            _buildSectionContent(
                'If you have any questions or concerns about these Terms and Conditions, please contact us at:\n- Email: [support@petdoor.com]\n- Address: [Your Address]'),
            SizedBox(height: 20),
            Text(
              'By continuing to use the PetDoor App, you acknowledge that you have read, understood, and agreed to these Terms and Conditions.',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildSectionContent(String content) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Text(
        content,
        style: TextStyle(fontSize: 14),
      ),
    );
  }
}
