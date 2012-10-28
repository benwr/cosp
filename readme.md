# Course of Study Planner #

## Design ##

Schedules are in s-expression data structures that look like:

    ("Schedule Name"  [semester1] [semester2] ... [semestern])

Where a semester is an s-expression that looks like:

    ("Semester name" [course1] [course2] ... [coursen])

and a course is an s-expression that looks like:

    ([course-id] [name] [credit count] [description] [requirement rules])

A course id is a dotted pair containing a string representing the subject
and an integer representing the course number: For example, `("ECE" . 2504)` 
represents what's currently called Intro to Computer Engineering.
