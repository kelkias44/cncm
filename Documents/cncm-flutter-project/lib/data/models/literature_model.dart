import 'package:flutter/material.dart';

import 'TrackModel.dart';

class LiteratureAssetFieldData{
  TextEditingController title;
  TextEditingController language;
  TextEditingController subject;
  TextEditingController description;
  TextEditingController date;
  TextEditingController pageNumbers;
  TextEditingController publisherName;
  TextEditingController publisherId;
  TextEditingController publisherPercentage;
  TextEditingController copyrightStatus;
  List<List<ContributorsModel>>? contributors ;
  var defaultValue = ContributorsModel(name: '',sharedPercentage: '',role: '');


  LiteratureAssetFieldData({var title, var language, var subject ,var date 
  ,var description , var pageNumbers, var publisherName 
  ,var publisherId ,var publisherPercentage, var copyrightStatus,var contributors
  }):title  =TextEditingController(text: ''),
  language  =TextEditingController(text: ''),
  subject  =TextEditingController(text: ''),
  date  =TextEditingController(text: ''),
  description  =TextEditingController(text: ''),
  copyrightStatus  =TextEditingController(text: ''),
  pageNumbers  =TextEditingController(text: ''),
  publisherName  =TextEditingController(text: ''),
  publisherId  =TextEditingController(text: ''),
  publisherPercentage  =TextEditingController(text: ''),
  contributors = contributors ?? [[ContributorsModel(name: TextEditingController(text: ''),
            sharedPercentage: '',role: '')]];

}