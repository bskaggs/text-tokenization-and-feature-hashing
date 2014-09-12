--- 
title       : Text Tokenization and Feature Hashing for Document Classification
subtitle    : "Produce fixed-sized features vectors with this one crazy trick!"
author      : Brad Skaggs
job         : Developing Data Products
framework   : io2012        # {io2012, html5slides, shower, dzslides, ...}
highlighter : highlight.js  # {highlight.js, prettify, highlight}
hitheme     : color-brewer     # 
widgets     : [mathjax]            # {mathjax, quiz, bootstrap}
mode        : selfcontained # {standalone, draft}
knit        : slidify::knit2slides
---  bg:#CBE7A5

## Motivation

Don't you just love text classification?  It's ever so much fun to filter spam out of your inbox.

We often use the [bag-of-words model](https://en.wikipedia.org/wiki/Bag-of-words_model) in text classification, where a document is represented as a vector of counts of distinct words.

Most generic classification algorithms rely on a fixed-sized representation of a data item.  To apply them to text classification, this means that we have to remember all the distinct words in our training corpus, and use this to define a fixed-sized vector space whose size depends on the training set.

Now, this seems a bit icky; is there some way we can get a representation that is independent of the training set?  *Yes!*

---  bg:#CBE7A5

## Tokenizing Text with Regular Expressions

First, we must get our bag-of-words representation of our documents.

R makes it easy to tokenize text with regular expressions.  The following code will split this quote by a famous philosopher by word boundaries, and then produce a count of distinct tokens:


```r
table(strsplit("I yam what I yam and tha's all what I yam.", "\\W+"))
```

```
## 
##    I  all  and    s  tha what  yam 
##    3    1    1    1    1    2    3
```

---  bg:#CBE7A5

## The Hashing Trick

Feature hashing is an easy way to get a fixed-sized representation of your documents that is independent of vocabulary size.

Start with an all-zeroes vector in a vector space of a size of your choosing ($n$).  For each word in the document, hash it $k$ different ways into the numbers between 1 and $n$, and $k$ different ways to the bits 0 and 1.  Then, in each position it hashes to, add or subtract one (based on the value of the corresponding bit hash) to the vector.

The resulting vector is independent of the vocabulary size you used, and has some nice theoretical properties as well that are discussed on the [feature hashing Wikipedia article](https://en.wikipedia.org/wiki/Feature_hashing).

---  bg:#CBE7A5

## Demo

So you've just heard about this crazy trick, and now you are itching to get your hands on some fixed-sized feature vectors for text classification.  Why not try this demo, which does all this for you?  You can play around with several parameters to see their effect.

* Try out [the Shiny App](https://skaggs.shinyapps.io/text-tokenization-and-feature-hashing/) now!
* The source code is [available on Github](https://github.com/bskaggs/text-tokenization-and-feature-hashing)!
* The source code for these slides is also [available on Github](https://github.com/bskaggs/text-tokenization-and-feature-hashing-slides)!



