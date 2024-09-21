import 'package:flutter/material.dart';
import 'package:vma/app/common/vma_state.dart';

class SelectableLabel extends StatefulWidget {
  final String text;
  final void Function()? onTap;

  const SelectableLabel({
    super.key,
    required this.text,
    this.onTap,
  });

  @override
  State<SelectableLabel> createState() => _SelectableLabelState();
}

class _SelectableLabelState extends VMAState<SelectableLabel> {
  Color _backgroundColor = Colors.white;

  void _onTap() {
    setState(() {
      if (_backgroundColor == Colors.white) {
        _backgroundColor = Colors.green;
      } else {
        _backgroundColor = Colors.white;
      }
    });

    if (widget.onTap != null) {
      widget.onTap!();
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _onTap,
      child: DecoratedBox(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(15),
          color: _backgroundColor,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: Text(widget.text),
        ),
      ),
    );
  }
}
