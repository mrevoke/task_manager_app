// ignore_for_file: library_private_types_in_public_api, unnecessary_string_interpolations

import 'package:flutter/material.dart';

import '../../../../Core_Logic/models/task_models/responses/todo_model.dart';

class TodoItemWidget extends StatefulWidget {
  final TodoModel item;
  final Function(TodoModel) onDelete;
  final Function(TodoModel) onUpdate;

  const TodoItemWidget(
      {Key? key,
      required this.item,
      required this.onDelete,
      required this.onUpdate}): super(key: key);
 
 
 @override
  _TodoItemWidgetState createState() => _TodoItemWidgetState();
}

class _TodoItemWidgetState extends State<TodoItemWidget> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 194, 227, 247),
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: const Color.fromARGB(255, 158, 158, 158).withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
          ),
        ],
      ),
      child: GestureDetector(
        onTap: () {
          setState(() {
            _isExpanded = !_isExpanded;
          });
        },
        child: Column(
          children: [
            ListTile(
              title: Row(
                children: [
                  Text(
                    "${widget.item.userId.toString().padLeft(2, '0')}",
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(width: 10),
                  Expanded(child: Text(widget.item.todo)),
                ],
              ),
              trailing: IconButton(
                icon: Icon(_isExpanded ? Icons.expand_less : Icons.expand_more),
                onPressed: () {
                  setState(() {
                    _isExpanded = !_isExpanded;
                  });
                },
              ),
            ),
            if (_isExpanded)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 23),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                        icon: const Icon(
                          Icons.edit,
                          color: Color.fromARGB(255, 16, 112, 153),
                        ),
                        onPressed: () {
                          widget.onUpdate(widget.item);
                          setState(() {
                            _isExpanded = !_isExpanded;
                          });
                        }),
                    // Adjust spacing between icons
                    IconButton(
                        icon: const Icon(Icons.delete,
                            color: Color.fromARGB(255, 16, 112, 153)),
                        onPressed: () {
                          widget.onDelete(widget.item);
                          setState(() {
                            _isExpanded = !_isExpanded;
                          });
                        }),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
