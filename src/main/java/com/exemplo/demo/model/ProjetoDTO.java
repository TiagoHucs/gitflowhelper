package com.exemplo.demo.model;

public class ProjetoDTO {

    public Long id;
    public String nome;
    public String diretorio;
    public String versao;
    public String branch;

    public ProjetoDTO(Long id, String nome, String diretorio, String versao, String branch) {
        this.id = id;
        this.nome = nome;
        this.diretorio = diretorio;
        this.versao = versao;
        this.branch = branch;
    }

}
