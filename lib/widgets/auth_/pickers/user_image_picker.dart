import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserImagePicker extends StatefulWidget {
  final void Function (File saveImage) imagePickFn;
  UserImagePicker({Key? key,required this.imagePickFn}) : super(key: key);

  @override
  State<UserImagePicker> createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
   File? _pickedImage;
  final ImagePicker _picker = ImagePicker();
   void _pickerImage(
     {required ImageSource src}
   )async{
    final XFile? pickedImageFile = await _picker.pickImage(source: src, imageQuality:50,maxWidth: 150 );
    if(pickedImageFile !=null){
      setState(() {
     _pickedImage =File(pickedImageFile.path);
      });
      widget.imagePickFn(_pickedImage!);
    }else{
      print ('No Image Selected');
    }

  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 50,
          backgroundColor: Colors.grey,
          backgroundImage: _pickedImage != null ? FileImage(_pickedImage!) : null,
        ),
        SizedBox(height: 10,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
          MaterialButton(onPressed: (){
         _pickerImage(src: ImageSource.camera);
          },
          child: Row(
            children: [
             Icon(Icons.camera_alt_outlined,color: Theme.of(context).primaryColor),
             Text('Add image\n from camera',style: TextStyle(
               color: Theme.of(context).primaryColor
             ),textAlign: TextAlign.center)
            ],
          ),
          ),

           MaterialButton(onPressed: (){
         _pickerImage(src: ImageSource.gallery);
          },
          child: Row(
            children: [
             Icon(Icons.photo_camera_back,color: Theme.of(context).primaryColor),
             Text('Add image\n from Gallary',style: TextStyle(
               color: Theme.of(context).primaryColor
             ),textAlign: TextAlign.center,)
            ],
          ),
          )
          ],
        )
      ],
    );
  }
}