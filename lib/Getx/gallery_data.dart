
import 'package:get/get.dart';
import 'package:photo_gallery_app/services/Network%20Helper.dart';
import '../keys.dart';


enum GalleryStatus{
  loading,
  initial,
  loaded,
  error
}


class GalleryData extends GetxController {
  GalleryStatus status = GalleryStatus.initial;

  List<String> _images = [];
  List<String> get images => [..._images];
  int get imagesCount => _images.length;

  int _page = 1;

  Future<void> getImageFromPixaby() async {
    status = GalleryStatus.loading;
    update();
    List<String> pixabyImages = [];

    String url =
        "https://pixabay.com/api/?key=$PixabayApiKey&image_type=photo&per_page=17&page=$_page";


    NetworkHelper networkHelper = NetworkHelper(url: url);
    Map<String, dynamic> data = await networkHelper.getData();

    for (var entry in data["hits"]) {
      pixabyImages.add(entry["largeImageURL"]);
    }

    _images = pixabyImages;
    status = GalleryStatus.loaded;
    update();
  }

  Future<void> lodemore() async{
     status = GalleryStatus.loading;
    update();
    List<String> pixabyImages = [];

    String url =
        "https://pixabay.com/api/?key=$PixabayApiKey&image_type=photo&per_page=17&page=${_page + 1}";
    _page++;

    NetworkHelper networkHelper = NetworkHelper(url: url);
    Map<String, dynamic> data = await networkHelper.getData();

    for (var entry in data["hits"]) {
      pixabyImages.add(entry["largeImageURL"]);
    }

    _images.addAll(pixabyImages);
    status = GalleryStatus.loaded;
    update();

  }
}
