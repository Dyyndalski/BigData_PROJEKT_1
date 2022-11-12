#!/usr/bin/env python3
import sys

PERSON_ID_COL = 2
CATEGORY_COL = 3

for index, line in enumerate(sys.stdin):

        if index == 0:
                continue

        actor_counter = 0
        director_counter = 0

        values = line.split()

        person_id = values[PERSON_ID_COL]
        person_id = person_id.replace("\x00", "")

        category_name = values[CATEGORY_COL]
        category_name = category_name.replace("\x00", "")

        if category_name == "actor" or category_name == "actress" or category_name == "self":
                actor_counter = 1
        elif category_name == "director":
                director_counter = 1

        print(f"{person_id}\t{actor_counter}\t{director_counter}")