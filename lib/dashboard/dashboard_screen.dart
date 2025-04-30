import 'package:firstproject/add_item/item.dart';
import 'package:firstproject/add_item/item_model.dart';
import 'package:firstproject/details/details_page/details_screen.dart';
import 'package:firstproject/add_item/add_item_screen.dart';
import 'package:firstproject/details/details_widget/details_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../profile/profile_page/profile_screen.dart';
import '../profile/user_model.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final profileImage= Provider.of<UserModel>(context).user?.image;
    final items= Provider.of<ItemModel>(context);

    return Scaffold(
      appBar: AppBar(title: Text("Dashboard"),
        actions: [

          Stack(
            children: [
              IconButton(onPressed: (){}, icon: Icon(Icons.favorite)),
              CircleAvatar(
                radius: 10,
                backgroundColor: Colors.grey.shade100,
                child: Text("${items.items.length}"),
              )
            ],
          )

          ,

          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfilePage()),
              );
            },
            icon: profileImage==null? Icon(Icons.account_circle_outlined): CircleAvatar(child: ClipOval(child:Image.file(profileImage,
              height:50 , width: 50,fit: BoxFit.cover,),),),
          ),
        ],
      ),

      body:GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2 , crossAxisSpacing: 10),
          itemCount: items.items.length,
          itemBuilder: (context,index){

            return InkWell(

              onTap: (){

                items.selectItem(Item(
                    images: items.items[index].images,
                    body: items.items[index].body,
                    title: items.items[index].title,
                    favorite: items.items[index].favorite));

                Navigator.push(context, MaterialPageRoute(builder: (context) => DetailsScreen()));
              },

              child: SizedBox(child: Column(
                children: [
                  Image.file(items.items[index].images.first , height: 125, width: 200, fit: BoxFit.cover,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(items.items[index].title),
                      FavoriteWidget(index: items.items.indexOf(items.items[index]))
                      /*IconButton(onPressed: (){
                        Provider.of<FavoriteModel>(context, listen: false).add(items.items[index]);

                      }, icon: Icon(Icons.favorite))*/
                    ],)
                ],
              ),
              ),
            );
          }),


      floatingActionButton: FloatingActionButton(onPressed: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => AddItemScreen()));
      }, child: Icon(Icons.add_a_photo),),
    );
  }
}