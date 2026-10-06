import 'package:CodaMi/features/pets/data/models/pets_model.dart';
import 'package:CodaMi/features/pets/domain/entities/pets_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('fromMap reads every field and tolerates missing ones', () {
    final pet = PetModel.fromMap('p1', {
      'ownerId': 'u1',
      'name': 'Luna',
      'species': 'cat',
      'breed': '  Siamese ',
      'color': '',
      'sex': 'F',
      'age': '3 years',
      'photoUrls': ['https://a', 'https://b'],
      'createdAt': Timestamp.fromDate(DateTime(2026, 10, 5)),
    });

    expect(pet.id, 'p1');
    expect(pet.species, PetSpecies.cat);
    expect(pet.breed, 'Siamese');
    expect(pet.color, isNull);
    expect(pet.sex, PetSex.female);
    expect(pet.coverUrl, 'https://a');
    expect(pet.createdAt, DateTime(2026, 10, 5));
    expect(pet.features, isNull);
    expect(pet.updatedAt, isNull);
  });

  test('unknown species falls back to other, unknown sex to null', () {
    final pet = PetModel.fromMap('p2', {'species': 'horse', 'sex': 'X'});
    expect(pet.species, PetSpecies.other);
    expect(pet.sex, isNull);
    expect(pet.photoUrls, isEmpty);
    expect(pet.coverUrl, isNull);
  });

  test('toFields trims text and marks empty optionals as null', () {
    final fields = PetModel.toFields(
      ownerId: 'u1',
      photoUrls: const ['https://a'],
      draft: const PetDraft(
        name: '  Milo ',
        species: PetSpecies.dog,
        breed: 'Golden Retriever',
        color: '   ',
        sex: PetSex.male,
        photos: [],
      ),
    );

    expect(fields['name'], 'Milo');
    expect(fields['species'], 'dog');
    expect(fields['sex'], 'M');
    expect(fields['breed'], 'Golden Retriever');
    expect(fields['color'], isNull);
    expect(fields['age'], isNull);
    expect(fields['photoUrls'], ['https://a']);
  });

  test('subtitle combines breed and age, else species', () {
    const withDetails = Pet(
      id: 'a',
      ownerId: 'u',
      name: 'Milo',
      species: PetSpecies.dog,
      breed: 'Beagle',
      age: '2 years',
    );
    const bare = Pet(id: 'b', ownerId: 'u', name: 'X', species: PetSpecies.cat);
    expect(withDetails.subtitle, 'Beagle · 2 years');
    expect(bare.subtitle, 'Cat');
  });
}
