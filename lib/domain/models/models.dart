class UserModel {
  final String id;
  final String email;
  final String fullName;
  final String role; // SUPER_ADMIN, ADMIN_OPERATIONS, OPERADOR, CLIENTE
  final String? phone;

  UserModel({
    required this.id,
    required this.email,
    required this.fullName,
    required this.role,
    this.phone,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      email: json['email'],
      fullName: json['full_name'] ?? '',
      role: json['role'] ?? 'CLIENTE',
      phone: json['phone'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'full_name': fullName,
      'role': role,
      'phone': phone,
    };
  }
}

class ParcelModel {
  final String id;
  final String userId;
  final String name;
  final double areaHectares;
  final String crop;
  final String location;
  final String status;

  ParcelModel({
    required this.id,
    required this.userId,
    required this.name,
    required this.areaHectares,
    required this.crop,
    required this.location,
    required this.status,
  });

  factory ParcelModel.fromJson(Map<String, dynamic> json) {
    return ParcelModel(
      id: json['id'],
      userId: json['user_id'],
      name: json['name'],
      areaHectares: (json['area_hectares'] as num).toDouble(),
      crop: json['crop'],
      location: json['location'],
      status: json['status'] ?? 'Activo',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'name': name,
      'area_hectares': areaHectares,
      'crop': crop,
      'location': location,
      'status': status,
    };
  }
}

class BookingModel {
  final String id;
  final String userId;
  final String parcelId;
  final String serviceName;
  final String bookingDate;
  final String bookingTime;
  final double totalAmount;
  final double depositAmount;
  final String paymentStatus;
  final String bookingStatus;

  BookingModel({
    required this.id,
    required this.userId,
    required this.parcelId,
    required this.serviceName,
    required this.bookingDate,
    required this.bookingTime,
    required this.totalAmount,
    required this.depositAmount,
    required this.paymentStatus,
    required this.bookingStatus,
  });

  factory BookingModel.fromJson(Map<String, dynamic> json) {
    return BookingModel(
      id: json['id'],
      userId: json['user_id'],
      parcelId: json['parcel_id'],
      serviceName: json['service_name'],
      bookingDate: json['booking_date'],
      bookingTime: json['booking_time'],
      totalAmount: (json['total_amount'] as num).toDouble(),
      depositAmount: (json['deposit_amount'] as num).toDouble(),
      paymentStatus: json['payment_status'],
      bookingStatus: json['booking_status'],
    );
  }
}
