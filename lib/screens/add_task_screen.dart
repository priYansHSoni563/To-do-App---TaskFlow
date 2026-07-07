import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';
import 'package:uuid/uuid.dart';
import '../models/todo.dart';
import '../widgets/custom_inputs.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final _titleCtrl = TextEditingController();
  final _noteCtrl = TextEditingController();
  late TimeOfDay _time = TimeOfDay.now();
  late DateTime _date = DateTime.now();

  @override
  void dispose() {
    _titleCtrl.dispose();
    _noteCtrl.dispose();
    super.dispose();
  }

  void _submit() {
    final title = _titleCtrl.text.trim();
    if (title.isEmpty) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          backgroundColor: Colors.white,
          title: Text(
            'Title Required',
            style: GoogleFonts.inter(
              fontWeight: FontWeight.w700,
              color: const Color(0xFF222222),
            ),
          ),
          content: Text(
            'Please enter a title for your task.',
            style: GoogleFonts.inter(
              color: const Color(0xFF666666),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: Text(
                'OK',
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF111111),
                ),
              ),
            ),
          ],
        ),
      );
      return;
    }
    Navigator.pop(
      context,
      Todo(
        id: const Uuid().v4(),
        title: title,
        description: _noteCtrl.text.trim(),
        time: _time,
        date: _date,
      ),
    );
    HapticFeedback.mediumImpact();
  }

  Future<void> _pickTime() async {
    final t = await showTimePicker(context: context, initialTime: _time);
    if (t != null) setState(() => _time = t);
  }

  Future<void> _pickDate() async {
    final d = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );
    if (d != null) setState(() => _date = d);
  }

  String _fmtTime() {
    final n = DateTime.now();
    return DateFormat('h:mm a')
        .format(DateTime(n.year, n.month, n.day, _time.hour, _time.minute));
  }

  String _fmtDate() => DateFormat('EEE, d MMM yyyy').format(_date);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded, color: Color(0xFF222222)),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'New Task',
          style: GoogleFonts.inter(
            fontWeight: FontWeight.w700,
            color: const Color(0xFF222222),
            fontSize: 18,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CustomLabel('Title'),
                  const SizedBox(height: 8),
                  CustomTextField(
                    controller: _titleCtrl,
                    hint: 'What needs to be done?',
                    autofocus: true,
                  ),

                  const SizedBox(height: 24),

                  const CustomLabel('Note'),
                  const SizedBox(height: 8),
                  CustomTextField(
                    controller: _noteCtrl,
                    hint: 'Add details...',
                    minLines: 3,
                    maxLines: null,
                  ),

                  const SizedBox(height: 24),

                  Row(
                    children: [
                      Expanded(
                        child: CustomPickerTile(
                          icon: Icons.access_time_rounded,
                          label: _fmtTime(),
                          onTap: _pickTime,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: CustomPickerTile(
                          icon: Icons.calendar_today_rounded,
                          label: _fmtDate(),
                          onTap: _pickDate,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // Submit button
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 0, 24, 32),
            child: SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                onPressed: _submit,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  textStyle: GoogleFonts.inter(
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                  ),
                ),
                child: const Text('Add Task'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
