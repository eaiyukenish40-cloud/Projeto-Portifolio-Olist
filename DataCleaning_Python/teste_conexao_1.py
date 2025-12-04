def teste_conexao(a = 'mysql+pymysql://root:@localhost:3306/olist'):
    import sqlalchemy
    from sqlalchemy import create_engine,text
    a = 'mysql+pymysql://root:@localhost:3306/olist
    db_connection_str = a
    db_connection = create_engine(db_connection_str)

    try:
        with db_connection.connect() as connection:
            resultado = connection.execute(text("SELECT 'Python e SQL conectados com sucesso!'"))
            print(resultado.fetchone()[0])
    except Exception as e:
        print('Erro na conexão do banco de dados',e)