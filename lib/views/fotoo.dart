import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:firebase_storage/firebase_storage.dart';

class Fotos extends StatefulWidget {
  @override
  State<Fotos> createState() => _Fotostate();
}

class _Fotostate extends State<Fotos> {
  File imageSelect;

  final ImagePicker _imagePicker = ImagePicker();

  pickImageCamera() async {
    final XFile image =
        await _imagePicker.pickImage(source: ImageSource.camera);

    if (image != null) {
      setState(() {
        imageSelect = File(image.path);
      });
    }
  }

  pickImageGaleria() async {
    final XFile image =
        await _imagePicker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        imageSelect = File(image.path);
      });
    }
  }

  clearImage() {
    setState(() {
      imageSelect = null;
    });
  }

  uploadImage() {
    setState(() async {
      // Create a storage reference from our app
      ;
      
      

// Create the file metadata
      final metadata = SettableMetadata(contentType: "imageee/jpeg");

// Create a reference to the Firebase Storage bucket
      final storageRef = FirebaseStorage.instance.ref();

// Upload file and metadata to the path 'images/mountains.jpg'
      final uploadTask = storageRef.child("imagens").putFile(imageSelect);

// Listen for state changes, errors, and completion of the upload.
      uploadTask.snapshotEvents.listen((TaskSnapshot taskSnapshot) {
        switch (taskSnapshot.state) {
          case TaskState.running:
            final progress = 100.0 *
                (taskSnapshot.bytesTransferred / taskSnapshot.totalBytes);
            print("Upload is $progress% complete.");
            break;
          case TaskState.paused:
            print("Upload is paused.");
            break;
          case TaskState.canceled:
            print("Upload was canceled");
            break;
          case TaskState.error:
            // Handle unsuccessful uploads
            break;
          case TaskState.success:
            // Handle successful uploads on complete
            // ...
            break;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 4 / 5,
              child: imageSelect == null
                  ? Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(32.0),
                      color: Colors.grey,
                      width: double.maxFinite,
                      height: 500,
                      child: const Icon(
                        Icons.camera_alt,
                        color: Colors.white,
                      ),
                    )
                  : Image.file(
                      File(imageSelect.path),
                      fit: BoxFit.cover,
                    ),
            ),
            SizedBox(
              height: 40,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 40, vertical: 8),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15))),
                  onPressed: pickImageCamera,
                  child: const Icon(
                    Icons.camera_alt,
                    color: Color.fromARGB(255, 255, 255, 255),
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      padding:
                          EdgeInsets.symmetric(horizontal: 40, vertical: 8),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15))),
                  onPressed: pickImageGaleria,
                  child: const Icon(
                    Icons.photo_library,
                    color: Color.fromARGB(255, 255, 255, 255),
                  ),
                ),
              ],
            ),
            if (imageSelect != null)
              ElevatedButton(
                onPressed: uploadImage,
                child: const Text("Salvar"),
              ),
            if (imageSelect != null)
              ElevatedButton(
                onPressed: clearImage,
                child: const Text("Eliminar"),
              ),
          ],
        ),
      ),
    );
  }
}
