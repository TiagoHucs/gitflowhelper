package com.exemplo.demo.services;

import com.exemplo.demo.model.Projeto;
import org.apache.maven.model.Model;
import org.apache.maven.model.io.xpp3.MavenXpp3Reader;
import org.springframework.stereotype.Service;

import java.io.FileReader;
import java.nio.file.Path;

@Service
public class MvnService {

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
}
