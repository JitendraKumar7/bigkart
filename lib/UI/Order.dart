import 'dart:convert';
import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:bigkart/app/HttpClient.dart';
import '../Basic.dart';
import 'MyProfile.dart';
import 'Profilemain.dart';

class OrderPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return OrderPageState();
  }
}

class OrderPageState extends State<OrderPage> {
  var mobileno;

List<WooCartItem> cartproducts ;
  Map<String, dynamic> map = new Map();
  WooCommerce wooCommerce = WooCommerce(
    baseUrl: BasicData().baseUrl,
    consumerKey: BasicData().consumerKey,
    consumerSecret: BasicData().consumerSecret,
    isDebug: true,
  );
  getcardproduct() async {
    cartproducts = await wooCommerce.getMyCartItems().then((value) {setState(() {


    }); });
  }
  getcartdeleteProducts() async {
    //  lineitems = new List();
    map = new Map();
    cartproducts = await wooCommerce.getMyCartItems();

    String auth = await wooCommerce.authToken;
    // print('aa${auth}');
    setState(() {

       // print(age.key);

        HttpClient().clearcart( auth.trim().toString()).then((
            value) async {
          setState(() {
            var response = jsonDecode(value);
            print(response);
            //print(lineitems);
          });
        });

    });
  }




  // ProgressDialog pr;
  bool _passwordVisible;
  final kTitleStyle = TextStyle(
      color: Colors.black,
      fontSize: 30.0,
      height: 1.5,
      fontFamily: "Product Sans");
  final kTitleStylesign = TextStyle(
      color: Colors.grey,
      fontSize: 20.0,
      height: 1.5,
      fontFamily: "Product Sans");

  @override
  void initState() {
    _passwordVisible = false;
    getcartdeleteProducts();

    super.initState();
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _load = false;

  String validateMobile(String value) {
    String patttern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
    RegExp regExp = new RegExp(patttern);
    if (value.length == 0) {
      return 'Please enter mobile number';
    } else if (!regExp.hasMatch(value)) {
      return 'Please enter valid mobile number';
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
//    pr = new ProgressDialog(context, showLogs: true);
//    pr.style(message: 'Please wait...');
    var Height = MediaQuery.of(context).size.height;
    var Width = MediaQuery.of(context).size.width;
    textphn.text = mobileno;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: ListView(
          children: [
            SizedBox(height: 20,),
            Container(
              height:200,
              child: Center(
                child: Image(

                  image: AssetImage('assets/imgapp/order.png'),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Order Succesfully",
                style: kTitleStyle,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Thanks for  the order Your order will be parepared with 2/3 days",
                      style: kTitleStylesign,
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(30.0),
              child: Container(
                child: Column(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                                color: Color.fromRGBO(143, 148, 251, .4),
                                blurRadius: 20.0,
                                offset: Offset(0, 10))
                          ]),
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            height: Height * 0.04,
                          ),
                        ],
                      ),
                    ),
                    InkWell(
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            gradient: LinearGradient(
                                colors: [Colors.greenAccent, Colors.green])),
                        child: Center(
                          child: Text(
                            "Continue Shopping",
                            style: TextStyle(
                                color: Colors.white, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      onTap: () async {

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) => HomeScreen()),
                        );
                        /*  pr.show();
                                  Future.delayed(Duration(seconds: 2)).then((value) {
                                    pr.hide().whenComplete(() {
                                      _futureAlbum = createAlbum(textphn.text,
                                          tetpass.text);
                                    });
                                  });

*/

                        //Navigator.of(context).pushReplacementNamed(HOME_SCREEN);
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
