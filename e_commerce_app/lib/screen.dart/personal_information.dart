import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PersonalInformation extends StatefulWidget {
  const PersonalInformation({super.key});

  @override
  State<PersonalInformation> createState() => _PersonalInformationState();
}

class _PersonalInformationState extends State<PersonalInformation> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _numberController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  late SharedPreferences pref;
  String name = "Set your name";
  String email = "Set your email";
  String number = "Set your number";
  String address = "Set your address";

  final _formKey = GlobalKey<FormState>();

  void setUpSharedPref() async {
    pref = await SharedPreferences.getInstance();
    setUserInfo();
  }

  void saveUserInfo() {
    if (_formKey.currentState?.validate() ?? false) {
      pref.setString("name", _nameController.text);
      pref.setString("email", _emailController.text);
      pref.setString("number", _numberController.text);
      pref.setString("address", _addressController.text);

      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("Profile Updated")));
      }

      FocusScope.of(context).unfocus();
    }
  }

  void setUserInfo() {
    setState(() {
      name = pref.getString("name") ?? "Set your name";
      email = pref.getString("email") ?? "Set your email";
      number = pref.getString("number") ?? "Set your number";
      address = pref.getString("address") ?? "Set your address";

      _nameController.text = name;
      _emailController.text = email;
      _numberController.text = number;
      _addressController.text = address;
    });
  }

  @override
  void initState() {
    super.initState();
    setUpSharedPref();
  }

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _numberController.dispose();
    _addressController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Personal Information"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Expanded(
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _nameController..text = name,
                      decoration: const InputDecoration(label: Text("Name")),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Name cannot be empty";
                        }

                        if (value.length < 2) {
                          return "Enter Valid Name";
                        }

                        return null;
                      },
                    ),
                    const SizedBox(height: 30),
                    TextFormField(
                      controller: _numberController..text = number,
                      decoration: const InputDecoration(label: Text("Number")),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Phone number cannot be empty";
                        }
                        if (value.length != 10) {
                          return "Phone number must be of 10 digits";
                        }
                        final regex = RegExp(r'[a-zA-Z]');
                        if (regex.hasMatch(value)) {
                          return "Enter a valid number (no letters allowed)";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 30),
                    TextFormField(
                      controller: _emailController..text = email,
                      decoration: const InputDecoration(label: Text("Email")),
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Email cannot be empty";
                        }
                        if (!value.contains('@')) {
                          return "Enter Valid Email";
                        }
                        if (value.length < 5) {
                          return "Enter Valid Email";
                        }

                        return null;
                      },
                    ),
                    const SizedBox(height: 30),
                    TextFormField(
                      controller: _addressController..text = address,
                      decoration: const InputDecoration(label: Text("Address")),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Address cannot be empty";
                        }

                        if (value.length < 5) {
                          return "Enter Valid Address";
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
            ),
            ElevatedButton(
              onPressed: saveUserInfo,
              style: const ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(Colors.amber),
                fixedSize: WidgetStatePropertyAll(Size(double.maxFinite, 60)),
              ),
              child: const Text(
                "Save profile information",
                style: TextStyle(color: Colors.black, fontSize: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
