package com.tienda.tienda.controller;

import com.tienda.tienda.dto.ClienteDTO;
import com.tienda.tienda.model.Cliente;
import com.tienda.tienda.model.DireccionEnvio;
import com.tienda.tienda.model.Usuario;
import com.tienda.tienda.service.ClienteService;
import com.tienda.tienda.service.DireccionEnvioService;
import com.tienda.tienda.service.UsuarioService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.web.bind.annotation.*;

import java.util.List;

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
    public ResponseEntity<?> createCliente(@RequestBody ClienteDTO clienteDTO) {
        String email = clienteDTO.getUsuario().getCorreoElectronico();
        
        if (usuarioService.getUsuarioByEmail(email) != null) {
            return ResponseEntity
                .status(HttpStatus.CONFLICT) 
                .body("El correo ya está registrado.");
        }
        
        String password = passwordEncoder.encode(clienteDTO.getUsuario().getContraseña());
        Usuario usuario = usuarioService.saveUsuario(clienteDTO.getUsuario(), password);
        clienteDTO.getCliente().setUsuario(usuario);
        Cliente cliente = clienteService.saveCliente(clienteDTO.getCliente());
        
        if (clienteDTO.getDireccionEnvio() != null) {
            clienteDTO.getDireccionEnvio().setCliente(cliente);
            direccionEnvioService.saveDireccionEnvio(clienteDTO.getDireccionEnvio());
        }
        
        return ResponseEntity.ok(cliente);
    }
    @PutMapping("/{id}")
    public ResponseEntity<?> updateCliente(@PathVariable int id, @RequestBody ClienteDTO clienteDTO) {
        Cliente clienteExistente = clienteService.getClienteById(id);
        if (clienteExistente == null) {
            return ResponseEntity.notFound().build();
        }
        
        String email = clienteDTO.getUsuario().getCorreoElectronico();
        Usuario usuarioExistente = usuarioService.getUsuarioByEmail(email);
        if (usuarioExistente != null && usuarioExistente.getIdUsuario() != clienteExistente.getUsuario().getIdUsuario()) {
            return ResponseEntity
                .status(HttpStatus.CONFLICT)
                .body("El correo ya está registrado por otro usuario.");
        }

        Usuario usuarioActual = clienteExistente.getUsuario();
        usuarioActual.setNombre(clienteDTO.getUsuario().getNombre());
        usuarioActual.setApellido(clienteDTO.getUsuario().getApellido());
        usuarioActual.setCorreoElectronico(clienteDTO.getUsuario().getCorreoElectronico());
        usuarioActual.setRol(clienteDTO.getUsuario().getRol());

        String passwordToSave;
        String nuevaContraseña = clienteDTO.getUsuario().getContraseña();
        
        // Verificar si hay una nueva contraseña y si es diferente a la existente
        if (nuevaContraseña != null && !nuevaContraseña.isEmpty() && !nuevaContraseña.equals(usuarioActual.getContraseña())) {
            passwordToSave = passwordEncoder.encode(nuevaContraseña);
            usuarioActual.setContraseña(passwordToSave);
        } else {
            passwordToSave = usuarioActual.getContraseña(); // Mantener la contraseña existente
        }

        usuarioService.saveUsuario(usuarioActual, passwordToSave); // Guardar cambios del usuario


        clienteExistente.setDireccion(clienteDTO.getCliente().getDireccion());
        clienteExistente.setTelefono(clienteDTO.getCliente().getTelefono());

        // Verificar si el cliente ya tiene una dirección de envío
        List<DireccionEnvio> direccionesExistentes = direccionEnvioService.getDireccionesEnvioByClienteId(id);
        DireccionEnvio direccionExistente = !direccionesExistentes.isEmpty() ? direccionesExistentes.get(0) : null;

        if (clienteDTO.getDireccionEnvio() != null) {
            if (direccionExistente == null) {
                // Crear una nueva dirección de envío si no existe
                direccionExistente = new DireccionEnvio();
                direccionExistente.setCliente(clienteExistente);
            }
            
            direccionExistente.setDireccion(clienteDTO.getDireccionEnvio().getDireccion());
            direccionExistente.setCiudad(clienteDTO.getDireccionEnvio().getCiudad());
            direccionExistente.setCodigoPostal(clienteDTO.getDireccionEnvio().getCodigoPostal());
            direccionExistente.setPais(clienteDTO.getDireccionEnvio().getPais());
            
            direccionEnvioService.saveDireccionEnvio(direccionExistente);  // Guardar o actualizar la dirección de envío
        }

        Cliente clienteActualizado = clienteService.saveCliente(clienteExistente);
        return ResponseEntity.ok(clienteActualizado);
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