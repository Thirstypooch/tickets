import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../data/models/event_filter.dart';
import '../../providers/event_providers.dart';

/// Event filter panel — replaces PropertyFiltersPanel.
/// Filters by keyword, city, category.
class EventFiltersPanel extends ConsumerStatefulWidget {
  const EventFiltersPanel({super.key});

  @override
  ConsumerState<EventFiltersPanel> createState() => _EventFiltersPanelState();
}

class _EventFiltersPanelState extends ConsumerState<EventFiltersPanel> {
  late TextEditingController _keywordController;
  late TextEditingController _cityController;
  late String _category;

  @override
  void initState() {
    super.initState();
    final filter = ref.read(eventFilterProvider);
    _keywordController = TextEditingController(text: filter.keyword);
    _cityController = TextEditingController(text: filter.city);
    _category = filter.category;
  }

  @override
  void dispose() {
    _keywordController.dispose();
    _cityController.dispose();
    super.dispose();
  }

  void _apply() {
    ref.read(eventFilterProvider.notifier).state = EventFilter(
      keyword: _keywordController.text,
      city: _cityController.text,
      category: _category,
    );
  }

  void _clear() {
    setState(() {
      _keywordController.clear();
      _cityController.clear();
      _category = '';
    });
    ref.read(eventFilterProvider.notifier).state = const EventFilter();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: Theme.of(context).cardTheme.color,
        borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
        border: Border.all(color: Theme.of(context).dividerColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Filtros', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
          const SizedBox(height: 24),

          // Keyword
          const Text('Buscar', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
          const SizedBox(height: 8),
          TextField(
            controller: _keywordController,
            decoration: const InputDecoration(
              hintText: 'Artista, evento o lugar',
              isDense: true,
            ),
          ),
          const SizedBox(height: 20),

          // City
          const Text('Ciudad', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
          const SizedBox(height: 8),
          TextField(
            controller: _cityController,
            decoration: const InputDecoration(
              hintText: 'ej. New York, Miami',
              isDense: true,
            ),
          ),
          const SizedBox(height: 20),

          // Category
          const Text('Categoría', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
          const SizedBox(height: 8),
          RadioGroup<String>(
            groupValue: _category,
            onChanged: (v) => setState(() => _category = v ?? ''),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: EventFilter.categoryOptions
                  .map((cat) => RadioListTile<String>(
                        title: Text(cat.label, style: const TextStyle(fontSize: 14)),
                        value: cat.value,
                        dense: true,
                        contentPadding: EdgeInsets.zero,
                        activeColor: AppColors.brand,
                      ))
                  .toList(),
            ),
          ),
          const SizedBox(height: 24),
          const Divider(),
          const SizedBox(height: 16),

          SizedBox(
            width: double.infinity,
            child: ElevatedButton(onPressed: _apply, child: const Text('Aplicar Filtros')),
          ),
          const SizedBox(height: 8),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(onPressed: _clear, child: const Text('Limpiar Todo')),
          ),
        ],
      ),
    );
  }
}
