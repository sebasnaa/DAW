/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package beans;

/**
 *
 * @author sebas
 */
public class Comida {
    
     private long id;
    private double precio;
    private String descripcion;
    private String nombre;

    public Comida( double precio, String descripcion, String nombre) {
        this.precio = precio;
        this.descripcion = descripcion;
        this.nombre = nombre;
    }

    public Comida() {
    }

    public double getPrecio() {
        return precio;
    }

    public void setPrecio(double precio) {
        this.precio = precio;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    @Override
    public String toString() {
        return "Bebida{" + "id=" + id + ", precio=" + precio + ", descripcion=" + descripcion + ", nombre=" + nombre + '}';
    }

    
}
