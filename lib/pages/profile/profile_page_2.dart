import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../../widgets/my_app_bar.dart';
import '../../widgets/my_drawer.dart';

class Profile {
  final String name;
  final String breed;
  final String sex;

  final String imagePath;
  // final String competeDiscipline = "empty";
  // final String competeLevel = "NA";
  // final String birthYear = "NA";

  Profile(
      {required this.name,
      required this.breed,
      required this.imagePath,
      required this.sex});

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'breed': breed,
      'imagePath': imagePath,
      'sex': sex,
    };
  }

  factory Profile.fromMap(Map<String, dynamic> map) {
    return Profile(
      name: map['name'] as String,
      breed: map['breed'] as String,
      sex: map['sex'] as String,
      imagePath: map['imagePath'] as String,
    );
  }
}

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  int _selectedIndex = 0;
  List<Profile> _profiles = [];

  Future<void> _uploadProfile(Profile profile) async {
    DatabaseReference myRef =
        FirebaseDatabase.instance.ref().child("test/profiles/${profile.name}");

    try {
      final data = profile.toMap();
      myRef.set(data);
    } catch (e) {
      print('Error uploading the profile: $e');
    }
  }

  Future<List<Profile>> getAllProfiles() async {
    final profilesRef = FirebaseDatabase.instance.ref().child('test/profiles');

    debugPrint("Path is: ${profilesRef.path}");
    //debugPrint(profilesRef.)

    final dataFromDb = await profilesRef.once();

    if (dataFromDb == null) {
      debugPrint("Data from Database is null");
      return [];
    }

    debugPrint("In getAllProfiles call");

    final data = dataFromDb.snapshot.value;
    debugPrint(data.toString());

    final profiles = (dataFromDb.snapshot.value as Map<dynamic, dynamic>)
        .entries
        .map((entry) => Profile.fromMap(Map<String, dynamic>.from(entry.value)))
        .toList();

    return profiles;
  }

  @override
  void initState() {
    debugPrint("Initializing");
    super.initState();

    List<Profile> dBProfiles = [];

    debugPrint("Begin future call");

    //in this future call since await cannot be used in initState so this is a workaround
    Future.delayed(Duration.zero, () async {
      dBProfiles = await getAllProfiles();
      setState(() {
        _profiles = dBProfiles;
      });
    });
  }

  //this function manages what horse is selected
  void _onItemTapped(int index) {
    debugPrint("Entered the onItemTapped function");

    setState(() {
      _selectedIndex = index;
    });

    //This line was just to test uploading profiles to the database
    //Uncomment if you want to see a profile uploaded (by clicking its icon on the left of the screen)
    //_uploadProfile(_profiles[_selectedIndex]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile Manager'),
      ),
      drawer: const MyDrawer(),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          //Expanded(
          // child: Align(
          //   alignment: Alignment.center,
          //child:
          //This chunk displays the left list view of availble horses to select
          Container(
            constraints: const BoxConstraints.expand(width: 200),
            height: double.infinity,
            width: 200,
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: _profiles.length,
              itemBuilder: (context, index) => GestureDetector(
                onTap: () => _onItemTapped(index),
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  margin: EdgeInsets.only(left: 20),
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: AssetImage(_profiles[index].imagePath),
                        radius: 30,
                      ),
                      SizedBox(width: 10),
                      Text(
                        _profiles[index].name,
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          //This chunk displays the selected horse and its attributes
          Expanded(
            flex: 2,
            child: Center(
              //Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    backgroundImage:
                        AssetImage(_profiles[_selectedIndex].imagePath),
                    radius: 50,
                  ),
                  SizedBox(height: 20),
                  Text(
                    _profiles[_selectedIndex].name,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Text(
                    _profiles[_selectedIndex].breed,
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 100),
                  // Text(
                  //   'Birth Year: ${_profiles[_selectedIndex].birthYear}',
                  //   style: TextStyle(fontSize: 16),
                  // ),
                  // Text(
                  //   'Compete Discipline: ${_profiles[_selectedIndex].competeDiscipline}',
                  //   style: TextStyle(fontSize: 16),
                  // ),
                  // Text(
                  //   'Compete Level: ${_profiles[_selectedIndex].competeLevel}',
                  //   style: TextStyle(fontSize: 16),
                  // ),
                  Text(
                    'Sex: ${_profiles[_selectedIndex].sex}',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
