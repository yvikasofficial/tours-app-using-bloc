class Tour {
  final String des;
  final String imageUrl;
  final String uid;
  final String location;

  Tour({this.imageUrl, this.location, this.des, this.uid});

  factory Tour.fromJson(Map<String, dynamic> json) {
    return Tour(
        des: json['des'],
        imageUrl: json['imageUrl'],
        uid: json['uid'],
        location: json['location']);
  }

  static Map<String, dynamic> toJson(Tour tour) {
    return {
      'des': tour.des,
      'imageUrl': tour.imageUrl,
      'uid': tour.uid,
      'location': tour.location,
    };
  }
}
