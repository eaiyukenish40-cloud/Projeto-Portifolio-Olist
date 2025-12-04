import pandas as pd
from sqlalchemy import create_engine
import os

#Programa importa do Mysql, as tabelas mais atuais do banco de dados definido.
#conexão com mysql
db_connection = 'mysql+pymysql://root:@localhost:3306/olist'
db_banco = create_engine(db_connection)

#pasta de saída de arquivos
pasta = r'C:\Users\gusta\OneDrive\Desktop\Geral\Projetos\Projeto Portifólio completo\Dados_Mysql_import'
try:
    if not os.path.exists(pasta):
        os.makedirs(pasta) # comando recursivo que cria as pastas conforme os caminhos.
except:
    print('\033[0:33mHouve problemas na criação das pastas\033[m ')

#tabelas = ['clientes','geolocation','geolocation_res','olist_order_payments','olist_order_reviews','olist_orders','olist_products','olist_sellers','order_items','product_category_name']
tabelas = ['olist_products']

print('\033[0:33mIniciando saída de arquivos\033[m')
for c in tabelas:
    try:
        df_mysql = pd.read_sql_table(c, con = db_banco)
    except Exception as e:
        raise ValueError('\033[0:33mHouve algum problema durante o acesso com o Mysql\033[m',e)
    else:
        print(f'\033[0:33mTabela: {c} lida com sucesso\033[m')
        #comandos para salvar em csv na pasta definida.
        nome_arq = f'{pasta}/{c}.csv'
        print(f'Salvando o csv no caminho {pasta}...')
        try:
            df_mysql.to_csv(nome_arq, index = False, sep=',',encoding='utf-8')
        except Exception as e:
            raise ValueError('\033[0:33mNão foi possível salvar o seu arquivo\033[m',e)
        else:
            print(f'\033[0:32mArquivo importado com sucesso...\033[m')


