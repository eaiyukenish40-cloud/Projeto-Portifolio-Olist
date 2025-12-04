import pandas as pd
from sqlalchemy import create_engine

#configurar conexão
db_conexao_banco = 'mysql+pymysql://root:@localhost:3306/olist' #endereço e porta do banco de dados no Mysql
db_conexao = create_engine(db_conexao_banco) # cria a conexão por meio do create engine no endereço definido

arquivo = {}
arquivo_abre = []
#obs:
# fase 1 - importação arquivos - ok verificado
# fase 2 - melhora do código para importação
try:
    #inicia a carga de arquivos
    n = int(input('Digita o número de arquivos que serão importados:'))  # escolhe quantos arquivos serão importados
    path = str(input('Digite o nome do caminho dos arquivos: ')).strip()  # escolhe o diretório de importação
    for c in range(0, n):
        arq =  str(input(f'Digite o nome do {c+1}° arquivo .csv: ')) #escolhe o nome do arquivo no diretório definido
        tabela = str(input('Digite o nome da tabela: ')) #define o nome da tabela no Mysql
        arquivo = {f'{tabela}':fr'{path}\{arq}.csv'}
        arquivo_abre.append(arquivo.copy())
except:
    print('\033[0:31mNão foi possível importar o arquivo .csv\033[m')
else:
    #ler arquivo com pandas
    for c,v in enumerate(arquivo_abre):
        for nome_tab,caminho in v.items():

            if 'customers' in caminho:
                df_clientes = pd.read_csv(caminho, dtype={'customer_zip_code_prefix': str})
            elif 'geolocation' in caminho:
                df_clientes = pd.read_csv(caminho, dtype={'geolocation_zip_code_prefix': str})
            else:
                df_clientes = pd.read_csv(caminho)
            print("Primeiras 5 linhas")
            print(df_clientes.head())
            print(df_clientes.info())
            print("\n\033[0:33mEnviando para o MySQL...\033[m")
            #comandos de envio para o Mysql:
            #name: nome da tabela
            # if_exists - apaga e cria uma nova tabela
            #chunksize a quantidade de dados que é enviado
            #index - não cria uma coluna adicional com numero de linhas
            try:
                df_clientes.to_sql(name = nome_tab,con = db_conexao, if_exists= 'replace', index = False, chunksize = 500)
                print('\033[0:32mDados enviados com sucesso!\033[m')
            except Exception as erro:
                print(f'Não foi possível importar a tabela {nome_tab}, erro')
