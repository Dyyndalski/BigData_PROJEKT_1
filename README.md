# PROJEKT 1
## Zestaw 4 – IMDB – Persons

## Uruchomienie

1. Pobierz dane:
```sh
wget https://www.cs.put.poznan.pl/kjankiewicz/bigdata/projekt1/zestaw4.zip
```

2. Rozpakuj je:
```sh
unzip zestaw4.zip
```

3. Prześlij dwa pliki:
 - mapper.py
 - reducer.py

4. Załaduj pliki do zasobnika:
```sh
hadoop fs -mkdir -p input
hadoop fs -copyFromLocal input/datasource1/*.tsv input
hadoop fs -copyFromLocal input/datasource4/*.tsv input
```

5. Nadaj prawa:
```sh
chmod +x *.py
```

6. Uruchom hadoop streaming:
```sh
mapred streaming 
-files mapper.py,reducer.py 
-input input/title.principals.tsv 
-output result 
-mapper ./mapper.py 
-reducer ./reducer.py
```

7. Sprawdzanie wyników działania mapreduce:

a) sprawdz wynikowy katalog
```sh
hadoop fs -ls result
```

b) przekopiuj jeden z wybranych plików do lokalnego systemu plików, np.
```sh
hadoop fs -copyToLocal output/part-r-00000 part-00001
```

c) zobacz jego zawartość (30 pierwszy wierszy)
```sh
head -n 30 part-00001
```

8. Uruchom pig'a:
```sh
export PIG_CLASSPATH=/etc/hadoop/conf.empty:/etc/tez/conf
pig -x tez
```

9. Prześlij plik analysis.pig

10. Uruchom pig:
```sh
pig -x tez -f analysis.pig
```

11. Sprawdź wynik końcowy:
 
 a) przekopiuj pliki winikowe do środowiska lokalnego
```sh
hadoop fs -ls output
```

b) jako, że pig wygenerował dwa pliki wynikowe dla lepszego zoobrazowania wyniku połączmy je w całość
```sh
cat final_result/* > FINAL_RESULT.json
```

c) wyświetlenie wyniku
```sh
cat FINAL_RESULT.json
```
