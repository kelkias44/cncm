// import 'package:cncm_flutter_new/core/colors.dart';
// import 'package:flutter/material.dart';
// import 'package:sticky_headers/sticky_headers/widget.dart';
//
// import '../../../data/models/TrackModel.dart';
//
// typedef OnDelete();
//
// class CreateMusic extends StatefulWidget {
//   CreateMusic({Key? key}) : super(key: key);
//   final state = _CreateMusicState();
//
//   @override
//   State<CreateMusic> createState() => state;
//
//   bool isValid() => state.validateForm();
// }
//
// class _CreateMusicState extends State<CreateMusic> {
//   /// music asset registration controllers
//   final TextEditingController _albumController = TextEditingController();
//
//   final TextEditingController _upcController = TextEditingController();
//
//   final TextEditingController _generController = TextEditingController();
//
//   final TextEditingController _dateController = TextEditingController();
//
//   final TextEditingController _descriptionController = TextEditingController();
//
//   final TextEditingController _publisherNameController =
//       TextEditingController();
//
//   final TextEditingController _ownershipPercentageController =
//       TextEditingController();
//
//   final TextEditingController _contributorFullNameController =
//       TextEditingController();
//
//   final TextEditingController _sharedPercentageController =
//       TextEditingController();
//
//   final TextEditingController _roleController = TextEditingController();
//
//   List<TrackModel> trackModel = [TrackModel()];
//   late final OnDelete onDelete;
//
//   double trackListHeight = 520;
//
//   List<double> contributorListHeight = [270];
//
//   _rebuildHeight(int index) {
//     double addHeight = 0;
//     for (int i = 0; i < trackModel.length; i++) {
//       addHeight = addHeight + trackModel[i].contributors!.length.toDouble() - 1;
//     }
//     trackListHeight = 520 * trackModel.length + (addHeight * 270);
//     contributorListHeight[index] =
//         270 * trackModel[index].contributors!.length.toDouble();
//   }
//
//   ///called when new track is created
//   _calculateSecondHeight() {
//     contributorListHeight.add(270);
//     trackListHeight = trackListHeight + 520;
//   }
//
//   bool validateForm() {
//     var isValid = forms.currentState?.validate();
//     if (isValid!) forms.currentState?.save();
//     return isValid;
//   }
//
//   addNewTrack() {
//     trackModel.add(TrackModel());
//   }
//
//   addContributor(int index) {
//     trackModel[index]
//         .contributors
//         ?.add([ContributorsModel(name: '', sharedPercentage: '', role: '')]);
//   }
//
//   static const kPadding = 15.0;
//   final forms = GlobalKey<FormState>();
//   List<TrackModel> tracks = [];
//   final List<TextEditingController> _isrcNumberController = [
//     TextEditingController(text: '')
//   ];
//
//   void onSave() {
//     validateForm();
//     // tracks.forEach((element) => element.);
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Form(
//       key: forms,
//       child: Column(
//     crossAxisAlignment: CrossAxisAlignment.start,
//     children: [
//       ///for music
//       const Text("Register Your Music",
//           style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
//       const SizedBox(height: 20),
//       buildTextField(hintText: 'Album', controller: _albumController),
//       const SizedBox(height: 20),
//       buildTextField(
//           hintText: 'UPC No (auto)',
//           controller: _upcController,
//           isDisable: true),
//       const SizedBox(height: 20),
//       buildTextField(hintText: 'Genre', controller: _generController),
//       const SizedBox(height: 20),
//       buildTextField(hintText: 'Date', controller: _dateController),
//       const SizedBox(height: 20),
//       buildTextField(
//           hintText: 'Description', controller: _descriptionController),
//       const SizedBox(height: 20),
//       buildTextField(
//           hintText: 'Publisher Name', controller: _publisherNameController),
//       const SizedBox(height: 20),
//       buildTextField(
//           hintText: 'Ownership Percentage',
//           controller: _ownershipPercentageController),
//       const SizedBox(height: 20),
//       const Text("Add the tracks list below",
//           style: TextStyle(fontWeight: FontWeight.bold)),
//       const SizedBox(height: 20),
//       const Divider(height: 1, color: Colors.black),
//       const SizedBox(height: 20),
//
//       /// track list
//       /// + (contributorsList.length.toDouble() * (contributorsList.length > 1 ? 270 :1))
//       Container(
//         margin: const EdgeInsets.only(left: 10),
//         color: Colors.white,
//         height: trackListHeight,
//         constraints:
//             const BoxConstraints(maxHeight: 100000, minHeight: 500.0),
//         child: ListView.builder(
//             itemCount: trackModel.length,
//             shrinkWrap: true,
//             physics: const NeverScrollableScrollPhysics(),
//             itemBuilder: (BuildContext context, int trackIndex) {
//               return Column(
//                 children: [
//                   buildFormField(
//                       hintText: 'Track Name',
//                       dataValue: trackModel[trackIndex].trackName!,
//                       errorMessage: 'Track Name  is require',
//                       context: context),
//                   const SizedBox(height: 20),
//                   buildTextField(
//                       hintText: 'ISRC No (auto)',
//                       controller: _isrcNumberController[0],
//                       isDisable: true),
//
//                   /*buildTextField(
//                        hintText: 'Track Name',
//                        controller:
//                            _trackNameController[trackList[trackIndex] - 1]),
//                    const SizedBox(height: 20),
//                    buildTextField(
//                        hintText: 'ISRC No (auto)',
//                        controller:
//                            _isrcNumberController[trackList[trackIndex] - 1],
//                        isDisable: true),*/
//                   const SizedBox(height: 20),
//
//                   ///contributors here
//                   StickyHeader(
//                     header: Container(
//                       color: Colors.white,
//                       height: 55,
//                       child: Row(
//                         children: [
//                           const Text("Contributors",
//                               style:
//                                   TextStyle(fontWeight: FontWeight.bold)),
//                           const Spacer(),
//                           InkWell(
//                               onTap: () {
//                                 setState(() {
//                                   print("add contributor");
//                                   print(trackModel[trackIndex]
//                                       .trackName
//                                       ?.length);
//                                   // addContributor(trackIndex);
//
//                                   //_rebuildHeight(trackIndex);
//                                 });
//                               },
//                               child: const Icon(Icons.add_circle_outline,
//                                   size: 30, color: green)),
//                         ],
//                       ),
//                     ),
//                     content: Container(
//                       margin: const EdgeInsets.only(left: 10),
//                       height: contributorListHeight[trackIndex],
//                       child: ListView.builder(
//                           itemCount:
//                               trackModel[trackIndex].contributors?.length,
//                           //contributor[trackIndex][0],
//                           physics: const NeverScrollableScrollPhysics(),
//                           shrinkWrap: true,
//                           itemBuilder:
//                               (BuildContext context, int contributorIndex) {
//                             return Column(children: [
//                               const SizedBox(height: 20),
//
//                               ///accessing the controllers is like [0][0]   ++   [1][0]   ++   [2][0]
//                               buildFormField(
//                                   hintText: 'Full Name',
//                                   dataValue: trackModel[trackIndex]
//                                       .contributors![contributorIndex][0]
//                                       .name!,
//                                   errorMessage:
//                                       'Contributor Name  is required',
//                                   context: context),
//                               const SizedBox(height: 20),
//                               buildFormField(
//                                   hintText: 'Shared Percentage',
//                                   dataValue: trackModel[trackIndex]
//                                       .contributors![contributorIndex][0]
//                                       .sharedPercentage!,
//                                   errorMessage:
//                                       'shared percentage is required',
//                                   context: context),
//                               const SizedBox(height: 20),
//                               buildFormField(
//                                   hintText: 'Role',
//                                   dataValue: trackModel[trackIndex]
//                                       .contributors![contributorIndex][0]
//                                       .role!,
//                                   errorMessage: 'Role  is required',
//                                   context: context),
//
//                               // buildTextField(
//                               //     hintText: "Full Name",
//                               //     controller: contributorFulNameControllers[
//                               //         (contributor[trackIndex][0] - 1) -
//                               //             contributorIndex][0]),
//                               // const SizedBox(height: 20),
//                               // buildTextField(
//                               //     hintText: 'Shared Percentage',
//                               //     controller:
//                               //         contributorSharedPercentageControllers[
//                               //             (contributor[trackIndex][0] - 1) -
//                               //                 contributorIndex][0]),
//                               // const SizedBox(height: 20),
//                               // buildTextField(
//                               //     hintText: 'Role',
//                               //     controller: contributorRoleControllers[
//                               //         (contributor[trackIndex][0] - 1) -
//                               //             contributorIndex][0]),
//                               const SizedBox(height: 20),
//                               trackModel[trackIndex].contributors!.length >
//                                       1
//                                   ?
//
//                                   ///remove contributor red button
//                                   Row(children: [
//                                       Padding(
//                                         padding: const EdgeInsets.only(
//                                             left: 8.0),
//                                         child: Text(
//                                           "Contributor " +
//                                               (contributorIndex + 1)
//                                                   .toString(),
//                                           style: const TextStyle(
//                                               fontWeight: FontWeight.bold,
//                                               fontSize: 15,
//                                               color: green),
//                                         ),
//                                       ),
//                                       const Spacer(),
//                                       InkWell(
//                                         onTap: () {
//                                           setState(() {
//                                             trackModel[trackIndex]
//                                                 .contributors
//                                                 ?.removeAt(
//                                                     contributorIndex);
//                                             //_rebuildContributorHeight(trackIndex);
//                                             _rebuildHeight(trackIndex);
//                                           });
//                                         },
//                                         child: const Icon(
//                                             Icons.remove_circle_outline,
//                                             size: 30,
//                                             color: Colors.redAccent),
//                                       )
//                                     ])
//                                   : Container(),
//                             ]);
//                           }),
//                     ),
//                   ),
//                   trackModel.length > 1
//                       ?
//
//                       ///remove track red button
//                       Row(children: [
//                           Padding(
//                             padding: const EdgeInsets.only(left: 8.0),
//                             child: Text(
//                               "Track " + (trackIndex + 1).toString(),
//                               style: const TextStyle(
//                                   fontWeight: FontWeight.bold,
//                                   fontSize: 15,
//                                   color: green),
//                             ),
//                           ),
//                           const Spacer(),
//                           InkWell(
//                             onTap: () {
//                               setState(() {
//                                 print('track model');
//                                 print(trackModel.length);
//                                 print(trackIndex);
//                                 print(trackModel[trackIndex].trackName);
//                                 trackModel.removeAt(trackIndex);
//                                 if (trackIndex == 0) {
//                                   _rebuildHeight(trackIndex);
//                                 } else {
//                                   _rebuildHeight(trackIndex - 1);
//                                 }
//                               });
//                             },
//                             child: const Icon(Icons.remove_circle_outline,
//                                 size: 30, color: Colors.redAccent),
//                           )
//                         ])
//                       : Container(),
//                   trackModel.length > 1
//                       ? const Divider(color: Colors.black)
//                       : Container(),
//                 ],
//               );
//             }),
//       ),
//
//       ///Add track button
//       Row(
//         children: [
//           InkWell(
//               onTap: () {
//                 setState(() {
//                   addNewTrack();
//                   //initialize contributor controller for the added track
//                   //initialize contributor controller for the added track
//                   //_calculateHeight(track);
//                   _calculateSecondHeight();
//                 });
//               },
//               child: Row(
//                 children: const [
//                   Text("Add Track",
//                       style: TextStyle(
//                           color: Colors.black,
//                           fontWeight: FontWeight.bold)),
//                   SizedBox(width: 10),
//                   Icon(Icons.add_circle_outline, size: 30, color: green),
//                 ],
//               )),
//           const Spacer(),
//         ],
//       ),
//     ],
//       ),
//     );
//   }
//
//   Container buildTextField(
//       {bool isDisable = false,
//       required String hintText,
//       required TextEditingController controller}) {
//     return Container(
//       width: double.infinity,
//       height: 50,
//       decoration: buildBoxDecoration(),
//       child: TextFormField(
//         controller: controller,
//         readOnly: isDisable,
//         decoration: buildInputDecoration(hintText: hintText),
//         validator: (v) {
//           if (v!.trim().isEmpty) {
//             return 'Please enter something';
//           }
//           return null;
//         },
//       ),
//     );
//   }
//
//   /// form  field
//   Container buildFormField(
//       {required String hintText,
//       required TextEditingController dataValue,
//       required String errorMessage,
//       required BuildContext context,
//       isEnabled: true}) {
//     return Container(
//       width: MediaQuery.of(context).size.width,
//       height: 50,
//       decoration: buildBoxDecoration(),
//       child: TextFormField(
//         controller: dataValue,
//         enabled: isEnabled,
//         onChanged: (value) => dataValue.text = value,
//         onSaved: (value) => dataValue.text = value!,
//         validator: (val) => val!.length > 2 ? null : errorMessage,
//         decoration: buildInputDecoration(hintText: hintText),
//       ),
//     );
//   }
//
//   InputDecoration buildInputDecoration({required String hintText}) {
//     return InputDecoration(
//       contentPadding: const EdgeInsets.only(left: kPadding),
//       focusedBorder: buildUnderlineInputBorder(),
//       hintText: ' $hintText',
//     );
//   }
//
//   UnderlineInputBorder buildUnderlineInputBorder() {
//     return UnderlineInputBorder(
//       borderRadius: BorderRadius.circular(10),
//       borderSide: const BorderSide(color: Colors.green, width: 1),
//     );
//   }
//
//   BoxDecoration buildBoxDecoration() {
//     return BoxDecoration(
//       borderRadius: BorderRadius.circular(7),
//       color: const Color(0XFFf0f0f0),
//     );
//   }
// }
