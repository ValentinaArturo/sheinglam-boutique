package com.tienda.tienda.service;

import com.tienda.tienda.model.DireccionEnvio;
import com.tienda.tienda.repository.DireccionEnvioRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.CrossOrigin;

import java.util.List;

@CrossOrigin
@Service
public class DireccionEnvioService {

    @Autowired
    private DireccionEnvioRepository direccionEnvioRepository;

    public List<DireccionEnvio> getAllDireccionesEnvio() {
        return direccionEnvioRepository.findAll();
    }

    public DireccionEnvio getDireccionEnvioById(int id) {
        return direccionEnvioRepository.findById(id).orElse(null);
    }

    public DireccionEnvio saveDireccionEnvio(DireccionEnvio direccionEnvio) {
        return direccionEnvioRepository.save(direccionEnvio);
    }

    public void deleteDireccionEnvio(int id) {
        direccionEnvioRepository.deleteById(id);
    }
    public List<DireccionEnvio> getDireccionesEnvioByClienteId(int clienteId) {
        return direccionEnvioRepository.findByClienteId(clienteId);
    }
}
