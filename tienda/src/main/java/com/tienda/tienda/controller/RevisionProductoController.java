package com.tienda.tienda.controller;

import com.tienda.tienda.model.RevisionProducto;
import com.tienda.tienda.service.RevisionProductoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@CrossOrigin
@RestController
@RequestMapping("/api/revisiones-producto")
public class RevisionProductoController {

    @Autowired
    private RevisionProductoService revisionProductoService;

    @GetMapping
    public List<RevisionProducto> getAllRevisionesProducto() {
        return revisionProductoService.getAllRevisionesProducto();
    }

    @GetMapping("/{id}")
    public ResponseEntity<RevisionProducto> getRevisionProductoById(@PathVariable int id) {
        RevisionProducto revisionProducto = revisionProductoService.getRevisionProductoById(id);
        if (revisionProducto != null) {
            return ResponseEntity.ok(revisionProducto);
        } else {
            return ResponseEntity.notFound().build();
        }
    }

    @PostMapping
    public RevisionProducto createRevisionProducto(@RequestBody RevisionProducto revisionProducto) {
        return revisionProductoService.saveRevisionProducto(revisionProducto);
    }

    @PutMapping("/{id}")
    public ResponseEntity<RevisionProducto> updateRevisionProducto(@PathVariable int id, @RequestBody RevisionProducto revisionProductoDetails) {
        RevisionProducto revisionProducto = revisionProductoService.getRevisionProductoById(id);
        if (revisionProducto != null) {
            revisionProducto.setCliente(revisionProductoDetails.getCliente());
            revisionProducto.setProducto(revisionProductoDetails.getProducto());
            revisionProducto.setCalificacion(revisionProductoDetails.getCalificacion());
            revisionProducto.setComentario(revisionProductoDetails.getComentario());
            revisionProducto.setFecha(revisionProductoDetails.getFecha());
            return ResponseEntity.ok(revisionProductoService.saveRevisionProducto(revisionProducto));
        } else {
            return ResponseEntity.notFound().build();
        }
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteRevisionProducto(@PathVariable int id) {
        if (revisionProductoService.getRevisionProductoById(id) != null) {
            revisionProductoService.deleteRevisionProducto(id);
            return ResponseEntity.ok().build();
        } else {
            return ResponseEntity.notFound().build();
        }
    }
}
