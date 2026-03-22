package com.exemplo.demo.services;

import com.exemplo.demo.model.Projeto;
import com.exemplo.demo.model.ProjetoDTO;
import com.exemplo.demo.repository.ProjetoRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestBody;

import java.util.List;

@Service
public class ProjetoService {

    @Autowired
    private ProjetoRepository repository;

    @Autowired
    private GitService gitService;

    @Autowired
    private MvnService mvnService;

    public Projeto salvar(Projeto projeto) {
        return repository.save(projeto);
    }

    public ProjetoDTO detalhar(Long id){
        Projeto proj = repository.findById(id).orElse(null);
        return new ProjetoDTO(proj.getId(), proj.getNome(), proj.getDiretorio(),
                mvnService.getVersao(proj), gitService.getBranch(proj));
    }

    public List<Projeto> listar(){
        return repository.findAll();
    }

    public void delete(Long id){
        repository.deleteById(id);
    }



}
