package com.tienda.tienda.service;

import com.tienda.tienda.model.Color;
import com.tienda.tienda.repository.ColorRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ColorService {

    @Autowired
    private ColorRepository colorRepository;

    public List<Color> getAllColores() {
        return colorRepository.findAll();
    }

    public Color getColorById(int id) {
        return colorRepository.findById(id).orElse(null);
    }

    public Color saveColor(Color color) {
        return colorRepository.save(color);
    }

    public void deleteColor(int id) {
        colorRepository.deleteById(id);
    }
}
