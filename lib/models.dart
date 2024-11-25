List<BikeModel> getBikeList() {
  final List<BikeModel> getBikeList = [
    BikeModel(
        "Road Bike",
        "PEUGEOT - LR01 ",
        [
          "assets/images/bike.png",
          "assets/images/bike0.png",
          "assets/images/bike1.png",
          "assets/images/bike2.png"
        ],
        5200,
        false,
        'The LR01 uses the same design as the most iconic bikes from PEUGEOT Cycles 130-year history and combines it with agile, dynamic performance thats perfectly suited to navigating todays cities. As well as a lugged steel frame and iconic PEUGEOT black-and-white chequer design, this city bike also features a 16-speed Shimano Claris drivetrain.',
        0),
    BikeModel(
        "Helmet",
        "HL30 - LR01 ",
        ["assets/images/helmet.png", "assets/images/helmet1.png"],
        340,
        false,
        'The LR01 uses the same design as the most iconic bikes from PEUGEOT Cycles 130-year history and combines it with agile, dynamic performance thats perfectly suited to navigating todays cities. As well as a lugged steel frame and iconic PEUGEOT black-and-white chequer design, this city bike also features a 16-speed Shimano Claris drivetrain.',
        0),
    BikeModel(
        "Helmet",
        "HL50 - LR01 ",
        ["assets/images/helmet2.png", "assets/images/helmet1.png"],
        500,
        false,
        'The LR01 uses the same design as the most iconic bikes from PEUGEOT Cycles 130-year history and combines it with agile, dynamic performance thats perfectly suited to navigating todays cities. As well as a lugged steel frame and iconic PEUGEOT black-and-white chequer design, this city bike also features a 16-speed Shimano Claris drivetrain.',
        0),
    BikeModel(
        "Street Bike",
        "NOMP - LRF2 ",
        ["assets/images/bike0.png", "assets/images/bike1.png"],
        7000,
        false,
        'The LR01 uses the same design as the most iconic bikes from PEUGEOT Cycles 130-year history and combines it with agile, dynamic performance thats perfectly suited to navigating todays cities. As well as a lugged steel frame and iconic PEUGEOT black-and-white chequer design, this city bike also features a 16-speed Shimano Claris drivetrain.',
        0),
    BikeModel(
        "Road Bike",
        "RTODK - LOK7 ",
        ["assets/images/bike1.png", "assets/images/bike_banner.png"],
        4200,
        false,
        'The LR01 uses the same design as the most iconic bikes from PEUGEOT Cycles 130-year history and combines it with agile, dynamic performance thats perfectly suited to navigating todays cities. As well as a lugged steel frame and iconic PEUGEOT black-and-white chequer design, this city bike also features a 16-speed Shimano Claris drivetrain.',
        0),
    BikeModel(
        "Street Bike",
        "VOLF - MNBL ",
        ["assets/images/bike3.png", "assets/images/bike.png"],
        8600,
        false,
        'The LR01 uses the same design as the most iconic bikes from PEUGEOT Cycles 130-year history and combines it with agile, dynamic performance thats perfectly suited to navigating todays cities. As well as a lugged steel frame and iconic PEUGEOT black-and-white chequer design, this city bike also features a 16-speed Shimano Claris drivetrain.',
        0),
    BikeModel(
        "Road Bike",
        "JILK - PDV ",
        ["assets/images/bike4.png", "assets/images/bike.png"],
        9980,
        false,
        'The LR01 uses the same design as the most iconic bikes from PEUGEOT Cycles 130-year history and combines it with agile, dynamic performance thats perfectly suited to navigating todays cities. As well as a lugged steel frame and iconic PEUGEOT black-and-white chequer design, this city bike also features a 16-speed Shimano Claris drivetrain.',
        0),
  ];
  return getBikeList;
}

class BikeModel {
  final String name;
  final String model;
  final List<String> images;
  final double price;
  final bool isLiked;
  final String desc;
  final int buyCount;
  BikeModel(this.name, this.model, this.images, this.price, this.isLiked,
      this.desc, this.buyCount);
}
