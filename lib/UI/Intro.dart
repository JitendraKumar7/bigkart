

import 'package:bigkart/UI/Login.dart';

import '../Basic.dart';

class Intro extends StatefulWidget {
  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<Intro> {
  final kTitleStyle = TextStyle(
    color: Colors.black,
    fontSize: 26.0,

    height: 1.5,
      fontFamily: "Product Sans"
  );

  final kSubtitleStyle = TextStyle(
    color: Colors.grey,
    fontSize: 14.0,
    height: 1.2,
      fontFamily: "Product Sans"
  );

  final int _numPages = 3;
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  List<Widget> _buildPageIndicator() {
    List<Widget> list = [];
    for (int i = 0; i < _numPages; i++) {
      list.add(i == _currentPage ? _indicator(true) : _indicator(false));
    }
    return list;
  }

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: Duration(microseconds: 150),
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      height: 8.0,
      width: isActive ? 24.0 : 16.0,
      decoration: BoxDecoration(
        color: isActive ? Colors.greenAccent:Color(0xFFF1F8E9) ,
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: Container(
          decoration: BoxDecoration(

          ),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 0.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Container(
                  height: MediaQuery.of(context).size.height-150,
                  child: PageView(
                    physics: ClampingScrollPhysics(),
                    controller: _pageController,
                    onPageChanged: (int page) {
                      setState(() {
                        _currentPage = page;
                      });
                    },
                    children: <Widget>[

                      Padding(
                        padding: EdgeInsets.all(0.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[


                            Center(
                              child: Container(
                                color: Color(0xFFF1F8E9),
                                height: MediaQuery.of(context).size.height*0.50,
                                width: MediaQuery.of(context).size.width,
                                child: Image(
                                  image:
                                  AssetImage('assets/imgapp/onbd1.png'),

                                ),
                              ),
                            ),
                            SizedBox(height: 30.0),
                            Text('Quality Kirana',

                              style:kTitleStyle , ),
                            SizedBox(height: 20,),
                            Text('Best Quality  Kirana items delivery at your store',

                              style:kSubtitleStyle , ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(0.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[


                            Center(
                              child: Container(
                                color: Color(0xFFF1F8E9),
                                height: MediaQuery.of(context).size.height*0.50,
                                width: MediaQuery.of(context).size.width,
                                child: Image(
                                  image:
                                  AssetImage('assets/imgapp/onbd2.png'),

                                ),
                              ),
                            ),
                            SizedBox(height: 30.0),
          Text('Easy  Ordering',

            style:kTitleStyle , ),
          SizedBox(height: 20,),
          Text('Order Easy and quick with minimal features', style:kSubtitleStyle ,
          ),
            ],
                        ),
                      ),
                      Padding(

                        padding: EdgeInsets.all(0.0),
                        child: Column(

                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[

                            Center(
                              child: Container(
                                color: Color(0xFFF1F8E9),
                                height: MediaQuery.of(context).size.height*0.50,
                                width: MediaQuery.of(context).size.width,
                                child: Image(
                                  image:
                                  AssetImage('assets/imgapp/onbg3.png'),

                                ),
                              ),
                            ),
                            SizedBox(height: 30.0),
                            Text('Fast Delivery',

                              style:kTitleStyle , ),
                            SizedBox(height: 20,),
                            Text('Get fast delivery and pay only when you are statistied',

                              style:kSubtitleStyle , ),
                          ],
                        ),
                      ),

                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: _buildPageIndicator(),
                ),
                _currentPage != _numPages - 1
                    ? Expanded(
                  child: Align(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          InkWell(child:
                          Padding(
                            padding:EdgeInsets.symmetric(horizontal: 15.0),
                            child: Text(
                              'Skip',
                              style: TextStyle(
                                  color: Colors.black, fontSize: 24.0),
                            ),
                          )
                          ,onTap:() {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                  LoginPage()
                              ),
                              );
                            },),
                          FlatButton(
                            onPressed: () {
                              _pageController.nextPage(
                                  duration: Duration(microseconds: 300),
                                  curve: Curves.easeIn);
                            },
                            child: Text(
                              'Next',
                              style: TextStyle(
                                  color: Colors.black, fontSize: 24.0),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
                    : Text(''),
              ],
            ),
          ),
        ),
      ),
      bottomSheet: _currentPage == _numPages - 1
          ? Container(

        height: 80.0,
        width: double.infinity,
        color:  Color(0xFFF1F8E9),
        child: GestureDetector(
          onTap: () {

            Navigator.push(
              context,
             MaterialPageRoute(
                    builder: (BuildContext context) =>
                        LoginPage()
              ),
            );
          },
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Get Started',
                  style: TextStyle(
                      color: Colors.greenAccent,
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(width: 10.0),
                Icon(
                  Icons.arrow_forward,
                  color: Colors.greenAccent,
                  size: 30.0,
                )
              ],
            ),
          ),
        ),
      )
          : Text(''),
    );
  }
}
