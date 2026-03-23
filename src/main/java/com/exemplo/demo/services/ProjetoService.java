package com.exemplo.demo.services;

import com.exemplo.demo.model.Projeto;
import com.exemplo.demo.model.ProjetoDTO;
import com.exemplo.demo.repository.ProjetoRepository;
import com.exemplo.demo.util.Utils;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ProjetoService {
    private static final org.slf4j.Logger log = LoggerFactory.getLogger(ProjetoService.class);

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
                mvnService.getVersao(proj),
                Utils.convert(mvnService.getVersao(proj)),
                gitService.getBranch(proj));
    }

    public List<Projeto> listar(){
        return repository.findAll();
    }

    public void delete(Long id){
        repository.deleteById(id);
    }

    public ProjetoDTO gitflow(Long id) {
        ProjetoDTO  p = detalhar(id);
        log.info(String.format("Iniciando gitflow para projeto: %s versao: %s ", p.nome,p.versao));
        gitService.setBranch(p.diretorio,"develop");
        gitService.update(p.diretorio);
        return detalhar(id);
    }
}
