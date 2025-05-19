import 'dart:io';

class Item{

  List<File> images;
  String title;
  String body;
  bool favorite;
  String ownerEmail; // New field

  Item({required this.images , required this.body , required this.title , required this.favorite, required this.ownerEmail});

  @override
  bool operator ==(Object other) {
    return other is Item && other.title == title && other.ownerEmail == ownerEmail;  }

  @override
  int get hashCode => title.hashCode ^ ownerEmail.hashCode;

}