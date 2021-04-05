import 'dart:async';



import 'package:progress_dialog/progress_dialog.dart';

import 'Basic.dart';

void main() {
  HttpOverrides.global = new MyHttpOverrides();
  runApp(new MaterialApp(
      title: 'Layout design',
      debugShowCheckedModeBanner: false,
      theme: new ThemeData(
          accentColor: Colors.black

          ,
          indicatorColor: Colors.black,
          highlightColor:  Colors.black,
          bottomAppBarColor: Colors.black,
          primaryColor: Color(0xFFffffff),
          primaryColorDark: Color(0xffffff)),
      home: MyApp(),

  ));
}

class MyApp extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(

        primarySwatch: Colors.blue,

        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);



  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

ProgressDialog pr;

  var _visible = true;
  startTime() async {
    var _duration = new Duration(seconds: 3);
    return new Timer(_duration, navigationPage);
  }
  getProducts() async{

   // cartproductscat= await wooCommerce.getProductCategories();

    setState(() {

    });

  }
  Future<void> navigationPage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var status = prefs.getBool('isLoggedIn') ?? false;


      pr.show();
      Future.delayed(Duration(seconds: 2))
          .then((value) {
        pr.hide().whenComplete(() {
          if (status == true){
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) =>
                    HomeScreen()
            ),
          );
          }else{
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) =>
                    Intro(),
              ),
            );
          }
        });
      });








  }

  @override
  Future<void> initState()  {
    super.initState();

    setState(() {
      _visible = !_visible;
    });
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    pr = new ProgressDialog(context, showLogs: true);
    pr.style(message: 'Loading...');
var Height= MediaQuery.of(context).size.height;
var Width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[

          new Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                child: Stack(children: [Center(
                  child: Container(
                  decoration: BoxDecoration(

                      image: DecorationImage(
                          image: AssetImage('assets/imgapp/bg.png'),

                      )
                  ),
                )  )],),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height ,

                decoration: BoxDecoration(
                  color: Colors.white,

                ),

              ),

            ],
          ),
        ],
      ),
    );
  }
}


class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}