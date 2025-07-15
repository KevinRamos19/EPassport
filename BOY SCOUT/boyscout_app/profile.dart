import 'package:flutter/material.dart';

class ScoutProfilePage extends StatefulWidget {
  const ScoutProfilePage({super.key});

  @override
  State<ScoutProfilePage> createState() => _ScoutProfilePageState();
}

class _ScoutProfilePageState extends State<ScoutProfilePage> {
  final _formKey = GlobalKey<FormState>();

  // Controllers
  final TextEditingController firstName = TextEditingController();
  final TextEditingController middleName = TextEditingController();
  final TextEditingController lastName = TextEditingController();
  final TextEditingController birthday = TextEditingController();
  final TextEditingController address = TextEditingController();
  final TextEditingController contactNumber = TextEditingController();
  final TextEditingController region = TextEditingController();
  final TextEditingController council = TextEditingController();
  final TextEditingController institution = TextEditingController();
  final TextEditingController outfitNo = TextEditingController();
  final TextEditingController position = TextEditingController();
  final TextEditingController serialNo = TextEditingController();
  final TextEditingController parentName = TextEditingController();
  final TextEditingController parentContact = TextEditingController();
  final TextEditingController investitureDate = TextEditingController();
  final TextEditingController membershipId = TextEditingController();
  final TextEditingController regDate = TextEditingController();
  final TextEditingController expDate = TextEditingController();

  // Checkbox state
  bool kab1 = false, kab2 = false, kab3 = false;
  bool boy1 = false, boy2 = false, boy3 = false;
  bool kid1 = false;

  Widget buildTextField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
          filled: true,
          fillColor: Colors.white,
        ),
      ),
    );
  }

  Widget buildCheckboxRow(String title, List<String> labels, List<bool> values, Function(int, bool) onChanged) {
    return Row(
      children: [
        Text(title),
        const SizedBox(width: 16),
        ...List.generate(labels.length, (i) {
          return Row(
            children: [
              Checkbox(
                value: values[i],
                onChanged: (val) => setState(() => onChanged(i, val!)),
              ),
              Text(labels[i]),
            ],
          );
        }),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Scout Profile"),
        backgroundColor: Colors.green,
        actions: [
    IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        Navigator.pop(context); // Go back to previous screen
      },
    ),
  ],
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('lib/boyscout_app/assets/images/bg.png'), 
            fit: BoxFit.cover, 
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                buildTextField("First Name", firstName),
                buildTextField("Middle Name", middleName),
                buildTextField("Last Name", lastName),
                buildTextField("Birthday", birthday),
                buildTextField("Address", address),
                buildTextField("Contact Number", contactNumber),
                buildTextField("Region", region),
                buildTextField("Council", council),
                buildTextField("Sponsoring Institution", institution),
                buildTextField("Outfit No.", outfitNo),
                buildTextField("Scouting Position", position),
                buildTextField("Serial Number", serialNo),
                buildTextField("Name of Parent/Guardian", parentName),
                buildTextField("Contact Number (Guardian)", parentContact),

                const SizedBox(height: 12),
                const Align(alignment: Alignment.centerLeft, child: Text("Tenure in Scouting:", style: TextStyle(fontWeight: FontWeight.bold))),
                const SizedBox(height: 4),
                buildCheckboxRow("Kid Scouting:", ["1 Year"], [kid1], (i, val) => kid1 = val),
                buildCheckboxRow("Kab Scouting:", ["1 Year", "2 Year", "3 Year"], [kab1, kab2, kab3], (i, val) {
                  kab1 = i == 0 ? val : kab1;
                  kab2 = i == 1 ? val : kab2;
                  kab3 = i == 2 ? val : kab3;
                }),
                buildCheckboxRow("Boy Scouting:", ["1 Year", "2 Year", "3 Year"], [boy1, boy2, boy3], (i, val) {
                  boy1 = i == 0 ? val : boy1;
                  boy2 = i == 1 ? val : boy2;
                  boy3 = i == 2 ? val : boy3;
                }),

                const SizedBox(height: 12),
                buildTextField("Date of Investiture Ceremony", investitureDate),
                buildTextField("Membership ID No.", membershipId),
                buildTextField("Date of Registration", regDate),
                buildTextField("Date of Expiration", expDate),

                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // Save or submit logic here
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Profile Saved")),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                  child: const Text("Save Profile", style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(
    home: ScoutProfilePage(),
    debugShowCheckedModeBanner: false,
  ));
}
