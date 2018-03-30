- Read Nate Foster's [lecture notes](http://www.cs.cornell.edu/courses/cs6110/2011sp/lectures/lecture24.pdf) on the D∞ model of the λ-calculus.
  - I believe there is an error in the definition of down(f).
    Instead of d_0 = f(\bot) it should be d_0 = \bot.
  - Compute the meaning of (λx.x), (λx.λy.y), (λx.λy.x), and ((λx.x) (λx.x)),
    but only giving the first three elements of the infinite tuple.
    Instead of using Nate's definitions of up and down, I recommend using
    Scott's definitions which can be found in my notes
    (where they are named apply and abstr).

