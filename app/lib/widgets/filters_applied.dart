import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class FiltersApplied extends StatelessWidget {
  final Map<String, dynamic> filters;
  final Function(Map<String, dynamic>) onFilterRemoved;

  const FiltersApplied({
    Key? key,
    required this.filters,
    required this.onFilterRemoved,
  }) : super(key: key);

  String _getDisplayText(String key, dynamic value) {
    if (key == 'type') {
      return value == 1 ? 'Full Time' : 'Part Time';
    }
    return value.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: filters.entries
                .map((entry) => Container(
              margin: const EdgeInsets.only(right: 5),
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: AppColors.gray,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    _getDisplayText(entry.key, entry.value),
                    style: const TextStyle(fontSize: 12),
                  ),
                  const SizedBox(width: 4),
                  InkWell(
                    onTap: () {
                      final updatedFilters =
                      Map<String, dynamic>.from(filters);
                      updatedFilters.remove(entry.key);
                      onFilterRemoved(updatedFilters);
                    },
                    child: const Icon(
                      Icons.close,
                      size: 14,
                    ),
                    ),
                  ],
                ),
              ),
            )
                .toList(),
          ),
        ],
      ),
    );
  }
}
