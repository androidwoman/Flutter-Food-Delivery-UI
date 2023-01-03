class ConcentricModel {
  String lottie;
  String text;
  //
  ConcentricModel({
    required this.lottie,
    required this.text,
  });
}

List<ConcentricModel> concentrics = [
    ConcentricModel(
      lottie: "assets/animations/1.json",
      text: "ارسال سریع\nغذا",
    ),
    ConcentricModel(
      lottie: "assets/animations/2.json",
      text: "کیفیت بالای\nغذا",
    ),
    ConcentricModel(
      lottie: "assets/animations/3.json",
      text: "ارسال رایگان\nغذا",
    ),
    ConcentricModel(
      lottie: "assets/animations/4.json",
      text: "امتحان غذاهای\nجدید خوشمزه",
    ),
  ];