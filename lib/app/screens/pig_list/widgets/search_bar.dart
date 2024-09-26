import 'package:flutter/material.dart';
import 'package:vma/app/common/vma_state.dart';
import 'package:vma/app/screens/pig_list/widgets/filter_sheet.dart';

class SearchBar extends StatefulWidget {
  const SearchBar({super.key});

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends VMAState<SearchBar> {
  final TextEditingController _controller = TextEditingController();

  void _showFilterSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return const FilterSheet();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
      child: TextField(
        controller: _controller,
        decoration: InputDecoration(
          hintText: 'Tìm kiếm',
          prefixIcon: const Icon(Icons.search),
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          suffixIcon: IconButton(
            icon: const Icon(Icons.filter_list_alt),
            onPressed: _showFilterSheet,
          ),
        ),
      ),
    );
  }
}
