import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ksloginpage/login.dart';
import 'package:ksloginpage/service/authService.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class MyRegister extends StatefulWidget {
  const MyRegister({Key? key}) : super(key: key);

  @override
  State<MyRegister> createState() => _MyRegisterState();
}

class _MyRegisterState extends State<MyRegister> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();

  AuthService authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create Account"),
        backgroundColor: Colors.cyan,
      ),
      backgroundColor: Colors.cyan,
      body: Column(
        children: [
          Expanded(
            child: CustomScrollView(
              slivers: [
                SliverPadding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 75),
                  sliver: SliverList(
                    delegate: SliverChildListDelegate(
                      [
                        TextField(
                          controller: usernameController,
                          style: const TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            hintText: 'User Name',
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                            // Make the field required
                            suffixIcon: const Icon(
                              Icons.person,
                              color: Colors.black,
                            ),
                            errorText: usernameController.text.isEmpty
                                ? 'Required field'
                                : null,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        TextField(
                          controller: emailController,
                          style: const TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            hintText: 'Email',
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                            // Make the field required
                            suffixIcon: const Icon(
                              Icons.email,
                              color: Colors.black,
                            ),
                            errorText: emailController.text.isEmpty
                                ? 'Required field'
                                : null,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        TextField(
                          controller: passwordController,
                          style: const TextStyle(color: Colors.black),
                          obscureText: true, // secure password
                          decoration: InputDecoration(
                            hintText: 'Password',
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                            // Make the field required
                            suffixIcon: const Icon(
                              Icons.lock,
                              color: Colors.black,
                            ),
                            errorText: passwordController.text.isEmpty
                                ? 'Required field'
                                : null,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        TextField(
                          controller: nameController,
                          style: const TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            hintText: 'First Name',
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                            // Make the field required
                            suffixIcon: const Icon(
                              Icons.person,
                              color: Colors.black,
                            ),
                            errorText: nameController.text.isEmpty
                                ? 'Required field'
                                : null,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        TextField(
                          controller: lastNameController,
                          style: const TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            hintText: 'Last Name',
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                            // Make the field required
                            suffixIcon: const Icon(
                              Icons.person,
                              color: Colors.black,
                            ),
                            errorText: lastNameController.text.isEmpty
                                ? 'Required field'
                                : null,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        TextField(
                          controller: mobileController,
                          style: const TextStyle(color: Colors.black),
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
                          ],
                          // Allow only numbers
                          keyboardType: TextInputType.number,
                          // Set the keyboard type to number
                          decoration: InputDecoration(
                            hintText: 'Mobile Number',
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                            // Make the field required
                            suffixIcon: const Icon(
                              Icons.phone,
                              color: Colors.black,
                            ),
                            errorText: mobileController.text.isEmpty
                                ? 'Required field'
                                : null,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(40.0),
                          child: ElevatedButton(
                            onPressed: handleSignUp,
                            style: ElevatedButton.styleFrom(
                              minimumSize: const Size(200, 50),
                              side: const BorderSide(
                                  width: 1.5, color: Colors.redAccent),
                              backgroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(25), // <-- Radius
                              ),
                            ),
                            child: const Text(
                              'Sign Up',
                              style:
                                  TextStyle(fontSize: 20, color: Colors.black),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void handleSignUp() {
    // Pick input values
    final String email = emailController.text;
    final String username = usernameController.text;
    final String password = passwordController.text;
    final String name = nameController.text;
    final String lastName = lastNameController.text;
    final String mobile = mobileController.text;

    // Validate fields
    if (username.isEmpty ||
        email.isEmpty ||
        password.isEmpty ||
        name.isEmpty ||
        lastName.isEmpty ||
        mobile.isEmpty) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Error'),
          content: const Text('Please fill in all required fields.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        ),
      );
      return;
    }

    try {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Dialog(
            child: Container(
              padding: const EdgeInsets.all(16.0),
              child: const Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Signing Up...'),
                  SizedBox(height: 16.0),
                  SpinKitCircle(
                    color: Colors.blue,
                    size: 50.0,
                  ),
                ],
              ),
            ),
          );
        },
      );

      authService.signUp(username,name,lastName, email, password,mobile).then((value) {
        Navigator.pop(context); // Close the loading dialog

        if (value) {
          // Navigate to login page
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Success'),
              content: const Text('Registration completed!!'),
              actions: [
                TextButton(
                  onPressed: () => navigateToLogin(),
                  child: const Text('OK'),
                ),
              ],
            ),
          );
        } else {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Failed'),
              content: const Text('Could not complete the registration'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('OK'),
                ),
              ],
            ),
          );
        }
      });
    } catch (e) {
      // Printing the error information
      if (kDebugMode) {
        print(e);
      }
    }
  }

  // Navigate to login page after successful registration.
  navigateToLogin() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const MyLogin()),
    );
  }
}
