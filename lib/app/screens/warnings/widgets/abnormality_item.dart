import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vma/app/screens/warnings/widgets/abnormality_detail.dart';
import 'package:vma/core/models/abnormality.dart';

class AbnormalityItem extends StatelessWidget {
  final Abnormality item;

  const AbnormalityItem({super.key, required this.item});

  void _showAbnormalityDetails(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return AbnormalityDetail(abnormalityId: item.id);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: () => _showAbnormalityDetails(context),
          child: Container(
            color: Color(0xFFFFC1C1),
            // color: Colors.red,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  title: Text(
                    item.title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.black.withOpacity(0.8),
                    ),
                  ),
                  leading: Icon(
                    CupertinoIcons.exclamationmark_triangle_fill,
                    color: Colors.red,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 10, bottom: 5),
                  child: Text(item.description),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
