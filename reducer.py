#!/usr/bin/env python3
import sys

current_person_id = None
current_roles_counter = 0
current_director_counter = 0

for line in sys.stdin:
    person_id, roles_number, director_number  = line.strip().split("\t")
    roles_number = int(roles_number)
    director_number = int(director_number)

    if current_person_id == person_id:
        current_roles_counter += roles_number
        current_director_counter += director_number
    else:
        if current_person_id is not None:
            print(f"{current_person_id}\t{current_roles_counter}\t{current_director_counter}")
        current_person_id = person_id
        current_roles_counter = roles_number
        current_director_counter = director_number

print(f"{person_id}\t{current_roles_counter}\t{current_director_counter}")