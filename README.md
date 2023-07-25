# Pokedex-Flutter

It is a complete Pokedex App developed over [Poke Api](https://pokeapi.co/), with Flutter. It was my Course project for the **Database management system(DBMS)** 
It is a complete app for scrapping data from API and storing it in Database

## FUNCTIONALITIES:

1. Login/SignUp Screen with interactive UI.
2. Search Pokemon by name
3. Sort by type, statistics, PokedexNumber, Albatically
4. Display All Pokemon
5. When I click on specific Pokemon it will give the Description of the Pokemon, Base stats, Abbities
6. When the Moves tab is clicked it shows Moves of Every Pokemon along with stats of that Moves

## INFORMATION ABOUT POKEMON

1. Name
2. Pokedex Number
3. Types
4. Pokedex Description
5. Height
6. Weight
7. Base Statistics
8. Abilities
9. Moves Learnt from

## SCREENSHOT FROM APP

![Untitled design](https://github.com/abdxlahs/Pokedex-Flutter/assets/109152435/eb39e8f5-9a26-4c7d-9e7c-a6abde867f85)

### SCHEMA FOR POKEDEX DATABASE

[database schema](https://github.com/abdxlahs/Pokedex-Flutter/files/12165332/__dynobird.com__2023-07-25_23_20_16.pdf)

    
## IMPORTANT:

For projects with Firestore integration, you must first run the following commands to ensure the project compiles:

```
flutter pub get
flutter packages pub run build_runner build --delete-conflicting-outputs
```

This command creates the generated files that parse each Record from Firestore into a schema object.

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
