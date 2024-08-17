CoreLab App Challenge

Este repositório contém o projeto desenvolvido para o desafio da CoreLab. O aplicativo foi construído usando Flutter e segue as diretrizes de design e funcionalidades especificadas no desafio.

Funcionalidades Implementadas

1. Navegação e Estrutura de Telas

	•	NavigationView: Tela principal que gerencia a navegação entre as diferentes views do aplicativo (Home, Categorias, Anunciar, Favoritos, Conta).
	•	HomeView: Exibe os últimos anúncios categorizados por data de adição (Hoje, Ontem, Todos).
	•	CategoriesView: Exibe uma lista de categorias com estilização específica e layout responsivo.
	•	SearchResultsView: Tela que exibe os resultados da pesquisa e gerencia o estado de “Nenhum resultado encontrado”.
	•	ProfileView: Tela de perfil (a ser customizada conforme necessário).

2. Lógica de Pesquisa

	•	Implementação de uma lógica de pesquisa na SearchLogicController que filtra produtos com base no termo de pesquisa e atualiza a interface do usuário em tempo real.
	•	Armazenamento e exibição de histórico de pesquisas, com possibilidade de pesquisa diretamente a partir do histórico.

3. Categorias

	•	Criação de uma tela de categorias com uma lista de itens estilizados.
	•	Alteração dinâmica da barra de navegação para exibir o título “Categorias” ao selecionar a aba de categorias.

4. Gerenciamento de Estado

	•	Uso do Provider para gerenciamento de estado nas diferentes telas e controladores, garantindo que a interface do usuário seja atualizada conforme as mudanças nos dados.

5. Layout Responsivo

	•	Implementação de layout responsivo para suportar diferentes tamanhos de tela e orientações (tablets e smartphones).

6. Exibição de Resultados

	•	A tela de resultados de pesquisa (SearchResultsView) exibe uma lista de produtos encontrados ou uma mensagem amigável caso nenhum resultado seja encontrado.

7. Testes

	•	Adicionados testes para verificar o funcionamento das principais funcionalidades do aplicativo, incluindo navegação, lógica de pesquisa e exibição de categorias.

Estrutura do Projeto

	•	controllers/: Contém os controladores de lógica, como HomeController e SearchLogicController.
	•	views/: Contém as diferentes telas do aplicativo.
	•	widgets/: Contém widgets reutilizáveis, como listas personalizadas e indicadores de progresso.
	•	data/: Contém utilitários e classes para comunicação com APIs e repositórios de dados.

Como Executar o Projeto

	1.	Clone este repositório.
	2.	Certifique-se de que o Flutter está instalado em sua máquina.
	3.	No terminal, navegue até a pasta do projeto e execute o comando flutter pub get para instalar as dependências.
	4.	Execute flutter run para iniciar o aplicativo em um emulador ou dispositivo conectado.

Testes

Para rodar os testes, execute o comando:
```bash
flutter run
```

Considerações Finais

Este projeto foi desenvolvido com foco em uma arquitetura limpa, mantendo as funcionalidades desacopladas e utilizando práticas recomendadas de Flutter. A lógica de pesquisa e navegação foi implementada para garantir uma experiência de usuário fluida e eficiente.