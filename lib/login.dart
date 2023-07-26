import 'dart:js_interop';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ksloginpage/service/authService.dart';
import 'package:ksloginpage/userProfile.dart';

class MyLogin extends StatefulWidget {
  const MyLogin({Key? key}) : super(key: key);

  @override
  State<MyLogin> createState() => _MyLoginState();
}

class _MyLoginState extends State<MyLogin> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  AuthService authService = AuthService();

  void validateAndSignIn() {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    // Email validation
    if (email.isEmpty || !isValidEmail(email)) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Invalid Email'),
          content: const Text('Please enter a valid email address.'),
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

    // Password validation
    if (password.isEmpty) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Invalid Password'),
          content: const Text('Please enter a password.'),
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

    // Call the API using the authService login method
    // authService.login(email, password);

    authService.login(email, password).then((userId) {
      if (!userId.isNull) {
        // Login successful, navigate to a new page
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => UserProfile(userId: userId)),
        );
      } else {
        if (kDebugMode) {
          print("login has failed");
        }
      }
    }).catchError((error) {
      if (kDebugMode) {
        print(error);
      }
    });


  }

  bool isValidEmail(String email) {
    // Implement your email validation logic here
    return RegExp(r'^[\w-]+(\.[\w-]+)*@[a-zA-Z0-9-]+(\.[a-zA-Z0-9-]+)*(\.[a-zA-Z]{2,})$').hasMatch(email);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: Colors.cyan
/*        image: DecorationImage(
          image: AssetImage('assets/login_bg1.png'),
          fit: BoxFit.fill,
        ),*/
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            Container(
              padding: const EdgeInsets.only(left: 35, top: 80),
              child: const Text(
                'Welcome',
                style: TextStyle(color: Colors.white, fontSize: 33),
              ),
            ),
            SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.3,
                  right: 75,
                  left: 75,
                ),
                child: Column(
                  children: [
                    TextField(
                      controller: emailController,
                      decoration: InputDecoration(
                        hintText: 'Email',
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        suffixIcon: const Icon(
                          Icons.email,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    TextField(
                      controller: passwordController,
                      obscureText: true, // secure password
                      decoration: InputDecoration(
                        hintText: 'Password',
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        suffixIcon: const Icon(
                          Icons.remove_red_eye_rounded,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.all(40.0),
                      child: Center(
                        child: ElevatedButton(
                          onPressed: validateAndSignIn,
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size(200, 50),
                            side: const BorderSide(
                                width: 1, color: Colors.black),
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius:
                              BorderRadius.circular(25), // <-- Radius
                            ),
                          ),
                          child: const Text(
                            'Sign In',
                            style:
                            TextStyle(fontSize: 20, color: Colors.black),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, 'register');
                          },
                          child: const Text(
                            'Sign Up',
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                              fontSize: 22,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: const Text(
                            'Forget Password',
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                              fontSize: 22,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

