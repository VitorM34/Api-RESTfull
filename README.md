# REST API - Contacts Management System

![Ruby](https://img.shields.io/badge/Ruby-3.4.3-red?logo=ruby)
![Rails](https://img.shields.io/badge/Rails-8.0.3-red?logo=rubyonrails)
![PostgreSQL](https://img.shields.io/badge/PostgreSQL-Database-blue?logo=postgresql)
![Docker](https://img.shields.io/badge/Docker-Ready-blue?logo=docker)

Uma API RESTful completa para gerenciamento de contatos, desenvolvida com Ruby on Rails 8. Este projeto implementa um sistema robusto de CRUD com relacionamentos complexos, validações e suporte a nested attributes.

## 📋 Índice

- [Sobre o Projeto](#sobre-o-projeto)
- [Funcionalidades](#funcionalidades)
- [Tecnologias Utilizadas](#tecnologias-utilizadas)
- [Pré-requisitos](#pré-requisitos)
- [Instalação](#instalação)
- [Configuração do Banco de Dados](#configuração-do-banco-de-dados)
- [Executando a Aplicação](#executando-a-aplicação)
- [Documentação da API](#documentação-da-api)
- [Testes](#testes)
- [Deploy](#deploy)
- [Estrutura do Projeto](#estrutura-do-projeto)
- [Contribuindo](#contribuindo)

## 🎯 Sobre o Projeto

Esta é uma **API REST desenvolvida para fins de estudo e aprendizado** de Ruby on Rails. O projeto serve como material educacional para demonstrar as melhores práticas no desenvolvimento de aplicações RESTful, implementando um sistema completo de gerenciamento de contatos com informações pessoais, tipos de contato, telefones e endereços.

### 📚 Objetivo Educacional

Este projeto foi criado com o propósito de:
- Aprender e praticar o desenvolvimento de APIs RESTful
- Compreender os conceitos de CRUD em Ruby on Rails
- Estudar relacionamentos entre modelos (associações)
- Implementar validações e nested attributes
- Explorar as funcionalidades do Rails 8

### Principais Características

- **Arquitetura RESTful**: Endpoints bem estruturados seguindo os padrões REST
- **Relacionamentos Complexos**: Implementação de associações `has_many`, `belongs_to` e `has_one`
- **Nested Attributes**: Suporte para criação e atualização de registros relacionados
- **Validações**: Garantia de integridade dos dados
- **Internacionalização**: Formatação de datas com i18n
- **Docker Ready**: Containerização completa para facilitar o deploy

## ✨ Funcionalidades

- ✅ CRUD completo de contatos
- ✅ Gerenciamento de tipos de contato (Kinds)
- ✅ Associação de múltiplos telefones por contato
- ✅ Gerenciamento de endereços
- ✅ Formatação automática de datas
- ✅ Validações de dados
- ✅ Respostas JSON estruturadas
- ✅ Health check endpoint

## 🚀 Tecnologias Utilizadas

### Backend
- **Ruby** `3.4.3` - Linguagem de programação
- **Rails** `8.0.3` - Framework web
- **PostgreSQL** - Banco de dados relacional
- **Puma** - Servidor web

### Frontend Assets
- **Importmap Rails** - Gerenciamento de JavaScript
- **Turbo Rails** - Navegação SPA-like
- **Stimulus** - Framework JavaScript modesto

### Infraestrutura
- **Docker** - Containerização
- **Kamal** - Deploy automation
- **Thruster** - HTTP/2 proxy

### Desenvolvimento
- **Rubocop** - Linter e formatador de código
- **Brakeman** - Análise de segurança
- **Pry** - Debugger
- **Faker** - Geração de dados fake

### Cache e Background Jobs
- **Solid Cache** - Caching
- **Solid Queue** - Background jobs
- **Solid Cable** - WebSockets

## 📦 Pré-requisitos

Antes de começar, certifique-se de ter instalado:

- **Ruby** 3.4.3 ou superior
- **Rails** 8.0.3 ou superior
- **PostgreSQL** 9.3 ou superior
- **Node.js** (para assets)
- **Docker** e **Docker Compose** (opcional, para containerização)
- **Git**

## 🔧 Instalação

### 1. Clone o repositório

```bash
git clone https://github.com/VitorM34/Api-RESTfull.git
cd rest_api
```

### 2. Instale as dependências

```bash
bundle install
```

### 3. Configure as variáveis de ambiente

Crie um arquivo `.env` na raiz do projeto (opcional, para configurações personalizadas):

```bash
DATABASE_URL=postgresql://localhost/rest_api_development
RAILS_MAX_THREADS=5
```

## 🗄️ Configuração do Banco de Dados

### Desenvolvimento Local

```bash
# Criar o banco de dados
rails db:create

# Executar as migrations
rails db:migrate

# Popular o banco com dados de exemplo (opcional)
rails db:seed
```

### Usando Docker

```bash
# Subir os containers
docker-compose up -d

# Executar as migrations
docker-compose exec web rails db:create db:migrate
```

## ▶️ Executando a Aplicação

### Modo Desenvolvimento

```bash
# Iniciar o servidor
rails server

# Ou usando o bin/dev para assets
bin/dev
```

A aplicação estará disponível em `http://localhost:3000`

### Modo Produção

```bash
# Compilar assets
rails assets:precompile

# Executar em modo produção
RAILS_ENV=production rails server
```

## 📚 Documentação da API

### Base URL
```
http://localhost:3000
```

### Endpoints

#### 🔍 Health Check

```http
GET /up
```

**Resposta:**
```
200 OK
```

---

#### 👥 Contacts

##### Listar todos os contatos

```http
GET /contacts
```

**Resposta:**
```json
[
  {
    "id": 1,
    "name": "João Silva",
    "email": "joao@example.com",
    "birthdate": "15/03/1990",
    "kind_id": 1
  }
]
```

##### Buscar um contato específico

```http
GET /contacts/:id
```

**Resposta:**
```json
{
  "id": 1,
  "name": "João Silva",
  "email": "joao@example.com",
  "birthdate": "15/03/1990",
  "kind": {
    "id": 1,
    "description": "Profissional"
  },
  "phones": [
    {
      "id": 1,
      "number": "(11) 98765-4321"
    }
  ]
}
```

##### Criar um novo contato

```http
POST /contacts
Content-Type: application/json
```

**Body:**
```json
{
  "contact": {
    "name": "Maria Santos",
    "email": "maria@example.com",
    "birthdate": "1985-07-20",
    "kind_id": 1,
    "phones_attributes": [
      {
        "number": "(11) 91234-5678"
      }
    ]
  }
}
```

**Resposta:**
```json
{
  "id": 2,
  "name": "Maria Santos",
  "email": "maria@example.com",
  "birthdate": "20/07/1985",
  "kind_id": 1
}
```

##### Atualizar um contato

```http
PUT /contacts/:id
Content-Type: application/json
```

**Body:**
```json
{
  "contact": {
    "name": "Maria Santos Silva",
    "email": "maria.silva@example.com"
  }
}
```

##### Deletar um contato

```http
DELETE /contacts/:id
```

**Resposta:**
```
204 No Content
```

---

#### 🏷️ Kinds (Tipos de Contato)

##### Listar todos os tipos

```http
GET /kinds
```

##### Criar um novo tipo

```http
POST /kinds
Content-Type: application/json
```

**Body:**
```json
{
  "kind": {
    "description": "Pessoal"
  }
}
```

##### Atualizar um tipo

```http
PUT /kinds/:id
```

##### Deletar um tipo

```http
DELETE /kinds/:id
```

## 🧪 Testes

### Executar todos os testes

```bash
rails test
```

### Executar testes específicos

```bash
# Testes de modelo
rails test test/models

# Testes de controller
rails test test/controllers

# Teste específico
rails test test/models/contact_test.rb
```

### Testes de Sistema (com Capybara)

```bash
rails test:system
```

### Análise de Segurança

```bash
# Executar Brakeman
brakeman

# Executar Rubocop
rubocop
```

## 🚢 Deploy

### Usando Kamal

```bash
# Setup inicial
kamal setup

# Deploy
kamal deploy

# Verificar status
kamal app details
```

### Usando Docker

```bash
# Build da imagem
docker build -t rest-api .

# Executar container
docker run -p 3000:3000 -e DATABASE_URL=your_db_url rest-api
```

### Variáveis de Ambiente para Produção

```bash
REST_API_DATABASE_PASSWORD=your_secure_password
RAILS_MASTER_KEY=your_master_key
SECRET_KEY_BASE=your_secret_key
```

## 📁 Estrutura do Projeto

```
rest_api/
├── app/
│   ├── controllers/      # Controladores da API
│   ├── models/           # Modelos de dados
│   ├── views/            # Views (JSON builders)
│   └── ...
├── config/
│   ├── routes.rb         # Definição de rotas
│   ├── database.yml      # Configuração do banco
│   └── ...
├── db/
│   ├── migrate/          # Migrations
│   └── seeds.rb          # Dados iniciais
├── test/                 # Testes automatizados
├── Dockerfile            # Configuração Docker
├── Gemfile               # Dependências Ruby
└── README.md             # Este arquivo
```

## 🤝 Contribuindo

Contribuições são bem-vindas! Para contribuir:

1. Faça um fork do projeto
2. Crie uma branch para sua feature (`git checkout -b feature/AmazingFeature`)
3. Commit suas mudanças (`git commit -m 'Add some AmazingFeature'`)
4. Push para a branch (`git push origin feature/AmazingFeature`)
5. Abra um Pull Request

### Padrões de Código

- Siga o guia de estilo Ruby (Rubocop)
- Escreva testes para novas funcionalidades
- Mantenha a cobertura de testes acima de 80%
- Documente mudanças significativas

## 📝 Licença

Este projeto está sob a licença MIT. Veja o arquivo `LICENSE` para mais detalhes.

## 👨‍💻 Autor

**Vitor M34**

- GitHub: [@VitorM34](https://github.com/VitorM34)
- Repositório: [Api-RESTfull](https://github.com/VitorM34/Api-RESTfull)

---

⭐ Se este projeto foi útil para você, considere dar uma estrela no repositório!
