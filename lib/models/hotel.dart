
class Hotel {
  String Name;
  String PropertyType;
  String Capacity;
  String Stars;
  String Breakfast;
  List<String> Facilities;
  List<String> RoomFacilities;
  String PrivateBathroom;
  String Rating;
  String DistanceToCenter;

  Hotel({required this.Name, required this.PropertyType, required this.Capacity, required this.Stars, required this.Breakfast, required this.Facilities, required this.RoomFacilities, required this.PrivateBathroom, required this.Rating, required this.DistanceToCenter});

  factory Hotel.fromJson(Map<String, dynamic> json) {

    var facilitiesJson = json['facilities'];
    var roomFacilitiesJson = json['roomFacilities'];
    List<String> facilities = facilitiesJson != null ? List.from(facilitiesJson) : List.empty();
    List<String> roomFacilities = roomFacilitiesJson != null ? List.from(roomFacilitiesJson) : List.empty();
    return Hotel(Name: json['name'], PropertyType:  json['propertyType'], Capacity: json['capacity'], Stars: json['stars'], Breakfast: json['breakfast'], Facilities: facilities, RoomFacilities: roomFacilities, PrivateBathroom: json['privateBathroom'], Rating: json['rating'], DistanceToCenter: json['distanceToCenter']);
  }
}