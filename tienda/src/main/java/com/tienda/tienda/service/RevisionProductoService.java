package com.tienda.tienda.service;

import com.tienda.tienda.model.RevisionProducto;
import com.tienda.tienda.repository.RevisionProductoRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.CrossOrigin;

import java.util.List;

@CrossOrigin
@Service
public class RevisionProductoService {

    @Autowired
    private RevisionProductoRepository revisionProductoRepository;

    public List<RevisionProducto> getAllRevisionesProducto() {
        return revisionProductoRepository.findAll();
    }

    public RevisionProducto getRevisionProductoById(int id) {
        return revisionProductoRepository.findById(id).orElse(null);
    }

    public RevisionProducto saveRevisionProducto(RevisionProducto revisionProducto) {
        return revisionProductoRepository.save(revisionProducto);
    }

    public void deleteRevisionProducto(int id) {
        revisionProductoRepository.deleteById(id);
    }
}
