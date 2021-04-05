import 'package:getwidget/components/loader/gf_loader.dart';

import '../Basic.dart';
import 'image_utilities.dart';

class Profile extends StatefulWidget{





  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return Profile1();
  }
}
class Profile1 extends State<Profile>{
  WooCustomer woouserbyid ;
bool flag= false;
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
  var   status;
  final kSubtitleStyle = TextStyle(
      color: Colors.black,
      fontSize: 16.0,
      height: 1.2,
      fontFamily: "Product Sans"
  );
  getProducts() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
   status = prefs.getInt('isidtrue') ;
    print(status);
    woouserbyid=  await wooCommerce.getCustomerById(id: status);
  //  cartproductscat= await wooCommerce.getProductCategories();

    setState(() {
flag= true;
    });
    //print(products.toString());
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
  File _image;


  bool _load = false;
  attachedFileDialog(BuildContext context) {
    AlertDialog alert = new AlertDialog(
      content: SafeArea(
        child: Container(
          child: new Wrap(
            children: <Widget>[
              new ListTile(
                  leading: new Icon(Icons.photo_library),
                  title: new Text('Photo Library'),
                  onTap: () async {
                    File image = await UtilsImage.getFromGallery();
                    //String str = FileUtils.readFileToString(image, "UTF-8");
                    updateimage(image.readAsString());
                    Navigator.of(context).pop();
                  }),
              new ListTile(
                leading: new Icon(Icons.photo_camera),
                title: new Text('Camera'),
                onTap: () async {
                  File image = await UtilsImage.getFromCamera();
                 updateimage(image.readAsString());
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        ),
      ),
      actions: [],
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
  updateimage(image){

    wooCommerce.updateCustomer(id: status,data: {

      "avatar_url":image.readas
    });
print(image);
  }
  @override
  Widget build(BuildContext context) {
    var Height= MediaQuery.of(context).size.height;
    var Width= MediaQuery.of(context).size.width;
    Widget loadingIndicator =_load? new Container(
      color: Colors.grey[300],
      width: 70.0,
      height: 70.0,
      child: new Padding(padding: const EdgeInsets.all(5.0),child: new Center(child: new CircularProgressIndicator())),
    ):new Container();



    return Scaffold(
      appBar:AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(icon:Icon( Icons.arrow_back_ios,),onPressed: (){Navigator.of(context).pop();},color: Colors.greenAccent,),
        title:const  Text(  " Profile"??"", textAlign: TextAlign.start,style:TextStyle(fontWeight:FontWeight.bold,color: Colors.black,fontFamily: "Product Sans" ),),),

      body: flag==false?Container(
        child: Center(
          child: GFLoader(loaderColorOne: Colors.greenAccent),
        ),
        width: MediaQuery.of(context).size.height,
        height: MediaQuery.of(context).size.height,):
      ListView(
        scrollDirection: Axis.vertical,
          shrinkWrap: true,
          children: [

            SizedBox(height: 10,),
            Container(


                child:

                Column( children: <Widget>[

                  SizedBox(height: 10,),
                  new Center(
                      child: new Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Stack(
                            children: [
                              new Container(
                                  margin: EdgeInsets.only(left: 0.0,right: 0,top: 20),
                                  width: 120.0,
                                  height: 120.0,
                                  decoration: new BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: new DecorationImage(
                                          fit: BoxFit.fill,
                                          image: new NetworkImage(woouserbyid.avatarUrl) ??new NetworkImage(
                                              "https://i.imgur.com/BoN9kdC.png")
                                      )
                                  )),

                            ],
                          ),
                          SizedBox(height: 30,),
                          Divider(thickness: 2,),

                        ],
                      )),


                  Padding(

                    padding: const EdgeInsets.fromLTRB( 20,5,20,5),
                    child: new Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[

                        Expanded(
                          child: Container(
                            child:

                            new Text( "Full Name:",style:kTitleStyle,),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            child:

                            new Text( woouserbyid.username??"vikasww", textAlign: TextAlign.start,style:TextStyle(fontWeight:FontWeight.bold,fontSize: 18,color: Colors.black,fontFamily: "Product Sans" ),),
                          ),
                        ), ],
                    ),
                  ),
                  Divider(),
                  Padding(

                    padding: const EdgeInsets.fromLTRB( 20,5,20,5),
                    child: new Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[

                        Expanded(
                          child: Container(
                            child:

                            new Text( "Birth Date:",style:kTitleStyle,),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            child:

                            new Text( "09/4/1997", textAlign: TextAlign.start,style:TextStyle(fontWeight:FontWeight.bold,fontSize: 18,color: Colors.black,fontFamily: "Product Sans" ),),
                          ),
                        ), ],
                    ),
                  ),
                  Divider(),
                  Padding(

                    padding: const EdgeInsets.fromLTRB( 20,5,20,5),
                    child: new Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[

                        Expanded(
                          child: Container(
                            child:

                            new Text( "Gender:",style:kTitleStyle,),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            child:

                            new Text( "Male", textAlign: TextAlign.start,style:TextStyle(fontWeight:FontWeight.bold,fontSize: 18,color: Colors.black,fontFamily: "Product Sans" ),),
                          ),
                        ), ],
                    ),
                  ),
                  Divider(),
                  Padding(

                    padding: const EdgeInsets.fromLTRB( 20,5,20,5),
                    child: new Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[

                        Expanded(
                          child: Container(
                            child:

                            new Text( "Email Address:",style:kTitleStyle,),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            child:

                            new Text( woouserbyid.email, textAlign: TextAlign.start,style:TextStyle(fontWeight:FontWeight.bold,fontSize: 18,color: Colors.black,fontFamily: "Product Sans" ),),
                          ),
                        ), ],
                    ),
                  ),
                  Divider(),
                  Padding(

                    padding: const EdgeInsets.fromLTRB( 20,5,20,5),
                    child: new Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[

                        Expanded(
                          child: Container(
                            child:

                            new Text( "Phone Number:",style:kTitleStyle,),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            child:

                            new Text( woouserbyid.billing.phone, textAlign: TextAlign.start,style:TextStyle(fontWeight:FontWeight.bold,fontSize: 18,color: Colors.black,fontFamily: "Product Sans" ),),
                          ),
                        ), ],
                    ),
                  ),
                  Divider(),






                ],
                )),

            SizedBox(height: 5,),

            new Align(child: loadingIndicator,alignment: FractionalOffset.center,),
            SizedBox(height: 5,),

          ],
        ),

    );
  }}





