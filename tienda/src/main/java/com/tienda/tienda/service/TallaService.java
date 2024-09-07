package com.tienda.tienda.service;

import com.tienda.tienda.model.Talla;
import com.tienda.tienda.repository.TallaRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.CrossOrigin;

import java.util.List;

@CrossOrigin
@Service
public class TallaService {

    @Autowired
    private TallaRepository tallaRepository;

    public List<Talla> getAllTallas() {
        return tallaRepository.findAll();
    }

    public Talla getTallaById(int id) {
        return tallaRepository.findById(id).orElse(null);
    }

    public Talla saveTalla(Talla talla) {
        return tallaRepository.save(talla);
    }

    public void deleteTalla(int id) {
        tallaRepository.deleteById(id);
    }
}
