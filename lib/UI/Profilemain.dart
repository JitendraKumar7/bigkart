import 'package:bigkart/UI/MyAddress.dart';
import 'package:getwidget/components/loader/gf_loader.dart';
import 'package:progress_dialog/progress_dialog.dart';

import '../Basic.dart';
import 'MyProfile.dart';

class Profilemain extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return Profile1main();
  }
}

class Profile1main extends State<Profilemain> {
  List<WooProductCategory> cartproductscat = new List();
  List<WooProduct> cartproductscatid = new List();
  List<WooProduct> products = new List();
  WooCustomer woouserbyid ;
  List<WooProduct> featuredProducts = [];
  var logout;
  bool flag=false;
  WooCommerce wooCommerce = WooCommerce(
    baseUrl: BasicData().baseUrl,
    consumerKey: BasicData().consumerKey,
    consumerSecret: BasicData().consumerSecret,
    isDebug: true,
  );

  ProgressDialog pr;
  final kTitleStyle = TextStyle(
      color: Colors.grey,
      fontSize: 16.0,
      height: 1.5,
      fontFamily: "Product Sans");

  final kSubtitleStyle = TextStyle(
      color: Colors.black,
      fontSize: 16.0,
      height: 1.2,
      fontFamily: "Product Sans");

  TextEditingController textphn = TextEditingController();
  TextEditingController tetpass = TextEditingController();
  getProducts() async{


    SharedPreferences prefs = await SharedPreferences.getInstance();
   var status = prefs.getInt('isidtrue') ;
    print(status);
     woouserbyid=  await wooCommerce.getCustomerById(id: status);
    //  cartproductscat= await wooCommerce.getProductCategories();

    setState(() {
      flag= true;

    });
    //print(products.toString());
  }
  void navigationPage() {
    // Navigator.of(context).pushReplacementNamed(INT_SCREEN);
  }

  Color coronas = Colors.lightBlue;

  @override
  void initState() {
    getProducts();
    super.initState();
  }




  @override
  Widget build(BuildContext context) {
    var Height = MediaQuery.of(context).size.height;
    var Width = MediaQuery.of(context).size.width;
    pr = new ProgressDialog(context, showLogs: true);
    pr.style(message: 'Please wait...');
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          " Profile" ?? "",
          textAlign: TextAlign.start,
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontFamily: "Product Sans"),
        ),
      ),
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
          new Center(
              child:
              new Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Stack(
                children: [
                  new Container(
                      margin: EdgeInsets.only(left: 0.0, right: 0, top: 20),
                      width: 120.0,
                      height: 120.0,
                      decoration: new BoxDecoration(
                          shape: BoxShape.circle,
                          image: new DecorationImage(
                              fit: BoxFit.fill,
                              image:new NetworkImage(woouserbyid.avatarUrl) ??new NetworkImage(
                                  "https://i.imgur.com/BoN9kdC.png")))),

                ],
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                child: new Text('${woouserbyid.firstName} ${woouserbyid.lastName} '??"",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.black,
                      fontFamily: "Product Sans"),
                ),
              ),
              Container(
                child: new Text(
                  woouserbyid.email??"",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.black,
                      fontFamily: "Product Sans"),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Divider(
                thickness: 2,
              ),
            ],
          )),
          Card(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
              child: ListTile(
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
            ),
          ),
          Card(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
              child: ListTile(onTap: (){

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
            ),
          ),

          Card(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
              child: ListTile(
                onTap: () async {
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();


                  setState(() {
                    logout = wooCommerce.logUserOut();
                    prefs.remove('isLoggedIn');
                    pr.show();
                    Future.delayed(Duration(seconds: 2))
                        .then((value) {
                      pr.hide().whenComplete(() {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) => LoginPage()),
                        );
                      });
                    });

                  });

                  print(logout.toString());
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
            ),
          ),
          Divider(),
          Center(
            child: Text(
              "ver 1.0.1",
              style: kTitleStyle,
            ),
          ),
        ],
      ),
    );
  }
}
