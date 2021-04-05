import 'dart:convert';

import 'package:bigkart/app/Basicdata.dart';
import 'package:bigkart/app/ProductModel.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:getwidget/components/loader/gf_loader.dart';
import 'package:woocommerce/models/product_category.dart';
import 'package:woocommerce/models/product_variation.dart';
import 'package:woocommerce/models/products.dart';
import 'package:woocommerce/woocommerce.dart';
import 'package:bigkart/app/HttpClient.dart';

import '../Basic.dart';
import 'Catogries.dart';
import 'MyProfile.dart';

class SeeAll extends StatefulWidget {
  int id;

  SeeAll({
    Key key,
    @required this.id,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return SeeAllstate();
  }
}

class SeeAllstate extends State<SeeAll> {
  List<WooProductCategory> cartproductscat = new List();
  List<WooProduct> cartproductscatid = [];
  List<WooProduct> products = new List();

  List<WooProduct> featuredProducts = [];
  WooCommerce wooCommerce = WooCommerce(
    baseUrl: BasicData().baseUrl,
    consumerKey: BasicData().consumerKey,
    consumerSecret: BasicData().consumerSecret,
    isDebug: true,
  );

  getProducts() async {
    products = await wooCommerce.getProducts();
    cartproductscat = await wooCommerce.getProductCategories();
    cartproductscatid =
        await wooCommerce.getProducts(category: widget.id.toString());
    setState(() {});
    print(cartproductscat.toString());
  }

  List<String> _option = new List();
  List<String> dropvalue = new List();
  List<WooProductVariationAttribute> woopa = [];
  List<ProductModel> productmodel = new List();
  List<TextEditingController> _listItem = List();
  WooCustomer woocustm;
  List<WooProductVariation> Selectiondropdown = new List();
  List<List<WooProductVariation>> listvariaton = [];

  TextEditingController textphn = TextEditingController();
  TextEditingController tetpass = TextEditingController();

  void navigationPage() {
    // Navigator.of(context).pushReplacementNamed(INT_SCREEN);
  }

  Color coronas = Colors.lightBlue;

  Future<void> varantionfunction(int id, int index) async {
    woopa = new List();

    listvariaton[id] = await wooCommerce.getProductVariations(productId: id);
    if (dropvalue[index].isNotEmpty) {
     /// dropvalue[index] = "Start at " + products[index].price;
    }
    ;
    setState(() {
      listvariaton[id].map((e) {
        Selectiondropdown.add(e);
      }).toList();
    });

    print('vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv');
    print(listvariaton[id][0]);
  }

  final kTitleStyle = TextStyle(
      color: Colors.black,
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
  final kwStyle = TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.bold,
      fontSize: 12.0,
      height: 1.2,
      fontFamily: "Product Sans");
  final kButtonStyle = TextStyle(
      color: Colors.white,
      fontSize: 14.0,
      height: 1.2,
      fontWeight: FontWeight.bold,
      fontFamily: "Product Sans");

  @override
  void initState() {
    super.initState();
    //You would want to use a feature builder instead.
    getProducts();
  }

  final kdescStyle = TextStyle(
      color: Colors.grey,
      fontSize: 12.0,
      fontWeight: FontWeight.bold,
      height: 1.2,
      fontFamily: "Product Sans");
  File _image;
  String desc;
  bool _load = false;
  Widget appBarTitle = new Text(
    "List Of Products",
    style: TextStyle(
        color: Colors.black,
        fontSize: 15.0,
        height: 1.5,
        fontFamily: "Product Sans"),
  );
  Icon actionIcon = new Icon(Icons.search);
  WooProductVariation wooProductVariation;

  @override
  Widget build(BuildContext context) {
    var Height = MediaQuery.of(context).size.height;
    var Width = MediaQuery.of(context).size.width;
    for (int i = 0; i < products.length; i++)
      _listItem.add(TextEditingController(text: 1.toString()));
    for (int i = 0; i < 500; i++) listvariaton.add(List());
    for (int i = 0; i < 500; i++) dropvalue.add("");
    for (int i = 0; i < 500; i++) Selectiondropdown.add(wooProductVariation);
    return Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.greenAccent,
        title: appBarTitle,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
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
                      height: 10,
                    ),
                    Container(
                      height: 40,
                      child: cartproductscatid == null
                          ? Container(
                              width: MediaQuery.of(context).size.height,
                              height: MediaQuery.of(context).size.height,
                              child: Center(
                                child: GFLoader(loaderColorOne: Colors.black26),
                              ),
                            )
                          : cartproductscatid.isEmpty
                              ? Container(
                                  width: MediaQuery.of(context).size.height,
                                  height: MediaQuery.of(context).size.height,
                                  child: Center(
                                    child: GFLoader(
                                        loaderColorOne: Colors.black26),
                                  ),
                                )
                              : ListView(
                                  scrollDirection: Axis.horizontal,
                                  shrinkWrap: true,
                                  children: cartproductscat.map(
                                    (e) {
                                      return Center(
                                        child: InkWell(
                                          onTap: () async {
                                            listvariaton.clear();
                                            dropvalue.clear();
                                            Selectiondropdown.clear();
                                            cartproductscatid.clear();
                                            for (int i = 0; i < 500; i++)
                                              listvariaton.add(List());
                                            for (int i = 0; i < 500; i++)
                                              dropvalue.add("");
                                            for (int i = 0; i < 500; i++)
                                              Selectiondropdown.add(
                                                  wooProductVariation);
                                            cartproductscatid =
                                                await wooCommerce.getProducts(
                                                    category: e.id.toString());
                                            setState(() {});
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 10.0, top: 0),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                  color: Colors.black,
                                                  style: BorderStyle.solid,
                                                  width: 1.0,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(5.0),
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(4),
                                                child: Text(
                                                  e.name
                                                      .replaceAll('&amp;', '&'),
                                                  style: kTitleStyle,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ).toList()),
                    ),
                    Container(
                      height: Height * 0.80,
                      child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: cartproductscatid.length,
                        itemBuilder: (context, index) {
                          HtmlTags.removeTag(
                              htmlString:
                                  products[index].description.toString(),
                              callback: (string) {
                                print(string);
                                desc = string;
                              });

                          if (cartproductscatid[index].type == 'variable') {
                            if (listvariaton[cartproductscatid[index].id]
                                    .length ==
                                0) {
                              varantionfunction(
                                  cartproductscatid[index].id, index);
                            }
                          }

                          print(listvariaton[cartproductscatid[index].id]);
                          _listItem[index].addListener(() {});
                          return Padding(
                            padding: const EdgeInsets.fromLTRB(7, 2, 7, 10),
                            child: InkWell(
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
                                                            cartproductscatid[
                                                                    index]
                                                                .images[0]
                                                                .src) ??
                                                        NetworkImage(
                                                            cartproductscatid[
                                                                    index]
                                                                .images[0]
                                                                .src),
                                                  )),
                                              Container(
                                                width: Width * 0.67,
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 4,
                                                              top: 4.0),
                                                      child: Text(
                                                        cartproductscatid[index]
                                                            .categories[0]
                                                            .name.replaceAll('&amp;', '&'),
                                                        style: kdescStyle,
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              0.0),
                                                      child: Text(
                                                        cartproductscatid[index]
                                                            .name
                                                            .toString(),
                                                        style: kSubtitleStyle,
                                                      ),
                                                    ),
                                                    cartproductscatid[index]
                                                                .type ==
                                                            'variable'
                                                        ? Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: Row(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Container(
                                                                  child:
                                                                      Padding(
                                                                    padding: const EdgeInsets
                                                                            .symmetric(
                                                                        horizontal:
                                                                            4.0),
                                                                    child: Text(
                                                                      "Weight:",
                                                                      style:
                                                                          kwStyle,
                                                                    ),
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  width: 10,
                                                                ),
                                                                Container(
                                                                  padding: EdgeInsets
                                                                      .symmetric(
                                                                          horizontal:
                                                                              6.0),
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            40.0),
                                                                    border: Border.all(
                                                                        color: Colors
                                                                            .black,
                                                                        style: BorderStyle
                                                                            .solid,
                                                                        width:
                                                                            0.80),
                                                                  ),
                                                                  width: 100,
                                                                  height: 35,
                                                                  child: DropdownButton<
                                                                      WooProductVariation>(
                                                                    value:Selectiondropdown[index],
                                                                    hint: Text(
                                                                        "Choose "),
                                                                    icon:
                                                                        const Icon(
                                                                      Icons
                                                                          .arrow_drop_down,
                                                                      color: Colors
                                                                          .pink,
                                                                    ),
                                                                    iconSize:
                                                                        24,
                                                                    elevation:
                                                                        10,
                                                                    style: const TextStyle(
                                                                        color: Colors
                                                                            .black),
                                                                    onChanged:
                                                                        (WooProductVariation
                                                                            Value) {
                                                                      setState(
                                                                          () {
                                                                        Selectiondropdown[index] =
                                                                            Value;

                                                                        dropvalue[index] = "₹${Selectiondropdown[index].price.toString()}";
                                                                        print(dropvalue[
                                                                            index]);
                                                                      });
                                                                    },
                                                                    items: listvariaton[cartproductscatid[index]
                                                                            .id]
                                                                        .map<DropdownMenuItem<WooProductVariation>>(
                                                                            (value) {
                                                                      print(
                                                                          value);
                                                                      return DropdownMenuItem<
                                                                          WooProductVariation>(
                                                                        value:
                                                                            value,
                                                                        child: value.attributes[0] !=
                                                                                null
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
                                                            ),
                                                          )
                                                        : Container(),
                                                    Text(
                                                      desc,
                                                      style: kdescStyle,
                                                    ),
                                                    Text(
                                                      '₹${dropvalue[index]} ',
                                                      style: kTitleStyle,
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
                                                      style: BorderStyle.solid,
                                                      width: 1.0,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5.0),
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(2),
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
                                                                    ? value - 1
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
                                                      style: BorderStyle.solid,
                                                      width: 1.0,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5.0),
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(2),
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
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            new BorderRadius
                                                                .circular(18.0),
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
                                                                cartproductscatid[
                                                                        index]
                                                                    .id
                                                                    .toString(),
                                                                _listItem[index]
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
                                                                  builder: (BuildContext
                                                                          context) =>
                                                                      HomeScreen()),
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
                                                                fontSize: 16.0);

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
                  ],
                ),
    );
  }
}
