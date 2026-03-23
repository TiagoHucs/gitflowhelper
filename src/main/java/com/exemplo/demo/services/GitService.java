package com.exemplo.demo.services;

import com.exemplo.demo.model.CommandResult;
import com.exemplo.demo.model.Projeto;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class GitService {

    @Autowired
    private CommandService commandService;

    public String getBranch(Projeto proj) {
        try {
            CommandResult result = commandService.executeCommand(
                    proj.getDiretorio(),
                    "git", "branch", "--show-current"
            );

            if (result.isSuccess()) {
                String branch = result.getOutput();

                if (branch != null && !branch.isBlank()) {
                    return branch.trim();
                } else {
                    return "DETACHED";
                }
            } else {
                System.out.println("Erro ao obter branch: " + result.getError());
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return "N/A";
    }


    public CommandResult setBranch(String path, String branch) {
        return commandService.executeCommand(
                path,"git", "checkout", branch
        );
    }

    public CommandResult update(String diretorio) {
        return commandService.executeCommand(diretorio,"git", "update");
    }
}
