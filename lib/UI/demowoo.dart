import 'package:flutter/material.dart';
import 'package:woocommerce/woocommerce.dart';






String baseUrl = "http://bigkart.in";
String consumerKey = "ck_19923520b89fb76ad04bf4a11ae1938e4700ad42";
String consumerSecret = "cs_86583c4e2ace6fd29ca13fa18e063fccafeb7ef0";
class demowooPage extends StatefulWidget {
  demowooPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
   createState() => _demowooPageState();
}

class _demowooPageState extends State<demowooPage> {

  List<WooProduct> products = [];
  List<WooProduct> featuredProducts = [];
  WooCommerce wooCommerce = WooCommerce(
    baseUrl: baseUrl,
    consumerKey: consumerKey,
    consumerSecret: consumerSecret,
    isDebug: true,
  );

  getProducts() async{
    products = await wooCommerce.getProducts();
    setState(() {
    });
    print(products.toString());
  }

  @override
  void initState() {
    super.initState();
    //You would want to use a feature builder instead.
    getProducts();

  }
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height - kToolbarHeight - 24) / 2;
    final double itemWidth = size.width / 2;
    return
      Scaffold(
        body: SafeArea(
          child: CustomScrollView(
            slivers: <Widget>[
              SliverToBoxAdapter(
                child: Container(
                  margin: EdgeInsets.all(10),
                  child: Text('My Awesome Shop',
                    style: Theme.of(context).textTheme.headline.apply(color: Colors.blueGrey),
                  ),),
              ),
              SliverGrid(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: (itemWidth / itemHeight),
                  mainAxisSpacing: 2,
                  crossAxisSpacing: 1,
                ),

                delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                    final product = products[index];
                    return
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Container(
                            height: 230,
                            width: 200,
                            margin: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              image: DecorationImage(image: NetworkImage(product.images[0].src,),
                                  fit: BoxFit.cover),
                              color: Colors.pinkAccent,
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                            ),
                            //child: Image.network(product.images[0].src, fit: BoxFit.cover,),
                          ),
                          Text(product.name?? 'Loading...', style: Theme.of(context).textTheme.title.apply(color: Colors.blueGrey),),
                          Text('\$'+product.price?? '', style: Theme.of(context).textTheme.subtitle,)
                        ],
                      );
                  },
                  childCount: products.length,
                ),
              )
            ],
          ),
        ),
      );
  }
}
