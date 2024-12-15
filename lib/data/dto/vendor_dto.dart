/// [VendorDTO] is a data transfer object for vendor model.
class VendorDTO {
  /// [id] is the unique identifier for the vendor.
  final int id;

  /// [name] is the name of the vendor.
  final String name;

  /// [address] is the address of the vendor.
  final String address;

  /// [openTime] is the opening time of the vendor.
  final String openTime;

  /// [closeTime] is the closing time of the vendor.
  final String closeTime;

  VendorDTO({
    required this.id,
    required this.name,
    required this.address,
    required this.openTime,
    required this.closeTime,
  });

  /// [toMap] is a method that converts the [VendorDTO] object to a map.
  /// This method is used when converting the [VendorDTO] object to a JSON object.
  ///
  /// Parameters:
  ///   - [map] is the map of the [VendorDTO] object.
  ///
  /// Returns a map of the [VendorDTO] object.
  factory VendorDTO.fromJson(Map<String, dynamic> map) {
    return VendorDTO(
      id: map['id'],
      name: map['name'],
      address: map['address'],
      openTime: map['open_time'],
      closeTime: map['close_time'],
    );
  }
}
