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
import 'package:equine_ai/controllers/global_state_management.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:equine_ai/controllers/filter_controller.dart';
import 'dart:math';
import 'package:uuid/uuid.dart';
import 'package:equine_ai/controllers/global_state_management.dart';

class UploadDataPage extends StatefulWidget {
  const UploadDataPage({Key? key}) : super(key: key);

  @override
  _UploadDataPageState createState() => _UploadDataPageState();
}

class _UploadDataPageState extends State<UploadDataPage> {
  final FilterController filterController = Get.find();
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

  String _generateRandomGuid() {
    var uuid = Uuid();
    return uuid.v4();
  }

  Future<void> _uploadFile(PlatformFile file) async {
    try {
        String fileName = path.basename(file.name);
        String fileExtension = path.extension(file.name);

        // Append a random GUID before the file extension
        String newFileName =
        fileName.replaceFirst(fileExtension, '_${_generateRandomGuid()}$fileExtension');

        // Create a reference to the file in Firebase Storage with the new file name
        FirebaseStorage storage = FirebaseStorage.instance;
        Reference ref = storage.ref().child('${uid?.value}/${filterController.getSelectedHorse()}/videos/$newFileName');

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
      // Send an HTTP POST request to the given URL with the required schema
      var requestUrl = "https://equine-ai-data-analysis-lubhti4cma-ue.a.run.app/analyze";
      var requestBody = json.encode({
        "video": newFileName,
        "username": uid?.value,
        "specimen": filterController.getSelectedHorse(),
        "email": email?.value
      });
      // Print the contents of the HTTP request to the Flutter console
      print("HTTP POST request: $requestUrl");
      print("Request body: $requestBody");

      var response = await http.post(
          Uri.parse(requestUrl),
          headers: {"Content-Type": "text/plain"},
          body: requestBody
      );

      // Check and print the status of the HTTP POST request
      if (response.statusCode == 200) {
        print("HTTP POST request successful");
      } else {
        print("HTTP POST request failed with status code ${response.statusCode}");
      }
    } catch (e) {
      print('Error uploading file: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isHorseSelected = filterController.getSelectedHorse() != null;
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
                  'slide6.png',
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
                  children: List.generate(6, (index) {
                    return Container(
                      width: 8.0,
                      height: 8.0,
                      margin: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 2.0),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _currentSlide == index
                            ? Theme.of(context).primaryColor
                            : const Color.fromRGBO(0, 0, 0, 0.4),
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
            const SizedBox(height: 20),
            //Pre upload message
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
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
                  onPressed: isHorseSelected
                    ? () async {
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
                  }
                  : null,
                  icon: const Icon(Icons.file_upload),
                  label: const Text('Upload Data'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            if (!isHorseSelected) // Display the message when the horse is not selected
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  'Please select a horse profile above before uploading.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
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
                  'Your file was successfully uploaded, please allow 1-2 hours for results to be available',
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