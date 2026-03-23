package com.exemplo.demo.services;

import com.exemplo.demo.model.CommandResult;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import java.io.BufferedReader;
import java.io.InputStreamReader;

@Service
public class CommandService {
    private static final org.slf4j.Logger log = LoggerFactory.getLogger(CommandService.class);

    public CommandResult executeCommand(String path, String... command) {
        log.info(String.format("Executando: %s -> %s", path, String.join(" ", command)));
        try {
            ProcessBuilder pb = new ProcessBuilder(command);
            pb.directory(new java.io.File(path));

            Process process = pb.start();

            // stdout
            BufferedReader outputReader = new BufferedReader(
                    new InputStreamReader(process.getInputStream())
            );

            StringBuilder output = new StringBuilder();
            String line;

            while ((line = outputReader.readLine()) != null) {
                output.append(line).append("\n");
            }

            // stderr
            BufferedReader errorReader = new BufferedReader(
                    new InputStreamReader(process.getErrorStream())
            );

            StringBuilder error = new StringBuilder();

            while ((line = errorReader.readLine()) != null) {
                error.append(line).append("\n");
            }

            int exitCode = process.waitFor();
            return new CommandResult(
                    exitCode,
                    output.toString().trim(),
                    error.toString().trim()
            );

        } catch (Exception e) {
            log.error(String.format("Erro ao executar comando: %s -> %s", path, String.join(" ", command)));
            e.printStackTrace();
            return new CommandResult(-1, "", e.getMessage());
        }
    }
}
