import 'package:flutter/foundation.dart';
import '../domain/models/models.dart';

class SupabaseBackendService extends ChangeNotifier {
  static const String supabaseUrl = 'https://your-supabase-project.supabase.co';
  static const String supabaseAnonKey = 'your-anon-key';

  bool _isInitialized = false;
  bool get isInitialized => _isInitialized;

  final List<ParcelModel> _parcels = [
    ParcelModel(
      id: 'p1',
      userId: 'u1',
      name: 'Finca El Paraíso',
      areaHectares: 8.2,
      crop: 'Maíz',
      location: 'Jutiapa',
      status: 'Activo',
    ),
    ParcelModel(
      id: 'p2',
      userId: 'u1',
      name: 'Parcela Los Olivos',
      areaHectares: 6.1,
      crop: 'Caña de azúcar',
      location: 'Escuintla',
      status: 'Activo',
    ),
  ];

  List<ParcelModel> get parcels => _parcels;

  Future<void> initialize() async {
    _isInitialized = true;
    notifyListeners();
  }

  Future<void> addParcel(ParcelModel parcel) async {
    _parcels.add(parcel);
    notifyListeners();
  }
}
