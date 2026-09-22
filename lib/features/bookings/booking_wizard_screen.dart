import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_radii.dart';
import '../../core/theme/app_shadows.dart';
import '../../core/theme/app_typography.dart';
import '../../shared/widgets/app_buttons.dart';

class BookingWizardScreen extends StatefulWidget {
  final VoidCallback onBookingComplete;

  const BookingWizardScreen({super.key, required this.onBookingComplete});

  @override
  State<BookingWizardScreen> createState() => _BookingWizardScreenState();
}

class _BookingWizardScreenState extends State<BookingWizardScreen> {
  int _currentStep = 1;

  // Form Selections
  String _selectedService = 'Fumigación Agrícola';
  String _selectedParcel = 'Finca El Paraíso (8.2 ha)';
  String _selectedDate = 'Mañana';
  String _selectedTime = '09:00 AM';
  bool _isDeposit25Percent = true;
  String _paymentMethod = 'Tarjeta';

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Solicitar servicio'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            if (_currentStep > 1) {
              setState(() => _currentStep--);
            } else {
              Navigator.pop(context);
            }
          },
        ),
      ),
      body: Column(
        children: [
          // Custom Stepper Progress Indicator
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            color: isDark ? AppColors.darkSurface : AppColors.softGreen.withOpacity(0.5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(5, (index) {
                final stepNum = index + 1;
                final isActive = stepNum <= _currentStep;
                return Expanded(
                  child: Row(
                    children: [
                      Container(
                        width: 28,
                        height: 28,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: isActive ? AppColors.emerald : AppColors.border,
                        ),
                        child: Center(
                          child: Text(
                            '$stepNum',
                            style: TextStyle(
                              color: isActive ? Colors.white : AppColors.mutedText,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      if (index < 4)
                        Expanded(
                          child: Container(
                            height: 3,
                            color: stepNum < _currentStep ? AppColors.emerald : AppColors.border,
                          ),
                        ),
                    ],
                  ),
                );
              }),
            ),
          ),

          // Wizard Body Step Views
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: _buildStepContent(context),
            ),
          ),

          // Bottom Action Button
          Padding(
            padding: const EdgeInsets.all(20),
            child: PrimaryButton(
              text: _currentStep == 5 ? 'Confirmar y Pagar' : 'Continuar',
              onPressed: () {
                if (_currentStep < 5) {
                  setState(() => _currentStep++);
                } else {
                  widget.onBookingComplete();
                  Navigator.pop(context);
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStepContent(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    switch (_currentStep) {
      case 1:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Paso 1: Selecciona el servicio', style: AppTypography.title(context, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            ...['Fumigación Agrícola', 'Abonado / Sólidos', 'Fertilización Foliar'].map(
              (service) => _buildSelectionTile(
                context,
                title: service,
                isSelected: _selectedService == service,
                onTap: () => setState(() => _selectedService = service),
              ),
            ),
          ],
        );
      case 2:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Paso 2: Selecciona la parcela', style: AppTypography.title(context, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            ...['Finca El Paraíso (8.2 ha)', 'Parcela Los Olivos (6.1 ha)', 'Finca San José (4.2 ha)'].map(
              (parcel) => _buildSelectionTile(
                context,
                title: parcel,
                isSelected: _selectedParcel == parcel,
                onTap: () => setState(() => _selectedParcel = parcel),
              ),
            ),
          ],
        );
      case 3:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Paso 3: Selecciona fecha y hora', style: AppTypography.title(context, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            Text('Día de aplicación:', style: AppTypography.caption(context, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Row(
              children: ['Hoy', 'Mañana', 'Viernes', 'Sábado'].map((date) {
                final isSel = _selectedDate == date;
                return Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => _selectedDate = date),
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        color: isSel ? AppColors.emerald : (isDark ? AppColors.darkSurface : AppColors.white),
                        borderRadius: AppRadii.mediumBorderRadius,
                        border: Border.all(color: AppColors.emerald),
                      ),
                      child: Center(
                        child: Text(
                          date,
                          style: TextStyle(
                            color: isSel ? Colors.white : (isDark ? Colors.white : AppColors.darkText),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 20),
            Text('Horario preferido:', style: AppTypography.caption(context, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Row(
              children: ['07:00 AM', '09:00 AM', '02:00 PM'].map((time) {
                final isSel = _selectedTime == time;
                return Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => _selectedTime = time),
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        color: isSel ? AppColors.emerald : (isDark ? AppColors.darkSurface : AppColors.white),
                        borderRadius: AppRadii.mediumBorderRadius,
                        border: Border.all(color: AppColors.emerald),
                      ),
                      child: Center(
                        child: Text(
                          time,
                          style: TextStyle(
                            color: isSel ? Colors.white : (isDark ? Colors.white : AppColors.darkText),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        );
      case 4:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Paso 4: Cotización del servicio', style: AppTypography.title(context, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: isDark ? AppColors.darkSurface : AppColors.white,
                borderRadius: AppRadii.largeBorderRadius,
                border: Border.all(color: isDark ? AppColors.darkBorder : AppColors.border),
                boxShadow: AppShadows.soft,
              ),
              child: Column(
                children: [
                  _buildCostRow(context, 'Servicio:', _selectedService),
                  _buildCostRow(context, 'Parcela:', _selectedParcel),
                  _buildCostRow(context, 'Precio por ha:', 'Q 180.00'),
                  _buildCostRow(context, 'Subtotal (8.2 ha):', 'Q 1,476.00'),
                  _buildCostRow(context, 'Descuento cliente:', '-Q 100.00', isDiscount: true),
                  const Divider(),
                  _buildCostRow(context, 'Total:', 'Q 1,376.00', isTotal: true),
                ],
              ),
            ),
          ],
        );
      case 5:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Paso 5: Opción de pago', style: AppTypography.title(context, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            // Option 25% vs 100%
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => _isDeposit25Percent = true),
                    child: Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: _isDeposit25Percent ? AppColors.softGreen : (isDark ? AppColors.darkSurface : AppColors.white),
                        borderRadius: AppRadii.mediumBorderRadius,
                        border: Border.all(
                          color: _isDeposit25Percent ? AppColors.emerald : AppColors.border,
                          width: _isDeposit25Percent ? 2 : 1,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Reservar 25%', style: AppTypography.body(context, fontWeight: FontWeight.bold)),
                          const SizedBox(height: 4),
                          Text('Paga Q 344.00 hoy', style: AppTypography.caption(context, color: AppColors.emerald, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => _isDeposit25Percent = false),
                    child: Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: !_isDeposit25Percent ? AppColors.softGreen : (isDark ? AppColors.darkSurface : AppColors.white),
                        borderRadius: AppRadii.mediumBorderRadius,
                        border: Border.all(
                          color: !_isDeposit25Percent ? AppColors.emerald : AppColors.border,
                          width: !_isDeposit25Percent ? 2 : 1,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Pagar 100%', style: AppTypography.body(context, fontWeight: FontWeight.bold)),
                          const SizedBox(height: 4),
                          Text('Paga Q 1,376.00 completo', style: AppTypography.caption(context, color: AppColors.emerald, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Text('Método de pago:', style: AppTypography.caption(context, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            ...['Tarjeta', 'Transferencia bancaria'].map(
              (method) => _buildSelectionTile(
                context,
                title: method,
                isSelected: _paymentMethod == method,
                onTap: () => setState(() => _paymentMethod = method),
              ),
            ),
          ],
        );
      default:
        return const SizedBox();
    }
  }

  Widget _buildSelectionTile(BuildContext context, {required String title, required bool isSelected, required VoidCallback onTap}) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.softGreen
              : (isDark ? AppColors.darkSurface : AppColors.white),
          borderRadius: AppRadii.mediumBorderRadius,
          border: Border.all(
            color: isSelected ? AppColors.emerald : (isDark ? AppColors.darkBorder : AppColors.border),
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title, style: AppTypography.body(context, fontWeight: FontWeight.w600)),
            if (isSelected)
              const Icon(Icons.check_circle, color: AppColors.emerald)
            else
              const Icon(Icons.circle_outlined, color: AppColors.mutedText),
          ],
        ),
      ),
    );
  }

  Widget _buildCostRow(BuildContext context, String label, String value, {bool isDiscount = false, bool isTotal = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: isTotal
                ? AppTypography.title(context, fontWeight: FontWeight.bold)
                : AppTypography.body(context, color: isDiscount ? AppColors.emerald : AppColors.mutedText),
          ),
          Text(
            value,
            style: isTotal
                ? AppTypography.title(context, color: AppColors.emerald, fontWeight: FontWeight.bold)
                : AppTypography.body(context, fontWeight: FontWeight.bold, color: isDiscount ? AppColors.emerald : null),
          ),
        ],
      ),
    );
  }
}
