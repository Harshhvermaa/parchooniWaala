import 'dart:io' as io ;

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class storageService
{

 uploadimage(String CategoryName , String path , String refname) async
  {
   FirebaseStorage storage = await FirebaseStorage.instance;
  io.File file = io.File(path);
  await storage.ref("$refname/$CategoryName").putFile(file);
  }


fetchImage(String CategoryName , String refname) async
{
  String url = "";
  await FirebaseStorage
  .instance
  .ref("$refname/$CategoryName")
  .getDownloadURL()
  .then((value) async
  {
     url = await value.toString();
  });
  print("sdffds" + url );
  return url;
}
}