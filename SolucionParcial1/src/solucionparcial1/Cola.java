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
public class Cola {

    Proceso[] arreglo;
    int Tamano;
    int Atencion;

    public Cola(int t) {
        arreglo = new Proceso[t];
        Tamano = -1;
        Atencion = 2;
    }

    public boolean Encolar(Proceso nuevo) {
        if (this.Llena() == false) {
            Tamano++;
            arreglo[Tamano] = nuevo;
            return true;
        }
        return false;
    }

    public Proceso Atender() {
        Proceso aux = null;
        if (this.Vacia() == false) {
            aux = arreglo[0];
            for (int i = 1; i <= Tamano; i++) {
                arreglo[i - 1] = arreglo[i];
            }
            Tamano--;
            return aux;
        }
        return aux;
    }

    public Proceso AtenderALU() {
        Proceso aux = null;
        if (this.Vacia() == false) {
            aux = arreglo[0];
            for (int i = 1; i <= Tamano; i++) {
                arreglo[i - 1] = arreglo[i];
            }
            Tamano--;
            aux.canAten -= this.Atencion;
            aux.Veces++;
            return aux;
        }
        return aux;
    }

    public boolean Llena() {
        return this.Tamano == this.arreglo.length -1;
    }

    public boolean Vacia() {
        return this.Tamano == -1;
    }

    public String Mostrar() {
        String x = "";
        for (int i = 0; i <= Tamano; i++) {
            x += "\n" + arreglo[i].toString();
        }
        return x;
    }
}
