package com.exemplo.demo.services;

import com.exemplo.demo.model.Projeto;
import org.springframework.stereotype.Service;

import java.io.BufferedReader;
import java.io.InputStreamReader;

@Service
public class GitService {

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
