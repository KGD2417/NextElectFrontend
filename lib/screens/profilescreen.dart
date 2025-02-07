import 'package:flutter/material.dart';


class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 10,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 40,
              backgroundImage: AssetImage("images/profile.png"), // Ensure this exists in assets
            ),
            SizedBox(height: 20),
            buildTextField("Name", "Joel Deo"),
            buildTextField("Aadhaar ID", "9087 5647 2341"),
            buildTextField("Birth Date", "01-12-2005"),
            buildTextField("Gender", "Male"),
            SizedBox(height: 30),
            buildGradientButton(),
          ],
        ),
      ),
    );
  }

  Widget buildTextField(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(height: 5),
          TextField(
            readOnly: true,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              filled: true,
              fillColor: Color(0xFFEFF4F8),
              hintText: value,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildGradientButton() {
    return Container(
      width: double.infinity,
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        gradient: LinearGradient(
          colors: [Color(0xFF343A72), Color(0xFF6A8DFF)], // Gradient colors
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
        child: Text(
          "LOGOUT",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
