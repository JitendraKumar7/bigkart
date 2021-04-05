import 'dart:convert';
import 'dart:io';
import 'package:html/parser.dart';
import 'package:bigkart/app/AppConstants.dart';
import 'package:bigkart/app/AppPreferences.dart';
import 'package:bigkart/app/Basicdata.dart';

import 'package:device_info/device_info.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:woocommerce/woocommerce.dart';
import '../Basic.dart';

class LoginPage extends StatefulWidget {
  final String item;

  const LoginPage({Key key, this.item}) : super(key: key);

  @override
  @override
  State<StatefulWidget> createState() {
    return LoginPageState();
  }
}

class LoginPageState extends State<LoginPage> {
  WooCommerce wooCommerce = WooCommerce(
    baseUrl: BasicData().baseUrl,
    consumerKey: BasicData().consumerKey,
    consumerSecret: BasicData().consumerSecret,
    isDebug: true,
  );
  var mobileno;
  List<WooCustomer> woocustm = [];
  ProgressDialog pr;
  bool _passwordVisible;
  final kTitleStyle = TextStyle(
      color: Colors.black,
      fontSize: 16.0,
      height: 1.5,
      fontFamily: "Product Sans");
  final kTitleStylesign = TextStyle(
      color: Colors.greenAccent,
      fontSize: 16.0,
      height: 1.5,
      fontFamily: "Product Sans");

  @override
  void initState() {
    _passwordVisible = false;
    mobileno = widget.item;

    super.initState();
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _load = false;

  String validateMobile(String value) {
    if (value.length == 0) {
      return 'Enter user name';
    }
    return null;
  }

  String validatpassword(String value) {
    if (value.length == 0) {
      return 'Enter Password';
    }
    return null;
  }

  static Future<List<String>> getDeviceDetails() async {
    String deviceName;
    String deviceVersion;
    String identifier;
    final DeviceInfoPlugin deviceInfoPlugin = new DeviceInfoPlugin();
    try {
      if (Platform.isAndroid) {
        var build = await deviceInfoPlugin.androidInfo;
        deviceName = build.model;
        deviceVersion = build.version.toString();
        identifier = build.androidId; //UUID for Android
      } else {
        if (Platform.isIOS) {
          var data = await deviceInfoPlugin.iosInfo;
          deviceName = data.name;
          deviceVersion = data.systemVersion;
          identifier = data.identifierForVendor; //UUID for iOS
        }
      }
    } on PlatformException {
      print('Failed to get platform version');
    }

//if (!mounted) return;
    return [deviceName, deviceVersion, identifier];
  }

  TextEditingController textphn = TextEditingController();
  TextEditingController tetpass = TextEditingController();

  Future<String> _getId() async {
    var deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) {
      // import 'dart:io'
      var iosDeviceInfo = await deviceInfo.iosInfo;
      return iosDeviceInfo.identifierForVendor
          .toUpperCase(); // unique ID on iOS
    } else {
      var androidDeviceInfo = await deviceInfo.androidInfo;
      return androidDeviceInfo.androidId.toUpperCase(); // unique ID on Android
    }
  }

  void navigationPage() {
    //  Navigator.of(context).pushReplacementNamed(HOME_SCREEN);
  }

  @override
  Widget build(BuildContext context) {
    pr = new ProgressDialog(context, showLogs: true);
    pr.style(message: 'Please wait...');
    var Height = MediaQuery.of(context).size.height;
    var Width = MediaQuery.of(context).size.width;
    textphn.text = mobileno;

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Container(
            child: Form(
                autovalidateMode: AutovalidateMode.always,
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: Height * 0.08,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Text(
                        "Log In Continue !",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 25,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(30.0),
                      child: Container(
                        height: Height * 0.70,
                        child: Column(
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                        color:
                                            Color.fromRGBO(143, 148, 251, .4),
                                        blurRadius: 20.0,
                                        offset: Offset(0, 10))
                                  ]),
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    padding: EdgeInsets.all(8.0),
                                    decoration: BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                                color: Colors.grey[100]))),
                                    child: TextFormField(
                                      validator: validateMobile,
                                      controller: textphn,
                                      decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(30.0),
                                            borderSide: BorderSide(
                                                color: Colors.blue.shade300),
                                          ),
                                          prefixIcon: IconButton(
                                              icon: Icon(Icons.person,
                                                  color: Colors.greenAccent)),
                                          hintText: mobileno ?? "User Name",
                                          hintStyle: TextStyle(
                                              color: Colors.grey[400])),
                                    ),
                                  ),
                                  SizedBox(
                                    height: Height * 0.02,
                                  ),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Expanded(
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Expanded(child: Text("")),
                                            Expanded(child: Text("")),
                                            Expanded(
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  /*   Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            0.0),
                                                    child: Container(
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                vertical: 6.0,
                                                                horizontal: 8),
                                                        child: Text(" Send OTP",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white)),
                                                      ),
                                                      decoration: BoxDecoration(
                                                        border: Border.all(
                                                          color: Colors
                                                              .greenAccent,
                                                          style:
                                                              BorderStyle.solid,
                                                          width: 1.0,
                                                        ),
                                                        color:
                                                            Colors.greenAccent,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(30.0),
                                                      ),
                                                    ),
                                                  ),
                                           */
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: Height * 0.02,
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(8.0),
                                    child: TextFormField(
                                      validator: validatpassword,
                                      controller: tetpass,
                                      obscureText: !_passwordVisible,
                                      decoration: InputDecoration(
                                          prefixIcon: IconButton(
                                              icon: Icon(Icons.lock,
                                                  color: Colors.greenAccent)),
                                          suffixIcon: IconButton(
                                            icon: Icon(
                                              _passwordVisible
                                                  ? Icons.visibility
                                                  : Icons.visibility_off,
                                              color: Colors.pink,
                                            ),
                                            onPressed: () {
                                              setState(() {
                                                _passwordVisible =
                                                    !_passwordVisible;
                                              });
                                            },
                                          ),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(30.0),
                                            borderSide: BorderSide(
                                                color: Colors.blue.shade300),
                                          ),
                                          hintText: "Password",
                                          hintStyle: TextStyle(
                                              color: Colors.grey[400])),
                                    ),
                                  ),
                                  SizedBox(
                                    height: Height * 0.04,
                                  ),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Expanded(child: Text("")),
                                      Expanded(child: Text("")),
                                      InkWell(
                                        child: Expanded(
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text(
                                                  "Forgot Password?",
                                                  style: kTitleStyle,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        onTap: () {
                                          /*  pr.show();
                                Future.delayed(Duration(seconds: 2)).then((value) {
                                  pr.hide().whenComplete(() {
                                    Navigator.push(context, new MaterialPageRoute(
                                        builder: (context) =>
                                        new ForgotPage(item: mobileno))
                                    );
                                  });
                                });*/
                                        },
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            InkWell(
                              child: Container(
                                height: 50,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    gradient: LinearGradient(colors: [
                                      Colors.greenAccent,
                                      Colors.green
                                    ])),
                                child: Center(
                                  child: Text(
                                    "Login",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                              onTap: () {
                                if (_formKey.currentState.validate()) {
                                  // Fetch Logged in user Id
                                  // int id = await fetchLoggedInUserId();

                                  pr.show();
                                  Future.delayed(Duration(seconds: 0))
                                      .then((value) {
                                    pr.hide().whenComplete(() async {
                                      var auth = await wooCommerce.loginCustomer(
                                              username: textphn.text,
                                              password: tetpass.text);
                                      print(auth.toString());
                                      String t="";
                                      HtmlTags.removeTag(htmlString: auth.toString(), callback: (string) { print(string);
                                      t=string;

                                      },);
                                   //   Map <String ,dynamic> response = jsonDecode(auth.toString());
                                  //    print('ssssssssssssssssssssssssssssssssssssssssssssssssss');
                               //    print('${response.containsKey ('id')}');

                                   if(t=='Unknown username. Check again or try your email address.'||t=='Error: The password you entered for the username ${textphn.text} is incorrect. Lost your password?')  {

                                   pr.hide();  Fluttertoast.showToast(

                                          msg: '${t}',
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.SNACKBAR,
                                          timeInSecForIosWeb: 1,
                                          backgroundColor: Colors.white,
                                          textColor: Colors.pink,
                                          fontSize: 16.0
                                      );}
                                     woocustm.add(auth);

                                      print('vikaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa${woocustm[0].id}');

                                      final isLoggedIn = await wooCommerce.isCustomerLoggedIn();
                                      String authtoken = await wooCommerce.authToken;
                                      print(isLoggedIn);

                                      final prefs =
                                          await SharedPreferences.getInstance();

                                      prefs.setInt('isidtrue', woocustm[0].id);

                                      prefs.setBool('isLoggedIn', isLoggedIn);
                                      AppPreferences.setString(
                                          AppConstants.Token_Data,
                                          authtoken.toString());

                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                HomeScreen()),
                                      );
                                      pr.hide();
                                    });
                                  });
                                }
                              },
                            ),
                            SizedBox(
                              height: 48,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Text(
                                    "Don't Have an account?",
                                    style: kTitleStyle,
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  InkWell(
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                          "Sign Up ",
                                          style: kTitleStylesign,
                                        ),
                                      ],
                                    ),
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                RegistPage()),
                                      );
                                      /*  pr.show();
                                      Future.delayed(Duration(seconds: 2)).then((value) {
                                        pr.hide().whenComplete(() {
                                          Navigator.push(context, new MaterialPageRoute(
                                              builder: (context) =>
                                              new ForgotPage(item: mobileno))
                                          );
                                        });
                                      });*/
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                )),
          ),
        ));
  }
}

class HtmlTags {

  static void removeTag({ htmlString, callback }){
    var document = parse(htmlString);
    String parsedString = parse(document.body.text).documentElement.text;
    callback(parsedString);
  }
}