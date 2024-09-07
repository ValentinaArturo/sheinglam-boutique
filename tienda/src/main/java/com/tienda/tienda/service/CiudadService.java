package com.tienda.tienda.service;

import com.tienda.tienda.model.Ciudad;
import com.tienda.tienda.repository.CiudadRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.CrossOrigin;

import java.util.List;

@CrossOrigin
@Service
public class CiudadService {

    @Autowired
    private CiudadRepository ciudadRepository;

    public List<Ciudad> getAllCiudades() {
        return ciudadRepository.findAll();
    }

    public Ciudad getCiudadById(int id) {
        return ciudadRepository.findById(id).orElse(null);
    }

    public Ciudad saveCiudad(Ciudad ciudad) {
        return ciudadRepository.save(ciudad);
    }

    public void deleteCiudad(int id) {
        ciudadRepository.deleteById(id);
    }
}
