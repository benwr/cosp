# Course of Study Planner #

Warning: This is "readme-driven development." Most of this document
is wishful thinking!

This is a project I'm working on to replicate the 
[Course of Study Planner] (http://www.univhonors.vt.edu/html/cosp.html)
in use by University Honors at Virginia Tech. It's made available under the 
MIT license (found in license.txt).

## Design ##

### Architecture ###

The base functions that are used for adding and removing classes are found
in `src/cosp.scm`. They're extremely simple, and can probably be modified to
work with any scheme implementation you care to try:

* `(add-course <course> <semester>)` Adds the course
  to the specified semester and returns the result.
* `(rem-course '(<subject> . <id>) <semester>)` Removes  course from the
  semester and returns the result. Returns nil if the course already exists.
* `(add-semester <semester-name> <schedule>)` Adds an empty semester to the 
  schedule.


The basic idea is that there is a key-value store somewhere, which spits
out course information when you send it a course id. Thus, to make this
work with other schools (with similar course-numbering schemes, such that
course descriptors match the regex `/^[A-Z]*\s?\d+$/`), one only needs to
re-implement the key-value store backend.

For the Virginia Tech implementation (the only one I care about, as it is 
the school I attend), the backend is a server in Ruby that trolls the VT 
timetables for information.

### Data Structures ###

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


