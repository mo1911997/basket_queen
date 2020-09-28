class SliderModel{
  String imagePath;
  String title;
  String desc;

  SliderModel({this.imagePath, this.title, this.desc});

  void setImagePath(String getIamgePath)
  {
    imagePath=getIamgePath;
  }

  void setTitle(String getTitle)
  {
    title=getTitle;
  }

  void setDesc(String getDesc)
  {
    desc=getDesc;
  }

  String getImagePath()
  {
    return imagePath;
  }

  String getTitle()
  {
    return title;
  }

  String getDesc()
  {
    return desc;
  }

}

List<SliderModel> getSlides(){
  List<SliderModel> slides =new List<SliderModel>();
  SliderModel sliderModel=new SliderModel();
  
  //1
  //sliderModel.setImagePath("assets/moving_bus.json");
  sliderModel.setImagePath("assets/bus.png");
  sliderModel.setTitle("School Bus");
  sliderModel.setDesc("Track your childeren's live location");
  slides.add(sliderModel);

  sliderModel = new SliderModel();

  //2
  sliderModel.setImagePath("assets/map_points.png");
  sliderModel.setTitle("Dyanamic");
  sliderModel.setDesc("Change pickup and drop location");
  slides.add(sliderModel);

  sliderModel = new SliderModel();

  //3
  sliderModel.setImagePath("assets/baby_sleeping.png");
  sliderModel.setTitle("Safty");
  sliderModel.setDesc("Ensure the safty of your children");
  slides.add(sliderModel);

  sliderModel = new SliderModel();

  return slides;
}