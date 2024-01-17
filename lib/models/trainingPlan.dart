class trainingPlan {
  final String name;
  final String start_time;

  const trainingPlan({required this.name, required this.start_time});

  toJson() {
    return {
      "name": name,
      "start_time": start_time,
    };
  }
}
