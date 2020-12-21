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
public class Procesador {

    //Cola UPP, ALU, UPA;
    Pila UPP, ALU, UPA;

    public Procesador(int t) {
//        UPP = new Cola(t);
//        ALU = new Cola(1);
//        UPA = new Cola(t);
        UPP = new Pila(t);
        ALU = new Pila(1);
        UPA = new Pila(t);
    }

    public boolean AgregarProceso(Proceso nuevo) {
        //return UPP.Encolar(nuevo);
        return UPP.Apilar(nuevo);
    }

    public boolean AtenderProcesos() {
        //while (UPP.Vacia() == false) {
//            Proceso x = UPP.Atender();
//            ALU.Encolar(x);
//            x = ALU.AtenderALU();
//            if(x.canAten<=0)
//                UPA.Encolar(x);
//            else
//                UPP.Encolar(x);

        Proceso x = UPP.Desapilar();
        ALU.Apilar(x);
        x = ALU.DesapilarALU();
        if (x.canAten <= 0) {
            UPA.Apilar(x);
        } else {
            UPP.Apilar(x);
        }
        //}

        return true;
    }

    void MostrarUnidades() {
        System.out.println("\nUnidad de Pendientes\n");
        System.out.println(UPP.Mostrar());

        System.out.println("\nALU\n");
        System.out.println(ALU.Mostrar());

        System.out.println("\nUnidad de Atendidos\n");
        System.out.println(UPA.Mostrar());
    }
}
