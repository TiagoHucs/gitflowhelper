
package com.exemplo.demo.model;

import jakarta.persistence.*;

@Entity
public class Projeto {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    private String nome;
    private String diretorio;

    public Long getId() { return id; }
    public String getNome() { return nome; }
    public void setNome(String nome) { this.nome = nome; }
    public String getDiretorio() { return diretorio; }
    public void setDiretorio(String diretorio) { this.diretorio = diretorio; }

}
