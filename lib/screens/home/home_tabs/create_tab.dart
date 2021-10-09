import 'dart:io' as io;
import 'dart:io';
import 'package:azedpolls/components/circular_indicator.dart';
import 'package:azedpolls/components/create_tab/picture_poll.dart';
import 'package:azedpolls/components/create_tab/text_poll.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:path/path.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class CreateTab extends StatefulWidget {
  const CreateTab({
    Key? key,
    this.callback,
  }) : super(key: key);

  final VoidCallback? callback;

  @override
  _CreateTabState createState() => _CreateTabState();
}

class _CreateTabState extends State<CreateTab> {
  int _selectedPageIndex = 0;
  File? _imageFile1;
  File? _imageFile2;
  bool _isLoading = false;
  final picker = ImagePicker();

  Future uploadImageToFirebase(File imageFile) async {
    String fileName = basename(imageFile.path);
    firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
        .ref()
        .child('uploads')
        .child('/$fileName');

    final metadata = firebase_storage.SettableMetadata(
      contentType: 'image/jpeg',
      customMetadata: {'picked-file-path': fileName},
    );
    firebase_storage.UploadTask uploadTask;
    uploadTask = ref.putFile(io.File(imageFile.path), metadata);
    Future.value(uploadTask)
        .then((value) => {print("Upload file path ${value.ref.fullPath}")})
        .onError((error, stackTrace) =>
            {print("Upload file path error ${error.toString()} ")});
  }

  Future pickImage1() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      _imageFile1 = File(pickedFile!.path);
    });
  }

  Future pickImage2() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      _imageFile2 = File(pickedFile!.path);
    });
  }

  _onItemTapped(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  void toggleSpinner() {
    setState(() {
      _isLoading = !_isLoading;
    });
  }

  List<BottomNavigationBarItem> tabsItems = [
    BottomNavigationBarItem(
      icon: Icon(
        FontAwesomeIcons.fileImage,
      ),
      label: "Picture",
    ),
    BottomNavigationBarItem(
      icon: Icon(
        Icons.format_size,
      ),
      label: "Text",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: ModalProgressHUD(
        inAsyncCall: _isLoading,
        progressIndicator: CircularIndicator(),
        child: Scaffold(
          bottomNavigationBar: BottomNavigationBar(
            iconSize: 28,
            backgroundColor: Color(0xFFffd6da),
            selectedItemColor: Color(0xFFdc8c97),
            onTap: _onItemTapped,
            currentIndex: _selectedPageIndex,
            items: tabsItems,
          ),
          body: CustomScrollView(
            slivers: [
              SliverAppBar(
                title: Text(
                  "Create Poll",
                  style: TextStyle(
                    fontFamily: 'Changa',
                    fontSize: 25,
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                leading: IconButton(
                  onPressed: () {
                    widget.callback!();
                  },
                  icon: Icon(
                    FontAwesomeIcons.times,
                    color: Color(0xFFdc8c97),
                  ),
                ),
                actions: [
                  Padding(
                    padding: const EdgeInsets.only(right: 6),
                    child: TextButton(
                      onPressed: () {
                        toggleSpinner();
                        if (_imageFile1 != null && _imageFile2 != null) {
                          uploadImageToFirebase(_imageFile1!);
                          uploadImageToFirebase(_imageFile2!).whenComplete(
                            () => uploadImageToFirebase(_imageFile1!)
                                .whenComplete(
                              () => widget.callback!(),
                            ),
                          );
                        } else {
                          showTopSnackBar(
                            context,
                            CustomSnackBar.error(
                              message: "Make sure to fill all requirements",
                            ),
                          );
                        }
                        toggleSpinner();
                      },
                      child: Text(
                        "Next",
                        style: TextStyle(
                          fontSize: 22,
                          color: Color(0xFFdc8c97),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  )
                ],
                centerTitle: true,
                automaticallyImplyLeading: false,
                backgroundColor: Colors.white,
                floating: true,
                snap: true,
                pinned: true,
              ),
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        children: [
                          SizedBox(height: 10),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: TextField(
                              maxLines: 2,
                              textAlign: TextAlign.center,
                              cursorHeight: 40,
                              cursorColor: Color(0xFFdc8c97),
                              style: TextStyle(
                                fontSize: 25.0,
                                height: 1.5,
                                color: Colors.black,
                              ),
                              decoration: InputDecoration(
                                labelStyle: TextStyle(
                                  fontSize: 28,
                                ),
                                hintMaxLines: 1,
                                hintText: "What will you ask the would",
                                border: InputBorder.none,
                                hintStyle: TextStyle(
                                  fontSize: 25,
                                ),
                              ),
                            ),
                          ),
                          if (_selectedPageIndex == 0)
                            PicturePoll(
                              imageFile1: _imageFile1,
                              imageFile2: _imageFile2,
                              onPressed1: pickImage1,
                              onPressed2: pickImage2,
                            ),
                          if (_selectedPageIndex != 0)
                            TextPoll(
                              onPressed1: () {
                                print("on pressed 1");
                              },
                              onPressed2: () {
                                print("on pressed 2");
                              },
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
