import 'package:courtly/data/dto/vendor_dto.dart';
import 'package:intl/intl.dart';

/// [Vendor] is a class that holds the information of a vendor.
class Vendor {
  /// [id] is the unique identifier for the vendor.
  final int id;

  /// [name] is the name of the vendor.
  final String name;

  /// [address] is the address of the vendor.
  final String address;

  /// [openTime] is the opening time of the vendor.
  final DateTime openTime;

  /// [closeTime] is the closing time of the vendor.
  final DateTime closeTime;

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
    /// [timeFormatter] is a date formatter for time.
    final DateFormat timeFormatter = DateFormat("hh:mm");

    return Vendor(
      id: dto.id,
      name: dto.name,
      address: dto.address,
      openTime: timeFormatter.parse(dto.openTime),
      closeTime: timeFormatter.parse(dto.closeTime),
    );
  }
}
