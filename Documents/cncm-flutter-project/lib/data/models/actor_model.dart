import 'package:flutter/material.dart';

import 'TrackModel.dart';


class FilmAndTheaterFieldData{
  TextEditingController title;
  TextEditingController year;
  TextEditingController releaseDate;
  TextEditingController runtimeLength;
  TextEditingController genre;
  TextEditingController director;
  TextEditingController writer;
  TextEditingController rossio;
  TextEditingController plot;
  TextEditingController language;
  TextEditingController country;
  TextEditingController poster;
  TextEditingController metaScore;
  TextEditingController type;
  TextEditingController production;
  TextEditingController website;

  FilmAndTheaterFieldData({var title,var year,var releaseDate,var runtimeLength
    ,var genre ,var director ,var writer ,var rossio ,var plot ,var language,
    var country, var poster, var metaScore, var type, var production, var website
  })
      : title =TextEditingController(text: ''),
        year = TextEditingController(text: ''),
        releaseDate = TextEditingController(text: ''),
        runtimeLength = TextEditingController(text: ''),
        genre  =TextEditingController(text: ''),
        director  =TextEditingController(text: ''),
        writer  =TextEditingController(text: ''),
        rossio  =TextEditingController(text: ''),
        plot  =TextEditingController(text: ''),
        language  =TextEditingController(text: ''),
        country = TextEditingController(text: ''),
        poster = TextEditingController(text: ''),
        metaScore = TextEditingController(text: ''),
        type = TextEditingController(text: ''),
        production = TextEditingController(text: ''),
        website = TextEditingController(text: '');



}

class ActorModel {
  TextEditingController? actorName;
  TextEditingController? role;
  List<List<ContributorsModel>>? contributors ;
  var defaultValue = ContributorsModel(name: '',sharedPercentage: '',role: '');

  ActorModel({var actorName,var contributors ,var role, }) :
        this.actorName =TextEditingController(text: ''),
        this.role =TextEditingController(text: ''),
        this.contributors = contributors ?? [[ContributorsModel(name: TextEditingController(text: ''),
            sharedPercentage: '',role: '')]];



}