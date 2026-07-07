import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../models/todo.dart';
import '../providers/todo_provider.dart';
import '../widgets/todo_tile.dart';
import 'add_task_screen.dart';
import 'edit_task_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static final _dateFormat = DateFormat('EEEE, d MMM');

  Future<void> _addTask(BuildContext context) async {
    final result = await Navigator.push<Todo>(
      context,
      MaterialPageRoute(builder: (_) => const AddTaskScreen()),
    );
    if (result != null && context.mounted) {
      context.read<TodoProvider>().addTask(result);
    }
  }

  Future<void> _editTask(BuildContext context, Todo todo) async {
    final result = await Navigator.push<String>(
      context,
      MaterialPageRoute(builder: (_) => EditTaskScreen(todo: todo)),
    );
    if (!context.mounted) return;
    if (result == 'deleted') {
      context.read<TodoProvider>().deleteTask(todo.id);
    } else if (result == 'updated') {
      context.read<TodoProvider>().updateTask(todo);
    }
  }

  void _toggle(BuildContext context, String id) {
    HapticFeedback.lightImpact();
    context.read<TodoProvider>().toggleTask(id);
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<TodoProvider>();
    final todos = provider.todos;
    final doneCount = todos.where((t) => t.isDone).length;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 48),

            // Date

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                _dateFormat.format(DateTime.now()),
                style: GoogleFonts.inter(
                  fontSize: 28,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF111111),
                ),
              ),
            ),

            const SizedBox(height: 6),

            // Task count
            if (todos.isNotEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Text(
                  '$doneCount / ${todos.length} done',
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    color: const Color(0xFFAAAAAA),
                  ),
                ),
              ),

            const SizedBox(height: 28),

            // Task list
            Expanded(
              child: todos.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.check_circle_outline_rounded,
                              size: 56, color: Colors.grey.shade300),
                          const SizedBox(height: 16),
                          Text(
                            'Nothing here yet',
                            style: GoogleFonts.inter(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFFBBBBBB),
                            ),
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.only(bottom: 100),
                      itemCount: todos.length,
                      itemBuilder: (_, i) {
                        final todo = todos[i];
                        return Dismissible(
                          key: Key(todo.id),
                          direction: DismissDirection.endToStart,
                          confirmDismiss: (_) async {
                            return await showDialog<bool>(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text('Delete Task', style: GoogleFonts.inter(fontWeight: FontWeight.bold)),
                                  content: Text('Are you sure you want to delete this task?', style: GoogleFonts.inter()),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () => Navigator.of(context).pop(false),
                                      child: Text('Cancel', style: GoogleFonts.inter(color: Colors.grey, fontWeight: FontWeight.w600)),
                                    ),
                                    TextButton(
                                      onPressed: () => Navigator.of(context).pop(true),
                                      child: Text('Delete', style: GoogleFonts.inter(color: Colors.red, fontWeight: FontWeight.w600)),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          onDismissed: (_) {
                            context.read<TodoProvider>().deleteTask(todo.id);
                          },
                          background: Container(
                            alignment: Alignment.centerRight,
                            padding: const EdgeInsets.only(right: 24),
                            margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 5),
                            decoration: BoxDecoration(
                              color: const Color(0xFFEE4444),
                              borderRadius: BorderRadius.circular(14),
                            ),
                            child: const Icon(Icons.delete_outline_rounded, color: Colors.white),
                          ),
                          child: TaskCard(
                            todo: todo,
                            onToggle: () => _toggle(context, todo.id),
                            onTap: () => _editTask(context, todo),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addTask(context),
        backgroundColor: Colors.deepPurple,
        elevation: 0,
        shape: const CircleBorder(),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

}
