import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../../../services/api_service.dart';
import '../../../models/appeal_type.dart';

class CreateAppealScreen extends StatefulWidget {
  const CreateAppealScreen({super.key});

  @override
  State<CreateAppealScreen> createState() => _CreateAppealScreenState();
}

class _CreateAppealScreenState extends State<CreateAppealScreen> {
  final _formKey = GlobalKey<FormState>();
  final _messageController = TextEditingController();
  final ImagePicker _picker = ImagePicker();

  AppealType? _selectedType;
  List<AppealType> _appealTypes = [];
  XFile? _evidenceFile;
  XFile? _selfieFile;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadAppealTypes();
  }

  Future<void> _loadAppealTypes() async {
    setState(() => _isLoading = true);
    final response = await Provider.of<ApiService>(context, listen: false)
        .get('v1/appeal/types');

    if (response != null) {
      setState(() {
        _appealTypes = (response as List)
            .map((type) => AppealType.fromJson(type))
            .toList();
      });
    }
    setState(() => _isLoading = false);
  }

  Future<void> _pickImage(bool isSelfie) async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        if (isSelfie) {
          _selfieFile = pickedFile;
        } else {
          _evidenceFile = pickedFile;
        }
      });
    }
  }

  Future<void> _submitAppeal() async {
    if (!_formKey.currentState!.validate() || _selectedType == null) return;
    if (_selfieFile == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please take a selfie')),
      );
      return;
    }

    setState(() => _isLoading = true);

    // Here you would implement the API call to submit the appeal
    // with the selected type, message, evidence and selfie

    setState(() => _isLoading = false);

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Appeal submitted successfully')),
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Appeal'),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              DropdownButtonFormField<AppealType>(
                value: _selectedType,
                hint: const Text('Select appeal type'),
                items: _appealTypes
                    .map((type) => DropdownMenuItem(
                  value: type,
                  child: Text(type.name),
                ))
                    .toList(),
                onChanged: (type) =>
                    setState(() => _selectedType = type),
                validator: (value) =>
                value == null ? 'Please select a type' : null,
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _messageController,
                maxLines: 5,
                decoration: const InputDecoration(
                  labelText: 'Message',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your message';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              const Text('Evidence (optional):'),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () => _pickImage(false),
                child: const Text('Add Evidence (Photo/Video)'),
              ),
              if (_evidenceFile != null)
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Text(_evidenceFile!.name),
                ),
              const SizedBox(height: 20),
              const Text('Selfie (required):'),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () => _pickImage(true),
                child: const Text('Take Selfie'),
              ),
              if (_selfieFile != null)
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Text(_selfieFile!.name),
                ),
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _submitAppeal,
                  child: _isLoading
                      ? const CircularProgressIndicator()
                      : const Text('Submit Appeal'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}