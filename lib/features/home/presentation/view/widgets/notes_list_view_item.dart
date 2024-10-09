import 'package:flutter/material.dart';
import 'package:games_app/features/home/domain/entities/notes_entity.dart';
import 'package:games_app/features/home/presentation/view/widgets/request_order_blue_container.dart';
import 'package:games_app/features/home/presentation/view/widgets/request_order_red_container.dart';
import 'package:games_app/features/home/presentation/view/widgets/request_order_yellow_container.dart';

class NotesListViewItem extends StatelessWidget {
  const NotesListViewItem({super.key, required this.notesEntity});

  final NotesEntity notesEntity;

  @override
  Widget build(BuildContext context) {
    List<Widget> noteContainers = [];

    switch (notesEntity.type) {
      case 'primary':
        noteContainers.add(RequestOrderBlueContainer(text: notesEntity.text!));
        break;
      case 'danger':
        noteContainers.add(RequestOrderRedContainer(text: notesEntity.text!));
        break;
      case 'warning':
        noteContainers.add(RequestOrderYellowContainer(text: notesEntity.text!));
        break;
      default:
        noteContainers.add(const Text('...'));
        break;
    }

    return Column(
      children: noteContainers,
    );
  }
}
