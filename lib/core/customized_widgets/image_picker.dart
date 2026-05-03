
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageManager extends StatefulWidget {
  const ImageManager({super.key,
    required this.unselectedImageBuilder,
    this.selectedImageBuilder,
    this.networkImageBuilder,
    this.onImageSelected,
    this.clickAble = true
  });
  final Widget unselectedImageBuilder;
  final Widget Function(String imagePath)? selectedImageBuilder;
  final void Function(String imagePath)? onImageSelected;
  final Widget? networkImageBuilder;
  final bool clickAble;

  @override
  State<ImageManager> createState() => _ImageManagerState();
}

class _ImageManagerState extends State<ImageManager> {
  final ImagePicker picker = ImagePicker();
  XFile? image;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.clickAble? pickImage: null,
      child: Builder(builder: (context){

        if(image != null){
          return widget.selectedImageBuilder!(image!.path);
        }
        else if(widget.networkImageBuilder != null){
          return widget.networkImageBuilder!;
        }
        return widget.unselectedImageBuilder;
      }),
    );
  }

  pickImage ()async{
    image = await picker.pickImage(source: ImageSource.gallery);
    if(image != null && widget.onImageSelected != null){
      widget.onImageSelected!(image!.path);
    }
    setState(() {

    });
  }
}