
package com.exemplo.demo.controller;

import com.exemplo.demo.model.Projeto;
import com.exemplo.demo.model.ProjetoDTO;
import com.exemplo.demo.services.ProjetoService;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/projetos")
@CrossOrigin("*")
public class ProjetoController {

    private final ProjetoService service;

    public ProjetoController(ProjetoService service) {
        this.service = service;
    }

    @PostMapping
    public Projeto salvar(@RequestBody Projeto projeto) {
        return service.salvar(projeto);
    }

    @GetMapping
    public List<Projeto> listar() {
        return service.listar();
    }

    @GetMapping("/{id}")
    public ProjetoDTO buscar(@PathVariable Long id) {
        return service.detalhar(id);
    }

    @DeleteMapping("/{id}")
    public void deletar(@PathVariable Long id) {
        service.delete(id);
    }

    @GetMapping("/gitflow/{id}")
    public ProjetoDTO gitflow(@PathVariable Long id) {
        return service.gitflow(id);
    }
}
