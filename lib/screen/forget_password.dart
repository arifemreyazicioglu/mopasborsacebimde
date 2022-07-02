import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mopasborsacebimde/data/static/global/mycolors.dart';
import 'package:mopasborsacebimde/screen/login.dart';
import 'package:mopasborsacebimde/screen/register.dart';

class ForgotPassword extends StatefulWidget {
  ForgotPassword({Key? key}) : super(key: key);

  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final _formKey = GlobalKey<FormState>();
  final FirebaseAuth auth = FirebaseAuth.instance;

  var email = "";

  // Create a text controller and use it to retrieve the current value
  // of the TextField.
  final emailController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    emailController.dispose();
    super.dispose();
  }

  resetPassword() async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: Duration(seconds: 2),
          backgroundColor: MyColors.matSari,
          content: Text(
            'Şifre yenileme maili gönderildi!',
            style: TextStyle(fontSize: 18, color: MyColors.acikMatSiyah),
            textAlign: TextAlign.center,
          ),
        ),
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('Bu emaile ait kullanıcı bulunamadı!');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            duration: Duration(seconds: 2),
            backgroundColor: MyColors.matSari,
            content: Text(
              'Bu emaile ait kullanıcı bulunamadı!',
              style: TextStyle(fontSize: 18.0, color: MyColors.acikMatSiyah),
              textAlign: TextAlign.center,
            ),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.acikMatSiyah,
      appBar: AppBar(
        backgroundColor: MyColors.acikMatSiyah,
        title: Text(
          "Şifre Yenileme",
          style: TextStyle(color: MyColors.matSari),
        ),
        leading: Text(""),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 40.0),
            child: Text(
              'Yenileme linki mail adresinize gönderilecek!',
              style: TextStyle(fontSize: 18.0, color: MyColors.matSari),
            ),
          ),
          Expanded(
            child: Form(
              key: _formKey,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                child: ListView(
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 10.0),
                      child: TextFormField(
                        cursorColor: MyColors.matSari,
                        style: TextStyle(color: MyColors.matSari),
                        autofocus: false,
                        decoration: InputDecoration(
                          labelText: 'Email: ',
                          labelStyle: TextStyle(
                            fontSize: 20.0,
                            color: MyColors.matSari,
                          ),
                          hoverColor: MyColors.matSari,
                          errorStyle: TextStyle(
                            color: MyColors.matSari,
                            fontSize: 15,
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: MyColors.matSari,
                            ),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: MyColors.matSari,
                            ),
                          ),
                        ),
                        controller: emailController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Lütfen bir mail giriniz!';
                          } else if (!value.contains('@')) {
                            return 'Lütfen geçerli bir mail adresi giriniz!';
                          }
                          return null;
                        },
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 0.0, top: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // ignore: deprecated_member_use
                          OutlinedButton(
                            borderSide: BorderSide(color: MyColors.matSari),
                            color: MyColors.matSari,
                            onPressed: () {
                              // Validate returns true if the form is valid, otherwise false.
                              if (_formKey.currentState!.validate()) {
                                setState(() {
                                  email = emailController.text;
                                });
                                resetPassword();
                              }
                            },
                            child: Text(
                              'Send Email',
                              style: TextStyle(
                                  fontSize: 18.0, color: MyColors.matSari),
                            ),
                          ),
                          TextButton(
                            onPressed: () => {
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  PageRouteBuilder(
                                    pageBuilder: (context, a, b) => LoginPage(),
                                    transitionDuration: Duration(seconds: 0),
                                  ),
                                  (route) => false)
                            },
                            child: Text(
                              'Giriş Yap',
                              style: TextStyle(
                                  fontSize: 14.0, color: MyColors.matSari),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Hesabınız yok mu ? ",
                            style: TextStyle(color: MyColors.matSari),
                          ),
                          TextButton(
                              onPressed: () => {
                                    Navigator.pushAndRemoveUntil(
                                        context,
                                        PageRouteBuilder(
                                          pageBuilder: (context, a, b) =>
                                              RegisterPage(),
                                          transitionDuration:
                                              Duration(seconds: 0),
                                        ),
                                        (route) => false)
                                  },
                              child: Text(
                                'Kayıt Ol',
                                style: TextStyle(color: MyColors.matSari),
                              ))
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
