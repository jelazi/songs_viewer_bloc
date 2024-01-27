import 'package:flutter/material.dart';

class ChordRadioListTile<T> extends StatelessWidget {
  final int index;
  final int groupIndex;
  final String leading;
  final ValueChanged<int> onChanged;

  const ChordRadioListTile({
    super.key,
    required this.index,
    required this.groupIndex,
    required this.onChanged,
    required this.leading,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onChanged(index),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: 50,
          width: 150,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: _customRadioButton,
        ),
      ),
    );
  }

  Widget get _customRadioButton {
    final isSelected = index == groupIndex;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: isSelected ? Colors.blue : const Color.fromARGB(255, 204, 203, 203),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(
          color: isSelected ? Colors.blue : Colors.grey[300]!,
          width: 2,
        ),
      ),
      child: Center(
        child: Text(
          leading,
          style: TextStyle(
            color: isSelected ? Colors.white : const Color.fromARGB(255, 5, 5, 5),
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}
