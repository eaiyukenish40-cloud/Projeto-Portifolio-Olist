
📜 Este projeto está licenciado sob a licença MIT - veja o arquivo LICENSE.md para detalhes. Nota: O dataset utilizado pertence à Olist e foi obtido publicamente no Kaggle. Os direitos sobre os dados permanecem com a Olist [Acesso a fonte de dados original](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce)

📌 Contém os códigos em Python desenvolvidos para etapa de Data Cleaning. Os Scripts desenvolvidos no Mysql para consulta dos dados do banco. O arquivo do dashboard do Tableau utilizado para visulizar os dados trabalhados.


## 📌 Visão Geral do Projeto

Este projeto consiste em uma solução completa de **Full-Stack Analytics** aplicada ao contexto de E-commerce. O objetivo foi simular um cenário real de engenharia e análise de dados, partindo de dados brutos (Raw Data), passando por pipelines de ETL, modelagem de Data Warehouse e finalizando em um Dashboard Executivo para tomada de decisão.

O projeto utiliza o dataset público da **Olist** (Brazilian E-Commerce Public Dataset), abrangendo pedidos, clientes, produtos e avaliações de 2016 a 2018.

---

## 💼 O Problema de Negócio

A Olist conecta pequenas empresas a grandes marketplaces. O desafio proposto foi responder a perguntas estratégicas para a diretoria:
1.  **Performance Financeira:** Qual a evolução do faturamento (GMV) e Ticket Médio (AOV)?
2.  **Eficiência Logística:** Onde o custo do frete impacta a margem e onde ocorrem os atrasos?
3.  **Experiência do Cliente (CX):** Existe correlação entre atrasos na entrega e o NPS (Review Score)?
4.  **Pareto de Produtos:** Quais categorias impulsionam a receita?

---

## 🛠️ Tech Stack e Ferramentas

A arquitetura do projeto foi desenhada para garantir escalabilidade e integridade dos dados.

### 🐍 1. Python (Engenharia & ETL)
Utilizado para orquestrar a ingestão de dados e limpeza avançada.
* **IDE:** PyCharm (Versão 2025.2.4).
* **Bibliotecas Utilizadas:**
    * `pandas`: Manipulação de DataFrames, limpeza de strings e tratamento de nulos.
    * `sqlalchemy`: Criação da *engine* de conexão com o banco de dados (ORM).
    * `pymysql`: Driver para comunicação Python-MySQL.
    * `unidecode`: Normalização de textos (remoção de acentos e caracteres especiais em nomes de cidades e categorias).
    * `os`: Gerenciamento de diretórios e caminhos de arquivos para automação.

### 🗄️ 2. Banco de Dados (Data Warehousing)
* **Servidor Local:** XAMPP (Apache + MariaDB/MySQL). Escolhido pela facilidade de criar um ambiente de servidor local robusto.
* **Interface de Gerenciamento:** MySQL Workbench. Utilizado para:
    * Modelagem do Schema (DDL).
    * Criação de Índices e Chaves (PKs e FKs).
    * Validação de integridade referencial.
    * Consultas ad-hoc (SQL) para validação de métricas.

### 📊 3. Visualização (Data Viz)
* **Ferramenta:** Tableau Public.
* **Modelagem:** Star Schema (Esquema Estrela) com tabela fato "order_items" centralizada. A conexão com as demais tabelas foram feitas por meio da definição das PK estabelecidas no Mysql.
* **Features:** Parâmetros dinâmicos (Top N categorias vendidas), Campos Calculados e Ações de Filtro interativas.

### 🐙 4. Versionamento
* **Ferramenta:** GitHub Desktop.
* **Controle:** Versionamento de scripts Python e queries SQL para garantir rastreabilidade do código.

---

## ⚙️ Metodologia e Etapas de Execução

### FASE 1: Engenharia de Dados (ETL)
* **Teste de conexão com o MYSQL:** [Criação do arquivo 'teste_conexao_1.py'](https://github.com/eaiyukenish40-cloud/Projeto-Portifolio-Olist/blob/main/DataCleaning_Python/teste_conexao_1.py)
* **Ingestão:** Criação de script Python para leitura automatizada de múltiplos arquivos CSV (Source: Kaggle Olist) sendo importados posteriormente dentro do Mysql [script 'carrega dados2.py':](https://github.com/eaiyukenish40-cloud/Projeto-Portifolio-Olist/blob/main/DataCleaning_Python/carrega%20dados_2.py])
* * **Investigação dos dados:** Com os arquivos importados no Mysql, foram contruídas queries para cada tabela para visualização dos dados disponíveis [Pasta SQL](https://github.com/eaiyukenish40-cloud/Projeto-Portifolio-Olist/tree/main/Mysql/Scripts_SQL)
* **Data Cleaning:**
    * Tratamento de tipos de dados (conversão de datas, floats e strings).
    * `sqlalchemy` para conexão com os dados e `pandas` para obter os dataframes, leitura, importação em csv, escrita no mysql.
    * Normalização de texto com `unidecode` para padronizar cidades (ex: "são paulo" -> "sao paulo").
    * Implementação de **Carga Fracionada (Chunking)** e método `multi` para otimizar a inserção de milhares de linhas no MySQL sem travar a memória.
    * Uso da importação de importação de dados do Mysql para uso dos CSV's limpos no Tableau Públic ['importa_mysql_4'](https://github.com/eaiyukenish40-cloud/Projeto-Portifolio-Olist/blob/main/DataCleaning_Python/importa_mysql_4.py)

### FASE 2: Modelagem de Dados (SQL)
* Transformação de tabelas "soltas" em um **Modelo Relacional**.
* Definição de **Primary Keys** simples e compostas (ex: `order_items` possui PK composta por `order_id` + `order_item_id`).
* Criação de **Foreign Keys** para garantir a integridade do banco (impedir pedidos sem clientes, etc.).
* Criação de tabela resumida de geolocalização (`geo_resumida`) para otimizar a performance do mapa no Tableau.

### FASE 3: Analytics & Storytelling (Tableau)
* Desenvolvimento de Dashboard Executivo com layout fixo (UX).
* Criação de análises YoY (Year over Year) para comparar 2017 vs 2018 (períodos entre janeiro a agosto).
* Análise de correlação entre **Prazo de Entrega** e **Nota de Avaliação**.

---

## 📈 Resultados e Dashboard

O resultado final é um painel interativo que permite filtrar por Estado, Ano e Categoria.

🔗 **[Clique aqui para acessar o Dashboard Interativo no Tableau Public](https://public.tableau.com/app/profile/gustavo.maizatto/viz/DataViz_ProjetoPortifolio/VisoGeralVendas?publish=yes)**

*<img width="1356" height="753" alt="image" src="https://github.com/user-attachments/assets/16978c6f-b33f-40f4-98cb-4af11654adc4" />*

**Principais Insights:**
* **Sazonalidade:** Pico agressivo de vendas identificado na Black Friday de 2017.
* **Logística:** O Sudeste possui o menor custo de frete relativo, enquanto Norte e Nordeste sofrem com custos altos, impactando diretamente na satisfação.
* **Qualidade:** Pedidos entregues com atraso têm uma nota média ~50% menor que pedidos no prazo.
* **Aumento nas vendas:** É notável a evolução no aumento das vendas em 2018, entre os períodos com dados disponíveis, e pode-se notar uma piora na qualidade da margem frete em 2018 em comparação com 2017. Uma possível sobrecarga na demanda x qualidade?

## 🧗 Desafios e Lições Aprendidas

Durante o desenvolvimento, enfrentei desafios reais de engenharia que exigiram adaptações na arquitetura:

* **Infraestrutura e Resiliência:** O ambiente de servidor local (XAMPP/MySQL) apresentou instabilidades durante cargas massivas de dados.
    * *Lição:* A importância crítica de rotinas de **Backup** e a separação dos arquivos de dados (`ibdata`) para recuperação de desastres.
* **Limitação de Conectividade:** O Tableau Public encerrou o suporte a conexões *live* com bancos locais.
    * *Solução (Workaround):* Implementei um pipeline intermediário em Python para exportar as tabelas processadas em arquivos `.csv` otimizados, simulando um Data Lake estático.  ['importa_mysql_4'](https://github.com/eaiyukenish40-cloud/Projeto-Portifolio-Olist/blob/main/DataCleaning_Python/importa_mysql_4.py)
* **Qualidade de Dados (Data Quality):**
    * Havia inconsistências graves na grafia de cidades (input manual do usuário).
    * *Estratégia:* Apliquei a **Regra de Pareto (80/20)** para limpar os maiores ofensores via script, garantindo a integridade das regiões principais.
    * *Melhoria Futura:* Importância de implementar constraints de validação na ponta da coleta (Front-end) para evitar "lixo na entrada" (Garbage In, Garbage Out).

---

## 🚀 Como reproduzir este projeto

1.  Clone este repositório.
2.  Instale as dependências: `pip install pandas sqlalchemy pymysql unidecode`.
3.  Configure seu servidor MySQL local (XAMPP) e crie um banco chamado `olist`.
4.  Ajuste a string de conexão no arquivo `config.py` (ou script principal).
5.  Execute os scripts de carga na ordem numérica.
