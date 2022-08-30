import 'dart:developer';

import 'package:cncm_flutter_new/core/colors.dart';
import 'package:cncm_flutter_new/data/models/TrackModel.dart';
import 'package:cncm_flutter_new/data/models/actor_model.dart';
import 'package:cncm_flutter_new/data/models/literature_model.dart';
import 'package:cncm_flutter_new/data/models/photograph_model.dart';
import 'package:cncm_flutter_new/presentation/assets_manager/pages/AssetManagePage.dart';
import 'package:cncm_flutter_new/presentation/assets_manager/pages/add_music.dart';
import 'package:cncm_flutter_new/presentation/assets_manager/pages/user_search_delegate.dart';
import 'package:cncm_flutter_new/presentation/assets_manager/register_bulk_asset_bloc/bloc.dart';
import 'package:cncm_flutter_new/presentation/auth/blocs/title_bloc/bloc.dart';
import 'package:cncm_flutter_new/presentation/auth/blocs/title_bloc/state.dart';
import 'package:cncm_flutter_new/presentation/common/widgets/customLoader.dart';
import 'package:cncm_flutter_new/presentation/common/widgets/custom_button.dart';
import 'package:dartz/dartz_unsafe.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sticky_headers/sticky_headers.dart';

import '../../../core/constants.dart';
import '../../../core/util/local_storage_service.dart';
import '../../../data/models/AssetRegistrationRequest.dart';
import '../../../data/models/BulkAssetRequest.dart';
import '../../../data/models/UserSearchResponse.dart';
import '../../../service_locator.dart';
import '../../auth/blocs/title_bloc/event.dart';
import '../../common/ui_helper/snackbar.dart';
import '../register_asset_bloc/bloc.dart';
import '../register_asset_bloc/event.dart';
import '../register_asset_bloc/state.dart';
import '../register_bulk_asset_bloc/event.dart';
import '../register_bulk_asset_bloc/state.dart';
import '../search_bloc/bloc.dart';
import '../widget/decorations.dart';
import '../widget/numberTextField.dart';
import '../widget/textFieldWidget.dart';

typedef OnDelete();

class AddAssetPage extends StatefulWidget {
  AddAssetPage({Key? key, required this.assetTypeArgument}) : super(key: key);
  static const String addAssetPage = 'add_asset_page';

  final AssetTypeArgument assetTypeArgument;
  static const kPadding = 15.0;
  final state = _AddAssetPageState();

  @override
  State<AddAssetPage> createState() => state;

  bool isValid() => state.validateForm();
}

class _AddAssetPageState extends State<AddAssetPage> {
  /// music asset registration controllers

  final TextEditingController _albumController = TextEditingController();

  final TextEditingController _upcController = TextEditingController();

  final TextEditingController _generController = TextEditingController();

  final TextEditingController _dateController = TextEditingController();

  final TextEditingController _descriptionController = TextEditingController();

  final TextEditingController _publisherNameController =
      TextEditingController();

  final TextEditingController _ownershipPercentageController =
      TextEditingController();

  final TextEditingController _contributorFullNameController =
      TextEditingController();

  final TextEditingController _sharedPercentageController =
      TextEditingController();

  final TextEditingController _roleController = TextEditingController();

  /// Film asset registration controllers
  final TextEditingController _titleController = TextEditingController();

  final TextEditingController _genreController = TextEditingController();

  final TextEditingController _langugeController = TextEditingController();

  // final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _durationController = TextEditingController();

  final TextEditingController _releaseDateController = TextEditingController();

  final TextEditingController _steeringController = TextEditingController();

  final TextEditingController _directorController = TextEditingController();

  final TextEditingController _labelRatingController = TextEditingController();

  /// literature asset registration controllers
  final TextEditingController _authorController = TextEditingController();

  final TextEditingController _subjectController = TextEditingController();

  final TextEditingController _pageNumberController = TextEditingController();

  ///photography asset registration controllers
  final TextEditingController _photographyController = TextEditingController();

  final TextEditingController _creatorController = TextEditingController();

  final TextEditingController _fNumberController = TextEditingController();

  final TextEditingController _cameraManufacturerController =
      TextEditingController();

  final TextEditingController _exposureTimeController = TextEditingController();

  final TextEditingController _cameraModelController = TextEditingController();

  final TextEditingController _isoSpeedRatingController =
      TextEditingController();

  final TextEditingController _lensFocalLengthController =
      TextEditingController();

  final TextEditingController _captureDateController = TextEditingController();

  final TextEditingController _imageWidthController = TextEditingController();

  final TextEditingController _imageHeightController = TextEditingController();

  ///theater and drama controller
  final TextEditingController _yearController = TextEditingController();

  final TextEditingController _runTimeController = TextEditingController();

  final TextEditingController _writerController = TextEditingController();

  final TextEditingController _rossioController = TextEditingController();

  final TextEditingController _plotController = TextEditingController();

  final TextEditingController _countryController = TextEditingController();
  final TextEditingController _posterController = TextEditingController();
  final TextEditingController _metaScoreController = TextEditingController();
  final TextEditingController _typeController = TextEditingController();
  final TextEditingController _productionController = TextEditingController();
  final TextEditingController _websiteController = TextEditingController();
  final TextEditingController _actorNameController = TextEditingController();
  final TextEditingController _actorRoleController = TextEditingController();

  final List<List<TextEditingController>> contributorFulNameControllers =
      <List<TextEditingController>>[];
  final contributorSharedPercentageControllers =
      <List<TextEditingController>>[];
  final contributorRoleControllers = <List<TextEditingController>>[];

  final List<TextEditingController> _isrcNumberController = [
    TextEditingController(text: '')
  ];
  List<List<DropdownMenuItem<String>>> titleDropdownItems = [[]];
  List<DropdownMenuItem<String>> literatureContributorRole = [];
  String? titleValue;

  MusicAssetFieldData musicAssetFieldData = MusicAssetFieldData();
  FilmAndTheaterFieldData filmAndTheaterFieldData = FilmAndTheaterFieldData();
  ContributorsModel contributorsFieldData = ContributorsModel();
  LiteratureAssetFieldData literatureAssetFieldData =
      LiteratureAssetFieldData();
  PhotographAssetFieldData photographAssetFieldData =
      PhotographAssetFieldData();

  List<TrackModel> trackModel = [TrackModel()];
  List<ActorModel> actorModel = [ActorModel()];
  List<ContributorsModel> contributorModel = [ContributorsModel()];
  late final OnDelete onDelete;

  double trackListHeight = 650;
  double actorListHeight = 450;
  double contributorHeight = 550;
  List<double> contributorListHeight = [270];
  double literatureContributorListHeight = 270;
  String? typtitle;

  String? _selectedDate;

  _rebuildHeight(int index) {
    double addHeight = 0;
    for (int i = 0; i < trackModel.length; i++) {
      addHeight = addHeight + trackModel[i].contributors!.length.toDouble() - 1;
    }
    trackListHeight = 650 * trackModel.length + (addHeight * 270);
    contributorListHeight[index] =
        270 * trackModel[index].contributors!.length.toDouble();
  }

  _rebuildLiteratureHeight() {
    double addHeight = 0;
    addHeight = addHeight +
        literatureAssetFieldData.contributors!.length.toDouble() -
        1;
    literatureContributorListHeight =
        270 * literatureAssetFieldData.contributors!.length.toDouble();
  }

  _rebuildActorHeight(int index) {
    double addHeight = 0;
    for (int i = 0; i < actorModel.length; i++) {}
    actorListHeight = 650 * actorModel.length + (addHeight * 270);
  }

  @override
  initState() {
    sl<TitleBloc>().add(LoadTitles());
  }

  ///called when new track is created
  _calculateSecondHeight() {
    contributorListHeight.add(270);
    trackListHeight = trackListHeight + 650;
  }

  _calculateActorSecondHeight() {
    contributorListHeight.add(270);
    actorListHeight = actorListHeight + 650;
  }

  _calculateContributorSecondHeight() {
    contributorListHeight.add(270);
    contributorHeight = contributorHeight + 650;
  }

  bool validateForm() {
    var isValid = forms.currentState?.validate();
    if (isValid!) forms.currentState?.save();
    print('is valid value from form validate is $isValid');
    return isValid;
  }

  addNewTrack() {
    // titleDropdownItems.add([]);
    trackModel.add(TrackModel());
    //titleDropdownItems.add([]);
  }

  addNewActor() {
    actorModel.add(ActorModel());
  }

  addNewContributor() {
    contributorModel.add(ContributorsModel());
  }

  addContributor(int index) {
    trackModel[index]
        .contributors
        ?.add([ContributorsModel(name: '', sharedPercentage: '', role: '')]);
  }

  addLiteratureContributor() {
    literatureAssetFieldData.contributors!
        .add([ContributorsModel(name: '', sharedPercentage: '', role: '')]);
  }

  final forms = GlobalKey<FormState>();
  List<TrackModel> tracks = [];
  List<ActorModel> actors = [];
  List<ContributorsModel> filmContributors = [];

  void onSave() {
    validateForm();
  }

  bool showSuggestion = false;
  static const kPadding = 15.0;

  @override
  Widget build(BuildContext context) {
    setState(() {
      typtitle = widget.assetTypeArgument.assetType;
    });
    tracks.clear();

    ///retrieve all tracks data from the forms
    for (int i = 0; i < trackModel.length; i++) {
      tracks.add(trackModel[i]);
      print(tracks[i].trackName);
    }

    /// retrieve all actors data from the forms
    for (int i = 0; i < actorModel.length; i++) {
      actors.add(actorModel[i]);
      print(actors[i].actorName);
    }

    /// retrieve all FilmContributors data from the forms
    for (int i = 0; i < contributorModel.length; i++) {
      filmContributors.add(contributorModel[i]);
      print(filmContributors[i].name);
    }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
        title: const Text("Asset Registering"),
        backgroundColor: Colors.black,
        elevation: 0,
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: BlocConsumer<RegisterBulkAssetBloc, RegisterBulkAssetState>(
              listener: (context, state) {
                if (state is RegisteredBulkAssetState) {
                  showSnackBar(
                      "Album Asset Registration is succeed!!", context);
                  Navigator.pop(context);
                } else if (state is ErrorRegisterBulkAsset) {
                  showSnackBar(state.errorResponse.message, context);
                }
              },
              builder: (context, bulkAssetState) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: BlocConsumer<RegisterAssetBloc, RegisterAssetState>(
                    listener: (context, state) {
                      if (state is RegisteredAssetState) {
                        showSnackBar("Asset Register is succeed!!", context);
                        Navigator.pop(context);
                      } else if (state is ErrorRegisterAsset) {
                        showSnackBar(state.errorResponse.message, context);
                      }
                    },
                    builder: (context, state) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          const SizedBox(height: 20),
                          // CreateMusic(),

                          widget.assetTypeArgument.assetType == music
                              ? musicRegistrationWidget()
                              : widget.assetTypeArgument.assetType ==
                                      audioVisualAndFilm
                                  ? filmAndTheaterRegistration()
                                  // Column(
                                  //           crossAxisAlignment: CrossAxisAlignment.start,
                                  //           children: [
                                  //             const Text("Register Your Audio visual and Film",
                                  //                 style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                                  //             filmAndTheaterRegistration(context),
                                  //           ],
                                  //         )
                                  : widget.assetTypeArgument.assetType ==
                                          theatreAndDrama
                                      ? filmAndTheaterRegistration()
                                      // Column(
                                      //               children: [
                                      //                 const Text("Register Your Theater and Drama",
                                      //                     style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                                      //                 filmAndTheaterRegistration(context),
                                      //               ],
                                      //             )
                                      : widget.assetTypeArgument.assetType ==
                                              literature
                                          ? literatureRegistrationWidget()
                                          : widget.assetTypeArgument
                                                      .assetType ==
                                                  photography
                                              ? photographyRegistrationWidget()
                                              : Container(),

                          const SizedBox(height: 20),
                          state is LoadingRegisterAsset ||
                                  bulkAssetState is LoadingRegisterBulkAsset
                              ? customLoader()
                              : customButton(
                                  text: "Publish",
                                  onClick: () async {
                                    print(actorModel);



                                    /// check if the asset is music then check it is album and then validate from then begin process
                                    if (widget.assetTypeArgument.assetType ==
                                        music) {
                                      if (tracks.length > 1) {
                                        if (validateForm()) {
                                          List<AssetRegistrationRequest>
                                              listOfAssets = [];

                                          ///iterating through tracks because the bulk asset request is accept list of assets
                                          for (int j = 0;
                                              j < tracks.length;
                                              j++) {
                                            String? userId =
                                                await sl<LocalStorageService>()
                                                    .getStringFromDisk(
                                                        'userId');
                                            String? name =
                                                await sl<LocalStorageService>()
                                                    .getStringFromDisk('name');
                                            List<AssetAddContributor>
                                                listOfContributors = [];
                                            for (int i = 0;
                                                i <
                                                    trackModel[j]
                                                        .contributors!
                                                        .length;
                                                i++) {
                                              listOfContributors.add(
                                                  AssetAddContributor(
                                                      role: trackModel[j]
                                                          .contributors![i][0]
                                                          .role!
                                                          .text,
                                                      name: trackModel[j]
                                                          .contributors![i][0]
                                                          .name!
                                                          .text,
                                                      id: trackModel[j]
                                                          .contributors![i][0]
                                                          .id!
                                                          .text,
                                                      sharePercentage: double
                                                          .parse(trackModel[j]
                                                              .contributors![i]
                                                                  [0]
                                                              .sharedPercentage!
                                                              .text)));
                                            }
                                            listOfAssets.add(
                                                AssetRegistrationRequest(
                                                    description:
                                                        musicAssetFieldData
                                                            .description.text
                                                            .toString(),
                                                    name: musicAssetFieldData
                                                        .album.text,
                                                    ownerId: userId!,
                                                    owner: "member",
                                                    type: widget
                                                        .assetTypeArgument
                                                        .departmentId
                                                        .toString(),
                                                    metaData:
                                                        AssetRegisterMetaData(
                                                      albumName:
                                                          musicAssetFieldData
                                                              .album.text,
                                                      releaseDate:
                                                          musicAssetFieldData
                                                              .date.text,
                                                      year: musicAssetFieldData
                                                          .date.text,
                                                      trackName: trackModel[j]
                                                          .trackName!
                                                          .text,
                                                      type: widget
                                                          .assetTypeArgument
                                                          .assetType,
                                                      language: trackModel[j]
                                                          .language!
                                                          .text,
                                                      subject: widget
                                                          .assetTypeArgument
                                                          .assetType,
                                                      author: name!,
                                                      runtime: trackModel[j]
                                                          .duration!
                                                          .text
                                                          .toString(),
                                                      genre: musicAssetFieldData
                                                          .genre.text,
                                                      actors: [Actor()],
                                                      exif: Exif(
                                                          imageSize:
                                                              ImageSize()),
                                                      contributors:
                                                          listOfContributors,
                                                      publisher: Publisher(
                                                          id: musicAssetFieldData
                                                              .publisherId.text
                                                              .toString(),
                                                          name:
                                                              musicAssetFieldData
                                                                  .publisherName
                                                                  .text,
                                                          sharePercentage:
                                                              double.parse(
                                                                  musicAssetFieldData
                                                                      .publisherPercentage
                                                                      .text)),
                                                    )));
                                          } // end for loop
                                          ///begin send BulkAsset Data
                                          sl<RegisterBulkAssetBloc>().add(
                                              RegisterBulkAsset(
                                                  assetRegistrationRequest:
                                                      BulkAssetRegistrationRequest(
                                                          assets:
                                                              listOfAssets)));
                                        }
                                      } else {
                                        if(_dateController.text.toString().isEmpty){
                                          showSnackBar("please select the date", context);
                                        }
                                        else if (validateForm()) {
                                          String? userId =
                                              await sl<LocalStorageService>()
                                                  .getStringFromDisk('userId');
                                          String? name =
                                              await sl<LocalStorageService>()
                                                  .getStringFromDisk('name');

                                          List<AssetAddContributor>
                                              listOfContributors = [];
                                          for (int i = 0;
                                              i <
                                                  trackModel[0]
                                                      .contributors!
                                                      .length;
                                              i++) {
                                            listOfContributors.add(
                                                AssetAddContributor(
                                                    role: trackModel[0]
                                                        .contributors![i][0]
                                                        .role!
                                                        .text,
                                                    name: trackModel[0]
                                                        .contributors![i][0]
                                                        .name!
                                                        .text,
                                                    id: trackModel[0]
                                                        .contributors![i][0]
                                                        .id!
                                                        .text,
                                                    sharePercentage: double
                                                        .parse(trackModel[0]
                                                            .contributors![i][0]
                                                            .sharedPercentage!
                                                            .text)));
                                          }

                                          sl<RegisterAssetBloc>().add(
                                              RegisterAsset(
                                                  assetRegistrationRequest:
                                                      AssetRegistrationRequest(
                                                          description:
                                                              musicAssetFieldData
                                                                  .description
                                                                  .text,
                                                          name: trackModel[0]
                                                              .trackName!
                                                              .text,
                                                          owner: "member",
                                                          ownerId: userId!,
                                                          type: widget
                                                              .assetTypeArgument
                                                              .departmentId
                                                              .toString(),
                                                          metaData:
                                                              AssetRegisterMetaData(
                                                            albumName:
                                                                musicAssetFieldData
                                                                    .album.text,
                                                            releaseDate:
                                                                // musicAssetFieldData
                                                                //     .date.text,
                                                            _dateController.text,
                                                            year:
                                                                musicAssetFieldData
                                                                    .date.text,
                                                            trackName:
                                                                trackModel[0]
                                                                    .trackName!
                                                                    .text,
                                                            type: widget
                                                                .assetTypeArgument
                                                                .assetType,
                                                            language:
                                                                trackModel[0]
                                                                    .language!
                                                                    .text,
                                                            subject: widget
                                                                .assetTypeArgument
                                                                .assetType,
                                                            author: name!,
                                                            runtime:
                                                                trackModel[0]
                                                                    .duration!
                                                                    .text
                                                                    .toString(),
                                                            genre:
                                                                musicAssetFieldData
                                                                    .genre.text,
                                                            actors: [Actor()],
                                                            exif: Exif(
                                                                imageSize:
                                                                    ImageSize()),
                                                            contributors:
                                                                listOfContributors,
                                                            publisher: Publisher(
                                                                id: musicAssetFieldData
                                                                    .publisherId
                                                                    .text
                                                                    .toString(),
                                                                name: musicAssetFieldData
                                                                    .publisherName
                                                                    .text,
                                                                sharePercentage:
                                                                    double.parse(musicAssetFieldData
                                                                        .publisherPercentage
                                                                        .text)),
                                                          ))));
                                        }

                                      }
                                    } else if (widget
                                            .assetTypeArgument.assetType ==
                                        literature) {
                                      if(_dateController.text.toString().isEmpty){
                                        showSnackBar("please select your release date", context);
                                      }
                                      else if(validateForm()){
                                      String? userId =
                                          await sl<LocalStorageService>()
                                              .getStringFromDisk('userId');
                                      String? name =
                                          await sl<LocalStorageService>()
                                              .getStringFromDisk('name');
                                      List<AssetAddContributor>
                                          listOfContributors = [];
                                      for (int i = 0;
                                          i <
                                              literatureAssetFieldData
                                                  .contributors!.length;
                                          i++) {
                                        listOfContributors.add(
                                            AssetAddContributor(
                                                role: trackModel[0]
                                                    .contributors![i][0]
                                                    .role!
                                                    .text,
                                                name: trackModel[0]
                                                    .contributors![i][0]
                                                    .name!
                                                    .text,
                                                id: trackModel[0]
                                                    .contributors![i][0]
                                                    .id!
                                                    .text,
                                                sharePercentage: double.parse(
                                                    trackModel[0]
                                                        .contributors![i][0]
                                                        .sharedPercentage!
                                                        .text)));
                                      }
                                      sl<RegisterAssetBloc>().add(RegisterAsset(
                                          assetRegistrationRequest:
                                              AssetRegistrationRequest(
                                                  description: literatureAssetFieldData.description.text,
                                                  name: literatureAssetFieldData
                                                      .title.text,
                                                  owner: 'member',
                                                  ownerId: userId.toString(),
                                                  type: widget.assetTypeArgument.departmentId.toString(),
                                                  metaData:
                                                      AssetRegisterMetaData(
                                                    author: name!,
                                                    title:
                                                        literatureAssetFieldData
                                                            .title.text,
                                                    subject:
                                                        literatureAssetFieldData
                                                            .subject.text,
                                                    releaseDate:
                                                        // literatureAssetFieldData
                                                        //     .date.text,
                                                    _dateController.text,
                                                    language:
                                                        literatureAssetFieldData
                                                            .language.text,
                                                    publisher: Publisher(
                                                      id: literatureAssetFieldData
                                                          .publisherId.text,
                                                      name:
                                                          literatureAssetFieldData
                                                              .publisherName
                                                              .text,
                                                      sharePercentage: double.parse(
                                                          literatureAssetFieldData
                                                              .publisherPercentage
                                                              .text),
                                                    ),
                                                    contributors:
                                                        listOfContributors,
                                                    copyrightStatus:
                                                        literatureAssetFieldData
                                                            .copyrightStatus
                                                            .text,
                                                    numberOfPages:
                                                        literatureAssetFieldData
                                                            .pageNumbers.text,
                                                    actors: [],
                                                    exif: Exif(
                                                      imageSize: ImageSize(),
                                                    ),
                                                  ))));
                                        }

                                    } else if (widget
                                            .assetTypeArgument.assetType ==
                                        photography) {
                                      if(_dateController.text.toString().isEmpty){
                                        showSnackBar("please select the date", context);
                                      }
                                          else if(validateForm()){

                                               String? userId = await sl<
                                                   LocalStorageService>()
                                                   .getStringFromDisk('userId');
                                               String? name = await sl<
                                                   LocalStorageService>()
                                                   .getStringFromDisk('name');
                                               sl<RegisterAssetBloc>().add(
                                                   RegisterAsset(
                                                       assetRegistrationRequest:
                                                       AssetRegistrationRequest(
                                                           description: photographAssetFieldData
                                                               .description
                                                               .text,
                                                           name: photographAssetFieldData
                                                               .title.text,
                                                           owner: 'member',
                                                           ownerId: userId!,
                                                           type: widget
                                                               .assetTypeArgument
                                                               .departmentId
                                                               .toString(),
                                                           metaData: AssetRegisterMetaData(
                                                               creator: name!,
                                                               title:
                                                               photographAssetFieldData
                                                                   .title.text,
                                                               releaseDate:
                                                               _dateController.text,
                                                               exif: Exif(
                                                                 cameraManufacturer: photographAssetFieldData
                                                                     .cameraManufacturer
                                                                     .text,
                                                                 cameraModel: photographAssetFieldData
                                                                     .cameraModel
                                                                     .text,
                                                                 exposureTime: photographAssetFieldData
                                                                     .exposureTime
                                                                     .text,
                                                                 imageSize: ImageSize(
                                                                     height: photographAssetFieldData
                                                                         .imageHeight
                                                                         .text,
                                                                     width: photographAssetFieldData
                                                                         .imageWidth
                                                                         .text
                                                                 ),
                                                                 fNumber: photographAssetFieldData
                                                                     .fNumber
                                                                     .text,
                                                                 isoSpeedRating: photographAssetFieldData
                                                                     .isoSpeedRating
                                                                     .text,
                                                                 captureDat: photographAssetFieldData
                                                                     .dateAndTimeOfDataGeneration
                                                                     .text,
                                                                 lensFocalLength: photographAssetFieldData
                                                                     .lensFocalLength
                                                                     .text,
                                                               ),
                                                               publisher: Publisher(),
                                                               contributors: [],
                                                               actors: []

                                                           ))));
                                             }


                                    } else if (widget
                                            .assetTypeArgument.assetType ==
                                        theatreAndDrama) {
                                      setState(() {
                                        typtitle =
                                            widget.assetTypeArgument.assetType;
                                      });
                                      if (validateForm()) {
                                        String? userId =
                                            await sl<LocalStorageService>()
                                                .getStringFromDisk('userId');
                                        String? name =
                                            await sl<LocalStorageService>()
                                                .getStringFromDisk('name');
                                        List<AssetRegistrationRequest>
                                            listOfAssets = [];
                                        List<AssetAddContributor>
                                            listOfContributors = [];
                                        List<Actor> listOfActors = [];

                                        for (int i = 0;
                                            i < contributorModel.length;
                                            i++) {
                                          listOfContributors.add(
                                              AssetAddContributor(
                                                  role: contributorModel[i]
                                                      .role!
                                                      .text,
                                                  name: contributorModel[i]
                                                      .name!
                                                      .text,
                                                  sharePercentage: double.parse(
                                                      contributorModel[i]
                                                          .sharedPercentage!
                                                          .text),
                                                  id: contributorModel[i]
                                                      .id!
                                                      .text));
                                        }
                                        for (int j = 0;
                                            j < actorModel.length;
                                            j++) {
                                          listOfActors.add(Actor(
                                              name: actorModel[j]
                                                  .actorName!
                                                  .text
                                                  .toString(),
                                              role: actorModel[j]
                                                  .role!
                                                  .text
                                                  .toString()));
                                        }

                                        sl<RegisterAssetBloc>().add(
                                            RegisterAsset(
                                                assetRegistrationRequest:
                                                    AssetRegistrationRequest(
                                                        // name:filmAndTheaterFieldData.title.text,
                                                        ownerId: userId!,
                                                        owner: "member",
                                                        type: widget
                                                            .assetTypeArgument
                                                            .departmentId
                                                            .toString(),
                                                        metaData: AssetRegisterMetaData(
                                                            title: filmAndTheaterFieldData
                                                                .title.text,
                                                            year: filmAndTheaterFieldData
                                                                .year.text,
                                                            releaseDate:
                                                                filmAndTheaterFieldData
                                                                    .releaseDate
                                                                    .text,
                                                            runtime: filmAndTheaterFieldData
                                                                .runtimeLength
                                                                .text,
                                                            genre: filmAndTheaterFieldData
                                                                .genre.text,
                                                            director:
                                                                filmAndTheaterFieldData
                                                                    .genre.text,
                                                            writer: filmAndTheaterFieldData
                                                                .website.text,
                                                            rossio: filmAndTheaterFieldData
                                                                .rossio.text,
                                                            plot: filmAndTheaterFieldData.plot.text,
                                                            language: filmAndTheaterFieldData.language.text,
                                                            country: filmAndTheaterFieldData.language.text,
                                                            poster: filmAndTheaterFieldData.poster.text,
                                                            metascore: filmAndTheaterFieldData.metaScore.text,
                                                            type: filmAndTheaterFieldData.type.text,
                                                            production: filmAndTheaterFieldData.production.text,
                                                            website: filmAndTheaterFieldData.website.text,
                                                            publisher: Publisher(),
                                                            actors: listOfActors,
                                                            exif: Exif(imageSize: ImageSize()),
                                                            contributors: listOfContributors))));
                                        Navigator.pop(context);

                                        // onSave();
                                        // showSnackBar(" Done 🎉", context);

                                      }
                                      print('is there');
                                    } else if (widget
                                            .assetTypeArgument.assetType ==
                                        audioVisualAndFilm) {
                                      setState(() {
                                        typtitle =
                                            widget.assetTypeArgument.assetType;
                                      });
                                     if(_dateController.text.toString().isEmpty){
                                      showSnackBar("please select your release day", context);
                                    }
                                      else if (validateForm()) {
                                        String? userId =
                                            await sl<LocalStorageService>()
                                                .getStringFromDisk('userId');
                                        String? name =
                                            await sl<LocalStorageService>()
                                                .getStringFromDisk('name');

                                        List<AssetRegistrationRequest>
                                            listOfAssets = [];
                                        List<AssetAddContributor>
                                            listOfContributors = [];
                                        List<Actor> listOfActors = [];

                                        for (int i = 0;
                                            i < contributorModel.length;
                                            i++) {
                                          listOfContributors.add(
                                              AssetAddContributor(
                                                  role: contributorModel[i]
                                                      .role!
                                                      .text,
                                                  name: contributorModel[i]
                                                      .name!
                                                      .text,
                                                  sharePercentage: double.parse(
                                                      contributorModel[i]
                                                          .sharedPercentage!
                                                          .text),
                                                  id: contributorModel[i]
                                                      .id!
                                                      .text));
                                        }
                                        for (int j = 0;
                                            j < actorModel.length;
                                            j++) {
                                          listOfActors.add(Actor(
                                              name: actorModel[j]
                                                  .actorName!
                                                  .text
                                                  .toString(),
                                              role: actorModel[j]
                                                  .role!
                                                  .text
                                                  .toString()));
                                        }

                                        sl<RegisterAssetBloc>().add(
                                            RegisterAsset(
                                                assetRegistrationRequest:
                                                    AssetRegistrationRequest(
                                                        // name:filmAndTheaterFieldData.title.text,
                                                        ownerId: userId!,
                                                        owner: "member",
                                                        type: widget
                                                            .assetTypeArgument
                                                            .departmentId
                                                            .toString(),
                                                        metaData: AssetRegisterMetaData(
                                                            title: filmAndTheaterFieldData
                                                                .title.text,
                                                            year: filmAndTheaterFieldData
                                                                .year.text,
                                                            releaseDate:
                                                                // filmAndTheaterFieldData
                                                                //     .releaseDate
                                                                //     .text,
                                                            _dateController.text,
                                                            runtime: filmAndTheaterFieldData
                                                                .runtimeLength
                                                                .text,
                                                            genre: filmAndTheaterFieldData
                                                                .genre.text,
                                                            director:
                                                                filmAndTheaterFieldData
                                                                    .genre.text,
                                                            writer: filmAndTheaterFieldData
                                                                .website.text,
                                                            rossio: filmAndTheaterFieldData
                                                                .rossio.text,
                                                            plot: filmAndTheaterFieldData.plot.text,
                                                            language: filmAndTheaterFieldData.language.text,
                                                            country: filmAndTheaterFieldData.language.text,
                                                            poster: filmAndTheaterFieldData.poster.text,
                                                            metascore: filmAndTheaterFieldData.metaScore.text,
                                                            type: filmAndTheaterFieldData.type.text,
                                                            production: filmAndTheaterFieldData.production.text,
                                                            website: filmAndTheaterFieldData.website.text,
                                                            publisher: Publisher(),
                                                            actors: listOfActors,
                                                            exif: Exif(imageSize: ImageSize()),
                                                            contributors: listOfContributors))));
                                        Navigator.pop(context);

                                        // onSave();
                                        // showSnackBar(" Done 🎉", context);

                                      }

                                    }
                                  }),
                          const SizedBox(height: 50),
                        ],
                      );
                    },
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }

  ///for music registration widget
  Widget musicRegistrationWidget() {
    return Form(
      key: forms,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ///for music
          const Text("Register Your Music",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),
          buildFormField(
              hintText: 'Album',
              dataValue: musicAssetFieldData.album,
              errorMessage: 'Album is required',
              context: context),
          const SizedBox(height: 20),
          buildReadOnlyFormField(
              hintText: 'UPC No (auto)', dataValue: "", context: context),

          const SizedBox(height: 20),
          buildFormField(
              hintText: 'Genre',
              dataValue: musicAssetFieldData.genre,
              errorMessage: 'Genre is required',
              context: context),
          const SizedBox(height: 20),
          // buildFormField(
          //     hintText: 'Date',
          //     dataValue: musicAssetFieldData.date,
          //     errorMessage: 'Date is required',
          //     context: context),
          TextFormField(
            onTap: _presentDatePicker,
            controller: _dateController,
            enabled: true,
            keyboardType: TextInputType.number,
            // onChanged: (value) => dataValue.text = value.toString(),

            onSaved: (value) => _dateController.text = value!.toString() ,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.only(left: 15),
              fillColor:  const Color(0XFFf0f0f0),
              suffixIcon: InkWell(
                onTap: _presentDatePicker,
                child: const Icon(
                  Icons.date_range,
                  color: Colors.black54,
                ),
              ),
              focusedBorder: buildUnderlineInputBorder(),
              border:   OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide:const BorderSide(
                  width: 0,
                  style: BorderStyle.none,
                ),
                //  borderRadius: BorderRadius.horizontal(left:Radius.circular(7.0),right: Radius.circular(7.0)),
              ),
              filled: true,
              hintText: 'Date',


            ),
          ),
          const SizedBox(height: 20),
          buildFormField(
              hintText: 'Description',
              dataValue: musicAssetFieldData.description,
              errorMessage: 'Description is required',
              context: context),
          const SizedBox(height: 20),

          Stack(
            children: [
              buildFormField(
                  hintText: 'Publisher Name',
                  dataValue: musicAssetFieldData.publisherName,
                  isEnabled: false,
                  errorMessage: "Publisher Name is required",
                  context: context,
                  onTap: () async {
                    var selected = await showSearch(
                        context: context, delegate: UserSearchDelegate());
                    print('from search $selected');
                    if (selected != null) {
                      musicAssetFieldData.publisherName.text =
                          selected.firstName + ' ' + selected.middleName;
                      musicAssetFieldData.publisherId.text = selected.id;
                    }
                  }),
              const SizedBox(height: 20),
            ],
          ),
          const SizedBox(height: 20),
          buildNumberFormField(
              hintText: 'Ownership Percentage',
              dataValue: musicAssetFieldData.publisherPercentage,
              errorMessage: 'Ownership Percentage is required',
              context: context),

          const SizedBox(height: 20),
          const Text("Add the tracks list below",
              style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),
          const Divider(height: 1, color: Colors.black),
          const SizedBox(height: 20),

          /// track list
          /// + (contributorsList.length.toDouble() * (contributorsList.length > 1 ? 270 :1))
          Container(
            margin: const EdgeInsets.only(left: 10),
            //  color: Colors.white,
            height: trackListHeight,
            child: ListView.builder(
                itemCount: trackModel.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (BuildContext context, int trackIndex) {
                  return Column(
                    children: [
                      trackModel.length > 1
                          ?

                          ///remove track red button
                          Row(children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Text(
                                  "Track " + (trackIndex + 1).toString(),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                      color: green),
                                ),
                              ),
                              const Spacer(),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    trackModel.removeAt(trackIndex);
                                    if (trackIndex == 0) {
                                      _rebuildHeight(trackIndex);
                                    } else {
                                      _rebuildHeight(trackIndex - 1);
                                    }
                                  });
                                },
                                child: const Icon(Icons.remove_circle_outline,
                                    size: 30, color: Colors.redAccent),
                              )
                            ])
                          : Container(),
                      trackModel.length > 1
                          ? const Divider(color: Colors.black)
                          : Container(),

                      const SizedBox(height: 10),
                      buildFormField(
                          hintText: 'Track Name',
                          dataValue: trackModel[trackIndex].trackName!,
                          errorMessage: 'Track Name  is require',
                          context: context),
                      const SizedBox(height: 20),
                      buildReadOnlyFormField(
                          hintText: 'ISRC No (auto)',
                          dataValue: "",
                          context: context),
                      const SizedBox(height: 20),
                      buildNumberFormField(
                          hintText: 'Duration (in minutes)',
                          dataValue: trackModel[trackIndex].duration!,
                          errorMessage: 'Duration  is require',
                          context: context),
                      const SizedBox(height: 20),
                      buildFormField(
                          hintText: 'Language',
                          dataValue: trackModel[trackIndex].language!,
                          errorMessage: 'Language  is require',
                          context: context),

                      ///contributors here
                      StickyHeader(
                        header: SizedBox(
                          // color: Colors.white,
                          height: 55,
                          child: Row(
                            children: [
                              const Text("Contributors",
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                              const Spacer(),
                              InkWell(
                                  onTap: () {
                                    setState(() {
                                      addContributor(trackIndex);
                                      _rebuildHeight(trackIndex);
                                    });
                                  },
                                  child: const Icon(Icons.add_circle_outline,
                                      size: 30, color: green)),
                            ],
                          ),
                        ),
                        content: Container(
                          margin: const EdgeInsets.only(left: 10),
                          height: contributorListHeight[trackIndex],
                          child: ListView.builder(
                              itemCount:
                                  trackModel[trackIndex].contributors?.length,
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemBuilder:
                                  (BuildContext context, int contributorIndex) {
                                return Column(children: [
                                  const SizedBox(height: 20),

                                  ///accessing the controllers is like [0][0]   ++   [1][0]   ++   [2][0]
                                  InkWell(
                                    onTap: () async {
                                      var selected = await showSearch(
                                          context: context,
                                          delegate: UserSearchDelegate());
                                      if (selected != null) {
                                        log('selected name is done ${selected.firstName}');
                                        setState(() {
                                          trackModel[trackIndex]
                                              .contributors![contributorIndex]
                                                  [0]
                                              .name
                                              ?.text = selected
                                                  .firstName +
                                              ' ' +
                                              selected.middleName;
                                        });
                                        log('This is controllers value');
                                        print(trackModel[trackIndex]
                                            .contributors![contributorIndex][0]
                                            .name);
                                      }
                                    },
                                    child: buildFormField(
                                        hintText: 'Full Name',
                                        dataValue: trackModel[trackIndex]
                                            .contributors![contributorIndex][0]
                                            .name!,
                                        errorMessage:
                                            'Contributor Name  is required',
                                        context: context,
                                        isEnabled: false,
                                        onTap: () async {
                                          var selected = await showSearch(
                                              context: context,
                                              delegate: UserSearchDelegate());
                                          if (selected != null) {
                                            log('selected name is done ${selected.firstName}');
                                            setState(() {
                                              trackModel[trackIndex]
                                                      .contributors![
                                                          contributorIndex][0]
                                                      .name
                                                      ?.text =
                                                  selected.firstName +
                                                      ' ' +
                                                      selected.middleName;
                                            });
                                          }
                                        }),
                                  ),

                                  const SizedBox(height: 20),
                                  buildNumberFormField(
                                      hintText: 'Shared Percentage',
                                      dataValue: trackModel[trackIndex]
                                          .contributors![contributorIndex][0]
                                          .sharedPercentage!,
                                      errorMessage:
                                          'shared percentage is required',
                                      context: context),
                                  const SizedBox(height: 20),
                                  BlocConsumer<TitleBloc, TitleState>(
                                    listener: (context, titleState) {
                                      // sl<TitleBloc>().add(LoadTitles());
                                      log('from bloc listener');
                                      if (titleState is LoadedTitles) {
                                        log("titles is loaded from bloc listener");
                                        setState(() {
                                          titleDropdownItems[trackIndex] =
                                              titleState.titles.map((titles) {
                                            return DropdownMenuItem(
                                              child: Text(titles.name),
                                              value: titles.name,
                                            );
                                          }).toList();
                                        });
                                      }
                                    },
                                    builder: (context, titleState) {
                                      return Container(
                                        width: double.infinity,
                                        height: 50,
                                        decoration: buildBoxDecoration(),
                                        child: titleState is LoadingTitles
                                            ? customLoader()
                                            : titleState is ErrorGettingTitles
                                                ? InkWell(
                                                    onTap: () {
                                                      sl<TitleBloc>()
                                                          .add(LoadTitles());
                                                    },
                                                    child: const Center(
                                                        child:
                                                            Text("Try again")))
                                                : DropdownButtonFormField(
                                                    decoration:
                                                        const InputDecoration(
                                                      filled: true,
                                                      fillColor:
                                                          Color(0XFFf0f0f0),
                                                      contentPadding:
                                                          EdgeInsets.only(
                                                              left:
                                                                  kPadding + 5),
                                                      focusedBorder:
                                                          UnderlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color:
                                                                Colors.green),
                                                      ),
                                                    ),
                                                    dropdownColor: Colors.white,
                                                    hint: const Text("Role"),
                                                    value: titleValue,
                                                    focusColor: Colors.green,
                                                    onChanged:
                                                        (String? newValue) {
                                                      setState(() {
                                                        // titleValue = newValue;
                                                        trackModel[trackIndex]
                                                            .contributors![
                                                                contributorIndex]
                                                                [0]
                                                            .role!
                                                            .text = newValue!;
                                                      });
                                                    },
                                                    items: titleDropdownItems[
                                                        trackIndex],
                                                  ),
                                      );
                                    },
                                  ),
                                  const SizedBox(height: 20),
                                  trackModel[trackIndex].contributors!.length >
                                          1
                                      ?

                                      ///remove contributor red button
                                      Row(children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8.0),
                                            child: Text(
                                              "Contributor " +
                                                  (contributorIndex + 1)
                                                      .toString(),
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 15,
                                                  color: green),
                                            ),
                                          ),
                                          const Spacer(),
                                          InkWell(
                                            onTap: () {
                                              setState(() {
                                                /// first remove contributor controller from class
                                                /// then rebuild the height
                                                trackModel[trackIndex]
                                                    .contributors
                                                    ?.removeAt(
                                                        contributorIndex);
                                                _rebuildHeight(trackIndex);
                                              });
                                            },
                                            child: const Icon(
                                                Icons.remove_circle_outline,
                                                size: 30,
                                                color: Colors.redAccent),
                                          )
                                        ])
                                      : Container(),
                                ]);
                              }),
                        ),
                      ),
                    ],
                  );
                }),
          ),

          ///Add track button
          Row(
            children: [
              InkWell(
                  onTap: () {
                    setState(() {
                      titleDropdownItems.add(titleDropdownItems[0]);
                      addNewTrack();
                      _calculateSecondHeight();
                    });
                  },
                  child: Row(
                    children: const [
                      Text("Add Track",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold)),
                      SizedBox(width: 10),
                      Icon(Icons.add_circle_outline, size: 30, color: green),
                    ],
                  )),
              const Spacer(),
            ],
          ),
        ],
      ),
    );
  }

  Widget filmAndTheaterRegistration() {
    return Form(
      key: forms,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          (typtitle == theatreAndDrama)
              ? Text("Theatre and Drama",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold))
              : Text("Audio Visual and Film",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),
          buildFormField(
              hintText: 'Title',
              dataValue: filmAndTheaterFieldData.title,
              errorMessage: 'Title is required',
              context: context),
          const SizedBox(height: 20),
          buildFormField(
              hintText: 'Year',
              dataValue: filmAndTheaterFieldData.year,
              errorMessage: 'Year is required',
              context: context),
          const SizedBox(height: 20),
          // buildFormField(
          //     hintText: 'release Date',
          //     dataValue: filmAndTheaterFieldData.releaseDate,
          //     errorMessage: 'release Date is required',
          //     context: context),
          TextFormField(
            onTap: _presentDatePicker,
            controller: _dateController,
            enabled: true,
            keyboardType: TextInputType.number,
            // onChanged: (value) => dataValue.text = value.toString(),

            onSaved: (value) => _dateController.text = value!.toString(),
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.only(left: 15),
              fillColor:  const Color(0XFFf0f0f0),
              suffixIcon: InkWell(
                onTap: _presentDatePicker,
                child: const Icon(
                  Icons.date_range,
                  color: Colors.black54,
                ),
              ),
              focusedBorder: buildUnderlineInputBorder(),
              border:   OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide:const BorderSide(
                  width: 0,
                  style: BorderStyle.none,
                ),
                //  borderRadius: BorderRadius.horizontal(left:Radius.circular(7.0),right: Radius.circular(7.0)),
              ),
              filled: true,
              hintText: 'Release date',


            ),
          ),
          const SizedBox(height: 20),
          buildFormField(
              hintText: 'Runtime/ Length',
              dataValue: filmAndTheaterFieldData.runtimeLength,
              errorMessage: 'Runtime/ Length is required',
              context: context),
          const SizedBox(height: 20),
          buildFormField(
              hintText: 'Genre',
              dataValue: filmAndTheaterFieldData.genre,
              errorMessage: 'Genere is required',
              context: context),
          const SizedBox(height: 20),
          buildFormField(
              hintText: 'Director',
              dataValue: filmAndTheaterFieldData.director,
              errorMessage: 'Director is required',
              context: context),
          const SizedBox(height: 20),
          buildFormField(
              hintText: 'Writer',
              dataValue: filmAndTheaterFieldData.writer,
              errorMessage: 'Writer is required',
              context: context),
          const SizedBox(height: 20),
          buildFormField(
              hintText: 'Rossio',
              dataValue: filmAndTheaterFieldData.rossio,
              errorMessage: 'Rossio is required',
              context: context),
          const SizedBox(height: 20),
          buildFormField(
              hintText: 'Plot',
              dataValue: filmAndTheaterFieldData.plot,
              errorMessage: 'Plot is required',
              context: context),
          const SizedBox(height: 20),
          buildFormField(
              hintText: 'Language',
              dataValue: filmAndTheaterFieldData.language,
              errorMessage: 'Language is required',
              context: context),
          const SizedBox(height: 20),
          buildFormField(
              hintText: 'Country',
              dataValue: filmAndTheaterFieldData.country,
              errorMessage: 'Country is required',
              context: context),
          const SizedBox(height: 20),
          buildFormField(
              hintText: 'Poster',
              dataValue: filmAndTheaterFieldData.poster,
              errorMessage: 'Poster is required',
              context: context),
          const SizedBox(height: 20),
          buildFormField(
              hintText: 'Meta Score',
              dataValue: filmAndTheaterFieldData.metaScore,
              errorMessage: 'Meta Score is required',
              context: context),
          const SizedBox(height: 20),
          buildFormField(
              hintText: 'Type',
              dataValue: filmAndTheaterFieldData.type,
              errorMessage: 'Type is required',
              context: context),
          const SizedBox(height: 20),
          buildFormField(
              hintText: 'Production',
              dataValue: filmAndTheaterFieldData.production,
              errorMessage: 'Production is required',
              context: context),
          const SizedBox(height: 20),
          buildFormField(
              hintText: 'Website',
              dataValue: filmAndTheaterFieldData.website,
              errorMessage: 'Website is required',
              context: context),
          const SizedBox(height: 20),
          const Text("Add the Actor list below",
              style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),
          const Divider(height: 1, color: Colors.black),
          const SizedBox(height: 20),
          Column(
            children: [
              ListView.builder(
                itemCount: actorModel.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (BuildContext context, int actorindex) {
                  return Column(
                    children: [
                      actorModel.length > 1
                          ?

                          /// remove actor red button

                          Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Text(
                                    "Actor " + (actorindex + 1).toString(),
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                        color: green),
                                  ),
                                ),
                                const Spacer(),
                                const SizedBox(
                                  height: 10,
                                ),
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      actorModel.removeAt(actorindex);
                                      if (actorindex == 0) {
                                        _rebuildActorHeight(actorindex);
                                      } else {
                                        _rebuildActorHeight(actorindex - 1);
                                      }
                                    });
                                  },
                                  child: const Icon(Icons.remove_circle_outline,
                                      size: 30, color: Colors.redAccent),
                                )
                              ],
                            )
                          : Container(),
                      actorModel.length > 1
                          ? const Divider(
                              color: Colors.black,
                            )
                          : Container(),
                      const SizedBox(
                        height: 10,
                      ),
                      buildFormField(
                          hintText: 'Actor Name',
                          dataValue: actorModel[actorindex].actorName!,
                          errorMessage: 'Actor Name  is require',
                          context: context),
                      const SizedBox(
                        height: 20,
                      ),
                      buildFormField(
                          hintText: 'Actor Role',
                          dataValue: actorModel[actorindex].role!,
                          errorMessage: 'Actor Role  is require',
                          context: context),
                    ],
                  );
                },
              ),

              /// Add Actor Button

              const SizedBox(height: 20),

              InkWell(
                  onTap: () {
                    setState(() {
                      addNewActor();
                      _calculateActorSecondHeight();
                    });
                    print('add actor is clicked');
                  },
                  child: Row(
                    children: const [
                      Text("Add Actor",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold)),
                      SizedBox(width: 10),
                      Icon(Icons.add_circle_outline, size: 30, color: green),
                    ],
                  ))
            ],
          ),
          const SizedBox(height: 30),
          const Text("Add The Contributors list below",
              style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),
          const Divider(height: 1, color: Colors.black),
          const SizedBox(height: 20),
          Column(
            children: [
              ListView.builder(
                itemCount: contributorModel.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (BuildContext context, int contributorIndex) {
                  return Column(
                    children: [
                      contributorModel.length > 1
                          ?

                          /// remove actor red button

                          Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Text(
                                    "Contributor " +
                                        (contributorIndex + 1).toString(),
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                        color: green),
                                  ),
                                ),
                                const Spacer(),
                                const SizedBox(
                                  height: 10,
                                ),
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      contributorModel
                                          .removeAt(contributorIndex);
                                      if (contributorIndex == 0) {
                                        _rebuildActorHeight(contributorIndex);
                                      } else {
                                        _rebuildActorHeight(
                                            contributorIndex - 1);
                                      }
                                    });
                                  },
                                  child: const Icon(Icons.remove_circle_outline,
                                      size: 30, color: Colors.redAccent),
                                )
                              ],
                            )
                          : Container(),
                      contributorModel.length > 1
                          ? const Divider(
                              color: Colors.black,
                            )
                          : Container(),
                      const SizedBox(
                        height: 10,
                      ),
                      InkWell(
                        onTap: () async {
                          var selected = await showSearch(
                              context: context,
                              delegate: UserSearchDelegate());
                          if (selected != null) {
                            log('selected name is done ${selected.firstName}');
                            setState(() {
                              contributorModel[contributorIndex].name!
                                  .text = selected
                                  .firstName +
                                  ' ' +
                                  selected.middleName;
                            });
                            log('This is controllers value');
                            // print(trackModel[trackIndex]
                            //     .contributors![contributorIndex][0]
                            //     .name);
                          }
                        },
                        child: buildFormField(
                            hintText: 'Full Name',
                            dataValue: contributorModel[contributorIndex].name!,
                            errorMessage:
                            'Contributor Name  is required',
                            context: context,
                            isEnabled: false,
                            onTap: () async {
                              var selected = await showSearch(
                                  context: context,
                                  delegate: UserSearchDelegate());
                              if (selected != null) {
                                log('selected name is done ${selected.firstName}');
                                setState(() {
                                  contributorModel[contributorIndex].name!.text =
                                      selected.firstName +
                                          ' ' +
                                          selected.middleName;
                                });
                              }
                            }),
                      ),

                      const SizedBox(
                        height: 20,
                      ),
                      buildNumberFormField(
                          hintText: 'Shared Percentage',
                          dataValue: contributorModel[contributorIndex]
                              .sharedPercentage!,
                          errorMessage: 'shared percentage is required',
                          context: context),
                      SizedBox(
                        height: 20,
                      ),
                      BlocConsumer<TitleBloc, TitleState>(
                        listener: (context, titleState) {
                          // sl<TitleBloc>().add(LoadTitles());
                          log('from bloc listener');
                          if (titleState is LoadedTitles) {
                            log("titles is loaded from bloc listener");
                            setState(() {
                              literatureContributorRole=
                                  titleState.titles.map((titles) {
                                    return DropdownMenuItem(
                                      child: Text(titles.name),
                                      value: titles.name,
                                    );
                                  }).toList();
                            });
                          }
                        },
                        builder: (context, titleState) {
                          return Container(
                            width: double.infinity,
                            height: 50,
                            decoration: buildBoxDecoration(),
                            child: titleState is LoadingTitles
                                ? customLoader()
                                : titleState is ErrorGettingTitles
                                ? InkWell(
                                onTap: () {
                                  sl<TitleBloc>()
                                      .add(LoadTitles());
                                },
                                child: const Center(
                                    child:
                                    Text("Try again")))
                                : DropdownButtonFormField(
                              decoration:
                              const InputDecoration(
                                filled: true,
                                fillColor:
                                Color(0XFFf0f0f0),
                                contentPadding:
                                EdgeInsets.only(
                                    left:
                                    kPadding + 5),
                                focusedBorder:
                                UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color:
                                      Colors.green),
                                ),
                              ),
                              dropdownColor: Colors.white,
                              hint: const Text("Contributor Role"),
                              value: titleValue,
                              focusColor: Colors.green,
                              onChanged:
                                  (String? newValue) {
                                setState(() {
                                  // titleValue = newValue;
                                  contributorModel[contributorIndex].role!
                                      .text = newValue!;
                                });
                              },
                              items: literatureContributorRole,
                            ),
                          );
                        },
                      ),

                    ],
                  );
                },
              ),

              /// Add Contributor Button
              const SizedBox(height: 20),

              InkWell(
                  onTap: () {
                    setState(() {
                      addNewContributor();
                      _calculateContributorSecondHeight();
                    });
                    print('add actor is clicked');
                  },
                  child: Row(
                    children: const [
                      Text("Add Contributor",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold)),
                      SizedBox(width: 10),
                      Icon(Icons.add_circle_outline, size: 30, color: green),
                    ],
                  )),
              const SizedBox(height: 20),
            ],
          ),
        ],
      ),
    );
  }

  Widget photographyRegistrationWidget() {
    return Form(
      key: forms,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Register Your Photograph",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),
          buildFormField(
            hintText: 'Title',
            dataValue: photographAssetFieldData.title,
            errorMessage: 'Title is required',
            context: context,
          ),
          const SizedBox(height: 20),
          // buildFormField(
          //   hintText: 'Date',
          //   dataValue: photographAssetFieldData.date,
          //   errorMessage: 'Date is required',
          //   context: context,
          // ),
          TextFormField(
            onTap: _presentDatePicker,
            controller: _dateController,
            enabled: true,
            keyboardType: TextInputType.number,
            // onChanged: (value) => dataValue.text = value.toString(),

            onSaved: (value) => _dateController.text= value!.toString(),
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.only(left: 15),
              fillColor:  const Color(0XFFf0f0f0),
              suffixIcon: InkWell(
                onTap: _presentDatePicker,
                child: const Icon(
                  Icons.date_range,
                  color: Colors.black54,
                ),
              ),
              focusedBorder: buildUnderlineInputBorder(),
              border:   OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide:const BorderSide(
                  width: 0,
                  style: BorderStyle.none,
                ),
                //  borderRadius: BorderRadius.horizontal(left:Radius.circular(7.0),right: Radius.circular(7.0)),
              ),
              filled: true,
              hintText: 'Date',


            ),
          ),
          const SizedBox(height: 20),
          buildFormField(
            hintText: 'Description',
            dataValue: photographAssetFieldData.description,
            errorMessage: 'Description is required',
            context: context,
          ),
          const SizedBox(height: 20),
          const Text("Camera Data",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),
          buildFormField(
            hintText: 'Camera Manufacturer',
            dataValue: photographAssetFieldData.cameraManufacturer,
            errorMessage: 'Camera Manufacturer is required',
            context: context,
          ),
          const SizedBox(height: 20),
          buildFormField(
            hintText: 'Camera Model',
            dataValue: photographAssetFieldData.cameraModel,
            errorMessage: 'Camera Model is required',
            context: context,
          ),
          const SizedBox(height: 20),
          buildFormField(
            hintText: 'Exposure Time',
            dataValue: photographAssetFieldData.exposureTime,
            errorMessage: 'Exposure Time is required',
            context: context,
          ),
          const SizedBox(height: 20),
          buildNumberFormField(
            hintText: 'F-number',
            dataValue: photographAssetFieldData.fNumber,
            errorMessage: 'F-number is required',
            context: context,
          ),
          const SizedBox(height: 20),
          buildNumberFormField(
            hintText: 'ISO Speed Rating',
            dataValue: photographAssetFieldData.isoSpeedRating,
            errorMessage: 'ISO speed rating is required',
            context: context,
          ),
          const SizedBox(height: 20),
          buildFormField(
            hintText: 'Date and Time of data generation',
            dataValue: photographAssetFieldData.dateAndTimeOfDataGeneration,
            errorMessage: 'Date and Time of data generation is required',
            context: context,
          ),
          const SizedBox(height: 20),
          buildNumberFormField(
            hintText: 'Lens focal length',
            dataValue: photographAssetFieldData.lensFocalLength,
            errorMessage: 'Lens focal length is required',
            context: context,
          ),
          const SizedBox(height: 20),
          buildNumberFormField(
            hintText: 'Image Width',
            dataValue: photographAssetFieldData.imageWidth,
            errorMessage: 'Image Width is required',
            context: context,
          ),
          const SizedBox(height: 20),
          buildNumberFormField(
            hintText: 'Image Height',
            dataValue: photographAssetFieldData.imageHeight,
            errorMessage: 'Image Height is required',
            context: context,
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget literatureRegistrationWidget() {
    return Form(
      key: forms,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Register Your Literature",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),
          buildFormField(
            hintText: 'Title',
            dataValue: literatureAssetFieldData.title,
            errorMessage: 'Title is required',
            context: context,
          ),
          const SizedBox(height: 20),
          buildFormField(
            hintText: 'Language',
            dataValue: literatureAssetFieldData.language,
            errorMessage: 'Language is required',
            context: context,
          ),
          const SizedBox(height: 20),
          buildFormField(
            hintText: 'Subject',
            dataValue: literatureAssetFieldData.subject,
            errorMessage: 'Subject is required',
            context: context,
          ),
          const SizedBox(height: 20),
          buildFormField(
            hintText: 'Description',
            dataValue: literatureAssetFieldData.description,
            errorMessage: 'Description is required',
            context: context,
          ),
          const SizedBox(height: 20),
          buildNumberFormField(
            hintText: 'pageNumbers',
            dataValue: literatureAssetFieldData.pageNumbers,
            errorMessage: 'Page Number is required',
            context: context,
          ),
          const SizedBox(height: 20),
          buildFormField(
            hintText: 'Copyright Status',
            dataValue: literatureAssetFieldData.copyrightStatus,
            errorMessage: 'Copyright Status is required',
            context: context,
          ),
          const SizedBox(height: 20),
          // buildFormField(
          //   hintText: 'Realease Date',
          //   dataValue: literatureAssetFieldData.date,
          //   errorMessage: 'Release Date is required',
          //   context: context,
          // ),
          TextFormField(
            onTap: _presentDatePicker,
            controller: _dateController,
            enabled: true,
            keyboardType: TextInputType.number,
            // onChanged: (value) => dataValue.text = value.toString(),

            onSaved: (value) => _dateController.text  = value!.toString(),
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.only(left: 15),
              fillColor:  const Color(0XFFf0f0f0),
              suffixIcon: InkWell(
                onTap: _presentDatePicker,
                child: const Icon(
                  Icons.date_range,
                  color: Colors.black54,
                ),
              ),
              focusedBorder: buildUnderlineInputBorder(),
              border:   OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide:const BorderSide(
                  width: 0,
                  style: BorderStyle.none,
                ),
                //  borderRadius: BorderRadius.horizontal(left:Radius.circular(7.0),right: Radius.circular(7.0)),
              ),
              filled: true,
              hintText: 'Release date',


            ),
          ),
          const SizedBox(height: 20),
          Stack(
            children: [
              buildFormField(
                  hintText: 'Publisher Name',
                  dataValue: literatureAssetFieldData.publisherName,
                  isEnabled: false,
                  errorMessage: "Publisher Name is required",
                  context: context,
                  onTap: () async {
                    var selected = await showSearch(
                        context: context, delegate: UserSearchDelegate());
                    print('from search $selected');
                    if (selected != null) {
                      literatureAssetFieldData.publisherName.text =
                          selected.firstName + ' ' + selected.middleName;
                      literatureAssetFieldData.publisherId.text = selected.id;
                    }
                  }),
              const SizedBox(height: 20),
            ],
          ),
          const SizedBox(height: 20),
          buildNumberFormField(
            hintText: 'Ownership Percntage',
            dataValue: literatureAssetFieldData.publisherPercentage,
            errorMessage: 'Ownnership is required',
            context: context,
          ),
          const SizedBox(height: 20),
          StickyHeader(
            header: SizedBox(
              // color: Colors.white,
              height: 55,
              child: Row(
                children: [
                  const Text("Contributors",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  const Spacer(),
                  InkWell(
                      onTap: () {
                        setState(() {
                          addLiteratureContributor();
                          _rebuildLiteratureHeight();
                        });
                      },
                      child: const Icon(Icons.add_circle_outline,
                          size: 30, color: green)),
                ],
              ),
            ),
            content: Container(
              margin: const EdgeInsets.only(left: 10),
              height: literatureContributorListHeight,
              child: ListView.builder(
                  itemCount: literatureAssetFieldData.contributors?.length,
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int contributorIndex) {
                    return Column(children: [
                      const SizedBox(height: 20),
                      buildFormField(
                          hintText: 'Full Name',
                          dataValue: literatureAssetFieldData
                              .contributors![contributorIndex][0].name!,
                          errorMessage: 'Contributor Name  is required',
                          context: context,
                          isEnabled: false,
                          onTap: () async {
                            var selected = await showSearch(
                                context: context,
                                delegate: UserSearchDelegate());
                            if (selected != null) {
                              log('selected name is done ${selected.firstName}');
                              setState(() {
                                literatureAssetFieldData
                                        .contributors![contributorIndex][0]
                                        .name
                                        ?.text =
                                    selected.firstName +
                                        ' ' +
                                        selected.middleName;
                              });
                            }
                          }),
                      const SizedBox(height: 20),
                      buildNumberFormField(
                          hintText: 'Shared Percentage',
                          dataValue: literatureAssetFieldData
                              .contributors![contributorIndex][0]
                              .sharedPercentage!,
                          errorMessage: 'shared percentage is required',
                          context: context),
                      const SizedBox(height: 20),
                      BlocConsumer<TitleBloc, TitleState>(
                        listener: (context, titleState) {
                          // sl<TitleBloc>().add(LoadTitles());
                          log('from bloc listener');
                          if (titleState is LoadedTitles) {
                            log("titles is loaded from bloc listener");
                            setState(() {
                              literatureContributorRole =
                                  titleState.titles.map((titles) {
                                return DropdownMenuItem(
                                  child: Text(titles.name),
                                  value: titles.name,
                                );
                              }).toList();
                            });
                          }
                        },
                        builder: (context, titleState) {
                          return Container(
                            width: double.infinity,
                            height: 50,
                            decoration: buildBoxDecoration(),
                            child: titleState is LoadingTitles
                                ? customLoader()
                                : titleState is ErrorGettingTitles
                                    ? InkWell(
                                        onTap: () {
                                          sl<TitleBloc>().add(LoadTitles());
                                        },
                                        child: const Center(
                                            child: Text("Try again")))
                                    : DropdownButtonFormField(
                                        decoration: const InputDecoration(
                                          filled: true,
                                          fillColor: Color(0XFFf0f0f0),
                                          contentPadding: EdgeInsets.only(
                                              left: kPadding + 5),
                                          focusedBorder: UnderlineInputBorder(
                                            borderSide:
                                                BorderSide(color: Colors.green),
                                          ),
                                        ),
                                        dropdownColor: Colors.white,
                                        hint: const Text("Role"),
                                        value: titleValue,
                                        focusColor: Colors.green,
                                        onChanged: (String? newValue) {
                                          setState(() {
                                            // titleValue = newValue;
                                            literatureAssetFieldData
                                                .contributors![contributorIndex]
                                                    [0]
                                                .role!
                                                .text = newValue!;
                                          });
                                        },
                                        items: literatureContributorRole,
                                      ),
                          );
                        },
                      ),
                      const SizedBox(height: 20),
                      literatureAssetFieldData.contributors!.length > 1
                          ?

                          ///remove contributor red button
                          Row(children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Text(
                                  "Contributor " +
                                      (contributorIndex + 1).toString(),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                      color: green),
                                ),
                              ),
                              const Spacer(),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    /// first remove contributor controller from class
                                    /// then rebuild the height
                                    literatureAssetFieldData.contributors!
                                        .removeAt(contributorIndex);
                                    _rebuildLiteratureHeight();
                                  });
                                },
                                child: const Icon(Icons.remove_circle_outline,
                                    size: 30, color: Colors.redAccent),
                              )
                            ])
                          : Container(),
                    ]);
                  }),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
  void _presentDatePicker() {
    // showDatePicker is a pre-made function of Flutter
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: green, // <-- SEE HERE
              onPrimary: Colors.white, // <-- SEE HERE
              onSurface: Colors.black, // <-- SEE HERE
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                primary: Colors.green, // button text color
              ),
            ),
          ),
          child: child!,
        );
      },
    ).then((pickedDate) {
      // Check if no date is selected
      if (pickedDate == null) {
        return;
      }
      setState(() {
        // using state so that the UI will be rerendered when date is picked
        _dateController.text = pickedDate.year.toString() +
            "-" +
            pickedDate.month.toString() +
            "-" +
            pickedDate.day.toString();
        _selectedDate = _dateController.text.toString();
      });
    });
  }
}








