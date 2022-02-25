import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:photo_gallery_app/Getx/gallery_data.dart';


class PhotoGalleryScreen extends StatelessWidget {
  PhotoGalleryScreen({Key? key}) : super(key: key){
    // Get.put(GalleryData());

  }
   GalleryData galleryData =  Get.put(GalleryData());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GetBuilder<GalleryData>(
            initState: (_)=> galleryData.getImageFromPixaby(),
            builder: (data){

              if(data.status == GalleryStatus.loading){
                return Center(child: CircularProgressIndicator(),);
              }
               if(data.status == GalleryStatus.loaded){
                return GridView.builder(
                    itemCount: data.imagesCount,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 6,
                      mainAxisSpacing: 6,
                    ),
                    itemBuilder: (context, index) {
                      return Image.network(
                        data.images[index],
                        fit: BoxFit.cover,
                      );
                    });
              }
              else return Container();
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: (){
          galleryData.lodemore();
        },
        icon: Icon(Icons.add),
        label: Text("Show more images") ,
      ),
    );
  }
}
