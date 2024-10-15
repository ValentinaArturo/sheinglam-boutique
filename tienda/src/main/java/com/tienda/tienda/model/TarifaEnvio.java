package com.tienda.tienda.model;

import java.util.HashMap;
import java.util.Map;

public class TarifaEnvio {
    private static final Map<String, Double> tarifas;

    static {
        tarifas = new HashMap<>();
        tarifas.put("Guatemala", 30.0);
        tarifas.put("San Marcos", 40.0);
        tarifas.put("Quetzaltenango", 35.0);
        tarifas.put("Escuintla", 25.0);
        tarifas.put("Alta Verapaz", 50.0);
        tarifas.put("Baja Verapaz", 45.0);
        tarifas.put("Chimaltenango", 30.0);
        tarifas.put("Chiquimula", 55.0);
        tarifas.put("El Progreso", 50.0);
        tarifas.put("Totonicapán", 40.0);
        tarifas.put("Sacatepéquez", 30.0);
        tarifas.put("Solalá", 30.0);
        tarifas.put("Suchitepéquez", 40.0);
        tarifas.put("Retalhuleu", 45.0);
        tarifas.put("Zacapa", 50.0);
        tarifas.put("Jalapa", 40.0);
        tarifas.put("Peten", 60.0);
        tarifas.put("Huehuetenango", 50.0);
        tarifas.put("San Juan Sacatepéquez", 30.0);
        tarifas.put("San Pedro Sacatepéquez", 35.0);
        tarifas.put("Sierra de las Minas", 55.0);
        tarifas.put("La Libertad", 50.0);
        tarifas.put("Coban", 50.0);
    }

    public static double getTarifa(String departamento) {
        return tarifas.getOrDefault(departamento, -1.0); // Retorna -1.0 si el departamento no está en la lista
    }
}

