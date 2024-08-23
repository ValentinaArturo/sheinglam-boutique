package com.tienda.tienda.service;

import com.tienda.tienda.model.Pais;
import com.tienda.tienda.repository.PaisRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class PaisService {

    @Autowired
    private PaisRepository paisRepository;

    public List<Pais> getAllPaises() {
        return paisRepository.findAll();
    }

    public Pais getPaisById(int id) {
        return paisRepository.findById(id).orElse(null);
    }

    public Pais savePais(Pais pais) {
        return paisRepository.save(pais);
    }

    public void deletePais(int id) {
        paisRepository.deleteById(id);
    }
}
