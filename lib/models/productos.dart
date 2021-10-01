class Productos {
  final String id;
  final String nombre;
  final String imagen;
  final String imagenPlano;
  final String imagenMedidas;
  final String descripcion;
  final List caraRotativa;
  final List elastomeros;
  final List partesMetalicas;
  final List asientos;
  final String velocidad;
  final String presion;
  final String tempMin;
  final String temmMax;
  final String ficha;
  final String categoria;

  const Productos(
      {this.id,
      this.nombre,
      this.imagen,
      this.imagenPlano,
      this.imagenMedidas,
      this.descripcion,
      this.caraRotativa,
      this.elastomeros,
      this.partesMetalicas,
      this.asientos,
      this.velocidad,
      this.presion,
      this.tempMin,
      this.temmMax,
      this.ficha,
      this.categoria});
}
