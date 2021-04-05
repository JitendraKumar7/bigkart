import 'package:provider/provider.dart';

import '../Basic.dart';


class DetailScreen extends StatefulWidget {
 final int _product;

  DetailScreen(this._product);

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  List<WooProductVariation>   productsvariant = new List();
  getProducts() async{


    productsvariant=await wooCommerce.getProductVariations(productId: 857);
    setState(() {

    });
    print(productsvariant);
  }
  WooCommerce wooCommerce = WooCommerce(
    baseUrl:BasicData().baseUrl,
    consumerKey: BasicData().consumerKey,
    consumerSecret: BasicData().consumerSecret,
    isDebug: true,
  );


  @override
  Widget build(BuildContext context) {



        return Scaffold(
          body: SafeArea(
            child: CustomScrollView(
              slivers: <Widget>[
                SliverAppBar(
                  backgroundColor: Theme.of(context).primaryColor,
                  elevation: 0,
                  title: Text("",
                    style: TextStyle(
                        fontFamily: 'Raleway', fontWeight: FontWeight.w500),
                  ),
                  centerTitle: false,
                  pinned: true,
                  floating: false,
                ),
                SliverList(
                    delegate: SliverChildListDelegate([

                      Padding(
                        padding:
                        const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                        child: Column(
                          children: <Widget>[



                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding:
                                  const EdgeInsets.symmetric(vertical: 16.0),
                                  child: Text(
                                    'YOU MIGHT LIKE',
                                    style: TextStyle(
                                        fontSize: 17, fontFamily: 'Raleway'),
                                  ),
                                ),

                              ],
                            )
                          ],
                        ),
                      ),
                    ]))
              ],
            ),
          ),
        );
  }


}
