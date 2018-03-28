# B629 Topics in PL: Denotational Semantics

Indiana University, Spring 2018

In this course we shall study the denotational semantics of
programming languages, including the classic domain-theoretic models
as well as elementary models based on functions-as-graphs and
intersection types. The course assignments will include readings from
selected chapters and papers, written homework, presentations, and
some programming.

## Instructor

**Jeremy Siek** Luddy 3016 [jsiek@indiana.edu](mailto:jsiek@indiana.edu)

## Lectures

9:30-10:45am MW in Luddy Hall Room 3069 (not BH 305!), 
  backup location Luddy Hall Room 4069.

The lecture notes are in progress at:

[https://github.com/jsiek/B629-denotational/notes.pdf](notes.pdf).

## Office Hours

- 11:00am-12 Thursdays in my office Luddy 3016,

- or by appointment

## Assignments

There will be a homework (reading and some exercises) each week and a
written report and presentations at the end of the semester.  Also,
roughly each week, one student will give a 30 minute presentation of a
paper that the class has read.

- [Homework 1](hw1.md) is due January 15
- [Homework 2](hw2.md) is due January 22.
- [Homework 3](hw3.md) is due January 29.
- [Homework 4](hw4.md) is due February 14.
- [Homework 5](hw5.md) is due February 28.
- [Homework 6](hw6.md) is due March 26.
- [Homework 7](hw7.md) is due April TBD.

## Week-by-week Schedule

1. Basics of denotational semantics
2. Fixed point semantics
3. Semantics of the simply-typed lambda calculus
4. Semantics of the untyped lambda calculus
5. Scott and Engeler's graph models
6. Plotkin's graph model
7. Filter models of the untyped lambda calculus
8. More on filter models
9. D-infinity model of the untyped lambda calculus
10. Category-theoretic solutions to domain equations
11. More on category-theoretic solutions to domain equations
12. Semantics of PCF
13. Full abstraction
14. Semantics for imperative languages
15. Monads and effect-handlers
16. Student Presentations


## Representative Readings

- [Denotational semantics: a methodology for language development](http://people.cs.ksu.edu/~schmidt/text/densem.html), Schmidt 1986.
- [Outline of a Mathematical Theory of Computation](https://www.cs.ox.ac.uk/publications/publication3720-abstract.html), Scott 1970.
- [The Denotational Semantics of Programming Languages](https://doi.org/10.1145/360303.360308), Tennent 1976.
- Simply Typed Lambda Calculus
  - Chapter 2 of Semantics of Programming Languages: Structures and Techniques. 
    Gunter 1992.
  - [A Certified Type-Preserving Compiler from Lambda Calculus to Assembly Language](https://doi.org/10.1145/1273442.1250742). Chlipala 2007. **Chaitanya Koparkar, April 2**
  - [Cartesian closed categories and typed λ-calculi](https://doi.org/10.1007/3-540-17184-3_44). J. Lambek 1985. **Jiawei Tang, February 28**
- The Lambda Calculus: its Syntax and Semantics, Barendregt 1984.
- [Lambda-Calculus And Combinators In The 20th Century](https://doi.org/10.1016/S1874-5857(09)70018-4). Cardone and Hindley, 2009.
  (aka. History of Lambda-calculus and Combinatory Logic, 2006)
- Graph Models of the Lambda Calculus
  - [Data Types as Lattices](https://www.dropbox.com/s/ikfyrwkizooah3q/data_types_as_lattices.pdf?dl=1), Scott 1976.
  - [Set-theoretical and other elementary models of the lambda-calculus](https://doi.org/10.1016/0304-3975(93)90094-A),
    Plotkin 1993.
  - [Algebras and combinators](https://doi.org/10.1007/BF02483849), Engeler 1981.
  - [Revisiting Elementary Denotational Semantics](https://arxiv.org/abs/1707.03762), Siek 2017.
- Filter Models of the Lambda Calculus
  - [Functional characterization of some semantic equalities
    inside lambda-calculus](https://doi.org/10.1007/3-540-09510-1_11). Coppo, Dezani-Ciancaglini, Salle 1979.
  - [A filter lambda model and the completeness of type assignment](https://www.jstor.org/stable/2273659).
    Barendregt, Coppo, Dezani-Ciancaglini 1983.
  - [Intersection Types and Lambda Models](https://doi.org/10.1016/j.tcs.2006.01.004).
    Alessi, Barbanera, Dezani-Ciancaglini 2006.
- PCF
  - [A type-theoretic alternative to ISWIM, CUCH, OWHY](https://doi.org/10.1016/0304-3975(93)90095-B), Scott 1993.
  - [LCF considered as a programming language](https://doi.org/10.1016/0304-3975(77)90044-5), Plotkin 1977.
- The D∞ model of the λ-calculus
  - [Lecture notes](http://www.cs.cornell.edu/courses/cs6110/2011sp/lectures/lecture24.pdf) from Nate Foster's CS 6110 course
  
- [Fixed point constructions in order-enriched categories](https://doi.org/10.1016/0304-3975(79)90053-7). Wand 1979.
- [The category-theoretic solution of recursive domain equations](http://homepages.inf.ed.ac.uk/gdp/publications/Category_Theoretic_Solution.pdf),
  Smyth and Plotkin, 1982.
- [The Essence of Algol](https://www.cs.cmu.edu/~crary/819-f09/Reynolds81.ps), Reynolds 1981.
- [Notions of computation and monads](https://doi.org/10.1016/0890-5401(91)90052-4), Moggi 1991.
- Full Abstraction
  - [Observable sequentiality and full abstraction](https://doi.org/10.1145/143165.143232),
    Cartwright, Felleisen 1992. **Ryan Scott, April 11**
  - [Full abstraction for the second order subset of an Algol-like language](https://doi.org/10.1016/S0304-3975(96)00066-7).
    Kurt Sieber, 1996.
  - [Full Abstraction for PCF](https://arxiv.org/abs/1311.6125).
    Samson Abramsky, Radha Jagadeesan, Pasquale Malacaria 2000.

