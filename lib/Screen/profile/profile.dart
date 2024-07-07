import 'dart:io';

import 'package:barberside/config/api_requests.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final ApiRequests _apiRequests = ApiRequests();
  File? _image;

  Future getImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    _image = File(pickedFile!.path);
    _apiRequests.uploadImage(_image!);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        height: 200,
        width: 200,
        child: Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                    radius: 70,
                    child: CachedNetworkImage(
                      imageUrl: '${_apiRequests.retrieveImageUrl()}',
                      placeholder: (context, url) => const Icon(
                        Icons.person,
                        size: 80,
                      ),
                    )),
                ElevatedButton(
                  onPressed: getImage,
                  child: const Text('Edit Profile Picture'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
