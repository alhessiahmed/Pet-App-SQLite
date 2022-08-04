import 'package:vp_qatar_assignment_5_local_db/model/pet.dart';

abstract class PetCrudEvent {}

class PetCreateEvent extends PetCrudEvent {
  final Pet pet;

  PetCreateEvent(this.pet);
}

class PetDeleteEvent extends PetCrudEvent {
  final int id;

  PetDeleteEvent(this.id);
}

class PetReadEvent extends PetCrudEvent {}

// class PetShowEvent extends PetCrudEvent {
//   final int id;

//   PetShowEvent(this.id);
// }

class PetUpdateEvent extends PetCrudEvent {
  final Pet pet;

  PetUpdateEvent(this.pet);
}
