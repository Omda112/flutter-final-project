import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../profile/profile_page/profile_screen.dart';

import '../user/user_view_model.dart';
import 'favorite_model.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final profileImage= Provider.of<UserViewModel>(context).user?.image;
    final favs= Provider.of<FavoriteModel>(context);

    return  Scaffold(

      appBar: AppBar(title: Text("Favorites"),
        actions: [

          Stack(
            children: [
              IconButton(onPressed: (){}, icon: Icon(Icons.favorite)),
              CircleAvatar(
                radius: 10,
                backgroundColor: Colors.grey.shade100,
                child: Text("${favs.fav.length}"),
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

      body: Consumer<FavoriteModel>(
          child: Text("No items found"),






          builder: (context, fav , child) {
            if (fav.fav.isNotEmpty){

              return GridView.builder(

                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(

                      crossAxisCount: 2, crossAxisSpacing: 10
                  ),
                  itemCount: fav.fav.length,
                  itemBuilder: (context, index) {
                    return SizedBox(
                      child: Column(
                        children: [
                          Image.file(
                            fav.fav[index].images.first, height: 125,
                            width: 200,
                            fit: BoxFit.cover,),


                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(fav.fav[index].title),
                              IconButton(onPressed: () {
                                fav.fav[index].favorite = false;

                                fav.remove(fav.fav[index]);
                              }, icon: Icon(Icons.favorite, color: Colors.red,))
                            ],
                          )

                        ],),);
                  }
              )
              ;
            }
            else{
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: child!,
              );
            }}

      ),

    );
  }
}