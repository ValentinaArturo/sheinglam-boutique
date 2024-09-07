package com.tienda.tienda.service;

import com.tienda.tienda.model.Promocion;
import com.tienda.tienda.repository.PromocionRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.CrossOrigin;

import java.util.List;

@CrossOrigin
@Service
public class PromocionService {

    @Autowired
    private PromocionRepository promocionRepository;

    public List<Promocion> getAllPromociones() {
        return promocionRepository.findAll();
    }

    public Promocion getPromocionById(int id) {
        return promocionRepository.findById(id).orElse(null);
    }

    public Promocion savePromocion(Promocion promocion) {
        return promocionRepository.save(promocion);
    }

    public void deletePromocion(int id) {
        promocionRepository.deleteById(id);
    }
}
