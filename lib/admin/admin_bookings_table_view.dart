import 'package:flutter/material.dart';
import '../core/theme/app_colors.dart';
import '../core/theme/app_radii.dart';
import '../core/theme/app_typography.dart';

class AdminBookingsTableView extends StatefulWidget {
  const AdminBookingsTableView({super.key});

  @override
  State<AdminBookingsTableView> createState() => _AdminBookingsTableViewState();
}

class _AdminBookingsTableViewState extends State<AdminBookingsTableView> {
  final List<Map<String, dynamic>> _bookings = [
    {
      'id': 'BK-1001',
      'client': 'Carlos Rodríguez',
      'service': 'Fumigación Agrícola',
      'parcel': 'Finca El Paraíso (8.2 ha)',
      'date': '15 Sep 2026',
      'time': '09:00 AM',
      'status': 'Programada',
      'amount': 'Q 1,376.00',
    },
    {
      'id': 'BK-1002',
      'client': 'María Mercedes',
      'service': 'Abonado / Sólidos',
      'parcel': 'Parcela Los Olivos (6.1 ha)',
      'date': '16 Sep 2026',
      'time': '07:30 AM',
      'status': 'En curso',
      'amount': 'Q 1,020.00',
    },
    {
      'id': 'BK-1003',
      'client': 'Juan Pablo Gómez',
      'service': 'Fertilización Foliar',
      'parcel': 'Finca San José (4.2 ha)',
      'date': '18 Sep 2026',
      'time': '02:00 PM',
      'status': 'Pendiente',
      'amount': 'Q 750.00',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Gestión de Reservas', style: AppTypography.title(context, fontWeight: FontWeight.bold)),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.emerald,
                  shape: const RoundedRectangleBorder(borderRadius: AppRadii.pillBorderRadius),
                ),
                icon: const Icon(Icons.add, color: Colors.white),
                label: const Text('Nueva Reserva', style: TextStyle(color: Colors.white)),
                onPressed: () {},
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Datatable Container
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: AppRadii.largeBorderRadius,
              border: Border.all(color: AppColors.border),
            ),
            child: DataTable(
              columns: const [
                DataColumn(label: Text('ID')),
                DataColumn(label: Text('Cliente')),
                DataColumn(label: Text('Servicio')),
                DataColumn(label: Text('Parcela')),
                DataColumn(label: Text('Fecha & Hora')),
                DataColumn(label: Text('Monto')),
                DataColumn(label: Text('Estado')),
                DataColumn(label: Text('Acciones')),
              ],
              rows: _bookings.map((booking) {
                final isCompleted = booking['status'] == 'Programada' || booking['status'] == 'En curso';

                return DataRow(
                  cells: [
                    DataCell(Text(booking['id'], style: const TextStyle(fontWeight: FontWeight.bold))),
                    DataCell(Text(booking['client'])),
                    DataCell(Text(booking['service'])),
                    DataCell(Text(booking['parcel'])),
                    DataCell(Text('${booking['date']}\n${booking['time']}')),
                    DataCell(Text(booking['amount'], style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.emerald))),
                    DataCell(
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: isCompleted ? AppColors.softGreen : Colors.orange.withOpacity(0.15),
                          borderRadius: AppRadii.pillBorderRadius,
                        ),
                        child: Text(
                          booking['status'],
                          style: TextStyle(
                            color: isCompleted ? AppColors.emerald : Colors.orange,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                    DataCell(
                      Row(
                        children: [
                          IconButton(icon: const Icon(Icons.visibility_outlined, size: 20), onPressed: () {}),
                          IconButton(icon: const Icon(Icons.edit_outlined, size: 20), onPressed: () {}),
                        ],
                      ),
                    ),
                  ],
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
