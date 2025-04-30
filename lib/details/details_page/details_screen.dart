import 'package:firstproject/add_item/item.dart';
import 'package:firstproject/profile/user_model.dart';
import 'package:flutter/material.dart';
import '../../add_item/add_item_screen.dart';
import '../../profile/profile_page/profile_screen.dart';
import '../details_widget/favorite_widget.dart';
import 'package:provider/provider.dart';
import 'package:firstproject/add_item/item_model.dart';

class DetailsScreen extends StatelessWidget {
  /*final String? title;
  final String? body;
  final List<File>? image;
*/

  const DetailsScreen(
       {/*this.image, this.title, this.body,*/ super.key}
      );

  @override
  Widget build(BuildContext context) {
    final profileImage= Provider.of<UserModel>(context).user?.image;
    final items= Provider.of<ItemModel>(context);
    return Scaffold(
      appBar: AppBar(
        actions: [

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
        title: Text("The ${items.selectedItem!.title ?? "tree"}"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [

            // image == null || image!.isEmpty?
            Image.file(
              items.selectedItem!.images.first,
              width: double.infinity,
              fit: BoxFit.cover,
            ) ,
            /*Image.file(
              image![0],
              height: 300,
              fit: BoxFit.cover,
              width: double.infinity,
            ),*/


            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FavoriteWidget(index: items.items.indexOf(items.selectedItem!),),
                IconButton(onPressed: () {}, icon: Icon(Icons.share)),
              ],
            ),


            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                items.selectedItem!.body,
                    //?? " A tree is a majestic and vital part of nature, standing tall with its strong trunk and widespread branches. Its leaves, whether vibrant green in spring or golden in autumn, provide shade, oxygen, and beauty to the environment. Deep roots anchor it firmly in the soil, absorbing water and nutrients to sustain life. Birds, insects, and animals find shelter within its branches, making it a small ecosystem of its own. Whether in a dense forest or standing alone in a quiet field",
                textAlign: TextAlign.justify,
                style: TextStyle(fontSize: 16),
              ),
            ),


           /* image == null || image!.isEmpty
                ? Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                MySeason(url: "assets/fall.jpg", text: "fall"),
                MySeason(url: "assets/spring.jpg", text: "spring"),
              ],
            )
                :*/
            SizedBox(
              height: 500,
              child: GridView.builder(
                itemCount: items.selectedItem!.images!.length,
                itemBuilder: (context, index) => Image.file(
                  items.selectedItem!.images[index],
                  fit: BoxFit.cover,
                  height: 100,
                  width: 200,
                ),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                ),
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddItemScreen()),
          );
        },
        child: Icon(Icons.next_plan),
      ),
    );
  }
}

extension on List<Item> {
  get selectedItem => null;
}