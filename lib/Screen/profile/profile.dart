import 'dart:io';

import 'package:barberside/config/api_requests.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  ApiRequests _apiRequests = ApiRequests();
  File? _image;

  Future getImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    _image = File(pickedFile!.path);
    _apiRequests.uploadImage(_image!);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      width: 300,
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                  radius: 80,
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
              ElevatedButton(
                onPressed: () {},
                child: const Text('Update Location'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
