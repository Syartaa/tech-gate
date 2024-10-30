import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tech_gate/widgets/custom_appbar.dart';

class DeleteAccount extends StatefulWidget {
  const DeleteAccount({super.key});

  @override
  _DeleteAccountState createState() => _DeleteAccountState();
}

class _DeleteAccountState extends State<DeleteAccount> {
  int? _selectedReason;
  int? _selectedFuture;
  String? _comment;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Container(
        padding: const EdgeInsets.all(15.0),
        child: ListView(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Formulari i fshirjes së llogarisë",
                  style: GoogleFonts.poppins(fontSize: 20, color: Colors.white),
                ),
                const SizedBox(height: 16.0),

                // Reason for deleting account
                Text(
                  "Pse po e fshini llogarinë tuaj? *",
                  style: GoogleFonts.poppins(fontSize: 16, color: Colors.white),
                ),
                ...List.generate(7, (index) {
                  return RadioListTile<int>(
                    activeColor: Colors.red, // Change the active color to red
                    title: Text(
                      _getReasonText(index),
                      style: GoogleFonts.poppins(color: Colors.white),
                    ),
                    value: index,
                    groupValue: _selectedReason,
                    onChanged: (value) {
                      setState(() {
                        _selectedReason = value;
                      });
                    },
                  );
                }),

                // Future account creation
                const SizedBox(height: 20.0),
                Text(
                  "A e shihni vetën duke krijuar një llogari të re me Tech Gate në çdo kohë në të ardhmen? *",
                  style: GoogleFonts.poppins(fontSize: 16, color: Colors.white),
                ),
                ...List.generate(6, (index) {
                  return RadioListTile<int>(
                    activeColor: Colors.red, // Change the active color to red
                    title: Text(
                      _getFutureText(index),
                      style: GoogleFonts.poppins(color: Colors.white),
                    ),
                    value: index,
                    groupValue: _selectedFuture,
                    onChanged: (value) {
                      setState(() {
                        _selectedFuture = value;
                      });
                    },
                  );
                }),

                // Comment Section
                const SizedBox(height: 20.0),
                Text(
                  "Ju lutemi na jepni çdo koment ose reagim shtesë.",
                  style: GoogleFonts.poppins(fontSize: 16, color: Colors.white),
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  onChanged: (value) {
                    setState(() {
                      _comment = value;
                    });
                  },
                  decoration: InputDecoration(
                    hintText: "Komentoni këtu...",
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor: const Color.fromARGB(155, 255, 255, 255),
                  ),
                  maxLines: 3,
                ),

                // Submit Button
                const SizedBox(height: 20.0),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFEC1D3B),
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      'Fshij',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _getReasonText(int index) {
    switch (index) {
      case 0:
        return "Përvojë e keqe e shërbimit ndaj klientit";
      case 1:
        return "Kohë të mjaftueshme";
      case 2:
        return "Nuk ka vlere për mua";
      case 3:
        return "Nuk mund ta përballojë tani";
      case 4:
        return "Jo ajo që çmisa";
      case 5:
        return "Vështirësi teknike";
      case 6:
        return "Tjera";
      default:
        return "";
    }
  }

  String _getFutureText(int index) {
    switch (index) {
      case 0:
        return "Patjetër";
      case 1:
        return "Ndoshta";
      case 2:
        return "Jo i sigurt";
      case 3:
        return "Me siguri jo";
      case 4:
        return "Definitivisht Jo";
      default:
        return "Tjera";
    }
  }
}
