import 'dart:io';
import 'package:equine_ai/widgets/my_app_bar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:equine_ai/widgets/my_drawer.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path/path.dart' as path;
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:equine_ai/pages/login/firebase_options.dart';
import 'package:equine_ai/pages/login/global_state_management.dart';

class UploadDataPage extends StatefulWidget {
  const UploadDataPage({Key? key}) : super(key: key);

  @override
  _UploadDataPageState createState() => _UploadDataPageState();
}

class _UploadDataPageState extends State<UploadDataPage> {
  int _currentSlide = 0;
  final CarouselController _carouselController = CarouselController();
  double _uploadProgress = 0.0;
  bool _uploadComplete = false;
  String? _selectedEquineProfile;

  @override
  void initState() {
    super.initState();
    _initializeFirebaseApp();
  }

  Future<void> _initializeFirebaseApp() async {
    if (Firebase.apps.isEmpty) {
      await Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform);
    }
  }

  Future<void> _uploadFile(PlatformFile file) async {
    try {
      // Create a reference to the file in Firebase Storage
      FirebaseStorage storage = FirebaseStorage.instance;
      Reference ref = storage.ref().child('videos/${path.basename(file.name)}');

      // Upload the file
      UploadTask task;
      if (kIsWeb) {
        task = ref.putData(file.bytes!);
      } else {
        File localFile = File(file.path!);
        task = ref.putFile(localFile);
      }

      // Monitor the upload progress and show an error message if it fails
      task.snapshotEvents.listen((TaskSnapshot snapshot) {
        setState(() {
          _uploadProgress = (snapshot.bytesTransferred.toDouble() /
              snapshot.totalBytes.toDouble());
        });
        print('Progress: ${_uploadProgress * 100} %');
      }, onError: (Object e) {
        print('Error: $e');
      });
      TaskSnapshot snapshot = await task;
      String downloadUrl = await snapshot.ref.getDownloadURL();
      print('File uploaded. Download URL: $downloadUrl');

      // Set the _uploadComplete state to true when the upload is finished
      setState(() {
        _uploadComplete = true;
      });
    } catch (e) {
      print('Error uploading file: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: 'Upload and Guidelines',
        onDrawerPressed: () {},
        onSettingsPressed: () {},
      ),
      drawer: const MyDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: CarouselSlider(
                carouselController: _carouselController,
                options: CarouselOptions(
                  height: MediaQuery.of(context).size.width *
                      670 /
                      1200 *
                      0.5 *
                      1.2, // Increased height by 20%
                  viewportFraction: 1,
                  autoPlay: false,
                  onPageChanged: (index, reason) {
                    setState(() {
                      _currentSlide = index;
                    });
                  },
                  aspectRatio: 1200 / 670,
                ),
                items: [
                  'slide1.png',
                  'slide2.png',
                  'slide3.png',
                  'slide4.png',
                  'slide5.png',
                ].map((imagePath) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                        width: MediaQuery.of(context).size.width * 0.5,
                        child: Image.asset(
                          imagePath,
                          fit: BoxFit.contain,
                        ),
                      );
                    },
                  );
                }).toList(),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () => _carouselController.previousPage(),
                  icon: const Icon(Icons.arrow_left),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(5, (index) {
                    return Container(
                      width: 8.0,
                      height: 8.0,
                      margin: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 2.0),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _currentSlide == index
                            ? Theme.of(context).primaryColor
                            : Color.fromRGBO(0, 0, 0, 0.4),
                      ),
                    );
                  }),
                ),
                IconButton(
                  onPressed: () => _carouselController.nextPage(),
                  icon: const Icon(Icons.arrow_right),
                ),
              ],
            ),
            // Dropdown selector for equineProfileNames
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Obx(
                () => DropdownButton<String>(
                  value: _selectedEquineProfile,
                  hint: const Text('Not Selected'),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedEquineProfile = newValue;
                    });
                  },
                  items: ['Not Selected', ...equineProfileNames]
                      .map<DropdownMenuItem<String>>(
                        (String value) => DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        ),
                      )
                      .toList(),
                ),
              ),
            ),

            const SizedBox(height: 20),
            //Pre upload message
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'Upload a Video: Must be 1080p of an .mp4 .mov or .avi file type.',
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: FractionallySizedBox(
                widthFactor: 1 / 3,
                child: ElevatedButton.icon(
                  onPressed: () async {
                    FilePickerResult? result =
                        await FilePicker.platform.pickFiles(
                      type: FileType.custom,
                      allowedExtensions: ['mp4', 'avi', 'mov'],
                    );

                    if (result != null) {
                      PlatformFile file = result.files.first;
                      if (!kIsWeb) {
                        print('File path: ${file.path}');
                      }
                      await _uploadFile(file);
                    } else {
                      // User canceled the picker
                    }
                  },
                  icon: const Icon(Icons.file_upload),
                  label: const Text('Upload Data'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: FractionallySizedBox(
                widthFactor: 1 / 3,
                child: Column(
                  children: [
                    LinearProgressIndicator(
                      value: _uploadProgress,
                    ),
                    Text('${(_uploadProgress * 100).toStringAsFixed(2)}%'),
                  ],
                ),
              ),
            ),
            if (_uploadComplete)
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Text(
                  'Your file was successfully uploaded, please allow 10-15 minutes for results to be available',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
