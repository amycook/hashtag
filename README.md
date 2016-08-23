
<!-- README.md is generated from README.Rmd. Please edit that file -->
### Installation

``` r
devtools::install_github("sk6aus6/hashtag")
```

``` r
library(hashtag)
library(readr)
library(twitteR)
```

### Quick demo

First connect to Twitter. I store my twitter API keys in a file buried deep in my computer:

``` r
keys <- read_csv('/Users/yam/OneDrive/shared files/Statslearningcourse/twitteR/keys.csv')
#> Parsed with column specification:
#> cols(
#>   item = col_character(),
#>   key = col_character()
#> )

# setup_twitter_oauth(consumerKey, consumerSecret, accessToken, accessTokenSecret)

setup_twitter_oauth(keys$key[1],
                    keys$key[2],
                    keys$key[3], 
                    keys$key[4])
#> [1] "Using direct authentication"
```

Then write a regular expression you want to search twitter for, and use this as an input for `hash_sentiment()`

``` r
hash_sentiment(regex = "coriander|cilantro", num.tweets = 800,
               method = "afinn", sentiment = "positive", num.summary = 3,
               scrape = TRUE)
#> $`New addiction thanks to Cucumber Dill Salad Who knew I would love the coriander in my salad dressing Amazing FIXATE`
#>      token afinn
#> 3   thanks     2
#> 12    love     3
#> 19 amazing     4
#> 21   TOTAL     9
#> 
#> $`If I could change places w someone for 1 day itd be w someone who likes cilantro bc I want to know what kind of life a person like that has`
#>    token afinn
#> 16 likes     2
#> 20  want     1
#> 24  kind     2
#> 29  like     2
#> 32 TOTAL     7
#> 
#> $`One of my favorite ways to use cilantro is in a beautiful clear soup with monkfish and lime NobuMatsuhisa quotes`
#>        token afinn
#> 4   favorite     2
#> 12 beautiful     3
#> 13     clear     1
#> 21     TOTAL     6
```

If you want to look at different parts of the same twitter scrape, set `scrape = FALSE`

``` r
hash_sentiment(regex = "coriander|cilantro", num.tweets = 800,
               method = "afinn", sentiment = "negative", num.summary = 3,
               scrape = FALSE)
#> $`I didnt know there was a CILANTRO HATING GENE thats the weirdest shit ever`
#>     token afinn
#> 8  hating    -3
#> 13   shit    -4
#> 15  TOTAL    -7
#> 
#> $`I just panicked and got all nervous because I accidentally only paid for normal cilantro but took organic cilantro and still walked out`
#>           token afinn
#> 3      panicked    -3
#> 7       nervous    -2
#> 10 accidentally    -2
#> 24        TOTAL    -7
#> 
#> $`dont me but I fucking hate cilantro`
#>     token afinn
#> 5 fucking    -4
#> 6    hate    -3
#> 8   TOTAL    -7
```

Please excuse the swearing!!
