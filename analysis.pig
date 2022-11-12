REGISTER /usr/lib/pig/piggybank.jar;

result = LOAD 'result' USING org.apache.pig.piggybank.storage.CSVExcelStorage('\t',
'NO_MULTILINE','NOCHANGE','SKIP_INPUT_HEADER')
as (person_id:chararray, number_of_roles:int,
 number_of_directed:int);

title = LOAD 'input/name.basics.tsv' USING
org.apache.pig.piggybank.storage.CSVExcelStorage('\t',
'NO_MULTILINE','NOCHANGE','SKIP_INPUT_HEADER')
as (nconst:chararray, primaryName:chararray,
 birthYear:int, deathYear:int,
 primaryProfession:chararray, knownForTitles:chararray);

projected_title = FOREACH title
 GENERATE nconst,
 primaryName,
 primaryProfession as professions_tuple;

profesion_with_counter = JOIN projected_title BY nconst, result BY person_id; 

profesion_with_counter_simple = FOREACH profesion_with_counter GENERATE
 primaryName as primaryName,
 professions_tuple as professions_tuple,
 number_of_roles as number_of_roles,
 number_of_directed as number_of_directed;

filtered_actors = FILTER profesion_with_counter_simple BY (professions_tuple matches '.*actor.*') OR (professions_tuple matches '.*actress.*');
top_actors = ORDER filtered_actors BY number_of_roles DESC;
top_3_actors = LIMIT top_actors 3;

top_3_actors_simple = FOREACH top_3_actors GENERATE
 primaryName as primaryName,
 'actor' as role,
 number_of_roles as movies;


filtered_directors = FILTER profesion_with_counter_simple BY (professions_tuple matches '.*director.*');
top_directors = ORDER filtered_directors BY number_of_directed DESC;
top_directors = FILTER top_directors BY number_of_directed != 0;
top_3_directors = LIMIT top_directors 3;

top_3_directors_simple = FOREACH top_3_directors GENERATE
 primaryName,
 'director' as role,
 number_of_directed as movies;
 
result = UNION top_3_directors_simple, top_3_actors_simple;



STORE result
    INTO 'final_result.json' 
    USING JsonStorage();