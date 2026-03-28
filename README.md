# GerenciadorProjetos

Uma aplicação Spring Boot para automatizar e garantir a segurança na execução dos passos necessários para **abrir e fechar versões** em projetos Maven, seguindo as regras do **GitFlow**.

## 🎯 Objetivo

Centralizar e automatizar o gerenciamento de versões em projetos Maven, garantindo que todos os passos do GitFlow sejam executados de forma segura e consistente.

## 🚀 Funcionalidades

- ✅ Automatização do fluxo de versionamento GitFlow
- ✅ Validação de passos obrigatórios antes de abrir/fechar versões
- ✅ Integração com Maven POM
- ✅ Controle seguro de versões em repositórios Git
- ✅ API REST para gerenciamento de versões

## 🛠 Tecnologias

- **Java** - Linguagem base
- **Spring Boot** - Framework web
- **Maven** - Gerenciador de dependências

## 📁 Estrutura do Projeto

```
src/
├── main/
│   ├── java/com/exemplo/demo/
│   │   ├── DemoApplication.java    # Aplicação principal
│   │   ├── controller/              # APIs REST
│   │   ├── model/                   # Entidades e DTOs
│   │   ├── repository/              # Camada de dados
│   │   ├── services/                # Lógica de negócio
│   │   └── util/                    # Utilitários
│   └── resources/                   # Configurações
└── test/                             # Testes
```

## 🚀 Como Usar

### Pré-requisitos
- Java 11+
- Maven 3.6+
- Git

### Compilar
```bash
mvn clean install
```

### Executar
```bash
mvn spring-boot:run
```

## 📋 Fluxo GitFlow Suportado

Esta aplicação automatiza os seguintes passos:

1. **Abertura de Versão** - Cria branch de release
2. **Validações** - Verifica estado do repositório e dependências
3. **Fechamento de Versão** - Merges e tags no Git
4. **Limpeza** - Remove branches temporários

## 📝 Licença

Este projeto é de uso aberto. Veja LICENSE para mais detalhes.

## 👤 Autor

Tiago Hucs