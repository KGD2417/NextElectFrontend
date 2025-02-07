import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:next_elect/providers/auth_provider.dart';
import 'package:next_elect/screens/auth/register_screen.dart';
import 'package:next_elect/screens/home_screen.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String? selectedGender;
  TextEditingController dateController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        dateController.text = "${picked.day}-${picked.month}-${picked.year}";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 40),
              const Icon(
                Icons.check_circle_outline,
                size: 64,
                color: Colors.indigo,
              ),
              const SizedBox(height: 20),
              const Text(
                'Welcome to NextElect',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2E2E47),
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Secure, accessible voting anytime, anywhere',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0xFF7D7D93),
                ),
              ),
              const SizedBox(height: 40),
              TextField(
                controller: _usernameController,
                decoration: InputDecoration(
                  labelText: 'Enter your Aadhaar ID',
                  hintText: 'Eg: 9827 0164 8224',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 20),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Enter your Password',
                  hintText: '',

                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                controller: _passwordController,
              ),
              const SizedBox(height: 20),
              TextField(
                controller: dateController,
                decoration: InputDecoration(
                  labelText: 'Enter your Birth Date',
                  hintText: 'Eg: 24-11-2005',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.calendar_today),
                    onPressed: () => _selectDate(context),
                  ),
                ),
                keyboardType: TextInputType.datetime,
              ),
              const SizedBox(height: 20),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Select your Gender',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GenderOption(title: 'Male', groupValue: selectedGender, onChanged: (value) {
                    setState(() {
                      selectedGender = value;
                    });
                  }),
                  GenderOption(title: 'Female', groupValue: selectedGender, onChanged: (value) {
                    setState(() {
                      selectedGender = value;
                    });
                  }),
                  GenderOption(title: 'Other', groupValue: selectedGender, onChanged: (value) {
                    setState(() {
                      selectedGender = value;
                    });
                  }),
                ],
              ),
              const SizedBox(height: 40),
              GradientButton(
                text: 'NEXT',
                onPressed: () async {
                  try {
                    await authProvider.login(
                      _usernameController.text,
                      _passwordController.text,
                    );
                    if(dateController.text.toString() == "31-1-1974"){
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Authenticated"))
                      );
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const HomeScreen()),);
                    }
                    else{
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Wrong Credentials"))
                      );
                    }
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(e.toString())),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class GradientButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const GradientButton({
    Key? key,
    required this.text,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF343A72), Color(0xFF6A8DFF)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

class GenderOption extends StatelessWidget {
  final String title;
  final String? groupValue;
  final ValueChanged<String?> onChanged;

  const GenderOption({Key? key, required this.title, required this.groupValue, required this.onChanged}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Radio<String>(
          value: title,
          groupValue: groupValue,
          onChanged: onChanged,
          activeColor: Colors.indigo,
        ),
        Text(
          title,
          style: const TextStyle(fontSize: 16, color: Color(0xFF2E2E47)),
        ),
      ],
    );
  }
}