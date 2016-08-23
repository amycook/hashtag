#' Tweet Analyser
#'
#' This function scrapes twitter for your chosen phrase, and outputs a summary of the most positive or
#' negative tweets
#' @param regex Regular expression for the words/phrase you are interested in. Twitter will be scraped for
#' this regex.
#' @param num.tweets How many tweets should be fetched? Currently, only the latest tweets can be scraped.
#' @param method Sentiment Analysis method. Options include "nrc" which assigns words to 8 emotions and 2
#' sentiments or "afinn" which assigns a positive numeric score to positive words and negative scores to
#' negative words. Only 'afinn' works right now.
#' @param sentiment Choose between "positive" or "negative" sentiment summary
#' @param num.summary The number of tweets to be summarised from the 'most positive' or 'most negative'
#' list
#' @keywords sentiment, twitter, tweets
#' @export
#' @import twitteR
#' @import dplyr
#' @import readr
#' @import magrittr
#' @import ggplot2
#' @import syuzhet
#' @examples
#' hash_sentiment(regex = "coriander|cilantro", num.tweets = 200,
#' method = "afinn", sentiment = "positive",
#' num.summary = 6)
#'



hash_sentiment <- function(regex = "coriander|cilantro", num.tweets = 800,
                           method = "afinn", sentiment = "positive",
                           num.summary = 6, scrape = TRUE){

        if(scrape == TRUE){
        tweets <- searchTwitter(regex, n= num.tweets, lang = "en")

        # extract more info about tweets and convert to a nice df
        tweetsDF <- twListToDF(tweets)
        tweetsDF <- tweetsDF %>% select(text, favorited, favoriteCount, created, retweetCount,
                                        retweeted, screenName)

        #clean tweets
        tweetsDF$text <- text_clean(tweetsDF$text)

        # use iconv function to convert character vector between encodings
        tweetsDF$text <- iconv(tweetsDF$text, from = "latin1", to = "ASCII", sub = "byte")

        # insert space before '<' and after '>' if it is next to a word - isolates emoticons
        tweetsDF$text  <- gsub('([[:alpha:]])([<])', '\\1 \\2', tweetsDF$text )
        tweetsDF$text  <- gsub('([>])([[:alpha:]])', '\\1 \\2', tweetsDF$text )

        # remove any tweets without regex
        tweetsDF <- tweetsDF[grepl(regex, tweetsDF$text, ignore.case = TRUE),]

        # remove duplicates
        tweetsDF <- tweetsDF[!duplicated(tweetsDF$text),]

        assign("tweetsDF", tweetsDF, envir = .GlobalEnv)
        }


        # add emotion scores to df
        if(method == "nrc"){
                sents = get_nrc_sentiment(tweetsDF$text)
                tweetsDF <- cbind(tweetsDF, sents)
        }

        if(method == "afinn"){
                tweetsDF <- cbind(tweetsDF,
                                  'afinn' = get_sentiment(tweetsDF$text, method = 'afinn'))
        }

        #summarise top num.summary tweets
        tweet.summ = sent_summary(sentiment = sentiment, df = tweetsDF,
                                  n = num.summary, meth = method)


        print(tweet.summ)

}






