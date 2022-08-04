import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vp_qatar_assignment_5_local_db/database/controllers/pet_vac_db_controller.dart';
import 'package:vp_qatar_assignment_5_local_db/model/pet_vaccine.dart';
import 'package:vp_qatar_assignment_5_local_db/utils/helpers.dart';

class PetVaccinesScreen extends StatefulWidget {
  PetVaccinesScreen({
    required this.petId,
    required this.petType,
    Key? key,
  }) : super(key: key);
  late int petId;
  late int petType;

  @override
  State<PetVaccinesScreen> createState() => _PetVaccinesScreenState();
}

class _PetVaccinesScreenState extends State<PetVaccinesScreen> with Helpers {
  final PetVacDBController _petVacDBController = PetVacDBController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Vaccines'),
        centerTitle: true,
      ),
      body: FutureBuilder<List<PetVaccine>>(
        future: _petVacDBController.read(widget.petId, widget.petType),
        builder:
            (BuildContext context, AsyncSnapshot<List<PetVaccine>> snapshot) {
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
                          vaccineId: snapshot.data![index].vaccineId,
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
      {required bool flag, required int petId, required int vaccineId}) async {
    if (flag) {
      await _petVacDBController.create(petId, vaccineId);
    } else {
      await _petVacDBController.delete(petId, vaccineId);
    }
  }
}
