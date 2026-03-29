import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../common/date_picker_field.dart';
import '../common/guest_counter.dart';
import '../../providers/search_providers.dart';

class SearchDialog extends ConsumerStatefulWidget {
  const SearchDialog({super.key});

  @override
  ConsumerState<SearchDialog> createState() => _SearchDialogState();
}

class _SearchDialogState extends ConsumerState<SearchDialog> {
  late TextEditingController _locationController;
  DateTime? _checkIn;
  DateTime? _checkOut;
  int _guests = 1;

  @override
  void initState() {
    super.initState();
    final params = ref.read(searchParamsProvider);
    _locationController = TextEditingController(text: params.location);
    _checkIn = params.checkIn;
    _checkOut = params.checkOut;
    _guests = params.guests;
  }

  @override
  void dispose() {
    _locationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 80),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xxl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Handle
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: AppColors.gray300,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Search',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 24),

            // Location
            TextField(
              controller: _locationController,
              decoration: const InputDecoration(
                labelText: 'Where are you going?',
                prefixIcon: Icon(LucideIcons.mapPin),
              ),
            ),
            const SizedBox(height: 16),

            // Dates
            Row(
              children: [
                Expanded(
                  child: DatePickerField(
                    label: 'Check in',
                    value: _checkIn,
                    onChanged: (d) => setState(() => _checkIn = d),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: DatePickerField(
                    label: 'Check out',
                    value: _checkOut,
                    onChanged: (d) => setState(() => _checkOut = d),
                    firstDate: _checkIn,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Guests
            GuestCounter(
              value: _guests,
              onChanged: (v) => setState(() => _guests = v),
            ),
            const SizedBox(height: 24),

            // Search button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  ref.read(searchParamsProvider.notifier).state = SearchParams(
                    location: _locationController.text,
                    checkIn: _checkIn,
                    checkOut: _checkOut,
                    guests: _guests,
                  );
                  Navigator.pop(context);
                },
                icon: const Icon(LucideIcons.search, size: 18),
                label: const Text('Search'),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).viewInsets.bottom),
          ],
        ),
      ),
    );
  }
}
