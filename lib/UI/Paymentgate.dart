import 'package:bigkart/UI/OrderSummary.dart';
import 'package:getwidget/components/loader/gf_loader.dart';
import 'package:woocommerce/models/customer.dart';
import 'package:woocommerce/models/order.dart';
import 'package:woocommerce/models/order_payload.dart';
import 'package:woocommerce/models/payment_gateway.dart';

import '../Basic.dart';
import 'MyProfile.dart';

class Paymentgate extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return Paymentgatestate();
  }
}
class Paymentgatestate extends State<Paymentgate>{
  List<WooCartItem>  cartitems=[] ;
  bool flag=false;
  List<WooPaymentGateway> paymentgatemthods = new List();
List<WooShippingZone>  wooShippingZone;
List<WooCustomer> woocustm=[];
List<WooOrder>wooorder;
  WooCustomer user;

  var logout;
  WooCommerce wooCommerce = WooCommerce(
    baseUrl:BasicData().baseUrl,
    consumerKey: BasicData().consumerKey,
    consumerSecret: BasicData().consumerSecret,
    isDebug: true,
  );
int status;

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

  getProducts() async{
    paymentgatemthods = await wooCommerce.getPaymentGateways();
  cartitems = await wooCommerce.getMyCartItems();

  print(cartitems.length);
 SharedPreferences prefs = await SharedPreferences.getInstance();
    status = prefs.getInt('isidtrue') ;
    print(status);
    user =  await wooCommerce.getCustomerById(id: status);
    setState(() {
flag= true;
    });
    print(paymentgatemthods);
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

            child: Text(" Place Order", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),

          ),),onTap: () async {

 var output= await wooCommerce.createOrder(WooOrderPayload( paymentMethod: "Cash On Delivery",billing:WooOrderPayloadBilling(firstName: user.billing.firstName,lastName: user.billing.lastName,city: user.billing.city,) ,customerId: status,shipping: WooOrderPayloadShipping(firstName: user.shipping.firstName,lastName: user.shipping.lastName,city: user.shipping.city),lineItems: []));
wooorder= new List();
wooorder.add(output);
 final prefs = await SharedPreferences.getInstance();
 prefs.setInt('wooorderid', wooorder[0].id);
 print(output);
          Navigator.push(

            context,

            MaterialPageRoute(

                builder: (BuildContext context) =>

                    OrderSummary()

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
        leading: IconButton(icon:Icon( Icons.arrow_back_ios,),onPressed: (){Navigator.of(context).pop();},color: Colors.greenAccent,),
        title:const  Text("PaymentMethod"??"", textAlign: TextAlign.start,style:TextStyle(fontWeight:FontWeight.bold,color: Colors.black,fontFamily: "Product Sans" ),),),

      body:flag==false?Container(   child: Center(
        child: GFLoader(loaderColorOne: Colors.greenAccent),
      ),
    width: MediaQuery.of(context).size.height,
    height: MediaQuery.of(context).size.height,):
      ListView(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        children: [


          Card(
            child: Padding(

              padding: const EdgeInsets.fromLTRB( 0,0,0,0),
              child:ListTile(

                leading: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Color(0xFFB9F6CA),

                        style: BorderStyle.solid,
                        width: 1.0,
                      ),

                      color:  Color(0xFFB9F6CA),
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(Icons.location_city,color: Colors.lightGreen),
                    )),
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
          ),),
          Card(
            child: Padding(

              padding: const EdgeInsets.fromLTRB( 0,0,0,0),
              child:ListTile(

                leading: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Color(0xFFB9F6CA),

                        style: BorderStyle.solid,
                        width: 1.0,
                      ),

                      color:  Color(0xFFB9F6CA),
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(Icons.location_on,color: Colors.lightGreen),
                    )),
                  subtitle: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
    Text(user.billing.address1 ),
    Text(user.billing.address2 ),
    Text('${user.billing.city} ${user.billing.postcode}'),
    Text(user.billing.country ),
    ],
    ),
                title: Text("Shipping address",style: kSubtitleStyle,),
              )
            ),
          ),
          Card(
            child: Padding(

              padding: const EdgeInsets.fromLTRB( 0,0,0,0),
              child:ListTile(

                leading: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Color(0xFFB9F6CA),

                        style: BorderStyle.solid,
                        width: 1.0,
                      ),

                      color:  Color(0xFFB9F6CA),
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(Icons.map,color: Colors.lightGreen),
                    )),
                subtitle: Text("Free"),
                title: Text("Shipping  Method",style: kSubtitleStyle,),
                ),
            ),
          ),
          Card(
            child: Padding(

              padding: const EdgeInsets.fromLTRB( 0,0,0,0),
              child:ListTile(

                leading: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Color(0xFFFF8A80),

                        style: BorderStyle.solid,
                        width: 1.0,
                      ),

                      color:  Color(0xFFFF8A80),
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(Icons.payment,color: Colors.white),
                    )),
                subtitle:ListTile(

        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Cash On Delivery"),
            ),

          ],
        ),

      ),
                title: Text("Payment Method ",style: kSubtitleStyle,),
              )
            ),
          ),
          Divider(),


        ],
      ),

    );
  }}





