import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vp_qatar_assignment_5_local_db/database/controllers/pet_tool_db_controller.dart';
import 'package:vp_qatar_assignment_5_local_db/model/pet_tool.dart';

class PetToolsScreen extends StatefulWidget {
  PetToolsScreen({
    required this.petId,
    required this.petType,
    Key? key,
  }) : super(key: key);
  late int petId;
  late int petType;
  @override
  State<PetToolsScreen> createState() => _PetToolsScreenState();
}

class _PetToolsScreenState extends State<PetToolsScreen> {
  final PetToolDBController _petToolDBController = PetToolDBController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tools'),
        centerTitle: true,
      ),
      body: FutureBuilder<List<PetTool>>(
        future: _petToolDBController.read(widget.petId, widget.petType),
        builder: (BuildContext context, AsyncSnapshot<List<PetTool>> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.active:
            case ConnectionState.waiting:
              return const CircularProgressIndicator();
            case ConnectionState.done:
              if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              }
              return ListView.separated(
                padding: const EdgeInsets.all(24),
                itemBuilder: (context, index) {
                  return CheckboxListTile(
                    title: Text(
                      snapshot.data![index].name,
                      style: GoogleFonts.nunito(
                        color: const Color(0xFFEB4747),
                      ),
                    ),
                    activeColor: const Color(0xFFF47C7C),
                    value: snapshot.data![index].taken,
                    onChanged: (bool? value) {
                      if (value != null) {
                        toggleCheckTile(
                          context,
                          flag: value,
                          petId: widget.petId,
                          toolId: snapshot.data![index].toolId,
                        );
                        setState(() {
                          snapshot.data![index].taken = value;
                        });
                      }
                    },
                  );
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(
                    height: 24,
                  );
                },
                itemCount: snapshot.data!.length,
              );

            case ConnectionState.none:
              return Text(
                'NO DATA',
                style: GoogleFonts.nunito(
                  fontSize: 24,
                ),
              );
          }
        },
      ),
    );
  }

  void toggleCheckTile(BuildContext context,
      {required bool flag, required int petId, required int toolId}) async {
    if (flag) {
      await _petToolDBController.create(petId, toolId);
    } else {
      await _petToolDBController.delete(petId, toolId);
    }
  }
}
