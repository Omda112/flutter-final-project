import 'dart:io';

import 'package:firstproject/add_item/item.dart';
import 'package:firstproject/add_item/item_model.dart';
import 'package:firstproject/dashboard/dashboard_screen.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';




class AddItemScreen extends StatefulWidget {
  const AddItemScreen({super.key});

  @override
  State<AddItemScreen> createState() => _AddItemScreenState();
}


class _AddItemScreenState extends State<AddItemScreen> {

  ImagePicker picker = ImagePicker();

  List<File>? selectedImage = [];


  Future<void> imageSelector() async {
    List<XFile>? images = await picker.pickMultiImage();

    if (images != null && mounted) {
      setState(() {
        selectedImage!.addAll(
            images.map((toElement) => File(toElement.path)).toList());
      });
    }
  }


  TextEditingController title = TextEditingController();
  TextEditingController body = TextEditingController();

  @override
  void dispose() {
    title.dispose();
    body.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/backgrounddd.jpg"),
              fit: BoxFit.cover,
            )
        ),


        child: Consumer <ItemModel>(
          builder: (context, itemModel, child) =>
              ListView(
                children: [
                  SizedBox(height: 30),


                  itemModel.selectedImage!.isEmpty ?
                  Container(
                    color: Colors.white38,
                    height: 150,
                    width: MediaQuery
                        .of(context)
                        .size
                        .width - 20,
                    child: IconButton(
                        onPressed: () {
                          itemModel.imageSelector();
                        },
                        icon: Icon(Icons.camera_alt)
                    ),
                  )
                      :

                  Row(
                    children: [

                      Container(
                        color: Colors.white38,
                        height: 100,
                        width: 100,
                        child: IconButton(
                            onPressed: () {
                              itemModel.imageSelector();
                            },
                            icon: Icon(Icons.camera_alt)
                        ),
                      ),


                      SizedBox(
                        height: 100,
                        width: MediaQuery
                            .of(context)
                            .size
                            .width - 120,
                        child: ListView(
                          scrollDirection: Axis.horizontal,


                          children: itemModel.selectedImage!.map((toElement) =>
                              Stack(
                                children: [

                                  Padding(
                                    padding:    EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: Image.file(
                                      toElement,
                                      height: 100,
                                      width: 100,
                                      fit: BoxFit.cover,
                                    ),
                                  ),

                                  IconButton(
                                      onPressed: () {
                                        itemModel.removeImage(
                                            itemModel.selectedImage!.indexOf(
                                                toElement));
                                      },
                                      icon: Icon(Icons.cancel)
                                  ),
                                ],
                              )).toList(),
                        ),
                      ),
                    ],
                  ),


                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: title,
                      decoration: InputDecoration(
                          hintText: "title",
                          border: OutlineInputBorder()
                      ),
                    ),
                  ),


                  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                          controller: body,
                          minLines: 3,
                          maxLines: 6,
                          decoration: InputDecoration(
                              hintText: "body",
                              border: OutlineInputBorder()
                          )
                      )
                  )
                ],
              ),
        ),
      ),

      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.save),
          onPressed: () {
            final item = Provider.of<ItemModel>(context , listen: false);
            item.addItem(Item(
                images: List.from(item.selectedImage!),
                body: body.text,
                title: title.text,
                favorite: false));

            item.selectedImage!.clear();

            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => DashboardScreen()
                )
            ); //Navigator
          } //onPressed

      ),
    );
  }
}