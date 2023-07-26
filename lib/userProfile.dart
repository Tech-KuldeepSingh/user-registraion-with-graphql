import 'package:flutter/material.dart';
import 'package:ksloginpage/service/authService.dart';

class UserProfile extends StatelessWidget {

  final int? userId;

  UserProfile({super.key, required this.userId});
  AuthService authService = AuthService();

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: authService.fetchUserData(userId!),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Failed to fetch user data'));
          } else {
            final userData = snapshot.data;

            return SingleChildScrollView(
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      margin: const EdgeInsets.all(20),
                      width: 150,
                      height: 150,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: AssetImage('assets/profile.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                   ListTile(
                      leading: const Icon(Icons.person),
                      title: Text(userData?["name"] ?? ''),
                    ),
                    ListTile(
                      leading: const Icon(Icons.email),
                      title: Text(userData?["username"] ?? ''),
                    ),
                    const ListTile(
                      leading: Icon(Icons.phone),
                      title: Text("+91-7823723935"),
                    ),
                    const ListTile(
                      leading: Icon(Icons.location_on),
                      title: Text("New Delhi"),
                    ),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }

}
