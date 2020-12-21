/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package solucionparcial1;

import java.util.Scanner;

/**
 *
 * @author estudiante
 */
public class SolucionParcial1 {

    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) {

        Scanner sc = new Scanner(System.in);
        Procesador pro = new Procesador(4);
        while (true) {

            System.out.println("Menu de opciones\n1.Ingresar proceso\n2. Atender procesos\n3.Mostrar unidades");
            int op = sc.nextInt();

            switch (op) {
                case 1:

                    pro.AgregarProceso(new Proceso("Proc1", 4));
                    pro.AgregarProceso(new Proceso("Proc2", 3));
                    pro.AgregarProceso(new Proceso("Proc3", 7));
                    pro.AgregarProceso(new Proceso("Proc4", 5));
//                    System.out.println("Nombre del proceso");
//                    String nom = sc.next();
//                    System.out.println("Tamaño del proceso");
//                    int tam = sc.nextInt();
//                    Proceso x = new Proceso(nom, tam);
//                    if (pro.AgregarProceso(x)) {
//                        System.out.println("Proceso agregado correctamente");
//                    } else {
//                        System.out.println("Proceso NO agregado");
//                    }
                    break;

                case 2:
                    pro.AtenderProcesos();
                    pro.MostrarUnidades();

                    break;

                case 3:
                    pro.MostrarUnidades();
                    break;
            }
        }
    }

}
