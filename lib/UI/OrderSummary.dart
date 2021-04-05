

import 'package:bigkart/UI/Order.dart';
import 'package:getwidget/components/loader/gf_loader.dart';
import 'package:woocommerce/models/payment_gateway.dart';

import '../Basic.dart';
import 'MyProfile.dart';

class OrderSummary extends StatefulWidget{





  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return OrderSummarystate();
  }
}
class OrderSummarystate extends State<OrderSummary>{
bool flag= false;
   WooOrder user;


  var logout;
  WooCommerce wooCommerce = WooCommerce(
    baseUrl:BasicData().baseUrl,
    consumerKey: BasicData().consumerKey,
    consumerSecret: BasicData().consumerSecret,
    isDebug: true,
  );


  final kTitleStyle = TextStyle(
      color: Colors.grey,
      fontSize: 16.0,

      height: 1.5,
      fontFamily: "Product Sans"
  );

  final kSubtitleStyle = TextStyle(
      color: Colors.black,
      fontSize: 16.0,
      height: 1.2,
      fontFamily: "Product Sans"
  );
var status;
  getProducts() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    status = prefs.getInt('wooorderid') ;
    print(status);

    user = await wooCommerce.getOrderById(status);

    setState(() {
flag=true;
    });
    print(user);
  }

  TextEditingController textphn = TextEditingController();
  TextEditingController tetpass =  TextEditingController();



  void navigationPage() {
    // Navigator.of(context).pushReplacementNamed(INT_SCREEN);
  }

  Color coronas= Colors.lightBlue;

  @override
  void initState() {
    getProducts();
    super.initState();

  }



  @override
  Widget build(BuildContext context) {
    var Height= MediaQuery.of(context).size.height;
    var Width= MediaQuery.of(context).size.width;



    return Scaffold(



      floatingActionButton:  Padding(
        padding: const EdgeInsets.symmetric(vertical:0.0,horizontal: 60),
        child:   InkWell(child:

        Container(

          height: 50,

          decoration: BoxDecoration(

              borderRadius: BorderRadius.circular(10),

              gradient: LinearGradient(

                  colors: [

                    Colors.greenAccent,



                    Colors.green

                  ]

              )

          ),

          child:

          Center(

            child: Text("Continue", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),

          ),),onTap: () async {



          Navigator.push(

            context,

            MaterialPageRoute(

                builder: (BuildContext context) =>

                    OrderPage()

            ),

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
      ) ,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,

      appBar:AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(icon:Icon( Icons.arrow_back_ios,),color: Colors.greenAccent,),
        title:const  Text("Order Summary"??"", textAlign: TextAlign.start,style:TextStyle(fontWeight:FontWeight.bold,color: Colors.black,fontFamily: "Product Sans" ),),),

      body:flag==false?Container(
        child: Center(
          child: GFLoader(loaderColorOne: Colors.greenAccent),
        ),
    width: MediaQuery.of(context).size.height,
    height: MediaQuery.of(context).size.height,):
      ListView(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        children: [
          ListTile(


            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(user.dateCreated??"12"),


              ],
            ),

            title: Text("Date",style: kSubtitleStyle,),

          ),
          Divider(),
          ListTile(


                      subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
    children: [
    Text(user.billing.address1 ),
    Text(user.billing.address2 ),
    Text('${user.billing.city} ${user.billing.postcode}'),
    Text(user.billing.country ),
    ],
    ),

    title: Text("Billing address",style: kSubtitleStyle,),

              ),
          Divider(),
          ListTile(


            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(user.shipping.address1 ),
                Text(user.shipping.address2 ),
                Text('${user.shipping.city} ${user.shipping.postcode}'),
                Text(user.shipping.country ),
              ],
            ),

            title: Text("Shipping address",style: kSubtitleStyle,),

          ),
          Divider(),

          ListTile(


            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(user.shippingTotal??"12"),


              ],
            ),

            title: Text("Shipping Method",style: kSubtitleStyle,),

          ),
          Divider(),
          ListTile(


            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(user.paymentMethod??"12"),


              ],
            ),

            title: Text("Payment Method",style: kSubtitleStyle,),

          ),
          Divider(),
          ListTile(


            subtitle: ListView(

              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              children:user.lineItems.map((e) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(child: Text(e.name??"12")),
                        Expanded(child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Text(e.price.toString()??"12"),
                            ),
                          ],
                        )),
                      ],
                    ),


                  ],
                );

    }) .toList()


            ),

            title: Text("Items",style: kSubtitleStyle,),

          ),
          Divider(),
          ListTile(


            subtitle:Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
    Row(
    children: [
    Expanded(child: Text("Shipping charge"??"12")),
    Expanded(child: Column(
    crossAxisAlignment: CrossAxisAlignment.end,
    children: [
    Padding(
    padding: const EdgeInsets.all(15.0),
    child: Text(user.shippingTotal.toString()??"12"),
    ),
    ],
    )),
    ],
    ),
      Row(
        children: [
          Expanded(child: Text("Discount"??"12")),
          Expanded(child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text(user.discountTax.toString()??"12"),
              ),
            ],
          )),
        ],
      ),
      Row(
        children: [
          Expanded(child: Text("Shipping charge"??"12")),
          Expanded(child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text(user.totalTax.toString()??"12"),
              ),
            ],
          )),
        ],
      ),
      Row(
        children: [
          Expanded(child: Text("Total"??"12")),
          Expanded(child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text(user.total.toString()??"12"),
              ),
            ],
          )),
        ],
      ),


    ]),

            title: Text("Totals",style: kSubtitleStyle,),

          ),
          Divider(),
SizedBox(height: 200,),

        ],
      ),

    );
  }}





