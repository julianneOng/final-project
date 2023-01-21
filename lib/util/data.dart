import 'dart:math';

Random random = Random();
List names = [
  "Ling Waldner",
  "Gricelda Barrera",
  "Lenard Milton",
  "Bryant Marley",
  "Rosalva Sadberry",
  "Guadalupe Ratledge",
  "Brandy Gazda",
  "Kurt Toms",
  "Rosario Gathright",
  "Kim Delph",
  "Stacy Christensen",
];

List contacts = [
  {'name': "Jeremiah Larry King Ungsod", 'email': ''},
{'name': "Arjay Audiencia Charcos", 'email': ''},
{'name': "Janmark Sabanal", 'email': ''},
{'name': "Johnlearn Mosqueda",'email': ''},
{'name':  "Jonard Salvanera Estamo",'email': ''},
{'name': "Julianne G. Ong",'email': ''},
{'name': "Ronald Naguita",'email': ''},
];

List posts = List.generate(
    13,
        (index) => {
      "name": names[random.nextInt(10)],
      "dp": "assets/images/cm${random.nextInt(10)}.jpeg",
      "time": "${random.nextInt(50)} min ago",
      "img": "assets/images/cm${random.nextInt(10)}.jpeg"
    });

List friends = List.generate(
    13,
        (index) => {
      "name": names[random.nextInt(10)],
      "dp": "assets/images/cm${random.nextInt(10)}.jpeg",
      "status": "Anything could be here",
      "isAccept": random.nextBool(),
    });

List group = List.generate(
    7,
        (index) => {
      "name": contacts,
      "dp": "assets/images/cm${random.nextInt(7)}.jpeg",
      "status": "Group Member",
    });

