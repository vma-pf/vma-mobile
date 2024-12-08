import 'package:flutter/material.dart';
import 'package:vma/app/common/vma_state.dart';
import 'package:vma/app/screens/pig_list/widgets/filter_sheet.dart';
import 'package:vma/core/view_models/pig_list_model.dart';

class SearchBar extends StatefulWidget {
  final PigListModel model;

  const SearchBar({super.key, required this.model});

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends VMAState<SearchBar> {
  final TextEditingController _controller = TextEditingController();

  void _showFilterSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return FilterSheet(model: widget.model);
      },
    );
  }

  void _search() {
    widget.model.searchText = _controller.text;
    widget.model.searchPigs();
  }

  @override
  void initState() {
    super.initState();
    _controller.text = widget.model.searchText;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
      child: TextField(
        controller: _controller,
        decoration: InputDecoration(
          hintText: 'Tìm kiếm',
          prefixIcon: IconButton(
            icon: Icon(Icons.search),
            onPressed: _search,
          ),
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
