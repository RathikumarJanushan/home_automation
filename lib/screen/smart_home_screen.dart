import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:home_automation/model/smart_home_model.dart';
import 'package:home_automation/screen/SignInScreen.dart';
import 'package:home_automation/screen/room_card.dart';

class SmartHomeScreen extends StatefulWidget {
  const SmartHomeScreen({super.key});

  @override
  State<SmartHomeScreen> createState() => _SmartHomeScreenState();
}

class _SmartHomeScreenState extends State<SmartHomeScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> _logout() async {
    await _auth.signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => SignInScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final User? user = _auth.currentUser;

    if (user == null) {
      return SignInScreen();
    }

    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 237, 128, 3),
        title: const Text('Smart Home'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: _logout,
            tooltip: 'Logout',
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: smartHomeData.length + 2,
                itemBuilder: (context, index) {
                  if (index == 0 || index == smartHomeData.length + 1) {
                    return Container(
                      width: 15,
                      height: size.height * 0.5,
                      color: Colors.transparent,
                    );
                  }
                  final data = smartHomeData[index - 1];
                  return RoomCard(
                    roomData: data,
                    imageSize: Size(size.width * 0.4,
                        size.height * 0.3), // Adjust image size
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
