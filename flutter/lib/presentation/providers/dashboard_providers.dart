import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../data/models/dashboard_stat.dart';

final dashboardStatsProvider = Provider<List<DashboardStat>>((ref) {
  return [
    DashboardStat(
      title: 'Eventos Asistidos',
      value: '8',
      icon: LucideIcons.calendar,
      description: 'Reservas totales',
      trend: '2 próximos',
    ),
    DashboardStat(
      title: 'Próximos Eventos',
      value: '2',
      icon: LucideIcons.ticket,
      description: 'Reservas confirmadas',
      trend: '¡Tenés planes!',
    ),
    DashboardStat(
      title: 'Gasto Total',
      value: '\$2,248',
      icon: LucideIcons.dollarSign,
      description: 'Gasto histórico',
      trend: 'Seguí explorando',
    ),
    DashboardStat(
      title: 'Calificación Promedio',
      value: '4.7',
      icon: LucideIcons.star,
      description: 'Tu promedio de reseñas',
      trend: '6 reseñas dadas',
    ),
  ];
});
