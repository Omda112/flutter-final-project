import 'dart:io';

class Item{

  List<File> images;
  String title;
  String body;
  bool favorite;

  Item({required this.images , required this.body , required this.title , required this.favorite});

  @override
  bool operator ==(Object other) {
    return other is Item && other.title == title ;
  }

  @override
  int get hashCode => title.hashCode;

}