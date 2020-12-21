/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package solucionparcial1;

/**
 *
 * @author estudiante
 */
public class Proceso {

    String nombre;
    int Tamano, canAten;
    int Veces;

    public Proceso(String nombre, int Tamano) {
        this.nombre = nombre;
        this.Tamano = this.canAten = Tamano;
        Veces=0;
    }
    
    @Override
    public String toString() {
        return "NombreProceso: "+this.nombre+" - Tamaño: "+this.Tamano+" - Veces en ALU: "+this.Veces;
    }

}
