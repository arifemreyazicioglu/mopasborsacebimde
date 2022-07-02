import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mopasborsacebimde/data/static/global/mycolors.dart';

class ChangePassword extends StatefulWidget {
  ChangePassword({Key? key}) : super(key: key);

  @override
  ChangePasswordState createState() => ChangePasswordState();
}

class ChangePasswordState extends State<ChangePassword> {
  final _formKey = GlobalKey<FormState>();

  var newPassword = "";
  var againPassword = "";
  // Create a text controller and use it to retrieve the current value
  // of the TextField.

  final newPasswordController = TextEditingController();
  final againPasswordController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    newPasswordController.dispose();
    againPasswordController.dispose();

    super.dispose();
  }

  final currentUser = FirebaseAuth.instance.currentUser;
  changePassword() async {
    try {
      await currentUser!.updatePassword(newPassword);
      FirebaseAuth.instance.signOut();
      Navigator.pushReplacementNamed(context, "/login");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: Duration(seconds: 2),
          backgroundColor: Colors.greenAccent,
          content: Text(
            'Şifreniz değiştirldi.Tekrar giriş yapınız!',
            style: TextStyle(fontSize: 18.0),
          ),
        ),
      );
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColors.acikMatSiyah,
        title: Text(
          "Profil",
          style: TextStyle(color: MyColors.matSari),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Navigator.pushReplacementNamed(context, "/profil"),
          icon: Icon(
            Icons.arrow_back_ios_outlined,
            color: MyColors.matSari,
            size: 20,
          ),
        ),
      ),
      body: Container(
        color: MyColors.kapaliMatSiyah,
        child: Form(
          key: _formKey,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
            child: ListView(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10.0),
                  child: Column(
                    children: [
                      TextFormField(
                        style: TextStyle(
                          color: MyColors.matSari,
                        ),
                        cursorColor: MyColors.matSari,
                        autofocus: false,
                        obscureText: true,
                        decoration: InputDecoration(
                          focusColor: MyColors.matSari,
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: MyColors.matSari,
                            ),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: MyColors.matSari,
                            ),
                          ),
                          labelText: 'Yeni Şifre : ',
                          labelStyle: TextStyle(
                              fontSize: 15.0, color: MyColors.matSari),
                          errorStyle:
                              TextStyle(color: Colors.redAccent, fontSize: 15),
                        ),
                        controller: newPasswordController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Lütfen bir parola girin!';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        style: TextStyle(
                          color: MyColors.matSari,
                        ),
                        cursorColor: MyColors.matSari,
                        autofocus: false,
                        obscureText: true,
                        decoration: InputDecoration(
                          focusColor: MyColors.matSari,
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: MyColors.matSari,
                            ),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: MyColors.matSari,
                            ),
                          ),
                          labelText: 'Yeni Şifre Tekrar : ',
                          labelStyle: TextStyle(
                              fontSize: 15.0, color: MyColors.matSari),
                          errorStyle:
                              TextStyle(color: Colors.redAccent, fontSize: 15),
                        ),
                        controller: againPasswordController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Lütfen bir parola girin!';
                          }
                          if (value != newPasswordController.text) {
                            return 'Girdiğiniz şifreler aynı değil!';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: MyColors.matSari,
                  ),
                  onPressed: () {
                    // Validate returns true if the form is valid, otherwise false.
                    if (_formKey.currentState!.validate()) {
                      setState(() {
                        newPassword = newPasswordController.text;
                        againPassword = againPasswordController.text;
                      });
                      changePassword();
                    }
                  },
                  child: Text(
                    'Change Password',
                    style:
                        TextStyle(fontSize: 18.0, color: MyColors.acikMatSiyah),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
