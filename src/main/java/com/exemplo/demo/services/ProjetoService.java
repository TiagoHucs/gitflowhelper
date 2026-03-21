package com.exemplo.demo.services;

import com.exemplo.demo.model.Projeto;
import com.exemplo.demo.model.ProjetoDTO;
import com.exemplo.demo.repository.ProjetoRepository;
import org.apache.maven.model.Model;
import org.apache.maven.model.io.xpp3.MavenXpp3Reader;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.InputStreamReader;
import java.nio.file.Path;

@Service
public class ProjetoService {

    @Autowired
    private ProjetoRepository repository;

    public ProjetoDTO detalhar(Long id){
        Projeto proj = repository.findById(id).orElse(null);
        return new ProjetoDTO(proj.getId(), proj.getNome(), proj.getDiretorio(),
                getVersao(proj), getBranch(proj));
    }

    public String getVersao(Projeto proj) {
        try {
            Path caminho = Path.of(proj.getDiretorio(), "pom.xml");

            MavenXpp3Reader reader = new MavenXpp3Reader();
            Model model = reader.read(new FileReader(caminho.toFile()));

            return model.getVersion();

        } catch (Exception e) {
            e.printStackTrace();
            return "N/A";
        }
    }

    public String getBranch(Projeto proj) {
        try {
            ProcessBuilder pb = new ProcessBuilder("git", "branch", "--show-current");
            pb.directory(new java.io.File(proj.getDiretorio()));

            Process process = pb.start();

            BufferedReader reader = new BufferedReader(
                    new InputStreamReader(process.getInputStream())
            );

            String branch = reader.readLine();

            process.waitFor();

            if (branch != null && !branch.isBlank()) {
                return branch;
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return "N/A";
    }
}
