import 'dart:io';

import 'package:firstproject/add_item/item.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';

class ItemModel extends ChangeNotifier{

  final List<Item> _items = [];
  List<Item> get items => _items;

  Item? _selectedItem;
  Item? get selectedItem => _selectedItem;

  List<Item> _favorites = [];
  List<Item> get favorites => _favorites;

  void addItem(Item item){
    _items.add(item);
    notifyListeners();
  }

  ImagePicker picker = ImagePicker();

  List<File>? selectedImage = [];


  Future<void> imageSelector() async {
    List<XFile>? images = await picker.pickMultiImage();

    if (images != null ) {

        selectedImage!.addAll(images.map((toElement) => File(toElement.path)).toList());

    }
    notifyListeners();
  }

  void removeImage(index){

      selectedImage!.removeAt(index);
      notifyListeners();
  }

  void selectItem(Item item){
    _selectedItem = item;
    notifyListeners();
  }

  void toggleFavorite(Item item) {
    item.favorite = !item.favorite;
    if (item.favorite) {
      _favorites.add(item);
    } else {
      _favorites.removeWhere((fav) => fav == item);
    }
    notifyListeners();
  }
}