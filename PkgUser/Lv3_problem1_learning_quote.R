
# learning quote
example(quote)
?quote

# learning quote by example
exp <- quote(xx+1)
eval(exp)
e <- new.env()
e$xx<-4
eval(exp,e)


# symbolic differential
D(quote(x^3),"x")
D(quote(sin(x)),"x")
example(D)



