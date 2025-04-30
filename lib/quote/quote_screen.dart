import 'package:firstproject/quote/quote.dart';
import 'package:firstproject/quote/service.dart';
import 'package:flutter/material.dart';

class QuoteScreen extends StatefulWidget {
  const QuoteScreen({super.key});

  @override
  State<QuoteScreen> createState() => _QuoteScreenState();
}

class _QuoteScreenState extends State<QuoteScreen> {

  late Future<List<Quote>> future;

  @override
  void initState() {
    future = fetchQuote();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body:  Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
        image: DecorationImage(
        image: AssetImage("assets/backgrounddd.jpg"),
    fit: BoxFit.cover,
    )
    ),

    child: FutureBuilder(future: future, builder: (context , snapshot)
    {
      if(snapshot.hasData) {
        ListView.builder(
          itemCount: snapshot.data!.length,
          itemBuilder: (context, index) =>
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Text(snapshot.data![index].quote),
                    Text(snapshot.data![index].author),
                    Text(snapshot.data![index].category),

                  ],
                ),
              ),
        );
      }
      else if(snapshot.hasError){
        return Icon(Icons.wifi_off_sharp , color: Colors.brown.shade200, size: 200,);
      }
      return  Center(child: SizedBox(
          height: 100,
          child: CircularProgressIndicator()));
    }
    ),


      ));
  }
}
