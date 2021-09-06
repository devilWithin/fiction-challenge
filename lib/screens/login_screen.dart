import 'package:fiction_challenge/components.dart';
import 'package:fiction_challenge/screens/products_screen.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: fictionFormField(
                textInputType: TextInputType.name,
                controller: nameController,
                label: 'Name',
                icon: Icons.account_circle,
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: fictionFormField(
                textInputType: TextInputType.phone,
                controller: phoneController,
                label: 'Phone',
                icon: Icons.phone,
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: fictionFormField(
                textInputType: TextInputType.emailAddress,
                controller: emailController,
                label: 'E-mail',
                icon: Icons.mail,
              ),
            ),
            const SizedBox(height: 30),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              width: double.infinity,
              height: 50,
              child: TextButton(
                onPressed: () {
                  navigateTo(context, ProductsScreen());
                },
                child: Text(
                  'Login'.toUpperCase(),
                  style: TextStyle(color: Colors.white),
                ),
                style: TextButton.styleFrom(
                  backgroundColor: Colors.deepOrange,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
