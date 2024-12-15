import 'package:courtly/data/dto/vendor_dto.dart';

/// [Vendor] is a class that holds the information of a vendor.
class Vendor {
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

  Vendor({
    required this.id,
    required this.name,
    required this.address,
    required this.openTime,
    required this.closeTime,
  });

  /// [fromDTO] is a factory method that converts the [VendorDTO] object to a [Vendor] object.
  /// 
  /// Parameters:
  ///   - [dto] is the [VendorDTO] object.
  /// 
  /// Returns a [Vendor] object.
  factory Vendor.fromDTO(VendorDTO dto) {
    return Vendor(
      id: dto.id,
      name: dto.name,
      address: dto.address,
      openTime: dto.openTime,
      closeTime: dto.closeTime,
    );
  }
}
