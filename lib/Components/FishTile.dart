/// ********************************************************************************************************************
/// This project was developed by two undergraduates who are studying for BSc (Hons) in Information Technology         *
/// Specializing in Software Engineering at Sri Lanka Institute of Information Technology as an assignment for the     *
/// module Current Trends in Software Engineering. The intellectual and technical concepts contained herein are        *
/// proprietary to its developers and Dissemination of this information or reproduction of this material is            *
/// strictly forbidden unless prior permission is obtained.                                                            *
///                                                                                                                    *
/// @description This class is mainly responsible for rendering FishTile. In the FishTile the url for the leading      *
/// image  which is stored in the firebase storage should be retrieved. Contains the fish delete functionalities,      *
/// delete popup and, rendering update bottom sheet.                                                                   *
/// @author H.M.Y.L.W.Bandara IT1725098 lakshanwarunab@gmail.com                                                       *
///                                                                                                                    *
///*********************************************************************************************************************

import 'package:flutter/material.dart';
import 'package:learnafish/Components/FishUpdateForm.dart';
import 'package:learnafish/models/Fish.dart';
import 'package:learnafish/screens/FishView.dart';
import 'package:learnafish/services/fish_crud_and_orther_services/FishDBService.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class FishTile extends StatefulWidget {
  final Fish fish; // Fish type variable to assign the fish sent by FishList Component

  //Constructor assigning Fish sent to the local variable
  FishTile({this.fish});

  @override
  _FishTileState createState() => _FishTileState();
}

class _FishTileState extends State<FishTile> {
  String imageUrl; // Store imageUrl retrieved from firebase storage

  // ignore: slash_for_doc_comments
  /**
   * @description uploadImageUrl() is called inside the intiState() to set the
   * image URL before widget builds
   * Reference : https://stackoverflow.com/questions/51963497/flutter-order-of-execution-build-and-initstate
   */
  @override
  void initState() {
    uploadImageUrl();
    super.initState();
  }

  // ignore: slash_for_doc_comments
  /**
   * @description Get the image Url from the firebase Storage.
   * The image is stored in the firebase storage with the same id of the fish document
   * which is stored in firebase fireStore. Therefore to retrieve the image
   * the fish doc is sent as an argument.
   * Reference : https://stackoverflow.com/questions/53299919/how-to-display-image-from-firebase-storage-into-widget
   */
  void uploadImageUrl() {
    StorageReference firebaseStorageReference =
    FirebaseStorage.instance.ref().child(widget.fish.docID);
    firebaseStorageReference
        .getDownloadURL()
        .then((iUrl) => setState(() => imageUrl = iUrl));
  }


  // ignore: slash_for_doc_comments
  /**
   * @description Delete Confirmation PopUp when user try to delete a fish
   */
  Future<bool> _showDeleteConfirmationPopup() {
    return Alert(
        context: context,
        title: "Are you sure you to delete!!!",
        image: Image.asset("assets/error-alert.png"),
        buttons: [
          DialogButton(
              child: Text('Confirm Delete'),
              onPressed: () {
                // Deletes the fish with given ID
                FishDBService().deleteSingleFishData(widget.fish.docID);
                Navigator.pop(context);
              }),
          DialogButton(
            child: Text('Cancel'),
            onPressed: () {
              Navigator.pop(context);
            },
          )
        ]).show();
  }

  @override
  Widget build(BuildContext context) {
    /**
     * @description Calls the getDownLoadURL function to again inside build method
     * to make sure that the imageUrl gets updated every time widget rebuilds.
     */
    uploadImageUrl();

    /**
     * @description Shows the ModalBottomSheet which renders FishUpdateForm
     */
    void _showFishUpdateModalBottomSheet(Fish fish) {
      showModalBottomSheet(
          backgroundColor: Colors.black45,
          context: context,
          builder: (context) {
            return Container(
              padding: EdgeInsets.symmetric(vertical: 17.0, horizontal: 57.0),
              // Renders the FishUpdateForm passing the Current(Selected) Fish Object
              child: FishUpdateForm(fish: fish),
            );
          });
    }

    return Padding(
        padding: EdgeInsets.only(top: 10.0),
        child: Card(
          margin: EdgeInsets.fromLTRB(17.0, 7.0, 17.0, 0.0),
          child: Container(
            height: 80.0,
            child: ListTile(
              leading: SizedBox(
                width: 100.0,
                height: 80.0,
                /**
                 * @description Renders the default image if imageUrl is null.
                 * If not renders the network image which is stored in firebase storage.
                 */
                child: (imageUrl == null)
                    ? Image.asset(
                        'assets/nemo.png',
                        fit: BoxFit.fill,
                      )
                    : Image.network(
                        imageUrl,
                        fit: BoxFit.fill,
                      ),
              ),
              title: Text(widget.fish.comName),
              subtitle: Text(widget.fish.scName),
              // OnLongPress calls the _showFishUpdateModalBottomSheet()
              onLongPress: () => _showFishUpdateModalBottomSheet(widget.fish),
              // OnTap renders the FishView widget
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          FishView(fish: widget.fish, imageUrl: imageUrl)),
                );
              },
              /**
               * @description Delete Icon and calls the _showDeleteConfirmationPopup()
               * which contains deletion functionality.
               */
              trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () => _showDeleteConfirmationPopup()),
            ),
          ),
        ));
  }
}
