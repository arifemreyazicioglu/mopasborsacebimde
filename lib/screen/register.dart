import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mopasborsacebimde/data/service/auth_service.dart';
import 'package:mopasborsacebimde/data/static/global/mycolors.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordAgainController =
      TextEditingController();
  AuthService _authService = AuthService();
  List exchangeList = [];
  List alarms = [];

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
        children: [
          getRegisterTitle(context, size),
          getRegisterPage(
            context,
            size,
            _nameController,
            _emailController,
            _passwordAgainController,
            _passwordController,
            _authService,
            exchangeList,
            alarms,
          ),
        ],
      ),
    );
  }
}

getRegisterPage(
  BuildContext context,
  Size size,
  TextEditingController _nameController,
  TextEditingController _emailController,
  TextEditingController _passwordAgainController,
  TextEditingController _passwordController,
  AuthService _authService,
  List exchangeList,
  List alarms,
) {
  return Padding(
    padding: const EdgeInsets.only(right: 25, left: 25, top: 29, bottom: 50),
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
                spreadRadius: 2)
          ]),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                  controller: _nameController,
                  style: TextStyle(
                    color: MyColors.matSari,
                  ),
                  cursorColor: MyColors.matSari,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.person,
                      color: MyColors.matSari,
                    ),
                    hintText: 'Kullanıcı Adı',
                    prefixText: ' ',
                    hintStyle: TextStyle(color: MyColors.matSari),
                    focusColor: MyColors.matSari,
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                      color: MyColors.matSari,
                    )),
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                      color: MyColors.matSari,
                    )),
                  )),
              SizedBox(
                height: size.height * 0.02,
              ),
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
                    hintStyle: TextStyle(color: MyColors.matSari),
                    focusColor: MyColors.matSari,
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                      color: MyColors.matSari,
                    )),
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                      color: MyColors.matSari,
                    )),
                  )),
              SizedBox(
                height: size.height * 0.02,
              ),
              TextField(
                  style: TextStyle(
                    color: MyColors.matSari,
                  ),
                  cursorColor: MyColors.matSari,
                  controller: _passwordAgainController,
                  obscureText: true,
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.vpn_key_outlined,
                      color: MyColors.matSari,
                    ),
                    hintText: 'Parola Tekrar',
                    prefixText: ' ',
                    hintStyle: TextStyle(color: MyColors.matSari),
                    focusColor: MyColors.matSari,
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                      color: MyColors.matSari,
                    )),
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                      color: MyColors.matSari,
                    )),
                  )),
              SizedBox(
                height: size.height * 0.08,
              ),
              InkWell(
                onTap: () async {
                  if (_passwordController.text ==
                          _passwordAgainController.text &&
                      _emailController.text.contains(".com"))
                    _authService.createPerson(
                      _nameController.text,
                      _emailController.text,
                      _passwordController.text,
                      exchangeList,
                      alarms,
                      context,
                    );
                  else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        duration: Duration(seconds: 2),
                        backgroundColor: Colors.redAccent,
                        content: Text(
                          'Lütfen geçerli değerler yazınız!',
                          style: TextStyle(fontSize: 18.0),
                        ),
                      ),
                    );
                  }
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
                        "Kaydet",
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
        ),
      ),
    ),
  );
}

getRegisterTitle(BuildContext context, Size size) {
  return Padding(
    padding: EdgeInsets.only(top: size.height * .04, left: size.width * .02),
    child: Align(
      alignment: Alignment.topLeft,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          IconButton(
            onPressed: () => Navigator.pushReplacementNamed(context, "/login"),
            icon: Icon(
              Icons.arrow_back_ios_outlined,
              color: MyColors.matSari,
              size: 26,
            ),
          ),
          SizedBox(
            width: size.width * 0.26,
          ),
          Text(
            "Üye Ol",
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
