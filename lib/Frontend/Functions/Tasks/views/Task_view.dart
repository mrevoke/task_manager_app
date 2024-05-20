// ignore_for_file: sized_box_for_whitespace, file_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager/Frontend/Functions/Tasks/Tasks_blocs/task_bloc/todo_bloc.dart';

import '../Ui_Tasks/add_update_todo_widget.dart';
import '../Ui_Tasks/todo_item_widget.dart';

class TodosView extends StatefulWidget {
  const TodosView({super.key});

  @override
  State<TodosView> createState() => _TodosViewState();
}

class _TodosViewState extends State<TodosView> {
  late ScrollController controller = ScrollController();
  void _onPagination() {
    final maxScroll = controller.position.maxScrollExtent;
    final currentScroll = controller.offset;

    if (currentScroll >= maxScroll) {
      context.read<TodoBloc>().add(const TodoEvent.getTodosPagination());
    }
  }

  @override
  void initState() {
    controller.addListener(_onPagination);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 172, 224, 246),
        title: const Text(
          "Manage Tasks",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
      floatingActionButton: SizedBox(
        width: 90.0, // Set the width of the button
        height: 90.0, // Set the height of the button
        child: FloatingActionButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  backgroundColor: const Color.fromARGB(255, 220, 239, 255),
                  contentPadding: EdgeInsets.zero,
                  content: Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: const Padding(
                      padding: EdgeInsets.all(25),
                      child: AddUpdateTodoWidget(),
                    ),
                  ),
                );
              },
            );
          },
          backgroundColor: const Color.fromARGB(255, 67, 162, 240),
          child: const Icon(
            Icons.add,
            size: 60.0,
          ), // Set the background color of the button
        ),
      ),
      body: BlocConsumer(
        bloc: context.read<TodoBloc>(),
        listener: (context, state) {},
        builder: (context, TodoState state) {
          return state.map(
            loading: (value) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
            loaded: (value) {
              return Column(
                children: [
                  Expanded(
                    child: ListView.separated(
                      controller: controller,
                      padding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 10),
                      separatorBuilder: (context, index) {
                        return const SizedBox(height: 12);
                      },
                      itemCount:
                          context.read<TodoBloc>().todosPagination.length,
                      itemBuilder: (context, index) {
                        return TodoItemWidget(
                          item: context.read<TodoBloc>().todosPagination[index],
                          onDelete: (todo) {
                            context
                                .read<TodoBloc>()
                                .add(TodoEvent.deleteToodo(todoId: todo.id));
                          },
                          onUpdate: (todo) {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  backgroundColor:
                                      const Color.fromARGB(255, 220, 239, 255),
                                  contentPadding: EdgeInsets.zero,
                                  content: Padding(
                                    padding: const EdgeInsets.all(25),
                                    child: AddUpdateTodoWidget(model: todo),
                                  ),
                                );
                              },
                            );
                          },
                        );
                      },
                    ),
                  ),
                  value.isLoading
                      ? const Padding(
                          padding: EdgeInsets.all(8),
                          child: CircularProgressIndicator(),
                        )
                      : const SizedBox()
                ],
              );
            },
            error: (value) {
              return Center(
                child: Text(value.message),
              );
            },
          );
        },
      ),
    );
  }
}
