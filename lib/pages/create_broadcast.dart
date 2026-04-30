import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

class CreateBroadcastPage extends StatefulWidget {
  const CreateBroadcastPage({super.key});

  @override
  State<CreateBroadcastPage> createState() => _CreateBroadcastPageState();
}

class _CreateBroadcastPageState extends State<CreateBroadcastPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _messageController;

  String _selectedTarget = 'All Users';
  final List<String> _targets = [
    'All Users',
    'Students Only',
    'Class Representatives',
    'Faculty Members',
    'Admins Only',
  ];

  bool _sendAsEmail = true;
  bool _sendAsPush = true;
  bool _sendAsInApp = true;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
    _messageController = TextEditingController();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  void _sendBroadcast() {
    if (_formKey.currentState!.validate()) {
      // Here you would implement the actual broadcast sending logic
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Broadcast sent successfully!'),
          backgroundColor: AppColors.success,
        ),
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Create Broadcast',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: AppColors.white,
          ),
        ),
        backgroundColor: AppColors.blueMirage,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Broadcast Details',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.darkGray,
                ),
              ),
              const SizedBox(height: 24),

              // Title Field
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(
                  labelText: 'Broadcast Title',
                  hintText: 'Enter a clear, concise title',
                  prefixIcon: const Icon(Icons.title_rounded),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  filled: true,
                  fillColor: AppColors.lightGray,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a broadcast title';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),

              // Message Field
              TextFormField(
                controller: _messageController,
                maxLines: 6,
                decoration: InputDecoration(
                  labelText: 'Message',
                  hintText: 'Enter your broadcast message...',
                  alignLabelWithHint: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  filled: true,
                  fillColor: AppColors.lightGray,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a message';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),

              // Target Audience Section
              Text(
                'Target Audience',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.darkGray,
                ),
              ),
              const SizedBox(height: 12),

              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: AppColors.lightGray,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.dividerGray),
                ),
                child: DropdownButtonFormField<String>(
                  initialValue: _selectedTarget,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.zero,
                  ),
                  items: _targets.map((target) {
                    return DropdownMenuItem(value: target, child: Text(target));
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedTarget = value!;
                    });
                  },
                ),
              ),
              const SizedBox(height: 24),

              // Delivery Channels Section
              Text(
                'Delivery Channels',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.darkGray,
                ),
              ),
              const SizedBox(height: 12),

              _buildChannelOption(
                title: 'Email Notification',
                subtitle: 'Send via email to all recipients',
                value: _sendAsEmail,
                onChanged: (value) => setState(() => _sendAsEmail = value),
              ),
              const SizedBox(height: 8),

              _buildChannelOption(
                title: 'Push Notification',
                subtitle: 'Send push notification to mobile devices',
                value: _sendAsPush,
                onChanged: (value) => setState(() => _sendAsPush = value),
              ),
              const SizedBox(height: 8),

              _buildChannelOption(
                title: 'In-App Notification',
                subtitle: 'Show notification within the app',
                value: _sendAsInApp,
                onChanged: (value) => setState(() => _sendAsInApp = value),
              ),
              const SizedBox(height: 32),

              // Action Buttons
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppColors.blueMirage,
                        side: const BorderSide(color: AppColors.blueMirage),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text('Cancel'),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: FilledButton.icon(
                      onPressed: _sendBroadcast,
                      icon: const Icon(Icons.send_rounded),
                      label: const Text('Send Broadcast'),
                      style: FilledButton.styleFrom(
                        backgroundColor: AppColors.blueMirage,
                        foregroundColor: AppColors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildChannelOption({
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.lightGray,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.dividerGray),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.darkGray,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.darkGray,
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeThumbColor: AppColors.blueMirage,
          ),
        ],
      ),
    );
  }
}
