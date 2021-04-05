import 'dart:convert';
import 'package:bigkart/app/AppConstants.dart';
import 'package:bigkart/app/AppPreferences.dart';
import 'package:bigkart/app/HttpClient.dart';
import 'package:bigkart/UI/Order.dart';
import 'package:bigkart/UI/Paymentgate.dart';
import 'package:bigkart/app/Basicdata.dart';
import 'package:getwidget/getwidget.dart';
import 'package:woocommerce/models/customer.dart';
import 'package:woocommerce/models/order_payload.dart';
import 'package:woocommerce/models/payment_gateway.dart';
import 'package:woocommerce/woocommerce.dart';

import '../Basic.dart';

class ShippingPage extends StatefulWidget {
  final String item;

  const ShippingPage({Key key, this.item}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return ShippingPageState();
  }
}

class ShippingPageState extends State<ShippingPage> {
  dynamic Authdata;
  WooCustomer user;
  int status;
  bool flag = false;

  // List<WooProduct> featuredProducts = [];
  WooCommerce wooCommerce = WooCommerce(
    baseUrl: BasicData().baseUrl,
    consumerKey: BasicData().consumerKey,
    consumerSecret: BasicData().consumerSecret,
    isDebug: true,
  );
  List<WooCartItem> cartproducts = new List();
  List<WooPaymentGateway> paymentgatemthods = new List();
  List<WooShippingZone> wooShippingZone;
  List<WooCustomer> woocustm = [];
  List<WooOrder> wooorder;
  List<LineItems> lineitems= [];
  Map<String ,dynamic> mapget= new Map();
  var totalamount, totalitems;
  getcartProducts() async {

    lineitems= new List();
    map = new Map();
    cartproducts = await wooCommerce.getMyCartItems();



        AppPreferences.getString(AppConstants.Token_Data).then((value) {
          setState(() {
         //   Authdata = value;
            //print(Authdata);
            HttpClient().getcart(value).then((value) {

              setState(() {
                map = jsonDecode(value);

                cartproducts.map((e) {
                  setState(() {
                    lineitems.add(new LineItems(name: map['${e.key}']['product_name'],productId: map['${e.key}']['product_id'],variationId:map['${e.key}']['variation_id'],quantity:map['${e.key}']['quantity'],total:map['${e.key}']['line_total'].toString(),   ));

                    print("response");
                    print("response");
                    print("response"); print("response");
                    print("response");

                    print(lineitems);
                  });
                }).toList();

              });
            });

      //  lineitems.add(new LineItems(variationId:,quantity: ,productId:  ));
      });
    });








    SharedPreferences prefs = await SharedPreferences.getInstance();
    status = prefs.getInt('isidtrue');
    print(status);
    user = await wooCommerce.getCustomerById(id: status);
    tfname.text = user.billing.firstName;
    tlname.text = user.billing.lastName;
    tmobile.text = user.billing.phone;
    temail.text = user.billing.email;
    tstate.text = user.billing.state;
    tpostcode.text = user.billing.postcode;
    tcountry.text = user.billing.country;
    tcity.text = user.billing.city;
    tstreetAddress.text = user.billing.address2;
    tstreetAddress2.text = user.billing.address2;

    setState(() {
      flag = true;
    });
    print(user);
  }

  var mobileno;

  // ProgressDialog pr;
  bool _passwordVisible;
  TextEditingController tfname = TextEditingController();
  TextEditingController tlname = TextEditingController();
  TextEditingController temail = TextEditingController();
  TextEditingController tmobile = TextEditingController();
  TextEditingController tcity = TextEditingController();
  TextEditingController tstreetAddress = TextEditingController();
  TextEditingController tstreetAddress2 = TextEditingController();
  TextEditingController tpostcode = TextEditingController();
  TextEditingController tstate = TextEditingController();
  TextEditingController tcountry = TextEditingController();

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
    getcartProducts();

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
      return 'Enter Your last Name';
    }
    return null;
  }

  String validateemail(String value) {
    if (value.length == 0) {
      return 'Please enter email';
    }

    return null;
  }

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
            "Confirm Address ",
            style: TextStyle(
                color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        backgroundColor: Colors.white,
        body: flag == false
            ? Container(
                width: MediaQuery.of(context).size.height,
                height: MediaQuery.of(context).size.height,
                child: Center(
                  child: GFLoader(loaderColorOne: Colors.greenAccent),
                ),
              )
            : SingleChildScrollView(
                child: Container(
                  child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.fromLTRB(30.0, 10, 30, 0),
                            child: Container(
                              height: Height * 0.80,
                              child: ListView(
                                children: <Widget>[
                                  Container(
                                    padding: EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(10),
                                        boxShadow: [
                                          BoxShadow(
                                              color: Color.fromRGBO(
                                                  143, 148, 251, .4),
                                              blurRadius: 20.0,
                                              offset: Offset(0, 10))
                                        ]),
                                    child: Column(
                                      children: <Widget>[
                                        Container(
                                          padding: EdgeInsets.all(4.0),
                                          decoration: BoxDecoration(
                                              border: Border(
                                                  bottom: BorderSide(
                                                      color:
                                                      Colors.grey[100]))),
                                          child: TextFormField(
                                            validator: validateMobile,
                                            controller: tstate,
                                            decoration: InputDecoration(
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                  BorderRadius.circular(
                                                      30.0),
                                                  borderSide: BorderSide(
                                                      color:
                                                      Colors.blue.shade300),
                                                ),
                                                prefixIcon: IconButton(
                                                    icon: Icon(
                                                        Icons
                                                            .location_on_outlined,
                                                        color: Colors
                                                            .greenAccent)),
                                                hintText: "State",
                                                hintStyle: TextStyle(
                                                    color: Colors.grey[400])),
                                          ),
                                        ),
                                        Container(
                                          padding: EdgeInsets.all(4.0),
                                          decoration: BoxDecoration(
                                              border: Border(
                                                  bottom: BorderSide(
                                                      color:
                                                          Colors.grey[100]))),
                                          child: TextFormField(
                                            validator: validateMobile,
                                            controller: tcity,
                                            decoration: InputDecoration(
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          30.0),
                                                  borderSide: BorderSide(
                                                      color:
                                                          Colors.blue.shade300),
                                                ),
                                                prefixIcon: IconButton(
                                                    icon: Icon(
                                                        Icons.location_city,
                                                        color: Colors
                                                            .greenAccent)),
                                                hintText: "City",
                                                hintStyle: TextStyle(
                                                    color: Colors.grey[400])),
                                          ),
                                        ),
                                        Container(
                                          padding: EdgeInsets.all(4.0),
                                          decoration: BoxDecoration(
                                              border: Border(
                                                  bottom: BorderSide(
                                                      color:
                                                          Colors.grey[100]))),
                                          child: TextFormField(
                                            validator: validateMobile,
                                            controller: tstreetAddress,
                                            decoration: InputDecoration(
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          30.0),
                                                  borderSide: BorderSide(
                                                      color:
                                                          Colors.blue.shade300),
                                                ),
                                                prefixIcon: IconButton(
                                                    icon: Icon(Icons.map,
                                                        color: Colors
                                                            .greenAccent)),
                                                hintText: "Street Address.",
                                                hintStyle: TextStyle(
                                                    color: Colors.grey[400])),
                                          ),
                                        ),
                                        Container(
                                          padding: EdgeInsets.all(4.0),
                                          decoration: BoxDecoration(
                                              border: Border(
                                                  bottom: BorderSide(
                                                      color:
                                                          Colors.grey[100]))),
                                          child: TextFormField(
                                            validator: validateMobile,
                                            controller: tpostcode,
                                            decoration: InputDecoration(
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          30.0),
                                                  borderSide: BorderSide(
                                                      color:
                                                          Colors.blue.shade300),
                                                ),
                                                prefixIcon: IconButton(
                                                    icon: Icon(
                                                        Icons
                                                            .local_activity_outlined,
                                                        color: Colors
                                                            .greenAccent)),
                                                hintText: "Post Code",
                                                hintStyle: TextStyle(
                                                    color: Colors.grey[400])),
                                          ),
                                        ),

                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 60,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 0.0, horizontal: 60),
                                    child: InkWell(
                                      child: Container(
                                        height: 50,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            gradient: LinearGradient(colors: [
                                              Colors.greenAccent,
                                              Colors.green
                                            ])),
                                        child: Center(
                                          child: Text(
                                            "Continue",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                      onTap: () async {
                                        wooCommerce.updateCustomer(id: status, data: {
                                          "billing": {
                                            "city": tcity.text,
                                            "country": "India",
                                            "postcode": tpostcode.text,
                                            "state": tstate.text,
                                            "address_1": tstreetAddress.text,
                                            "address_2": tstreetAddress.text,
                                          },
                                          "shipping": {
                                            "city": tcity.text,
                                            "country": "India",
                                            "postcode": tpostcode.text,
                                            "state": tstate.text,
                                            "address_1": tstreetAddress.text,
                                            "address_2": tstreetAddress.text,
                                          }
                                        })
                                            .then((value) async {
                                          var output = await wooCommerce
                                              .createOrder(WooOrderPayload(
                                              paymentMethod:
                                              "Cash On Delivery",
                                              billing: WooOrderPayloadBilling(
                                                firstName:
                                                user.shipping.firstName,
                                                lastName:
                                                user.billing.lastName,
                                                city: tcity.text,
                                                state: tstate.text,
                                                address1: tstreetAddress.text,
                                                postcode: tpostcode.text,
                                              ),
                                              customerId: status,
                                              shipping:
                                              WooOrderPayloadShipping(
                                                firstName:
                                                user.shipping.firstName,
                                                lastName:
                                                user.billing.lastName,
                                                city: tcity.text,
                                                state: tstate.text,
                                                address1: tstreetAddress.text,
                                                postcode: tpostcode.text,
                                              ),
                                              lineItems: lineitems));
                                          wooorder = new List();
                                          wooorder.add(output);
                                          print(output);

                                          /* final response = await wooCommerce.put("wp-json/wc/v3/customers/5",  {
      "first_name": "Vikas Yadav",
      "billing": {
        "first_name": "Vikas Billing"
      },
      "shipping": {
        "first_name": "Vikas Shipping"
      }
    });*/

                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (BuildContext context) =>
                                                    OrderPage()),
                                          );
                                        });



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
