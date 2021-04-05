import 'package:bigkart/Basic.dart';
import 'package:bigkart/app/Basicdata.dart';
import 'package:getwidget/components/loader/gf_loader.dart';
import 'package:woocommerce/models/cart_item.dart';
import 'package:woocommerce/models/products.dart';
import 'package:woocommerce/woocommerce.dart';

import 'SeeAll.dart';

class Catogries  extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
   return CatogriesState();
  }
}
class CatogriesState extends State<Catogries>{
  List<WooProductCategory> cartCat = [] ;
  List<WooProduct> featuredProducts = new List();
  WooCommerce wooCommerce = WooCommerce(
    baseUrl:BasicData().baseUrl,

    consumerKey: BasicData().consumerKey,
    consumerSecret: BasicData().consumerSecret,
    isDebug: true,
  );
  final kcStyle = TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.bold,
      fontSize: 15.0,
      height: 1.2,
      fontFamily: "Product Sans");
  getcartProducts() async{

    cartCat = await wooCommerce.getProductCategories();
   // featuredProducts = await wooCommerce.getProducts(category: "42");

    print(cartCat);
    setState(() {

    });
  }
  void initState() {
    getcartProducts();
    super.initState();
    //You would want to use a feature builder instead.




  }
  Widget appBarTitle = new Text("Catogries",style: TextStyle(  color: Colors.black,
      fontSize: 15.0,

      height: 1.5,
      fontFamily: "Product Sans"),);
  Icon actionIcon = new Icon(Icons.search);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  new AppBar(
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
                  this.appBarTitle = new Text("Catogries");
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
      body:cartCat==null
          ? Container(
        width: MediaQuery.of(context).size.height,
        height: MediaQuery.of(context).size.height,
        child: Center(
          child: GFLoader(loaderColorOne: Colors.black26),
        ),
      )
          : cartCat.isEmpty
          ? Container(
        width: MediaQuery.of(context).size.height,
        height: MediaQuery.of(context).size.height,
        child: Center(
          child: GFLoader(loaderColorOne: Colors.black26),
        ),
      ):
      GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 12.0,
          children: cartCat.map((e) {

           // print(e.image.src);
            return InkWell(onTap: (){
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) =>
                        SeeAll(id: e.id,)),
              );
            },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                 /* new Container(
                      margin: EdgeInsets.only(left: 0.0, right: 0, top: 20),
                      width: 100.0,
                      height: 100.0,
                      decoration: new BoxDecoration(
                          shape: BoxShape.circle,
                          image: new DecorationImage(
                              fit: BoxFit.fill,
                              image:new AssetImage('assets/imgapp/icn5.png')))),*/
                 new Container(
              margin: EdgeInsets.only(left: 0.0, right: 0, top: 20),
              width: 100.0,
              height: 100.0,
              decoration: new BoxDecoration(
              shape: BoxShape.circle,
              image: new DecorationImage(
              fit: BoxFit.fill,
              image:new NetworkImage(e.image.src)))),

               Container(alignment: Alignment.center,
                   child: Text(e.name.replaceAll('&amp;', '&'),style:kcStyle  ,)),
                ],
              ),
            );
          }
          ).toList()
      )


    );

  }

}


