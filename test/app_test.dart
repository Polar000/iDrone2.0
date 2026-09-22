import 'package:flutter_test/flutter_test.dart';
import 'package:idrone/core/theme/app_colors.dart';
import 'package:idrone/domain/models/models.dart';

void main() {
  group('iDRONE Design System & Models Tests', () {
    test('AppColors light palette tokens', () {
      expect(AppColors.deepForest.value, 0xFF063F35);
      expect(AppColors.lime.value, 0xFFC8F45A);
      expect(AppColors.emerald.value, 0xFF159A6B);
    });

    test('ParcelModel JSON serialization', () {
      final model = ParcelModel(
        id: 'p_test',
        userId: 'u_test',
        name: 'Finca Test',
        areaHectares: 10.5,
        crop: 'Maíz',
        location: 'Guatemala',
        status: 'Activo',
      );

      final json = model.toJson();
      expect(json['name'], 'Finca Test');
      expect(json['area_hectares'], 10.5);

      final deserialized = ParcelModel.fromJson(json);
      expect(deserialized.id, 'p_test');
      expect(deserialized.crop, 'Maíz');
    });
  });
}
