package com.tienda.tienda.controller;

import com.tienda.tienda.dto.ClienteDTO;
import com.tienda.tienda.model.Cliente;
import com.tienda.tienda.model.DireccionEnvio;
import com.tienda.tienda.model.Usuario;
import com.tienda.tienda.service.ClienteService;
import com.tienda.tienda.service.DireccionEnvioService;
import com.tienda.tienda.service.UsuarioService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@CrossOrigin
@RestController
@RequestMapping("/api/clientes")
public class ClienteController {

    @Autowired
    private ClienteService clienteService;

    @Autowired
    private UsuarioService usuarioService;

    @Autowired
    private DireccionEnvioService direccionEnvioService;
    @Autowired
    private PasswordEncoder passwordEncoder;

    @GetMapping
    public List<Cliente> getAllClientes() {
        return clienteService.getAllClientes();
    }

    @GetMapping("/{id}")
    public ResponseEntity<Cliente> getClienteById(@PathVariable int id) {
        Cliente cliente = clienteService.getClienteById(id);
        if (cliente != null) {
            return ResponseEntity.ok(cliente);
        } else {
            return ResponseEntity.notFound().build();
        }
    }

    @PostMapping
    public ResponseEntity<Cliente> createCliente(@RequestBody ClienteDTO clienteDTO) {
    	String password = passwordEncoder.encode(clienteDTO.getUsuario().getContraseña());
        Usuario usuario = usuarioService.saveUsuario(clienteDTO.getUsuario(),password);
        clienteDTO.getCliente().setUsuario(usuario);
        Cliente cliente = clienteService.saveCliente(clienteDTO.getCliente());

        if (clienteDTO.getDireccionEnvio() != null) {
            clienteDTO.getDireccionEnvio().setCliente(cliente);
            direccionEnvioService.saveDireccionEnvio(clienteDTO.getDireccionEnvio());
        }

        return ResponseEntity.ok(cliente);
    }

    @PutMapping("/{id}")
    public ResponseEntity<Cliente> updateCliente(@PathVariable int id, @RequestBody Cliente clienteDetails) {
        Cliente cliente = clienteService.getClienteById(id);
        if (cliente != null) {
            cliente.setUsuario(clienteDetails.getUsuario());
            cliente.setDireccion(clienteDetails.getDireccion());
            cliente.setTelefono(clienteDetails.getTelefono());
            return ResponseEntity.ok(clienteService.saveCliente(cliente));
        } else {
            return ResponseEntity.notFound().build();
        }
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteCliente(@PathVariable int id) {
        if (clienteService.getClienteById(id) != null) {
            clienteService.deleteCliente(id);
            return ResponseEntity.ok().build();
        } else {
            return ResponseEntity.notFound().build();
        }
    }
}