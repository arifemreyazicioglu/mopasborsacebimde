import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mopasborsacebimde/data/service/auth_service.dart';
import 'package:mopasborsacebimde/data/static/global/mycolors.dart';
import 'package:mopasborsacebimde/data/static/global/userinfo.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  AuthService _authService = AuthService();

  // ignore: must_call_super
  void initState() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: MyColors.kapaliMatSiyah,
      body: ListView(
        children: <Widget>[
          getLoginTitle(context, size),
          getLoginPage(context, size, _emailController, _passwordController,
              _authService),
        ],
      ),
    );
  }
}

getLoginPage(
    BuildContext context,
    Size size,
    TextEditingController _emailController,
    TextEditingController _passwordController,
    AuthService _authService) {
  return Padding(
    padding: const EdgeInsets.only(right: 25, left: 25, top: 40, bottom: 50),
    child: Container(
      height: size.height * .7,
      width: size.width * .85,
      decoration: BoxDecoration(
        color: MyColors.acikMatSiyah,
        borderRadius: BorderRadius.all(Radius.circular(20)),
        boxShadow: [
          BoxShadow(
            color: MyColors.matSari.withOpacity(.50),
            blurRadius: 10,
            spreadRadius: 2,
          )
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: _emailController,
                style: TextStyle(
                  color: MyColors.matSari,
                ),
                cursorColor: MyColors.matSari,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.mail,
                    color: MyColors.matSari,
                  ),
                  hintText: 'E-Mail',
                  prefixText: ' ',
                  hintStyle: TextStyle(color: MyColors.matSari),
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
                ),
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
              TextField(
                style: TextStyle(
                  color: MyColors.matSari,
                ),
                cursorColor: MyColors.matSari,
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.vpn_key,
                    color: MyColors.matSari,
                  ),
                  hintText: 'Parola',
                  prefixText: ' ',
                  hintStyle: TextStyle(
                    color: MyColors.matSari,
                  ),
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
                ),
              ),
              SizedBox(
                height: size.height * 0.06,
              ),
              Row(
                children: [
                  SizedBox(
                    width: size.width * 0.07,
                  ),
                  InkWell(
                    onTap: () async {
                      _authService.signIn(_emailController.text,
                          _passwordController.text, context);
                      var user = await _authService.getCurrentUser();
                      UserInfo.email = user!.email;
                      UserInfo.uId = user.uid;
                      UserInfo.userName = user.displayName;
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.3,
                      padding: EdgeInsets.symmetric(vertical: 5),
                      decoration: BoxDecoration(
                        border: Border.all(color: MyColors.matSari, width: 1),
                        //color: colorPrimaryShade,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Center(
                          child: Text(
                            "Giriş Yap",
                            style: TextStyle(
                              color: MyColors.matSari,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.04,
                    width: size.width * 0.06,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pushReplacementNamed(context, "/register");
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.3,
                      padding: EdgeInsets.symmetric(vertical: 5),
                      decoration: BoxDecoration(
                        border: Border.all(color: MyColors.matSari, width: 1),
                        //color: colorPrimaryShade,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Center(
                          child: Text(
                            "Üye Ol",
                            style: TextStyle(
                              color: MyColors.matSari,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: size.height * 0.04,
              ),
              // ignore: deprecated_member_use
              OutlinedButton(
                highlightedBorderColor: MyColors.matSari,
                borderSide: BorderSide(color: MyColors.matSari),
                onPressed: () {
                  Alert(
                    closeIcon: Text(""),
                    context: context,
                    type: AlertType.info,
                    style: AlertStyle(
                      backgroundColor: Color.fromRGBO(40, 40, 40, .0),
                      titleStyle: TextStyle(
                          color: Colors.white, fontFamily: "SourceSansPro"),
                      descStyle: TextStyle(
                          color: Colors.white, fontFamily: "SourceSansPro"),
                      alertBorder: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0.0),
                        side: BorderSide(
                          color: Color.fromRGBO(237, 217, 76, 25.0),
                        ),
                      ),
                      animationType: AnimationType.shrink,
                    ),
                    title: "Çıkış yapmak istiyor musunuz ?",
                    buttons: [
                      DialogButton(
                        radius: BorderRadius.zero,
                        color: MyColors.matSari,
                        padding: EdgeInsets.all(5),
                        child: Text(
                          "Hayır",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontFamily: "SourceSansPro",
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        width: 150,
                      ),
                      DialogButton(
                        radius: BorderRadius.zero,
                        color: MyColors.matSari,
                        padding: EdgeInsets.all(5),
                        child: Text(
                          "Çık",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontFamily: "SourceSansPro",
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        onPressed: () {
                          SystemNavigator.pop();
                        },
                        width: 150,
                      ),
                    ],
                  ).show();
                },
                child: Text("Çıkış",
                    style: TextStyle(
                      color: MyColors.matSari,
                      fontSize: 16,
                    )),
              ),
              TextButton(
                onPressed: () =>
                    Navigator.pushReplacementNamed(context, "/forgetpassword"),
                child: Text(
                  "Şifremi Unuttum",
                  style: TextStyle(color: MyColors.matSari),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

Widget getLoginTitle(BuildContext context, Size size) {
  return Padding(
    padding: EdgeInsets.only(top: size.height * .06, left: size.width * .03),
    child: Align(
      alignment: Alignment.topLeft,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            width: size.width * 0.38,
          ),
          Text(
            "MOPAŞ",
            style: TextStyle(
                fontSize: 20,
                color: MyColors.matSari,
                fontWeight: FontWeight.bold),
          )
        ],
      ),
    ),
  );
}
