import 'dart:convert';

import 'package:bigkart/app/Basicdata.dart';
import 'package:country_state_city_picker/country_state_city_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:woocommerce/models/customer.dart';
import 'package:woocommerce/woocommerce.dart';
import 'package:bigkart/app/HttpClient.dart';
import '../Basic.dart';

class RegistPage extends StatefulWidget {
  final String item;

  const RegistPage({Key key, this.item}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return RegistPage1();
  }
}

class RegistPage1 extends State<RegistPage> {
  dynamic Authdata;
  WooCustomer user;

  // List<WooProduct> featuredProducts = [];
  WooCommerce wooCommerce = WooCommerce(
    baseUrl: BasicData().baseUrl,
    consumerKey: BasicData().consumerKey,
    consumerSecret: BasicData().consumerSecret,
    isDebug: true,
  );

  getcartProducts() async {}

  var mobileno;

  // ProgressDialog pr;
  bool _passwordVisible;
  TextEditingController tname = TextEditingController();
  TextEditingController tpaswd = TextEditingController();
  TextEditingController temail = TextEditingController();
  TextEditingController tmobile = TextEditingController();
  TextEditingController tcity = TextEditingController();
  TextEditingController tpostcode = TextEditingController();
  TextEditingController tstate = TextEditingController();
  TextEditingController tstreetAddress = TextEditingController();
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
  Map map = new Map();

  @override
  void initState() {
    _passwordVisible = false;
    mobileno = widget.item;

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

  String validatename(String value) {
    if (value.length == 0) {
      return 'Enter Your first Name';
    }
    return null;
  }

  String validatelname(String value) {
    if (value.length == 0) {
      return 'Enter Your  Name';
    }
    return null;
  }

  String validateemail(String value) {
    if (value.length == 0) {
      return 'Please enter email';
    }

    return null;
  }
  String countryValue;
  String stateValue;
  String cityValue;
  @override
  @override
  Widget build(BuildContext context) {
    //   pr = new ProgressDialog(context, showLogs: true);
    // pr.style(message: 'Please wait...');

    var Height = MediaQuery.of(context).size.height;
    var Width = MediaQuery.of(context).size.width;
    //  textphn.text=mobileno;

    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Sign up to  Continue !",
            style: TextStyle(
                color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.white,
          leading: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        body: Center(
          child: SingleChildScrollView(
            child: Container(
              child: Form(
                autovalidateMode: AutovalidateMode.always,
                key: _formKey,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 5),
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
                              Container(
                                padding: EdgeInsets.all(8.0),
                                decoration: BoxDecoration(
                                    border: Border(
                                        bottom:
                                            BorderSide(color: Colors.grey[100]))),
                                child: TextFormField(
                                  validator: validatelname,
                                  controller: tname,
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30.0),
                                        borderSide: BorderSide(
                                            color: Colors.blue.shade300),
                                      ),
                                      prefixIcon: IconButton(
                                          icon: Icon(Icons.person,
                                              color: Colors.greenAccent)),
                                      hintText: mobileno ?? "Your Name",
                                      hintStyle:
                                          TextStyle(color: Colors.grey[400])),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(8.0),
                                decoration: BoxDecoration(
                                    border: Border(
                                        bottom:
                                            BorderSide(color: Colors.grey[100]))),
                                child: TextFormField(
                                  validator: validateMobile,
                                  controller: tmobile,
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30.0),
                                        borderSide: BorderSide(
                                            color: Colors.blue.shade300),
                                      ),
                                      prefixIcon: IconButton(
                                          icon: Icon(Icons.phone,
                                              color: Colors.greenAccent)),
                                      hintText: mobileno ?? "Mobile No.",
                                      hintStyle:
                                          TextStyle(color: Colors.grey[400])),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(8.0),
                                decoration: BoxDecoration(
                                    border: Border(
                                        bottom:
                                            BorderSide(color: Colors.grey[100]))),
                                child: TextFormField(
                                  validator:validateemail ,
                                  controller: temail,
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30.0),
                                        borderSide: BorderSide(
                                            color: Colors.blue.shade300),
                                      ),
                                      prefixIcon: IconButton(
                                          icon: Icon(Icons.email,
                                              color: Colors.greenAccent)),
                                      hintText: mobileno ?? "Email Address",
                                      hintStyle:
                                          TextStyle(color: Colors.grey[400])),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(8.0),
                                child: TextFormField(
                                  validator: validatpassword,
                                  controller: tpaswd,
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
                                            _passwordVisible = !_passwordVisible;
                                          });
                                        },
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30.0),
                                        borderSide: BorderSide(
                                            color: Colors.blue.shade300),
                                      ),
                                      hintText: "Password",
                                      hintStyle:
                                          TextStyle(color: Colors.grey[400])),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(4.0),
                                decoration: BoxDecoration(
                                    border: Border(
                                        bottom:
                                            BorderSide(color: Colors.grey[100]))),
                                child: TextFormField(

                                  controller: tstreetAddress,
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30.0),
                                        borderSide: BorderSide(
                                            color: Colors.blue.shade300),
                                      ),
                                      prefixIcon: IconButton(
                                          icon: Icon(Icons.map,
                                              color: Colors.greenAccent)),
                                      hintText: "Street Address.",
                                      hintStyle:
                                          TextStyle(color: Colors.grey[400])),
                                ),
                              ),


                  Container(
                                padding: EdgeInsets.all(4.0),
                                decoration: BoxDecoration(
                                    border: Border(
                                        bottom:
                                            BorderSide(color: Colors.grey[100]))),
                                child: TextFormField(

                                  controller: tstate,
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30.0),
                                        borderSide: BorderSide(
                                            color: Colors.blue.shade300),
                                      ),
                                      prefixIcon: IconButton(
                                          icon: Icon(Icons.location_on_outlined,
                                              color: Colors.greenAccent)),
                                      hintText: "State",
                                      hintStyle:
                                          TextStyle(color: Colors.grey[400])),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(4.0),
                                decoration: BoxDecoration(
                                    border: Border(
                                        bottom:
                                            BorderSide(color: Colors.grey[100]))),
                                child: TextFormField(

                                  controller: tcity,
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30.0),
                                        borderSide: BorderSide(
                                            color: Colors.blue.shade300),
                                      ),
                                      prefixIcon: IconButton(
                                          icon: Icon(Icons.location_city,
                                              color: Colors.greenAccent)),
                                      hintText: "City",
                                      hintStyle:
                                          TextStyle(color: Colors.grey[400])),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(4.0),
                                decoration: BoxDecoration(
                                    border: Border(
                                        bottom:
                                            BorderSide(color: Colors.grey[100]))),
                                child: TextFormField(

                                  controller: tpostcode,
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30.0),
                                        borderSide: BorderSide(
                                            color: Colors.blue.shade300),
                                      ),
                                      prefixIcon: IconButton(
                                          icon: Icon(
                                              Icons.local_activity_outlined,
                                              color: Colors.greenAccent)),
                                      hintText: "Post Code",
                                      hintStyle:
                                          TextStyle(color: Colors.grey[400])),
                                ),
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
                                gradient: LinearGradient(
                                    colors: [Colors.greenAccent, Colors.green])),
                            child: Center(
                              child: Text(
                                "Sign Up",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          onTap: () async {
    if (_formKey.currentState.validate()) {

      /*   user = WooCustomer(
                                username: tname.text,
                                password: tpaswd.text,
                                email: temail.text,
                              /*  shipping: Shipping(
                                    city: tcity.text,
                                    address1: tstreetAddress.text,
                                    firstName: tname.text,
                                    state: tstate.text,
                                    postcode: tpostcode.text,
                                    country: "india")*/
                            );
                            final result = wooCommerce.createCustomer(user);*/

      HttpClient().createcustomer(
          tpaswd.text,
          temail.text,
          tname.text,
          tmobile.text,
          tcity.text,
          tstate.text,
          tstreetAddress.text,
          tpostcode.text


      ).then((value) {
        setState(() {
          Map <String ,dynamic> response = jsonDecode(value);
          response.containsKey ('message');
          print("vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv");
          print('${ response.containsKey ('message')}'
          );if( response.containsKey ('message')==false){
            Fluttertoast.showToast(
                msg: "Succesfully Registered",
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.SNACKBAR,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.black,
                textColor: Colors.white,
                fontSize: 16.0
            );



            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => LoginPage()),
            );}else{
            Fluttertoast.showToast(
                msg: '${response['message']}',
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.SNACKBAR,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.black,
                textColor: Colors.white,
                fontSize: 16.0
            );
          }

        });
      });

      /*final result   =  wooCommerce.post('/wp-json/wc/v3/customers',
                            {"username":tname.text,
                              "email":temail.text,

                              "first_name": tname.text,
                              "billing": {

                                "city": tcity.text,
                                "country": "India",
                                "postcode": tpostcode.text,
                                "state": tstate.text,
                                "address_1": tstreetAddress.text,



                              },
                              "shipping": {
                                "city": tcity.text,
                                "country": "India",
                                "postcode": tpostcode.text,
                                "state": tstate.text,
                                "address_1": tstreetAddress.text,

                              }
                            });*/

      //   print('vikaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa${result}');

      /*  pr.show();
                                  Future.delayed(Duration(seconds: 2)).then((value) {
                                    pr.hide().whenComplete(() {
                                      _futureAlbum = createAlbum(textphn.text,
                                          tetpass.text);
                                    });
                                  });

*/

      //Navigator.of(context).pushReplacementNamed(HOME_SCREEN);
    } },
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Text(
                                "Have an account?",
                                style: kTitleStyle,
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              InkWell(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      "Login ",
                                      style: kTitleStylesign,
                                    ),
                                  ],
                                ),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            LoginPage()),
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
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ));
  }
}
