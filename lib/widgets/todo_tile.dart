import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../models/todo.dart';

class TaskCard extends StatelessWidget {
  final Todo todo;
  final VoidCallback onToggle;
  final VoidCallback onTap;

  const TaskCard({
    super.key,
    required this.todo,
    required this.onToggle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 5),
        padding: const EdgeInsets.all(16),
        decoration: _buildCardDecoration(),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _CustomCheckbox(isDone: todo.isDone, onToggle: onToggle),
            const SizedBox(width: 14),
            Expanded(child: _buildTaskContent()),
          ],
        ),
      ),
    );
  }

  BoxDecoration _buildCardDecoration() {
    return BoxDecoration(
      color: todo.isDone ? Colors.deepPurple.shade50 : Colors.white,
      borderRadius: BorderRadius.circular(14),
      border: Border.all(
        color: todo.isDone ? Colors.deepPurple.shade100 : const Color(0xFFEEEEEE),
        width: 1,
      ),
    );
  }

  Widget _buildTaskContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          todo.title,
          style: GoogleFonts.inter(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: todo.isDone ? Colors.deepPurple.shade300 : const Color(0xFF222222),
            decoration: todo.isDone ? TextDecoration.lineThrough : null,
          ),
        ),
        if (todo.description.isNotEmpty) ...[
          const SizedBox(height: 4),
          Text(
            todo.description,
            style: GoogleFonts.inter(
              fontSize: 13,
              color: todo.isDone ? Colors.deepPurple.shade300 : const Color(0xFF666666),
              decoration: todo.isDone ? TextDecoration.lineThrough : null,
            ),
          ),
        ],
        const SizedBox(height: 8),
        Align(
          alignment: Alignment.centerRight,
          child: _DateTimeBlock(todo: todo),
        ),
      ],
    );
  }
}

class _CustomCheckbox extends StatelessWidget {
  final bool isDone;
  final VoidCallback onToggle;

  const _CustomCheckbox({required this.isDone, required this.onToggle});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onToggle,
      child: Container(
        width: 22,
        height: 22,
        margin: const EdgeInsets.only(top: 2),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isDone ? Colors.deepPurple : Colors.transparent,
          border: Border.all(
            color: isDone ? Colors.deepPurple : const Color(0xFFCCCCCC),
            width: 1.8,
          ),
        ),
        child: isDone ? const Icon(Icons.check, size: 14, color: Colors.white) : null,
      ),
    );
  }
}

class _DateTimeBlock extends StatelessWidget {
  final Todo todo;

  static final _timeFormat = DateFormat('hh:mm a');
  static final _dateFormatFull = DateFormat('EEE, MMM d, yyyy');

  const _DateTimeBlock({required this.todo});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          _formatTime(),
          style: GoogleFonts.inter(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: todo.isDone ? Colors.deepPurple.shade400 : const Color(0xFF888888),
          ),
        ),
        const SizedBox(height: 2),
        Text(
          _formatDateFull(),
          style: GoogleFonts.inter(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: todo.isDone ? Colors.deepPurple.shade400 : const Color(0xFF888888),
          ),
        ),
      ],
    );
  }

  String _formatTime() {
    final now = DateTime.now();
    final dt = DateTime(now.year, now.month, now.day, todo.time.hour, todo.time.minute);
    return _timeFormat.format(dt);
  }

  String _formatDateFull() {
    return _dateFormatFull.format(todo.date);
  }
}
