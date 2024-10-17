package com.tienda.tienda.controller;

import com.tienda.tienda.model.Color;
import com.tienda.tienda.service.ColorService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;


@CrossOrigin
@RestController
@RequestMapping("/api/colores")
public class ColorController {

    @Autowired
    private ColorService colorService;

    @GetMapping
    public List<Color> getAllColores() {
        return colorService.getAllColores();
    }

    @GetMapping("/{id}")
    public ResponseEntity<Color> getColorById(@PathVariable int id) {
        Color color = colorService.getColorById(id);
        if (color != null) {
            return ResponseEntity.ok(color);
        } else {
            return ResponseEntity.notFound().build();
        }
    }

    @PostMapping
    public Color createColor(@RequestBody Color color) {
        return colorService.saveColor(color);
    }

    @PutMapping("/{id}")
    public ResponseEntity<Color> updateColor(@PathVariable int id, @RequestBody Color colorDetails) {
        Color color = colorService.getColorById(id);
        if (color != null) {
            color.setColor(colorDetails.getColor());
            return ResponseEntity.ok(colorService.saveColor(color));
        } else {
            return ResponseEntity.notFound().build();
        }
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteColor(@PathVariable int id) {
        if (colorService.getColorById(id) != null) {
            colorService.deleteColor(id);
            return ResponseEntity.ok().build();
        } else {
            return ResponseEntity.notFound().build();
        }
    }
}
