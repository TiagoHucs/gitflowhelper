
package com.exemplo.demo.controller;

import com.exemplo.demo.model.Projeto;
import com.exemplo.demo.model.ProjetoDTO;
import com.exemplo.demo.repository.ProjetoRepository;
import com.exemplo.demo.services.ProjetoService;
import org.springframework.web.bind.annotation.*;
import java.util.List;

@RestController
@RequestMapping("/projetos")
@CrossOrigin("*")
public class ProjetoController {

    private final ProjetoRepository repository;
    private final ProjetoService service;

    public ProjetoController(ProjetoRepository repository,ProjetoService service) {
        this.repository = repository;
        this.service = service;
    }

    @PostMapping
    public Projeto salvar(@RequestBody Projeto projeto) {
        return repository.save(projeto);
    }

    @GetMapping
    public List<Projeto> listar() {
        return repository.findAll();
    }

    @GetMapping("/{id}")
    public ProjetoDTO buscar(@PathVariable Long id) {
        return service.detalhar(id);
    }

    @DeleteMapping("/{id}")
    public void deletar(@PathVariable Long id) {
        repository.deleteById(id);
    }
}
