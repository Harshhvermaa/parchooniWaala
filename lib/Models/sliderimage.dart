class sliderimgeModel
{
    String? SliderImageName;
    String ? SliderImageUrl;

    sliderimgeModel({ this.SliderImageUrl, this.SliderImageName });

    sliderimgeModel.toJson( Map<String,dynamic> json )
    {
      SliderImageUrl = json["SliderImageUrl"];
      SliderImageName = json["SliderImageName"];
    }

    Map<String,dynamic> toJson()
    {
      Map<String,dynamic> data = Map<String,dynamic>();
      data["SliderImageUrl"] = SliderImageUrl;
      data["SliderImageName"] = SliderImageName;
      return data;
    }

}