import 'package:flutter/cupertino.dart';

class PhotographAssetFieldData{
  TextEditingController creator;
  TextEditingController title;
  TextEditingController date;
  TextEditingController description;
  TextEditingController cameraManufacturer;
  TextEditingController cameraModel;
  TextEditingController exposureTime;
  TextEditingController fNumber;
  TextEditingController isoSpeedRating;
  TextEditingController dateAndTimeOfDataGeneration;
  TextEditingController lensFocalLength;
  TextEditingController imageWidth;
  TextEditingController imageHeight;

 PhotographAssetFieldData({var creator, var title, var date, 
   var description, var cameraManufacturer, var cameraModel, 
   var exposureTime, var fNumber, var isoSpeedRating, 
   var dateAndTimeOfDataGeneration, var lensFocalLength, var imageSize
 }):creator  = TextEditingController(text: ''),
  title  = TextEditingController(text: ''),
  date  = TextEditingController(text: ''),
  description = TextEditingController(text: ''),
  cameraManufacturer = TextEditingController(text: ''),
  cameraModel = TextEditingController(text: ''),
  exposureTime = TextEditingController(text: ''),
  fNumber = TextEditingController(text: ''),
  isoSpeedRating = TextEditingController(text: ''),
  dateAndTimeOfDataGeneration = TextEditingController(text: ''),
  lensFocalLength = TextEditingController(text: ''),
  imageHeight = TextEditingController(text: ''),
  imageWidth = TextEditingController(text: '');
}