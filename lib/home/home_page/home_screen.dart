import 'dart:io';

import 'package:firstproject/add_item/add_item_screen.dart';
import 'package:firstproject/profile/profile_page/profile_screen.dart';
import 'package:flutter/material.dart';
import '../home_widget/home_widget.dart';


class MyHomePage extends StatelessWidget {
  final String? title;
  final String? body;
  final List <File>? image;
  const MyHomePage({super.key, this.title , this.body, this.image});

  @override
  Widget build (BuildContext context){
    return Scaffold(
      appBar:AppBar(
          actions: [IconButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => ProfilePage()));
          },
              icon: Icon(Icons.account_circle_outlined))],
          title:Text("The ${title ?? "Tree"}")
          ,centerTitle: true
      ) ,
      body:
      SingleChildScrollView(
        child: Column(children: [
          image == null || image!.isEmpty? Image.asset("assets/tree.jpg" ,width: double.infinity, fit: BoxFit.fill):Image.file(image![0] , height: 300,width: double.infinity, fit: BoxFit.cover,),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              FavoriteWidget (),
              IconButton(onPressed:(){}, icon:Icon(Icons.share)),

            ],
          ),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text( textAlign: TextAlign.justify , body ?? "Trees are essential for the enviroment as they produce oxygen, absorb carbon dioxide, and improve air quality. They help prevent soil erosion by holding the ground together with their roots. Many animals depend in trees for food and shelter, creating rich ecosystems. Additionally, trees provide shade, reducing tempratures and making urban areas more livable. Some trees can live for thousands of years, making them among the oldest living organisms on earth "),
          ),

          image == null || image!.isEmpty?
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              MySeason(url: "assets/spring.jpg", text: "Spring"),
              MySeason(url: "assets/fall.jpg", text: "Fall"),
            ],
          ):
              SizedBox( height: 500,
                child: GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2 ,mainAxisSpacing: 10 , crossAxisSpacing: 10),
                  itemCount: image!.length, itemBuilder: (context,index) => Image.file(image![index] , height: 200,width: 200,fit: BoxFit.cover,)),
              )
        ],
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => AddItemScreen()));
      } , child: Icon(Icons.next_plan),),
    );
  }
}



