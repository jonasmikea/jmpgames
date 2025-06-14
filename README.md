Projeto Final – JMP GAMES (E-commerce de Jogos)
Este é o projeto final da disciplina de Desenvolvimento Full-Stack, consistindo em uma plataforma de e-commerce para venda de jogos digitais. O sistema foi desenvolvido com uma arquitetura moderna, utilizando Python e o microframework Flask para o back-end, e renderização de templates com HTML, CSS e JavaScript no front-end.

👥 Integrantes do Grupo
Jonas Mikea 

Maria Clara 

Pedro HENRIQUE  

✨ Funcionalidades Principais
O sistema JMP GAMES conta com as seguintes funcionalidades:

Autenticação de Usuários: Sistema completo de cadastro e login seguro, com criptografia de senhas.

Visualização de Jogos:

Página inicial com carrosséis de "Lançamentos" e "Ofertas".

Página de detalhes para cada jogo, com descrição e preço.

Funcionalidade de busca de jogos por nome.

Integração com API Externa: A página de detalhes do jogo consome a API do CheapShark para buscar e exibir preços do mesmo jogo em outras lojas, enriquecendo a experiência do usuário.

Sistema de Carrinho: O usuário pode adicionar e remover jogos de um carrinho de compras persistente na sessão.

Fluxo de Compra:

Compra Direta: Opção de finalizar a compra de um item único através de um pop-up (modal).

Compra do Carrinho: O usuário pode finalizar a compra de todos os itens do carrinho de uma só vez.

Biblioteca Pessoal: Após a compra, os jogos são adicionados à biblioteca pessoal do usuário, que pode ser visualizada a qualquer momento.

Painel de Administração:

Área restrita para administradores.

Implementação de um CRUD (Create, Read, Update, Delete) completo para gerenciar os jogos da loja.

🛠️ Tecnologias Utilizadas

Back-end

Python
Linguagem principal para toda a lógica do servidor.

Flask
Microframework web utilizado para gerenciar rotas, requisições e a estrutura geral da aplicação.

Flask-SQLAlchemy
Extensão que facilita a interação com o banco de dados através de modelos Python (ORM).

-------------------------------------------------------------------------------------------
Front-end

HTML5
Linguagem de marcação para a estrutura de todas as páginas.

CSS3
Utilizado para a estilização completa do site, criando uma identidade visual coesa.

JavaScript
Usado para funcionalidades dinâmicas no lado do cliente, como os carrosséis de jogos.

Jinja2
Motor de templates do Flask, usado para injetar dados do back-end no HTML de forma dinâmica.

Bootstrap 5
Framework front-end utilizado para componentes específicos, como o modal de confirmação de compra.
------------------------------------------------------------------------------------------------------------
Banco de Dados

MySQL
Sistema de gerenciamento de banco de dados relacional para armazenar usuários, jogos e compras.

---------------------------------------------------------------------------------------------------------
API Externa

CheapShark API
Utilizada para buscar e comparar preços de jogos em tempo real, agregando valor à plataforma.
---------------------------------------------------------------------------------------------------------

Ferramentas

Git & GitHub
Sistema de controle de versão para o código-fonte e hospedagem do repositório.


