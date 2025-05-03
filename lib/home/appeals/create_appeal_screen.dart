import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../models/appeal.dart';
import '../../models/appeal_type.dart';
import '../../services/api_service.dart';

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
  File? _evidenceFile;
  File? _selfieFile;
  bool _isLoading = false;
  List<Appeal> _myAppeals = [];

  @override
  void initState() {
    super.initState();
    _loadAppealTypes();
    _loadMyAppeals();
  }

  Future<void> _loadAppealTypes() async {
    setState(() => _isLoading = true);
    try {
      final response = await Provider.of<ApiService>(context, listen: false)
          .get('v1/appeal/types');

      if (response != null) {
        setState(() {
          _appealTypes = (response as List)
              .map((type) => AppealType.fromJson(type))
              .toList();
        });
      }
    } catch (e) {
      Fluttertoast.showToast(msg: "Failed to load appeal types");
    }
    setState(() => _isLoading = false);
  }

  Future<void> _loadMyAppeals() async {
    setState(() => _isLoading = true);
    try {
      final response = await Provider.of<ApiService>(context, listen: false)
          .get('v1/appeals');

      if (response != null) {
        setState(() {
          _myAppeals = (response as List)
              .map((appeal) => Appeal.fromJson(appeal))
              .toList();
        });
      }
    } catch (e) {
      Fluttertoast.showToast(msg: "Failed to load your appeals");
    }
    setState(() => _isLoading = false);
  }

  Future<void> _pickImage(bool isSelfie) async {
    try {
      final pickedFile = await _picker.pickImage(source: ImageSource.camera);
      if (pickedFile != null) {
        setState(() {
          if (isSelfie) {
            _selfieFile = File(pickedFile.path);
          } else {
            _evidenceFile = File(pickedFile.path);
          }
        });
      }
    } catch (e) {
      Fluttertoast.showToast(msg: "Failed to pick image");
    }
  }

  Future<void> _submitAppeal() async {
    if (!_formKey.currentState!.validate() || _selectedType == null) {
      Fluttertoast.showToast(msg: "Please fill all required fields");
      return;
    }
    if (_selfieFile == null) {
      Fluttertoast.showToast(msg: "Please take a selfie");
      return;
    }

    setState(() => _isLoading = true);

    try {
      // APIga so'rov yuborish
      final apiService = Provider.of<ApiService>(context, listen: false);
      final response = await apiService.post('v1/appeals', {
        'type_id': _selectedType!.id,
        'message': _messageController.text,
        // Bu yerda fayllarni yuklash kodini qo'shishingiz kerak
      });

      if (response != null) {
        Fluttertoast.showToast(msg: "Appeal submitted successfully");
        _messageController.clear();
        setState(() {
          _evidenceFile = null;
          _selfieFile = null;
          _selectedType = null;
        });
        _loadMyAppeals(); // Yangi murojaatni ro'yxatga qo'shish
      }
    } catch (e) {
      Fluttertoast.showToast(msg: "Failed to submit appeal");
    }

    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Create Appeal'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'New Appeal'),
              Tab(text: 'My Appeals'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // Yangi murojaat qismi
            SingleChildScrollView(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    // Murojaat turini tanlash
                    DropdownButtonFormField<AppealType>(
                      value: _selectedType,
                      hint: const Text('Select appeal type*'),
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
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Xabar matni
                    TextFormField(
                      controller: _messageController,
                      maxLines: 5,
                      decoration: const InputDecoration(
                        labelText: 'Message*',
                        border: OutlineInputBorder(),
                        hintText: 'Describe your appeal in detail...',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your message';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),

                    // Dalil uchun rasm/video
                    const Text('Evidence (optional):',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 10),
                    ElevatedButton.icon(
                      onPressed: () => _pickImage(false),
                      icon: const Icon(Icons.camera_alt),
                      label: const Text('Add Evidence (Photo/Video)'),
                    ),
                    if (_evidenceFile != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Column(
                          children: [
                            Image.file(_evidenceFile!, height: 150),
                            Text(_evidenceFile!.path.split('/').last),
                          ],
                        ),
                      ),
                    const SizedBox(height: 20),

                    // Selfie uchun rasm
                    const Text('Selfie (required):',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    const Text('Take a selfie to verify your identity',
                        style: TextStyle(color: Colors.grey)),
                    const SizedBox(height: 10),
                    ElevatedButton.icon(
                      onPressed: () => _pickImage(true),
                      icon: const Icon(Icons.face),
                      label: const Text('Take Selfie'),
                    ),
                    if (_selfieFile != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Column(
                          children: [
                            Image.file(_selfieFile!, height: 150),
                            Text(_selfieFile!.path.split('/').last),
                          ],
                        ),
                      ),
                    const SizedBox(height: 30),

                    // Yuborish tugmasi
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: _isLoading ? null : _submitAppeal,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          foregroundColor: Colors.white,
                        ),
                        child: _isLoading
                            ? const CircularProgressIndicator()
                            : const Text('Submit Appeal',
                            style: TextStyle(fontSize: 16)),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Mening murojaatlarim ro'yxati
            _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _myAppeals.isEmpty
                ? const Center(child: Text('No appeals submitted yet'))
                : ListView.builder(
              padding: const EdgeInsets.all(10),
              itemCount: _myAppeals.length,
              itemBuilder: (context, index) {
                final appeal = _myAppeals[index];
                return Card(
                  child: ListTile(
                    title: Text(appeal.type?.name ?? 'No Type'),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(appeal.message),
                        const SizedBox(height: 5),
                        Text(
                          'Status: ${appeal.status}',
                          style: TextStyle(
                            color: appeal.status == 'approved'
                                ? Colors.green
                                : appeal.status == 'rejected'
                                ? Colors.red
                                : Colors.orange,
                          ),
                        ),
                      ],
                    ),
                    trailing: appeal.selfieUrl != null
                        ? CircleAvatar(
                      backgroundImage: NetworkImage(appeal.selfieUrl!),
                    )
                        : null,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}