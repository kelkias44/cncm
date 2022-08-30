import 'package:flutter/cupertino.dart';
class MusicAssetFieldData{
  TextEditingController album;
  TextEditingController genre;
  TextEditingController date;
  TextEditingController description;
  TextEditingController publisherName;
  TextEditingController publisherId;
  TextEditingController publisherPercentage;


  MusicAssetFieldData({var album ,var genre ,var date ,var description ,var publisherName ,var publisherId ,var publisherPercentage })
  : album =TextEditingController(text: ''),
  genre  =TextEditingController(text: ''),
  date  =TextEditingController(text: ''),
  description  =TextEditingController(text: ''),
  publisherName  =TextEditingController(text: ''),
  publisherId  =TextEditingController(text: ''),
  publisherPercentage  =TextEditingController(text: '');

}


class TrackModel {
  TextEditingController? trackName;
  TextEditingController? language;
  TextEditingController? duration;
  String? isrc;
  List<List<ContributorsModel>>? contributors ;
  var defaultValue = ContributorsModel(name: '',sharedPercentage: '',role: '');

  TrackModel({var trackName,var language,var duration,var contributors  ,var isrc }) :
        this.trackName =TextEditingController(text: ''),
        this.language =TextEditingController(text: ''),
        this.duration =TextEditingController(text: ''),
        this.isrc ='',
        this.contributors = contributors ?? [[ContributorsModel(name: TextEditingController(text: ''),
            sharedPercentage: '',role: '')]];
}
class ContributorsModel {

  TextEditingController? name;
  TextEditingController? sharedPercentage;
  TextEditingController? role;
  TextEditingController? id;

  ContributorsModel({var name ,var sharedPercentage ,var role, var id })
       : name = TextEditingController(text: ''),
         sharedPercentage =TextEditingController(text: ''),
         role = TextEditingController(text: ''),
         id = TextEditingController(text: '');
}