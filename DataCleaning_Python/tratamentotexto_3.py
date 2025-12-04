from logging import exception
from time import sleep
import pandas as pd
from sqlalchemy import create_engine, text
from unidecode import unidecode


print('Conectando com banco de dados...')
sleep(1)
try:
    db_conexao_banco = 'mysql+pymysql://root:@localhost:3306/olist'
    db_conexao = create_engine(db_conexao_banco)
except:
    raise ValueError('\033[0:31mErro na conexão com o banco MYSQL\033[m')
print('\033[0:33mLendo o banco de dados...\033[m')
sleep(1)
# obtenção dos dados da tabela do banco Mysql:
try:
    tabela = str(input('Digite o nome da tabela que será lida: ')).strip().lower()
    df_leitura = pd.read_sql_table(tabela, con = db_conexao)
    print(f'\033[0:32mTabela "{tabela}" acessada com sucesso!\033[m')
    coluna = str(input('Digite o nome da coluna que será lida: ')).strip().lower()
    if coluna not in df_leitura.columns:
        raise ValueError(f'\033[0:31mA coluna "{coluna}" não existe na tabela "{tabela}"\033[m')
    else:
        print('Acesso a coluna com sucesso!')
except KeyboardInterrupt:
    print('\033[0:33mPrograma interrompido pelo usuario!\033[m')
except Exception as erro:
    print(f'Erro na leitura da tabela \033[0:31m{erro}\033[m\n')
else:
    print('Iniciando a transformação dos dados...')
    sleep(1)
    #processo de padronização de dados tirando acentos, letras em minusculo
    coluna_limpa = df_leitura[coluna].apply(lambda x: unidecode(str(x)).lower() if pd.notnull(x) else x)
    #confere diferença de erros:
    correcoes = (df_leitura[coluna] != coluna_limpa).sum()
    print(f'Total de correções: \033[0:33m{correcoes}\033[m')
    df_leitura[coluna] = coluna_limpa
    #envia os dados limpos para o mysql:
    if correcoes > 0:
        try:
            print('\033[0:32mSalvando os dados...\033[m')
            df_leitura.to_sql(name=tabela, con = db_conexao, if_exists= 'replace', index = False,chunksize = 200, method = 'multi')
            print('\033[0:32mFinalizado com sucesso\033[m')
        except Exception as erro:
            print('Erro na salvar os dados limpos...',erro)
    else:
        print('\033[0:32mLimpeza finalizada\033[m')
finally:
    print('\033[0:31mFinalizado o programa...\033[m')


