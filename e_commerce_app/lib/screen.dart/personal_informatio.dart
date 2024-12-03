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

  late SharedPreferences prefs;
  String name = "Set your name";
  String email = "Set your email";
  String number = "Set your number";
  String address = "Set your address";

  void setUpSharedPref() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("name", _nameController.text);
    prefs.setString("email", _emailController.text);
    prefs.setString("number", _emailController.text);
    prefs.setString("address", _addressController.text);
  }

  @override
  void initState() {
    super.initState();
    setUpSharedPref();

    name = prefs.getString("name").toString();
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
    return Center(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Personal Information"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Expanded(
                child: Form(
                    child: Column(
                  children: [
                    TextFormField(
                      decoration: const InputDecoration(label: Text("Name")),
                      initialValue: name,
                    ),
                    const SizedBox(height: 30),
                    TextFormField(
                      decoration: const InputDecoration(label: Text("Number")),
                      initialValue: number,
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 30),
                    TextFormField(
                      decoration: const InputDecoration(label: Text("Email")),
                      initialValue: email,
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 30),
                    TextFormField(
                      decoration: const InputDecoration(label: Text("Address")),
                      initialValue: address,
                      keyboardType: TextInputType.number,
                    )
                  ],
                )),
              ),
              ElevatedButton(
                  onPressed: () {},
                  style: const ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(Colors.amber),
                    fixedSize:
                        WidgetStatePropertyAll(Size(double.maxFinite, 60)),
                  ),
                  child: const Text(
                    "Save profile information",
                    style: TextStyle(color: Colors.black, fontSize: 20),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
