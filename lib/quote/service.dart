import 'dart:convert';

import 'package:firstproject/quote/quote.dart';
import 'package:http/http.dart' as http;


Future<List<Quote>> fetchQuote () async{

 final response = await http.get(Uri.parse("https://api.api-ninjas.com/v1/quotes"),
   headers: {
     'X-Api-Key': 'TeNGTQvieFx6dH5fLOr2IQ==G7YBFTKUaZ4DGTZp'
   },
 );

 if(response.statusCode == 200){
   List<dynamic> data = jsonDecode(response.body) ;
   return data.map((json) => Quote.fromJson(json)).toList();
 }
 throw Exception("Failed to load data!");
}