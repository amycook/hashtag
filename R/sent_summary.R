#' Sentiment Summariser
#'
#' This function summarises the sentiment calculations and outputs the top scores
#' This can be ordered as positive tweets first or negative tweets first (ascending or descending)
#' @param sentiment 'positive' or 'negative' currently working
#' @param df dataframe containing the tweets
#' @param n number of tweets to summarise
#' @param order.desc TRUE is default which outputs highest scores i.e. most positive tweets. FALSE
#' outputs the most negative tweets
#' @keywords sentiment summary
#' @export
#' @examples
#' sent.summary('positive', n = 6)

sent_summary <- function(sentiment = "positive", df = tweetsDF, n = 3, meth = "afinn"){
        if(meth == "afinn"){
                if(sentiment == "positive"){
                        temp <- df[order(-df[, 'afinn']),] %>% slice(1:n)
                }
                
                if(sentiment == "negative"){
                        temp <- df[order(df[, 'afinn']),] %>% slice(1:n)
                        
                }
        } else {
                temp <- df[order(-df[, sentiment]),] %>% slice(1:n)
        }
        
        if(meth != "afinn"){
                top.n <- token.sent(temp$text)
        } else {
                top.n = token.afinn(temp$text)
        }
        
        return(
                top.n
        )
        
}
