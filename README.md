# projeto_nome_sortido

📱 App de Controle de Gastos Pessoais
Um aplicativo Flutter simples e intuitivo para controle de despesas, com suporte a gráficos, persistência de dados com SharedPreferences e exportação de relatórios em PDF.

Funcionalidades
💸 Cadastro de despesas com descrição e valor
📋 Listagem de todas as despesas salvas
📊 Visualização de gráfico de pizza com resumo dos gastos
🧮 Cálculo automático do total gasto
📁 Exportação das despesas em formato PDF
💾 Armazenamento local usando SharedPreferences

🛠️ Como Usar
1. Instale as dependências:
   flutter pub get
2. Execute o app:
   flutter run

📚 Passo a passo dentro do app
➕ Adicionar nova despesa:
  - Toque no botão + no canto inferior direito.
  - Preencha a descrição e o valor da despesa.
  - Toque em Salvar.

🗂️ Visualizar despesas
As despesas cadastradas aparecem em uma lista principal.
Cada item mostra o nome e o valor gasto.
  - Toque no ícone de lápis ✏️ para editar.
  - Toque no ícone de lixeira 🗑️ para excluir.

📊 Visualizar gráfico
Toque no ícone de gráfico de pizza no topo da tela.
Veja um gráfico com:
  - Cada fatia representando uma despesa.
  - Descrição e valor em R$ dentro da fatia.
Abaixo do gráfico, o total gasto é exibido.

📤 Exportar para PDF
Toque no ícone de PDF no topo da tela.
Um arquivo PDF é gerado com:
  - Tabela de despesas
  - Total gasto
Você poderá visualizar, imprimir ou compartilhar o relatório.
