import 'dart:convert';
import 'package:bigkart/app/AppConstants.dart';
import 'package:bigkart/app/AppPreferences.dart';
import 'package:bigkart/app/ProductModel.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:getwidget/getwidget.dart';
import 'package:bigkart/UI/Catogries.dart';
import 'package:bigkart/UI/SeeAll.dart';
import 'package:bigkart/app/Basicdata.dart';
import 'package:bigkart/app/HttpClient.dart';

import 'package:bigkart/model/Items.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shimmer/shimmer.dart';
import 'package:woocommerce/models/product_variation.dart';
import 'package:woocommerce/models/products.dart';
import 'package:woocommerce/woocommerce.dart';

import '../Basic.dart';
import 'DetailScreen.dart';
import 'MyAddress.dart';
import 'MyProfile.dart';

class Homemain extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return Home1main();
  }
}

class Home1main extends State<Homemain> {
  List<WooProductCategory> cartproductscat = new List();
  List<WooProduct> products = [];
  String  desc;
  bool flagchhose= false;
  List<String> _option = new List();
  List<String> dropvalue = new List();
  List<WooProductVariationAttribute> woopa = [];
  List<ProductModel> productmodel = new List();
  List<TextEditingController> _listItem = List();
  WooCustomer woocustm;
  List<WooProductVariation> Selectiondropdown = new List();
  List<List<WooProductVariation>> listvariaton = [];
  WooCommerce wooCommerce = WooCommerce(
    baseUrl: BasicData().baseUrl,
    consumerKey: BasicData().consumerKey,
    consumerSecret: BasicData().consumerSecret,
    isDebug: true,
  );
  ProgressDialog pr;
  WooProductVariation wooProductVariation;
  WooCustomer woouserbyid;List<WooCartItem>cartproducts;
  var totalamount = new Map();
  var totalitems;
  WooProductVariationAttribute wooProductVariationAttribute;
  List<List<String>> pricevar = new List();
  bool flag = false;
String cartproductname="";
  getcartProducts() async {
    cartproducts = await wooCommerce.getMyCartItems();
   // map = new Map();
    AppPreferences.getString(AppConstants.Token_Data).then((value) {
      setState(() {
        cartproducts.map((e) {
          cartproductname= cartproductname+","+e.name;
        }).toList();
     var   Authdata = value;
        print(Authdata);
        HttpClient().getcart(value).then((value) {
          setState(() {
         //   map = jsonDecode(value);


            print("response");
          //  print(map);
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
  getProducts() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var status = prefs.getInt('isidtrue');
    print(status);
    woouserbyid = await wooCommerce.getCustomerById(id: status);
    //  cartproductscat= await wooCommerce.getProductCategories();

    setState(() {
      flag = true;
    });
    products = await wooCommerce.getProducts();
    cartproductscat = await wooCommerce.getProductCategories();
    // productsvariant = await wooCommerce.getProductVariations(productId: 857);
    setState(() {});
    // print(productsvariant);
  }

  final kTitleStyle = TextStyle(
      color: Colors.black,
      fontSize: 16.0,
      fontWeight: FontWeight.bold,
      height: 1.0,
      fontFamily: "Product Sans");
  final kcattleStyle = TextStyle(
      color: Color(0xFF00C853),
      fontSize: 14.0,
      fontWeight: FontWeight.bold,
      height: 1.5,
      fontFamily: "Product Sans");
  List<Widget> _childrenlink = List();
  final kSubtitleStyle = TextStyle(
      color: Colors.black,
      fontSize: 16.0,
      fontWeight: FontWeight.bold,
      height: 1.2,
      fontFamily: "Product Sans");
  final kdescStyle = TextStyle(
      color: Colors.grey,
      fontSize: 12.0,
      fontWeight: FontWeight.bold,
      height: 1.2,
      fontFamily: "Product Sans");
  final kwStyle = TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.bold,
      fontSize: 12.0,
      height: 1.2,
      fontFamily: "Product Sans");
  final kcStyle = TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.bold,
      fontSize: 11.0,
      height: 1.2,
      fontFamily: "Product Sans");
  final kButtonStyle = TextStyle(
      color: Colors.white,
      fontSize: 15.0,
      height: 1.2,
      fontWeight: FontWeight.bold,
      fontFamily: "Product Sans");
  TextEditingController textphn = TextEditingController();
  TextEditingController tetpass = TextEditingController();

  int count = 0;

 // String dropdownValue = "Choose";
  Color coronas = Colors.lightBlue;

  @override
  void initState() {
    super.initState();
    getcartProducts();
    getProducts();
  }

  Future<void> varantionfunction(int id, int index) async {
    woopa = new List();

    listvariaton[id] = await wooCommerce.getProductVariations(productId: id);
  //if(dropvalue[index].isNotEmpty){  dropvalue[index] = "Start at " + products[index].price;};
    setState(() {
      listvariaton[id].map((e) {
        setState(() {
          Selectiondropdown.add(e);
          flagchhose=true;
        });


      }).toList();
    });

    print('vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv');
    print(listvariaton[id][0]);
  }

  @override
  Widget build(BuildContext context) {
    pr = new ProgressDialog(context, showLogs: true);
    pr.style(message: 'Please wait...');
    var Height = MediaQuery.of(context).size.height;
    var Width = MediaQuery.of(context).size.width;
    for (int i = 0; i < products.length; i++)
      _listItem.add(TextEditingController(text: 1.toString()));
    for (int i = 0; i < 500; i++) listvariaton.add(List());
    for (int i = 0; i < 500; i++) dropvalue.add("");
    for (int i = 0; i < 500; i++) Selectiondropdown.add(wooProductVariation);

    return Scaffold(
        drawer: Drawer(
          child: ListView(
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            children: [
              new Center(
                  child: new Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Stack(
                    children: [
                      new Container(
                        margin: EdgeInsets.only(left: 0.0, right: 0, top: 20),
                        width: 120.0,
                        height: 120.0,
                        child: Icon(
                          Icons.person,
                          size: 120,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  flag == true
                      ? Container(
                          child: new Text(
                            '${woouserbyid.firstName} ${woouserbyid.lastName} ' ??
                                "",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: Colors.black,
                                fontFamily: "Product Sans"),
                          ),
                        )
                      : Container(),
                  flag == true
                      ? Container(
                          child: new Text(
                            woouserbyid.email ?? "",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: Colors.black,
                                fontFamily: "Product Sans"),
                          ),
                        )
                      : Container(),
                  SizedBox(
                    height: 10,
                  ),
                  Divider(
                    thickness: 2,
                  ),
                ],
              )),
              ListTile(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => Profile()),
                  );
                },
                leading: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Color(0xFFB9F6CA),
                        style: BorderStyle.solid,
                        width: 1.0,
                      ),
                      color: Color(0xFFB9F6CA),
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(Icons.person, color: Colors.lightGreen),
                    )),
                title: Text(
                  "My Profile",
                  style: kSubtitleStyle,
                ),
                trailing: Icon(Icons.arrow_forward_ios),
              ),
              Divider(
                height: 2,
              ),
              ListTile(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => MyAddressPage()),
                  );
                },
                leading: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Color(0xFFC8E6C9),
                        style: BorderStyle.solid,
                        width: 1.0,
                      ),
                      color: Color(0xFFC8E6C9),
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(Icons.location_on, color: Colors.green),
                    )),
                title: Text(
                  "My Address",
                  style: kSubtitleStyle,
                ),
                trailing: Icon(Icons.arrow_forward_ios),
              ),
              Divider(
                height: 2,
              ),
              ListTile(
                onTap: () async {
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();

                  setState(() {
                    var logout = wooCommerce.logUserOut();
                    prefs.remove('isLoggedIn');
                    pr.show();
                    Future.delayed(Duration(seconds: 2)).then((value) {
                      pr.hide().whenComplete(() {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) => LoginPage()),
                        );
                      });
                    });
                  });

                  // print(logout.toString());
                },
                leading: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Color(0xFFFF80AB),
                        style: BorderStyle.solid,
                        width: 1.0,
                      ),
                      color: Color(0xFFFF80AB),
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.logout,
                        color: Colors.pink,
                      ),
                    )),
                title: Text(
                  "Logout",
                  style: kSubtitleStyle,
                ),
                trailing: Icon(Icons.arrow_forward_ios),
              ),
              Divider(),
              Center(
                child: Text(
                  "version 1.0.1",
                  style: kTitleStyle,
                ),
              ),
            ],
          ),
        ),
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.green),
          backgroundColor: Colors.white,
          centerTitle: true,
        ),
        body: cartproductscat == null
            ? Container(
                width: MediaQuery.of(context).size.height,
                height: MediaQuery.of(context).size.height,
                child: Center(
                  child: GFLoader(loaderColorOne: Colors.black26),
                ),
              )
            : cartproductscat.isEmpty
                ? Container(
                    width: MediaQuery.of(context).size.height,
                    height: MediaQuery.of(context).size.height,
                    child: Center(
                      child: GFLoader(loaderColorOne: Colors.black26),
                    ),
                  )
                : ListView(
                    children: [
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                    left: 10,
                                  ),
                                  child: Container(
                                    child: new Text(
                                      "Categories",
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                          color: Colors.black,
                                          fontFamily: "Product Sans"),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              SeeAll(
                                                id: 72,
                                              )),
                                    );
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 8.0),
                                    child: Container(
                                      child: new Text(
                                        "See All",
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                            fontWeight: FontWeight.normal,
                                            fontSize: 18,
                                            color: Color(0xFF00C853),
                                            fontFamily: "Product Sans"),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      Container(
                        height: 60,
                        child: ListView(
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            children: cartproductscat.map((e) {
                              return InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            SeeAll(id: e.id)),
                                  );
                                },
                                child:
                                    /*new Container(
                                        margin: EdgeInsets.only(
                                            left: 0.0, right: 0, top: 20),
                                        width: 50.0,
                                        height: 50.0,
                                        decoration: new BoxDecoration(
                                            shape: BoxShape.circle,
                                            image: new DecorationImage(
                                                fit: BoxFit.fill,
                                                image: new AssetImage(
                                                    'assets/imgapp/icn5.png')))),*/

                                    Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10.0, top: 8, bottom: 12),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Color(0xFF00C853),
                                        style: BorderStyle.solid,
                                        width: 1.0,
                                      ),
                                      borderRadius: BorderRadius.circular(5.0),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(4),
                                      child: Text(
                                        e.name.replaceAll('&amp;', '&'),
                                        style: kcattleStyle,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }).toList()),
                      ),
                      Divider(
                        height: 2,
                        color: Colors.grey,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          child: new Text(
                            "Products",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: Colors.black,
                                fontFamily: "Product Sans"),
                          ),
                        ),
                      ),
                      Divider(
                        height: 2,
                        color: Colors.grey,
                      ),
                      Container(
                        height: Height * 0.60,
                        child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: products.length,
                          itemBuilder: (context, index) {


        HtmlTags.removeTag(htmlString: products[index].description.toString(), callback: (string) {
      print(string);
      desc = string;
    });


    if (products[index].type == 'variable') {
                              if (listvariaton[products[index].id].length ==
                                  0) {
                                varantionfunction(products[index].id, index);
                              }
                            }

                            print(listvariaton[products[index].id]);
                            _listItem[index].addListener(() {});
                            return
                            Padding(
                              padding: const EdgeInsets.fromLTRB(7, 2, 7, 10),
                              child:
                              InkWell(
                                onTap: () {},
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Card(
                                      shadowColor: Colors.grey,
                                      child: Container(
                                        //    height: 136,
                                        width: Width,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                    width: Width * 0.25,
                                                    height: 100,
                                                    child: Image(
                                                      fit: BoxFit.fill,
                                                      image: NetworkImage(
                                                              products[index]
                                                                  .images[0]
                                                                  .src) ??
                                                          NetworkImage(
                                                              products[index]
                                                                  .images[0]
                                                                  .src),
                                                    )),
                                                Container(
                                                  width: Width * 0.67,


                                                   child:   Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Padding(
                                                            padding:
                                                            const EdgeInsets.only(left:4,top:4.0),
                                                            child: Text(
                                                              products[index].categories[0].name.replaceAll('&amp;', '&'),
                                                              style: kdescStyle,
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(0.0),
                                                            child: Text(
                                                              products[index]
                                                                  .name
                                                                  .toString(),
                                                              style:
                                                                  kSubtitleStyle,
                                                            ),
                                                          ),
                                                          products[index]
                                                                      .type ==
                                                                  'variable'
                                                              ? Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          8.0),
                                                                  child:listvariaton[products[index].id].isNotEmpty?
                                                                  Row(
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .center,
                                                                    children: [
                                                                      Container(
                                                                        child:
                                                                            Padding(
                                                                          padding:
                                                                              const EdgeInsets.symmetric(horizontal: 4.0),
                                                                          child:
                                                                              Text(
                                                                            "Weight:",
                                                                            style:
                                                                                kwStyle,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      SizedBox(
                                                                        width:
                                                                            10,
                                                                      ),
                                                                      Container(
                                                                        padding:
                                                                            EdgeInsets.symmetric(horizontal: 6.0),
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          borderRadius:
                                                                              BorderRadius.circular(40.0),
                                                                          border: Border.all(
                                                                              color: Colors.black,
                                                                              style: BorderStyle.solid,
                                                                              width: 0.80),
                                                                        ),
                                                                        width:
                                                                            100,
                                                                        height:
                                                                            35,
                                                                        child: DropdownButton<
                                                                            WooProductVariation>(
                                                                          value: Selectiondropdown[index],
                                                                          hint:
                                                                              Text("Choose "),
                                                                          icon:
                                                                              const Icon(
                                                                            Icons.arrow_drop_down,
                                                                            color:
                                                                                Colors.pink,
                                                                          ),
                                                                          iconSize:
                                                                              24,
                                                                          elevation:
                                                                              10,
                                                                          style:
                                                                              const TextStyle(color: Colors.black),
                                                                          onChanged: (WooProductVariation Value) {
                                                                            setState(() {
                                                                            //  listvariaton[products[index].id][index].price.toString();
                                                                              Selectiondropdown.clear();
                                                                              dropvalue.clear();
                                                                              for (int i = 0; i < 500; i++) Selectiondropdown.add(wooProductVariation);
                                                                              for (int i = 0; i < 500; i++) dropvalue.add("");


                                                                              Selectiondropdown[index] = Value;

                                                                              dropvalue[index] ="₹${Selectiondropdown[index].price.toString()}";
                                                                              print(dropvalue[index]);
                                                                            });
                                                                          },
                                                                          items: listvariaton[products[index].id].map<DropdownMenuItem<WooProductVariation>>((value) {
                                                                            print(value);
                                                                            return DropdownMenuItem<WooProductVariation>(
                                                                              value: value,
                                                                              child: value.attributes[0] != null
                                                                                  ? Text(
                                                                                      value.attributes[0].option.toString(),
                                                                                    )
                                                                                  : Text(
                                                                                      value.id.toString(),
                                                                                    ),
                                                                            );
                                                                          }).toList(),
                                                                        ),
                                                                      ),

                                                                    ],
                                                                  ):Container(),
                                                                )
                                                              : Container(),


                                                            Text(
                                                              desc,
                                                              style: kdescStyle,
                                                            ),

                                                          Text(
                                                            '${dropvalue[index]} ',
                                                            style:
                                                            kTitleStyle,
                                                          ),


                                                        ],
                                                      ),


                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 0,
                                            ),
                                            Row(
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.all(
                                                    5.0,
                                                  ),
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      color: Colors.black12,
                                                      border: Border.all(
                                                        color: Colors.black,
                                                        style:
                                                            BorderStyle.solid,
                                                        width: 1.0,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5.0),
                                                    ),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              2),
                                                      child: InkWell(
                                                          onTap: () {
                                                            setState(() {
                                                              int value = int.tryParse(
                                                                      _listItem[
                                                                              index]
                                                                          .text) ??
                                                                  0;
                                                              _listItem[index]
                                                                  .text = (value >
                                                                          1
                                                                      ? value -
                                                                          1
                                                                      : value)
                                                                  .toString();
                                                            });
                                                          },
                                                          child: Icon(
                                                            Icons.remove,
                                                            color: Colors.black,
                                                            size: 18,
                                                          )),
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(2),
                                                  child: Container(
                                                    alignment:
                                                        Alignment.bottomCenter,
                                                    width: 30,
                                                    child: TextFormField(
                                                      maxLines: 1,
                                                      keyboardType:
                                                          TextInputType.number,
                                                      textInputAction:
                                                          TextInputAction.done,
                                                      controller:
                                                          _listItem[index],
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(5),
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      color: Colors.black12,
                                                      border: Border.all(
                                                        color: Colors.black,
                                                        style:
                                                            BorderStyle.solid,
                                                        width: 1.0,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5.0),
                                                    ),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              2),
                                                      child: InkWell(
                                                          onTap: () {
                                                            setState(() {
                                                              int value = int.parse(
                                                                      _listItem[
                                                                              index]
                                                                          .text) ??
                                                                  0;
                                                              _listItem[index]
                                                                      .text =
                                                                  (value + 1)
                                                                      .toString();
                                                            });
                                                          },
                                                          child: Icon(
                                                            Icons.add,
                                                            color: Colors.black,
                                                            size: 18,
                                                          )),
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Container(
                                                    width: Width * 0.20,
                                                    child: Positioned.fill(
                                                        child: Align(
                                                      alignment:
                                                          Alignment.topRight,
                                                      child: RaisedButton(
                                                        shape: RoundedRectangleBorder(
                                                          borderRadius:
                                                              new BorderRadius
                                                                      .circular(
                                                                  18.0),
                                                          side: BorderSide(
                                                              color: Colors
                                                                  .redAccent),
                                                        ),
                                                        color: Colors.redAccent,
                                                        child: Text(
                                                          "ADD",
                                                          style: kButtonStyle,
                                                        ),
                                                        onPressed: () async {
                                                          /* wooCommerce.post('/wp-json/wc/store/cart/items', { 'id': 860,
                                                  'quantity' : 2,});*/
                                                          String auth =
                                                              await wooCommerce
                                                                  .authToken;
                                                          print('aa${auth}');

                                                          HttpClient()
                                                              .addtocart(
                                                                  products[
                                                                          index]
                                                                      .id
                                                                      .toString(),
                                                                  _listItem[
                                                                          index]
                                                                      .text,
                                                                  Selectiondropdown[
                                                                          index]
                                                                      .id
                                                                      .toString(),
                                                                  auth
                                                                      .trim()
                                                                      .toString())
                                                              .then((value) {
                                                            setState(() {
                                                           //   getcartProducts();
                                                              Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                    builder: (BuildContext context) => HomeScreen()),
                                                              );
                                                              Map response =
                                                                  jsonDecode(
                                                                      value);
                                                              Fluttertoast.showToast(
                                                                  msg:
                                                                      "Added To Cart",
                                                                  toastLength: Toast
                                                                      .LENGTH_LONG,
                                                                  gravity:
                                                                      ToastGravity
                                                                          .SNACKBAR,
                                                                  timeInSecForIosWeb:
                                                                      1,
                                                                  backgroundColor:
                                                                      Colors
                                                                          .black,
                                                                  textColor:
                                                                      Colors
                                                                          .white,
                                                                  fontSize:
                                                                      16.0);

                                                              print(response);
                                                            });
                                                          });
                                                          //   print(  https.post('https://bigkart.in/wp-json/cocart/v1/add-item',{"product_id": "837", "quantity": "15"}));

                                                          //  text:''
                                                        },
                                                      ),
                                                    )),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                     cartproducts.length!=0? InkWell(
                       child: Container(decoration:   BoxDecoration(
                         color:   Color(0xFF00E676),
                         borderRadius:
                         BorderRadius.circular(40.0),
                         border: Border.all(
                             color: Colors.white,
                             style: BorderStyle.solid,
                             width: 0.80),
                       ),
                            //color: Colors.greenAccent,
                    child:  Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                      //    Center(child: Text("Click View Cart/checkout",style: kcStyle,)),

                              Row(
                                children: [
                                  Container(
                                    width: Width*0.70,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text("${totalitems} items",style:  TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15.0,
                                              height: 1.2,
                                              fontFamily: "Product Sans"),),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: SingleChildScrollView(scrollDirection: Axis.vertical,
                                            child: Container(width:300,child: Text( cartproductname,style:  TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 11.0,
                                                height: 1.2,
                                                fontFamily: "Product Sans"),)),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                   Text('₹${ totalamount['subtotal'].toString()}',style:  TextStyle(
                                       color: Colors.white,
                                       fontWeight: FontWeight.bold,
                                       fontSize: 18.0,
                                       height: 1.2,
                                       fontFamily: "Product Sans"),)
                                ],
                              ),



                        ],
                    )),
                     ):Container()
                    ],
                  ));
  }
}
