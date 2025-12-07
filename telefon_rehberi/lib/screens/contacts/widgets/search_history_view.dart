import 'package:flutter/material.dart';
import 'package:telefon_rehberi/core/theme/app_colors.dart';
import 'package:telefon_rehberi/core/theme/app_text_styles.dart';

class SearchHistoryView extends StatelessWidget {
  final List<String> history;
  final ValueChanged<String> onSelect;
  final ValueChanged<String> onDelete;
  final VoidCallback onClearAll;

  const SearchHistoryView({
    super.key,
    required this.history,
    required this.onSelect,
    required this.onDelete,
    required this.onClearAll,
  });

  @override
  Widget build(BuildContext context) {
    if (history.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 4, 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'SEARCH HISTORY',
                style: AppTextStyles.bodyRegular.copyWith(
                  color: AppColors.gray300,
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
              InkWell(
                onTap: onClearAll,
                child: Text(
                  'Clear All',
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.primaryBlue,
                    fontWeight: FontWeight.w500,
                    decoration: TextDecoration.underline,
                    decorationColor: AppColors.primaryBlue,
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            children: [
              for (int i = 0; i < history.length; i++) ...[
                ListTile(
                  leading: IconButton(
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    icon: const Icon(
                      Icons.close,
                      size: 16,
                      color: AppColors.gray500,
                    ),
                    onPressed: () => onDelete(history[i]),
                  ),
                  title: Transform.translate(
                    offset: const Offset(-16, 0),
                    child: Text(
                      history[i],
                      style: AppTextStyles.bodyRegular.copyWith(
                        color: AppColors.gray500,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  onTap: () => onSelect(history[i]),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                  visualDensity: const VisualDensity(
                    horizontal: 0,
                    vertical: -2,
                  ),
                  minLeadingWidth: 20,
                ),
                if (i != history.length - 1)
                  const Divider(
                    height: 1,
                    indent: 16,
                    endIndent: 16,
                    color: AppColors.divider,
                  ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}
