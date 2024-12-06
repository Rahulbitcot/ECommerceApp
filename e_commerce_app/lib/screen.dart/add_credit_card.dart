import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';

final firebase = FirebaseAuth.instance;
final firestore = FirebaseFirestore.instance;

class CreditCardFormPage extends StatefulWidget {
  @override
  _CreditCardFormPageState createState() => _CreditCardFormPageState();
}

class _CreditCardFormPageState extends State<CreditCardFormPage> {
  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';

  final _formKey = GlobalKey<FormState>();
  GlobalKey<FormFieldState<String>> cardNumberKey =
      GlobalKey<FormFieldState<String>>();
  GlobalKey<FormFieldState<String>> cvvCodeKey =
      GlobalKey<FormFieldState<String>>();
  GlobalKey<FormFieldState<String>> expiryDateKey =
      GlobalKey<FormFieldState<String>>();
  GlobalKey<FormFieldState<String>> cardHolderKey =
      GlobalKey<FormFieldState<String>>();

  void onSubmit() {
    if (_formKey.currentState!.validate()) {
      User? user = firebase.currentUser;
      if (user != null) {
        DocumentReference userRef = firestore.collection('users').doc(user.uid);
        userRef.set({
          'cardNumber': cardNumber,
          'expiryDate': expiryDate,
          'cardHolderName': cardHolderName,
          'cvvCode': cvvCode,
          'uid': user.uid,
        }, SetOptions(merge: true));
      }
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Credit Card Submitted')));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please fill all fields')));
    }
  }

  void setCardInfo() async {
    User? user = firebase.currentUser;

    if (user != null) {
      DocumentSnapshot snapshot =
          await firestore.collection('users').doc(user.uid).get();

      if (snapshot.exists) {
        setState(() {
          cardNumber = snapshot['cardNumber'];
          expiryDate = snapshot['expiryDate'];
          cvvCode = snapshot['cvvCode'];
          cardHolderName = snapshot['cardHolderName'];
        });
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("Card data not found")));
      }
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("User not logged in")));
    }
  }

  @override
  void initState() {
    super.initState();
    setCardInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(46, 84, 84, 84),
      appBar: AppBar(
        elevation: 24,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'Credit Card Information',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            CreditCardWidget(
              glassmorphismConfig: Glassmorphism(
                blurX: 10.0,
                blurY: 10.0,
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: <Color>[
                    Colors.grey.withAlpha(20),
                    Colors.white.withAlpha(20),
                  ],
                  stops: const <double>[
                    0.3,
                    0,
                  ],
                ),
              ),
              floatingConfig: const FloatingConfig(
                isGlareEnabled: true,
                isShadowEnabled: true,
                shadowConfig: FloatingShadowConfig(
                  offset: Offset(10, 10),
                  color: Colors.black,
                  blurRadius: 15,
                ),
              ),
              cardNumber: cardNumber,
              expiryDate: expiryDate,
              cardHolderName: cardHolderName,
              cvvCode: cvvCode,
              onCreditCardWidgetChange: (CreditCardBrand) {},
              showBackView: true,
              // Toggle to show the back of the card
            ),
            const SizedBox(height: 20),
            Expanded(
              child: cardNumber.isEmpty
                  ? const Center(child: CircularProgressIndicator())
                  : CreditCardForm(
                      formKey: _formKey,
                      cardNumber: cardNumber,
                      expiryDate: expiryDate,
                      cardHolderName: cardHolderName,
                      cvvCode: cvvCode,
                      cardNumberKey: cardNumberKey,
                      cvvCodeKey: cvvCodeKey,
                      expiryDateKey: expiryDateKey,
                      cardHolderKey: cardHolderKey,
                      onCreditCardModelChange: (CreditCardModel data) {
                        setState(() {
                          cardNumber = data.cardNumber;
                          expiryDate = data.expiryDate;
                          cardHolderName = data.cardHolderName;
                          cvvCode = data.cvvCode;
                        });
                      },
                      obscureCvv: true,
                      obscureNumber: true,
                      isHolderNameVisible: true,
                      isCardNumberVisible: true,
                      isExpiryDateVisible: true,
                      enableCvv: true,
                      cvvValidationMessage: 'Please input a valid CVV',
                      dateValidationMessage: 'Please input a valid date',
                      numberValidationMessage: 'Please input a valid number',
                      cardNumberValidator: (String? cardNumber) {
                        if (cardNumber!.isEmpty) {
                          return "Enter Valid Card number ";
                        }
                        return null;
                      },
                      expiryDateValidator: (String? expiryDate) {
                        if (expiryDate!.isEmpty) {
                          return "Enter Valid expiryDate ";
                        }
                        return null;
                      },
                      cvvValidator: (String? cvv) {
                        if (cvv!.isEmpty) {
                          return "Enter Valid cvv ";
                        }
                        return null;
                      },
                      cardHolderValidator: (String? cardHolderName) {
                        if (cardHolderName!.isEmpty) {
                          return "Enter Valid cardHolderName ";
                        }
                        return null;
                      },
                      onFormComplete: () {
                        onSubmit();
                      },
                      autovalidateMode: AutovalidateMode.always,
                      disableCardNumberAutoFillHints: false,
                      inputConfiguration: const InputConfiguration(
                        cardNumberDecoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Number',
                          hintText: 'XXXX XXXX XXXX XXXX',
                          labelStyle:
                              TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        expiryDateDecoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Expired Date',
                          hintText: 'XX/XX',
                          labelStyle:
                              TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        cvvCodeDecoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'CVV',
                          hintText: 'XXX',
                          labelStyle:
                              TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        cardHolderDecoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Card Holder',
                          labelStyle:
                              TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        cardNumberTextStyle: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                        cardHolderTextStyle: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                        expiryDateTextStyle: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                        cvvCodeTextStyle: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                    ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(16),
              child: TextButton(
                  style: const ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(Colors.amber),
                    fixedSize:
                        WidgetStatePropertyAll(Size(double.maxFinite, 60)),
                  ),
                  onPressed: onSubmit,
                  child: const Text(
                    "Validate",
                    style: TextStyle(color: Colors.black, fontSize: 20),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
