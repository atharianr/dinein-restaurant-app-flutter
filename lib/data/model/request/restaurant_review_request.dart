class RestaurantReviewRequest {
  String? id;
  String? name;
  String? review;

  RestaurantReviewRequest({
    this.id,
    this.name,
    this.review,
  });

  factory RestaurantReviewRequest.fromJson(Map<String, dynamic> json) =>
      RestaurantReviewRequest(
        id: json["id"],
        name: json["name"],
        review: json["review"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "review": review,
      };
}
