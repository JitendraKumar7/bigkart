import 'dart:convert';

import 'package:bigkart/UI/Catogries.dart';
import 'package:bigkart/app/AppConstants.dart';
import 'package:bigkart/app/AppPreferences.dart';
import 'package:getwidget/components/badge/gf_badge.dart';
import 'package:getwidget/components/badge/gf_icon_badge.dart';
import 'package:getwidget/components/button/gf_icon_button.dart';
import 'package:getwidget/shape/gf_badge_shape.dart';
import 'package:getwidget/size/gf_size.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:bigkart/app/HttpClient.dart';

import '../Basic.dart';
import 'Cart.dart';
import 'Homemain.dart';
import 'MyProfile.dart';
import 'Profilemain.dart';

class HomeScreen extends StatefulWidget {
  @override
  HomeScreenState createState() => new HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  WooCommerce wooCommerce = WooCommerce(
    baseUrl: BasicData().baseUrl,
    consumerKey: BasicData().consumerKey,
    consumerSecret: BasicData().consumerSecret,
    isDebug: true,
  );
  List<WooCartItem> cart = new List ();
  int currentIndex = 0;
  var  totalitems=0;
  Color colora=Colors.white;
  ProgressDialog pr;
  int _currentIndex = 0;
  PageController _pageController;
  final kSubtitleStyle = TextStyle(
      color: Colors.black,
      fontSize: 16.0,
      height: 1.2,
      fontFamily: "Product Sans"
  );
  final kTitleStyle = TextStyle(
      color: Colors.grey,
      fontSize: 16.0,

      height: 1.5,
      fontFamily: "Product Sans"
  );
  getcartProducts() async {
    AppPreferences.getString(AppConstants.Token_Data).then((value) {
      setState(() {
        HttpClient().gettotalitems(value).then((value) {
          setState(() {
            totalitems =jsonDecode(value);
            print("total items");
            print(totalitems);
            AppPreferences.setString(AppConstants.CARt_ITEM, totalitems.toString());
          });

        });
      });
    });


    cart = await wooCommerce.getMyCartItems();

    setState(() {

    });

  }
  @override
  void initState() {
    super.initState();
getcartProducts();

        _pageController = PageController();







  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
  final List<Widget> viewContainer = [

  //  Create(),
  //  Saved(),
  //  Favourite(),
  //  Xplore(),
  ];
  Widget appBarTitle = new Text("Sales Orders");
  Icon actionIcon = new Icon(Icons.search);
  @override
  Widget build(BuildContext context) {
 /*   AppPreferences.getString(AppConstants.CARt_ITEM).then((value) {
      setState(() {
        totalitems=int.parse(value);
      });
    });*/

    pr = new ProgressDialog(context, showLogs: true);
    pr.style(message: 'Please wait...');
    void onTabTapped(int index) {
      setState(() {
        currentIndex = index;
      });
    }

    return new Scaffold(

      body: SizedBox.expand(
        child: PageView(
            physics:new NeverScrollableScrollPhysics(),
          controller: _pageController,
          onPageChanged: (index) {
            setState(() => _currentIndex = index);
          },
          children: <Widget>[

            Homemain(),
            Catogries(),
            Cartmain(),
            Profilemain(),
          ],
        ),
      ),
      bottomNavigationBar:  BottomNavigationBar(
unselectedLabelStyle: TextStyle(color: Colors.grey),
        selectedLabelStyle: TextStyle(color: Colors.green),
        backgroundColor: Colors.white,
        currentIndex: _currentIndex,
        showSelectedLabels: false,
        showUnselectedLabels: false,


        onTap: (index) {
          setState(() => _currentIndex = index);
          _pageController.jumpToPage(index);
        },
        items: <BottomNavigationBarItem>[
      BottomNavigationBarItem(
      icon: Icon(Icons.home,
        color: Colors.grey,
      ),
        title:Text('Profile',style: TextStyle(color: Colors.green),),
      backgroundColor: Colors.white,

      activeIcon: Icon(Icons.home,
        color: Color(0xFF00C853),
      ),
    ),
    BottomNavigationBarItem(
    icon: Icon(Icons.star_border,
    color: Colors.grey,
    ),
      title:Text('Profile',style: TextStyle(color: Colors.green),),

    activeIcon: Icon(Icons.star_border,
    color: Color(0xFF00C853),
    ),
    ),


    BottomNavigationBarItem(
    icon: GFIconBadge(
    child: GFIconButton(
    size: GFSize.SMALL,
      buttonBoxShadow: false,
      disabledColor: Colors.white,
    color: Colors.transparent,
    icon: Icon(Icons.shopping_cart, size: 25,color: Colors.grey,),



    ),
    counterChild: GFBadge(

    shape: GFBadgeShape.circle,
    color: Colors.orangeAccent,
    child: Text(totalitems.toString()),
    ),
    ),


      title:Text('Profile',style: TextStyle(color: Colors.green),),
    activeIcon: GFIconBadge(
    child: GFIconButton(
    size: GFSize.SMALL,
    buttonBoxShadow: false,
    disabledColor: Colors.white,
    color: Colors.white,
    icon: Icon(Icons.shopping_cart, size: 25,color: Color(0xFF00C853),),

    ),
    counterChild: GFBadge(

    shape: GFBadgeShape.circle,
    color: Colors.orangeAccent,
    child: Text(totalitems.toString()),
    ),

    ),
    ),
          BottomNavigationBarItem(
          icon: Icon(Icons.account_circle_outlined,
    color: Colors.grey,
    ),
            title:Text('Profile',style: TextStyle(color: Colors.green),),
    activeIcon: Icon(Icons.account_circle_outlined,
    color: Color(0xFF00C853),
    ),
    ),

    ],
      ),

    );
    // TODO: implement build


  }
}



