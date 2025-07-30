import 'package:flutter/material.dart';

class TextAnnotationEditor extends StatefulWidget {
  final String initialText;
  final Function(String) onTextSubmitted;
  final VoidCallback onCancel;

  const TextAnnotationEditor({
    super.key,
    this.initialText = '',
    required this.onTextSubmitted,
    required this.onCancel,
  });

  @override
  State<TextAnnotationEditor> createState() => _TextAnnotationEditorState();
}

class _TextAnnotationEditorState extends State<TextAnnotationEditor> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialText);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      color: Colors.white,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _controller,
            autofocus: true,
            decoration: const InputDecoration(
              labelText: 'Text',
              border: OutlineInputBorder(),
            ),
            maxLines: null,
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: widget.onCancel,
                child: const Text('Cancel'),
              ),
              const SizedBox(width: 8),
              ElevatedButton(
                onPressed: () {
                  widget.onTextSubmitted(_controller.text);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                ),
                child: const Text('Done'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}