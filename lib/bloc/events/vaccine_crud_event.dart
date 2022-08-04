import 'package:vp_qatar_assignment_5_local_db/model/vaccine.dart';

abstract class VaccineCrudEvent {}

class VaccineCreateEvent extends VaccineCrudEvent {
  final Vaccine vaccine;

  VaccineCreateEvent(this.vaccine);
}

class VaccineDeleteEvent extends VaccineCrudEvent {
  final int index;

  VaccineDeleteEvent(this.index);
}

class VaccineReadEvent extends VaccineCrudEvent {}
