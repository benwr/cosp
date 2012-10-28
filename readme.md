# Course of Study Planner #

This is a project I'm working on to replicate the Course of Study Planner
in use by University Honors at Virginia Tech.

## Design ##

Schedules are in s-expression data structures that look like:

    '([schedule-name]  [semester1] [semester2] ... [semestern])

Where a semester is an s-expression that looks like:

    '([semester-name] [course1] [course2] ... [coursen])

and a course is an s-expression that looks like:

    '([course-id] [name] [credit count] [description] [requirement rules])

A course id is a dotted pair containing a string representing the subject
and an integer representing the course number: For example, `'(ece . 2504)` 
represents what's currently called Intro to Computer Engineering.

A full plan, then, would look like this:

    '("Ben's Plan"
      ("Fall 2012"
        ((ece . 2534) "Microcontroller Interfacing and Programming" 4
          "Course about making electronics programmable.")
        ((ece . 2524) "Intro to UNIX" 2 "Course teaching the basics of
          programming in the UNIX environment")
        ((math . 2214) "Intro to Differential Equations" 3
          "Methods and applications of solving differential equations"))
      ("Spring 2013"
        ((ece . 3574) "Applied Software Design" 3 "Designing software for
          the corporate world using C++")))
