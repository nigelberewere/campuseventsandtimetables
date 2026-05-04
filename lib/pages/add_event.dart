import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

class AddEventPage extends StatefulWidget {
  const AddEventPage({super.key});

  @override
  State<AddEventPage> createState() => _AddEventPageState();
}

class _AddEventPageState extends State<AddEventPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  late TextEditingController _locationController;
  late TextEditingController _organizerController;
  late TextEditingController _attendeesController;
  late TextEditingController _dateController;
  late TextEditingController _startTimeController;
  late TextEditingController _endTimeController;

  String _selectedCategory = 'Academic';
  final List<String> _categories = [
    'Academic',
    'Sports',
    'Career',
    'Cultural',
    'Workshop',
    'Social',
    'Other',
  ];

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
    _descriptionController = TextEditingController();
    _locationController = TextEditingController();
    _organizerController = TextEditingController();
    _attendeesController = TextEditingController();
    _dateController = TextEditingController();
    _startTimeController = TextEditingController();
    _endTimeController = TextEditingController();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _locationController.dispose();
    _organizerController.dispose();
    _attendeesController.dispose();
    _dateController.dispose();
    _startTimeController.dispose();
    _endTimeController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2027),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppColors.blueMirage, 
              onPrimary: AppColors.white, 
              onSurface: AppColors.darkGray,
            ),
          ),
          child: child!,
        );
      },
    );
    if (pickedDate != null) {
      setState(() {
        _dateController.text = _formatDate(pickedDate);
      });
    }
  }

  Future<void> _selectTime(
    BuildContext context,
    TextEditingController controller,
  ) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppColors.blueMirage, 
            ),
          ),
          child: child!,
        );
      },
    );
    if (pickedTime != null) {
      setState(() {
        controller.text = pickedTime.format(context);
      });
    }
  }

  String _formatDate(DateTime date) {
    const months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
    ];
    return '${months[date.month - 1]} ${date.day}, ${date.year}';
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final newEvent = {
        'title': _titleController.text,
        'description': _descriptionController.text,
        'location': _locationController.text,
        'organizer': _organizerController.text,
        'attendees': int.parse(_attendeesController.text),
        'category': _selectedCategory,
        'date': _dateController.text,
        'startTime': _startTimeController.text,
        'endTime': _endTimeController.text,
        'time': '${_startTimeController.text} - ${_endTimeController.text}',
      };

      Navigator.pop(context, newEvent);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Create Event',
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
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Text(
                  'Event Details',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.blueMirage,
                  ),
                ),
                const SizedBox(height: 20),

                // Title Field
                _buildTextField(
                  controller: _titleController,
                  label: 'Event Title',
                  hint: 'e.g., Tech Conference 2026',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter an event title';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // Category Dropdown
                _buildCategoryDropdown(),
                const SizedBox(height: 16),

                // Description Field
                _buildTextField(
                  controller: _descriptionController,
                  label: 'Description',
                  hint: 'Describe your event...',
                  maxLines: 4,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a description';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24),

                // Date Section
                Text(
                  'Date & Time',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.blueMirage,
                  ),
                ),
                const SizedBox(height: 12),

                // Date Field
                _buildDateField(
                  controller: _dateController,
                  label: 'Event Date',
                  onTap: () => _selectDate(context),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select a date';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 12),

                // Time Row (Start and End side-by-side)
                Row(
                  children: [
                    Expanded(
                      child: _buildTimeField(
                        controller: _startTimeController,
                        label: 'Start Time',
                        onTap: () => _selectTime(context, _startTimeController),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Required';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _buildTimeField(
                        controller: _endTimeController,
                        label: 'End Time',
                        onTap: () => _selectTime(context, _endTimeController),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Required';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // Location Section
                Text(
                  'Location & Organizer',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.blueMirage,
                  ),
                ),
                const SizedBox(height: 12),

                // Location Field
                _buildTextField(
                  controller: _locationController,
                  label: 'Location',
                  hint: 'e.g., Auditorium A',
                  prefixIcon: Icons.location_on,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a location';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 12),

                // Organizer Field
                _buildTextField(
                  controller: _organizerController,
                  label: 'Organizer',
                  hint: 'e.g., Computer Science Department',
                  prefixIcon: Icons.people,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter an organizer';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24),

                // Additional Section
                Text(
                  'Additional Info',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.blueMirage,
                  ),
                ),
                const SizedBox(height: 12),

                // Expected Attendees
                _buildTextField(
                  controller: _attendeesController,
                  label: 'Expected Attendees',
                  hint: 'e.g., 150',
                  prefixIcon: Icons.people_outline,
                  // NEW: Ensures a clean number pad on both iOS and Android
                  keyboardType: const TextInputType.numberWithOptions(decimal: false, signed: false),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter expected attendees';
                    }
                    if (int.tryParse(value) == null) {
                      return 'Please enter a valid number';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 32),

                // Action Buttons
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => Navigator.pop(context),
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(
                            color: AppColors.blueMirage,
                            width: 2,
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          'Cancel',
                          style: TextStyle(
                            color: AppColors.blueMirage,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: _submitForm,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.amberSmoke, // Matches the new FAB color
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          'Create Event',
                          style: TextStyle(
                            color: AppColors.blueMirage,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    int maxLines = 1,
    IconData? prefixIcon,
    TextInputType keyboardType = TextInputType.text,
    required String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: prefixIcon != null
            ? Icon(prefixIcon, color: AppColors.blueMirage)
            : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.dividerGray),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.dividerGray),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.blueMirage, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.error),
        ),
        labelStyle: const TextStyle(color: AppColors.blueMirage),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
      ),
      maxLines: maxLines,
      keyboardType: keyboardType,
      validator: validator,
    );
  }

  Widget _buildDateField({
    required TextEditingController controller,
    required String label,
    required VoidCallback onTap,
    required String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      readOnly: true,
      onTap: onTap,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: const Icon(
          Icons.calendar_today,
          color: AppColors.blueMirage,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.dividerGray),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.dividerGray),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.blueMirage, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.error),
        ),
        labelStyle: const TextStyle(color: AppColors.blueMirage),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
      ),
      validator: validator,
    );
  }

  Widget _buildTimeField({
    required TextEditingController controller,
    required String label,
    required VoidCallback onTap,
    required String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      readOnly: true,
      onTap: onTap,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: const Icon(Icons.access_time, color: AppColors.blueMirage),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.dividerGray),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.dividerGray),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.blueMirage, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.error),
        ),
        labelStyle: const TextStyle(color: AppColors.blueMirage),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
      ),
      validator: validator,
    );
  }

  Widget _buildCategoryDropdown() {
    return DropdownButtonFormField<String>(
      initialValue: _selectedCategory,
      decoration: InputDecoration(
        labelText: 'Category',
        prefixIcon: const Icon(Icons.category, color: AppColors.blueMirage),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.dividerGray),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.dividerGray),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.blueMirage, width: 2),
        ),
        labelStyle: const TextStyle(color: AppColors.blueMirage),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
      ),
      items: _categories.map((category) {
        return DropdownMenuItem(value: category, child: Text(category));
      }).toList(),
      onChanged: (value) {
        if (value != null) {
          setState(() {
            _selectedCategory = value;
          });
        }
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please select a category';
        }
        return null;
      },
    );
  }
}