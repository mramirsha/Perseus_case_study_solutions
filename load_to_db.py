import pandas as pd

from sqlalchemy import create_engine


def load_data_to_db(file_name, table_name):
    user = 'postgres'
    password = 'mypasswd'
    host = 'postgres'
    port = 5432
    dbname = 'postgres'
    connection_url = f'postgresql://{user}:{password}@{host}:{port}/{dbname}'
    engine = create_engine(connection_url)
    df = pd.read_json(file_name)
    df.to_sql(table_name, engine, if_exists='replace', index=False)


if __name__ == "__main__":
    load_data_to_db('courses.json', 'course')
    load_data_to_db('certificates.json', 'certificate')
    load_data_to_db('users.json', 'user')
