import 'dart:convert';
import 'dart:io';
import 'package:bigkart/app/Basicdata.dart';

import 'AppConstants.dart';

import 'package:http/http.dart' as http;

class HttpClient extends AppConstants {
  //final String base = 'https://meo.co.in/meoApiPro/konnectBusiness_v4/index.php/';
  final String base = 'https://bigkart.in';
 // https://bigkart.in/wp-json/cocart/v1/get-cart?consumer_key=ck_19923520b89fb76ad04bf4a11ae1938e4700ad42&consumer_secret=cs_86583c4e2ace6fd29ca13fa18e063fccafeb7ef0
  Future<String> getcart( String auth) async {

    final http.Response response = await http.get(
      '${base}/wp-json/cocart/v1/get-cart?consumer_key=${BasicData().consumerKey}&consumer_secret=${BasicData().consumerSecret}',
      headers: <String, String>{
        'Content-Type': 'application/json',
        'authorization':'Bearer '+auth},


    );

    print('Response Body ${response.body}');
    return response.body;
  }
  Future<String> gettotal( String auth) async {

    final http.Response response = await http.get(
      '${base}/wp-json/cocart/v1/totals?consumer_key=${BasicData().consumerKey}&consumer_secret=${BasicData().consumerSecret}',
      headers: <String, String>{
        'Content-Type': 'application/json',
        'authorization':'Bearer '+auth},


    );

    print('Response Body ${response.body}');
    return response.body;
  }
  Future<String> gettotalitems( String auth) async {

    final http.Response response = await http.get(
      '${base}/wp-json/cocart/v1/count-items?consumer_key=${BasicData().consumerKey}&consumer_secret=${BasicData().consumerSecret}',
      headers: <String, String>{
        'Content-Type': 'application/json',
        'authorization':'Bearer '+auth},


    );

    print('Response Body ${response.body}');
    return response.body;
  }
  Future<String> addtocart( productid,qunty,variation,auth) async {
    Map params = Map<String, dynamic>();

    params['variation_id'] = variation;
    params['quantity'] = qunty;
    params['product_id'] = productid;
    params['quantity'] = qunty;
    params['consumerKey'] = BasicData().consumerKey;
    params['consumerSecret'] = BasicData().consumerSecret;

    final http.Response response = await http.post(
      '${base}/wp-json/cocart/v1/add-item',
      headers: <String, String>{
        'authorization':'Bearer '+auth},

      body: params,
    );

    print('Response Body ${response.body}');
    return response.body;
  }
  Future<String> removetocart( productid,auth) async {
    Map params = Map<String, dynamic>();
    params['cart_item_key'] = productid;

    params['consumerKey'] = BasicData().consumerKey;
    params['consumerSecret'] = BasicData().consumerSecret;

    final http.Response response = await http.delete(
      '${base}/wp-json/cocart/v1/item?consumer_key=${BasicData().consumerKey}&consumer_secret=${BasicData().consumerSecret}&cart_item_key=${productid}',
      headers: <String, String>{
        'authorization':'Bearer'+auth,
        'Content-Type': 'application/json',

       },

    );

    print('Response Body ${response.body}');
    return response.body;
  }
  Future<String> clearcart( auth) async {
    Map params = Map<String, dynamic>();

    params['consumerKey'] = BasicData().consumerKey;
    params['consumerSecret'] = BasicData().consumerSecret;

    final http.Response response = await http.post(
      '${base}/wp-json/cocart/v1/clear?consumer_key=${BasicData().consumerKey}&consumer_secret=${BasicData().consumerSecret}',
      headers: <String, String>{
      'authorization':'Bearer'+auth,
        'Content-Type': 'application/json',

      },

    );

    print('Response Body ${response.body}');
    return response.body;
  }
  Future<String> updatetocart( productid,qunty,auth) async {
    Map params = Map<String, dynamic>();
    params['cart_item_key'] = productid;
    params['quantity'] = qunty;
    params['consumerKey'] = BasicData().consumerKey;
    params['consumerSecret'] = BasicData().consumerSecret;

    final http.Response response = await http.post(
      '${base}/wp-json/cocart/v1/item',
      headers: <String, String>{
        'Content-Type': 'application/json',
        'authorization':'Bearer '+auth},

      body:jsonEncode( params),
    );

    print('Response Body ${response.body}');
    return response.body;
  }
  Future<String> createcustomer( var Password,String Email,String Username,String Phone,String City,String State, String Address,String Postcode) async {


    final http.Response response = await http.post(
      '${base}/wp-json/wc/v3/customers?consumer_key=${BasicData().consumerKey}&consumer_secret=${BasicData().consumerSecret}',
      headers: <String, String>{
        'Content-Type': 'application/json',
        },body:jsonEncode(

        {"password":Password,
        "email": Email,
        "first_name": Username,

        "username": Username,
        "billing": {
          "first_name": Username,


        "address_1": Address,

        "city": City,
        "state": State,
        "postcode": Postcode,
        "country": "india",
        "email": Email,
        "phone": Phone
        },
        "shipping": {
          "first_name": Username,


        "address_1": Address,
          "city": City,
        "state": State,
        "postcode": Postcode,
        "country": "india"
        }
    })




    );

    print('Response Body ${response.body}');
    return response.body;
  }


}