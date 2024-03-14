const days = [1, 2, 3, 4, 5, 6, 7];
const sessions = [1, 2, 3];

const muscleGroups = [
  'Upper Traps',
  "Middle Traps",
  "Lower Traps",
  "Lats",
  "Lower Back",
  "Biceps",
  "Triceps",
  "Forearms",
  "Front Delts",
  "Side Delts",
  'Rear Delts',
  'Upper Chest',
  'Chest',
  'Abs',
  "Lower Abs",
  'Obliques',
  "Quads",
  "Glutes",
  "Hamstrings",
  "Calves"
];

const focus = [
  "Even",
  "Upper",
  "Lower",
  "Glutes",
  "Chest",
  "Shoulders",
  "Back"
];

class Exercise {
  String name;
  String type;
  Iterable<String>? primary;
  Iterable<String>? secondary;

  Exercise(
      {required this.name, required this.type, this.primary, this.secondary});
}

var exercises = [
  Exercise(
      name: 'Bench',
      type: 'Barbell',
      primary: ['Chest'],
      secondary: ['Tricep']),
  Exercise(
      name: 'Squat',
      type: 'Barbell',
      primary: ['Quad', "Glute"],
      secondary: ['Lower Back', 'Hamstring', "Calf"]),
  Exercise(
      name: 'Deadlift',
      type: 'Barbell',
      primary: ['Lower Back', 'Upper Traps', "Lats"]),
  Exercise(
      name: 'Pullup',
      type: 'Body Weight',
      primary: ['Lats'],
      secondary: ['Bicep']),
];

class Mesocycle {

}

class Workout {

}