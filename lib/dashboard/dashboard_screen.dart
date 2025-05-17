import 'package:firstproject/add_item/item.dart';
import 'package:firstproject/add_item/item_model.dart';
import 'package:firstproject/details/details_page/details_screen.dart';
import 'package:firstproject/add_item/add_item_screen.dart';
import 'package:firstproject/details/details_widget/details_widget.dart';
import 'package:firstproject/favorite/favorite_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../profile/profile_page/profile_screen.dart';
import '../user/user_view_model.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final profileImage = Provider.of<UserViewModel>(context).user?.image;
    final items = Provider.of<ItemModel>(context);
    final favs = Provider.of<FavoriteModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Dashboard"),
        actions: [
          Stack(
            children: [
              IconButton(onPressed: () {}, icon: Icon(Icons.favorite)),
              CircleAvatar(
                radius: 10,
                backgroundColor: Colors.grey.shade100,
                child: Text("${favs.fav.length}"),
              )
            ],
          ),
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfilePage()),
              );
            },
            icon: profileImage == null
                ? Icon(Icons.account_circle_outlined)
                : CircleAvatar(
              child: ClipOval(
                child: Image.file(
                  profileImage,
                  height: 50,
                  width: 50,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ],
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
        ),
        itemCount: items.items.length,
        itemBuilder: (context, index) {
          final item = items.items[index];

          return Stack(
            children: [
              InkWell(
                onTap: () {
                  items.selectItem(item);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => DetailsScreen()),
                  );
                },
                child: SizedBox(
                  child: Column(
                    children: [
                      Image.file(
                        item.images.first,
                        height: 125,
                        width: 200,
                        fit: BoxFit.cover,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(item.title),
                          FavoriteWidget(index: index),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 0,
                right: 0,
                child: IconButton(
                  icon: Icon(Icons.remove_circle, color: Colors.red),
                  onPressed: () {
                    items.removeItem(item);
                    favs.remove(item); // Optional, for double safety
                  },
                ),
              ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddItemScreen()));
        },
        child: Icon(Icons.add_a_photo),
      ),
    );
  }
}
