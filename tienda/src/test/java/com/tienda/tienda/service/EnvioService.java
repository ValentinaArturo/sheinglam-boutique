package com.tienda.tienda.service;

import com.tienda.tienda.model.Envio;
import com.tienda.tienda.repository.EnvioRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class EnvioService {

    @Autowired
    private EnvioRepository envioRepository;

    public List<Envio> getAllEnvios() {
        return envioRepository.findAll();
    }

    public Envio getEnvioById(int id) {
        return envioRepository.findById(id).orElse(null);
    }

    public Envio saveEnvio(Envio envio) {
        return envioRepository.save(envio);
    }

    public void deleteEnvio(int id) {
        envioRepository.deleteById(id);
    }
}
