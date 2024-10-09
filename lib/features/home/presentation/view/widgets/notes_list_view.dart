import 'package:flutter/material.dart';
import 'package:games_app/features/home/presentation/view/widgets/request_order_screen_body.dart';

import 'notes_list_view_item.dart';

class NotesListView extends StatelessWidget {
  const NotesListView({
    super.key,
    required this.widget,
  });

  final RequestOrderScreenBody widget;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        itemBuilder: (context, index) => NotesListViewItem(
            notesEntity: widget.companiesEntity.notes![index]),
        separatorBuilder: (context, index) =>
        const SizedBox(height: 12),
        itemCount: widget.companiesEntity.notes!.length,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics());
  }
}