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
public class Pila {

    Proceso[] arreglo;
    int Tamano;
    int Atencion;
    
    public Pila(int t) {
        arreglo = new Proceso[t];
        Tamano = -1;
        Atencion=2;
    }

    public boolean Apilar(Proceso nuevo) {
        if (this.Llena() == false) {
            Tamano++;
            arreglo[Tamano] = nuevo;
            return true;
        }
        return false;
    }

    public Proceso Desapilar() {
        Proceso aux = null;
        if (this.Vacia() == false) {
            aux = arreglo[Tamano];
            Tamano--;
            return aux;
        }
        return aux;
    }
    
    public Proceso DesapilarALU() {
        Proceso aux = null;
        if (this.Vacia() == false) {
            aux = arreglo[Tamano];
            Tamano--;
            aux.canAten-=this.Atencion;
            aux.Veces++;
            return aux;
        }
        return aux;
    }

    public boolean Llena() {
        return this.Tamano == this.arreglo.length - 1;
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
