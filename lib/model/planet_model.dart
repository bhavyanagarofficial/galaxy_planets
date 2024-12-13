class PlanetModel {
  late String position,
      name,
      subtitle,
      model,
      velocity,
      distance,
      description,
      length_of_day,
      orbital_period,
      gravity,
      surface_area;

  PlanetModel(this.position,
      this.name,
      this.subtitle,
      this.model,
      this.velocity,
      this.distance,
      this.description,
      this.length_of_day,
      this.orbital_period,
      this.gravity,
      this.surface_area);

  factory PlanetModel.fromJson(Map m1){
    return PlanetModel(
        m1["position"],
        m1["name"],
        m1["subtitle"],
        m1["model"],
        m1["velocity"],
        m1["distance"],
        m1["description"],
        m1["length_of_day"],
        m1["orbital_period"],
        m1["gravity"],
        m1["surface_area"]);
  }
}
