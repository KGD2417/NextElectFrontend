import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:next_elect/providers/election_provider.dart';

class CreateElectionScreen extends StatefulWidget {
  const CreateElectionScreen({super.key});

  @override
  _CreateElectionScreenState createState() => _CreateElectionScreenState();
}

class _CreateElectionScreenState extends State<CreateElectionScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final List<TextEditingController> _candidateControllers = [TextEditingController()];

  @override
  Widget build(BuildContext context) {
    final electionProvider = Provider.of<ElectionProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Create Election')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Election Name'),
                validator: (value) => value!.isEmpty ? 'Required' : null,
              ),
              ..._candidateControllers.map((controller) => TextFormField(
                controller: controller,
                decoration: const InputDecoration(labelText: 'Candidate'),
                validator: (value) => value!.isEmpty ? 'Required' : null,
              )),
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: () => setState(() => _candidateControllers.add(TextEditingController())),
                  ),
                  IconButton(
                    icon: const Icon(Icons.remove),
                    onPressed: () => setState(() => _candidateControllers.removeLast()),
                  ),
                ],
              ),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    await electionProvider.createElection(
                      _nameController.text,
                      _candidateControllers.map((c) => c.text).toList(),
                      60, // Default 1 hour duration
                    );
                    Navigator.pop(context);
                  }
                },
                child: const Text('Create Election'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}