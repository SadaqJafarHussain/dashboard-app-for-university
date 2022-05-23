class Ads {
  String image;
  String video;
  String text;
  String url;


  Ads.fromJson (Map <dynamic,dynamic> json,String urlFile){
    image=json["image_ads"];
    video=json["video_ads"];
    text=json["text_ads"];
    url=urlFile;
  }
}