# 7. R Best Practices
> What are best practices for working in R?
> What are best practices for working with R in Alteryx?

There are many books on the topics of 
- programming best practices
- functional programming best practices
- R programming best practices

It's not at all practical for us to cover any of those topics in any reasonable amount of depth.

If I had one sentence to say regarding R programming generally that is especially helpful when moving between your IDE and Alteryx it would be

> Write and use pure functions that do only one thing.

Let me break this down a little bit.

A pure function is one that returns the same results for given inputs and has no side affects.

If a function is going to return the same results every time it's run for given inputs, it should not
- use a non-local variable. i.e. every variable the function is depdendent on should be an argument to the function.

Doing only one thing means exactly that. An `openDoor` function should not also `putOnClothes`, however it might `grabHandle` and  `turnHandle`. And it may take `doorType` as an argument to see whether it should `pushDoor` or `pullDoor`.

When working in R, this is generally recommended. When working with R moving between an IDE and Alteryx, it's practically essential. 

The reason for this is that it allows you to separate 
- the functionality of the R code and
- the movement of the data between R and Alteryx

[//]: # (This could probably use an example)

> What are best practices for debugging R development in Alteryx?
> It's much harder to debug when I don't have the interactive ability of RStudio.

Firstly, follow the above practices. They'll help resolve many issues and will make the debugging easier.

However, when you do run into issues, I find the easiest thing is to pull all of the Alteryx inputs into an object. E.g:
```
alteryxData <- list(
  dataStream.1 = read.Alteryx("#1"),
  dataStream.2 = read.Alteryx("#2"),
  question.questionName1 = '%Question.questionName1%`,
  question.questionName2 = '%Question.questionName2%`,
  ...
)
```

And then save this object somewhere you can play with it in your IDE:
```
# In Alteryx
saveRDS(
  object = alteryxData,
  file = <your file>
)
```

Now you can load this into R and play with it wherever
```
# In RStudio
alteryxData <- readRDS(<your file>)
```

You can interactively play with it now and debug interactively in an R IDE instead of through Alteryx.



> What are best practices for seamlessly transitioning work between my IDE and RStudio and back?

Covered [here](9_Moving_Between_IDE_And_Alteryx.md)
