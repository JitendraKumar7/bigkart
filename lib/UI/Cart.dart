import 'dart:convert';

import 'package:bigkart/UI/Order.dart';
import 'package:bigkart/app/AppConstants.dart';
import 'package:bigkart/app/AppPreferences.dart';
import 'package:bigkart/app/Basicdata.dart';
import 'package:getwidget/components/loader/gf_loader.dart';
import 'package:woocommerce/models/cart_item.dart';
import 'package:woocommerce/models/order_payload.dart';
import 'package:woocommerce/models/payment_gateway.dart';
import 'package:woocommerce/woocommerce.dart';

import 'package:bigkart/app/HttpClient.dart';

import '../Basic.dart';
import 'MyProfile.dart';
import 'Paymentgate.dart';
import 'ShipplingAddress.dart';

class Cartmain extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return Cart1main();
  }
}

class Cart1main extends State<Cartmain> {
  List<WooCartItem> cartproducts = new List();
  List<WooCartItem> Cartproductskey = new List();

  WooCommerce wooCommerce = WooCommerce(
    baseUrl: BasicData().baseUrl,
    consumerKey: BasicData().consumerKey,
    consumerSecret: BasicData().consumerSecret,
    isDebug: true,
  );
  Map<String, dynamic> map = new Map();
  var mapvatiation = new Map();
  var totalamount = new Map();
  var totalitems;
  String Authdata;

//  dynamic Authdata;
  WooCustomer user;

  getcartProducts() async {
    cartproducts = await wooCommerce.getMyCartItems();
    map = new Map();
    AppPreferences.getString(AppConstants.Token_Data).then((value) {
      setState(() {
        Authdata = value;
        print(Authdata);
        HttpClient().getcart(value).then((value) {
          setState(() {
            map = jsonDecode(value);


            print("response");
            print(map);
          });
        });

        HttpClient().gettotal(value).then((value) {
          setState(() {
            totalamount = jsonDecode(value);
            print("total");

            print(totalamount['subtotal']);
          });
        });
        HttpClient().gettotalitems(value).then((value) {
          setState(() {
            totalitems = jsonDecode(value);
            print("total items");
            print(totalitems);
            AppPreferences.setString(
                AppConstants.CARt_ITEM, totalitems.toString());
          });
        });
      });
    });

    setState(() {});
  }

  final kTitleStyle = TextStyle(
      color: Colors.black,
      fontSize: 15.0,
      height: 1.5,
      fontFamily: "Product Sans");

  final kSubtitleStyle = TextStyle(
      color: Colors.black,
      fontSize: 16.0,
      height: 1.2,
      fontFamily: "Product Sans");

  TextEditingController textphn = TextEditingController();
  TextEditingController tetpass = TextEditingController();
  int status;
  bool flag = false;

  void navigationPage() {
    // Navigator.of(context).pushReplacementNamed(INT_SCREEN);
  }

  // List<WooCartItem> cartproducts = new List();
  List<WooPaymentGateway> paymentgatemthods = new List();
  List<WooShippingZone> wooShippingZone;
  List<WooCustomer> woocustm = [];
  List<WooOrder> wooorder;
  List<LineItems> lineitems = [];
  Map<String, dynamic> mapget = new Map();

  getcartfinalProducts() async {
    lineitems = new List();
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
                lineitems.add(new LineItems(
                  name: map['${e.key}']['product_name'],
                  productId: map['${e.key}']['product_id'],
                  variationId: map['${e.key}']['variation_id'],
                  quantity: map['${e.key}']['quantity'],
                  total: map['${e.key}']['line_total'].toString(),));

                print("response");
                print("response");
                print("response");
                print("response");
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


    setState(() {
      flag = true;
    });
    print(user);
  }


  Color coronas = Colors.greenAccent;

  @override
  void initState() {
    setState(() {
      getcartProducts();
    });

    super.initState();
  }

  Widget appBarTitle = new Text(
    "My Cart",
    style: TextStyle(
        color: Colors.black,
        fontSize: 15.0,
        height: 1.5,
        fontFamily: "Product Sans"),
  );
  Icon actionIcon = new Icon(Icons.search);

  @override
  Widget build(BuildContext context) {
    var Height = MediaQuery
        .of(context)
        .size
        .height;
    var Width = MediaQuery
        .of(context)
        .size
        .width;

    int Length;

    return Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.greenAccent,
        title: appBarTitle,
        /* actions: <Widget>[
          new IconButton(
            icon: actionIcon,
            onPressed: () {
              setState(() {
                if (this.actionIcon.icon == Icons.search) {
                  this.actionIcon = new Icon(Icons.close);
                  this.appBarTitle = new TextFormField(
                    autofocus: false,
                    decoration: InputDecoration(
                      filled: true,
                      hintText: 'Search Here...',
                      fillColor: Colors.white,
                      prefixIcon: Icon(Icons.search),
                      contentPadding:
                          EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6.0),
                        borderSide: BorderSide(color: Colors.greenAccent),
                      ),
                    ),
                  );
                } else {
                  this.actionIcon = new Icon(Icons.search);
                  this.appBarTitle = new Text("My Cart");
                }
              });
            },
          ),
        ],*/
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () {},
        ),
      ),
      body: cartproducts.isEmpty
          ? Container(
        width: MediaQuery
            .of(context)
            .size
            .height,
        height: MediaQuery
            .of(context)
            .size
            .height,
        child: Center(
          child: new Container(
              margin: EdgeInsets.only(left: 0.0, right: 0, top: 20),
              width: 250.0,
              height: 250.0,
              decoration: new BoxDecoration(
                  shape: BoxShape.circle,
                  image: new DecorationImage(
                      fit: BoxFit.fill,
                      image: new AssetImage('assets/imgapp/cart.png')))),
        ),
      )
          : cartproducts == null
          ? Container(
        width: MediaQuery
            .of(context)
            .size
            .height,
        height: MediaQuery
            .of(context)
            .size
            .height,
        child: Center(
          child: GFLoader(loaderColorOne: Colors.black26),
        ),
      )
          : Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              height: Height * 0.68,
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: cartproducts.length,
                itemBuilder: (context, index) {
                  return
                    map['${cartproducts[index].key}'] == null ? Container(
                      width: MediaQuery
                          .of(context)
                          .size
                          .height,
                      height: MediaQuery
                          .of(context)
                          .size
                          .height,
                      child: Center(
                        child: GFLoader(loaderColorOne: Colors.black26),
                      ),
                    )
                        : cartproducts.isEmpty
                        ? Container(
                      width: MediaQuery
                          .of(context)
                          .size
                          .height,
                      height: MediaQuery
                          .of(context)
                          .size
                          .height,
                      child: Center(
                        child: GFLoader(loaderColorOne: Colors.black26),
                      ),
                    )
                        : Padding(
                      padding: const EdgeInsets.fromLTRB(7, 2, 7, 10),
                      child: InkWell(
                        onTap: () {},
                        child: Card(
                          shadowColor: Colors.grey,
                          child: Container(
                            //    height: 136,
                            width: Width,
                            child: Row(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: [
                                Container(
                                    width: Width * 0.25,
                                    height: 100,
                                    child: Image(
                                      fit: BoxFit.fill,
                                      image: NetworkImage(
                                          cartproducts[index]
                                              .images[0]
                                              .src) ??
                                          NetworkImage(
                                              cartproducts[index]
                                                  .images[0]
                                                  .src),
                                    )),
                                Container(
                                  width: Width * 0.57,
                                  child: Stack(
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding:
                                            const EdgeInsets.all(
                                                4.0),
                                            child: Text(
                                              cartproducts[index].name,
                                              style: kSubtitleStyle,
                                            ),
                                          ),
                                          Padding(
                                              padding:
                                              const EdgeInsets.all(
                                                  4.0),
                                              child: Text(
                                                  '${ map['${cartproducts[index]
                                                      .key}']['variation']['attribute_weight']}')

                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            crossAxisAlignment:
                                            CrossAxisAlignment
                                                .start,
                                            children: [
                                              Padding(
                                                padding:
                                                const EdgeInsets
                                                    .all(4.0),
                                                child: Text(
                                                  '₹${map['${cartproducts[index]
                                                      .key}']['line_total']} ',
                                                  style: kTitleStyle,
                                                ),
                                              ),
                                              SizedBox(
                                                width: Width * 0.06,
                                              ),
                                              Padding(
                                                padding:
                                                const EdgeInsets
                                                    .only(
                                                    left: 5.0,
                                                    top: 0),
                                                child: Container(
                                                  decoration:
                                                  BoxDecoration(
                                                    color:
                                                    Colors.black12,
                                                    border: Border.all(
                                                      color:
                                                      Colors.black,
                                                      style: BorderStyle
                                                          .solid,
                                                      width: 1.0,
                                                    ),
                                                    borderRadius:
                                                    BorderRadius
                                                        .circular(
                                                        5.0),
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                    const EdgeInsets
                                                        .all(2),
                                                    child: InkWell(
                                                        onTap:
                                                            () async {
                                                          String auth =
                                                          await wooCommerce
                                                              .authToken;
                                                          print(
                                                              'aaaaaaaaa${auth}');

                                                          setState(() {
                                                            int value = cartproducts[index]
                                                                .quantity ?? 0;
                                                            cartproducts[index]
                                                                .quantity =
                                                            (value > 1 ? value -
                                                                1 : value);
                                                            // int value = cartproducts[index].quantity--;

                                                            HttpClient()
                                                                .updatetocart(
                                                                cartproducts[index]
                                                                    .key,
                                                                cartproducts[index]
                                                                    .quantity,
                                                                auth)
                                                                .then(
                                                                    (value) {
                                                                  HttpClient()
                                                                      .gettotal(
                                                                      auth
                                                                          .trim()
                                                                          .toString())
                                                                      .then(
                                                                          (
                                                                          value) {
                                                                        setState(
                                                                                () {
                                                                              totalamount =
                                                                                  jsonDecode(
                                                                                      value);
                                                                              print(
                                                                                  "total");
                                                                              print(
                                                                                  totalamount['subtotal']);
                                                                            });
                                                                      });
                                                                  HttpClient()
                                                                      .gettotalitems(
                                                                      auth
                                                                          .trim()
                                                                          .toString())
                                                                      .then(
                                                                          (
                                                                          value) {
                                                                        setState(
                                                                                () {
                                                                              totalitems =
                                                                                  jsonDecode(
                                                                                      value);
                                                                              print(
                                                                                  "total items");
                                                                              print(
                                                                                  totalitems);
                                                                              AppPreferences
                                                                                  .setString(
                                                                                  AppConstants
                                                                                      .CARt_ITEM,
                                                                                  totalitems
                                                                                      .toString());
                                                                            });
                                                                      });
                                                                });
                                                          });
                                                        },
                                                        child: Icon(
                                                          Icons.remove,
                                                          color: Colors
                                                              .black,
                                                          size: 18,
                                                        )),
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                const EdgeInsets
                                                    .only(
                                                    left: 5.0,
                                                    top: 0),
                                                child: Container(
                                                  alignment:
                                                  Alignment.center,
                                                  width: 30,
                                                  decoration:
                                                  BoxDecoration(
                                                    border: Border.all(
                                                      color:
                                                      Colors.black,
                                                      style: BorderStyle
                                                          .solid,
                                                      width: 1.0,
                                                    ),
                                                    borderRadius:
                                                    BorderRadius
                                                        .circular(
                                                        5.0),
                                                  ),
                                                  child: Padding(
                                                      padding:
                                                      const EdgeInsets
                                                          .all(2),
                                                      child: Text(
                                                          cartproducts[
                                                          index]
                                                              .quantity
                                                              .toString())),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                const EdgeInsets
                                                    .only(
                                                    left: 5.0,
                                                    top: 0),
                                                child: Container(
                                                  decoration:
                                                  BoxDecoration(
                                                    color:
                                                    Colors.black12,
                                                    border: Border.all(
                                                      color:
                                                      Colors.black,
                                                      style: BorderStyle
                                                          .solid,
                                                      width: 1.0,
                                                    ),
                                                    borderRadius:
                                                    BorderRadius
                                                        .circular(
                                                        5.0),
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                    const EdgeInsets
                                                        .all(2),
                                                    child: InkWell(
                                                        onTap:
                                                            () async {
                                                          String auth =
                                                          await wooCommerce
                                                              .authToken;
                                                          print('aa${auth}');

                                                          setState(() {
                                                            int value = cartproducts[index]
                                                                .quantity ?? 0;
                                                            cartproducts[index]
                                                                .quantity =
                                                            (value + 1);
                                                            print(
                                                                cartproducts[index]
                                                                    .quantity);
                                                            HttpClient()
                                                                .updatetocart(
                                                                cartproducts[index]
                                                                    .key,
                                                                cartproducts[index]
                                                                    .quantity,
                                                                auth)
                                                                .then(
                                                                    (value) {
                                                                  HttpClient()
                                                                      .gettotal(
                                                                      auth
                                                                          .trim()
                                                                          .toString())
                                                                      .then(
                                                                          (
                                                                          value) {
                                                                        setState(
                                                                                () {
                                                                              totalamount =
                                                                                  jsonDecode(
                                                                                      value);
                                                                              print(
                                                                                  "total");
                                                                              print(
                                                                                  totalamount['subtotal']);
                                                                            });
                                                                      });
                                                                  HttpClient()
                                                                      .gettotalitems(
                                                                      auth
                                                                          .trim()
                                                                          .toString())
                                                                      .then(
                                                                          (
                                                                          value) {
                                                                        setState(
                                                                                () {
                                                                              totalitems =
                                                                                  jsonDecode(
                                                                                      value);
                                                                              print(
                                                                                  "total items");
                                                                              print(
                                                                                  totalitems);
                                                                              AppPreferences
                                                                                  .setString(
                                                                                  AppConstants
                                                                                      .CARt_ITEM,
                                                                                  totalitems
                                                                                      .toString());
                                                                            });
                                                                      });
                                                                });
                                                          });
                                                        },
                                                        child: Icon(
                                                          Icons.add,
                                                          color: Colors
                                                              .black,
                                                          size: 18,
                                                        )),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  width: Width * 0.10,
                                  child: Positioned.fill(
                                      child: Align(
                                        alignment: Alignment.topRight,
                                        child: IconButton(
                                          icon: Icon(
                                              Icons.remove_shopping_cart,
                                              color: Colors.redAccent),
                                          onPressed: () async {
                                            /* wooCommerce.post('/wp-json/wc/store/cart/items', { 'id': 860,
                                          'quantity' : 2,});*/
                                            String auth =
                                            await wooCommerce.authToken;
                                            print(
                                                'aa${auth}');

                                            HttpClient().removetocart(cartproducts[index].key, auth.trim().toString()).then((value) async {
                                              setState(() {
                                                var response =
                                                jsonDecode(value);

                                                print(response);
                                                cartproducts
                                                    .removeAt(index);
                                                HttpClient()
                                                    .gettotal(auth
                                                    .trim()
                                                    .toString())
                                                    .then((value) {
                                                  setState(() {
                                                    totalamount =
                                                        jsonDecode(value);
                                                    print("total");
                                                    print(totalamount[
                                                    'subtotal']);
                                                  });
                                                });
                                                HttpClient()
                                                    .gettotalitems(auth
                                                    .trim()
                                                    .toString())
                                                    .then((value) {
                                                  setState(() {
                                                    totalitems =
                                                        jsonDecode(value);
                                                    print("total items");
                                                    print(totalitems);
                                                    AppPreferences.setString(
                                                        AppConstants
                                                            .CARt_ITEM,
                                                        totalitems
                                                            .toString());
                                                  });
                                                });
                                              });

                                              cartproducts =
                                              await wooCommerce
                                                  .getMyCartItems();
                                            });
                                            //   print(  https.post('https://bigkart.in/wp-json/cocart/v1/add-item',{"product_id": "837", "quantity": "15"}));

                                            //  text:''
                                          },
                                        ),
                                      )),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                },
              ),
            ),
            Container(
              alignment: Alignment.bottomCenter,
              height: Width * 0.20,
              color: Colors.white,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 10),
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: totalitems != 0
                                ? Text(
                              "Total Items: ${totalitems}",
                              style: kSubtitleStyle,
                            )
                                : Text("0"),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: totalamount['subtotal'] != null
                                ? Text(
                                'Total price:${totalamount['subtotal']}')
                                : Text("0"),
                          )
                        ],
                      )),
                  Expanded(
                    child: InkWell(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12.0),
                        child: Container(
                          height: 40,
                          width: 30,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              gradient: LinearGradient(colors: [
                                Colors.red,
                                Colors.redAccent
                              ])),
                          child: Center(
                            child: Text(
                              "Buy Now",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                      onTap: () async {
                        getcartfinalProducts().then((value) async {
                        var output = await wooCommerce
                            .createOrder(WooOrderPayload(
                        paymentMethod:
                        "Cash On Delivery",
                        billing: WooOrderPayloadBilling(
                        firstName:user.shipping.firstName,
                        lastName:user.billing.lastName,
                        city: user.shipping.city,
                        state: user.shipping.state,
                        address1: user.shipping.address1,
                        address2:user.shipping.address2,
                        postcode: user.shipping.postcode,
                        ),
                        customerId: status,
                        shipping:
                        WooOrderPayloadShipping(
                        firstName:user.shipping.firstName,
                        lastName:user.billing.lastName,
                        city: user.shipping.city,
                        state: user.shipping.state,
                        address1: user.shipping.address1,
                        address2:user.shipping.address2,
                        postcode: user.shipping.postcode,
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

                        Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => OrderPage()),);});

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
            )
          ],
        ),
      ),
    );
  }
}
