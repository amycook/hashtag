#' Tweet Cleaner
#'
#' This function cleans the raw tweets scraped from twitter, to suit the hash_sentiment function.
#' @param x A vector of tweets
#' @keywords tweet, twitter, clean
#' @export
#' @examples
#' text.clean(x = tweetDF$text)

text_clean <- function(x = tweetDF$text) {
        
        x = gsub('http\\S+\\s*', '', x) ## Remove URLs
        
        x = gsub('\\b+RT', '', x) ## Remove RT
        
        x = gsub('#', '', x) ## Remove Hashtags
        
        x = gsub('@\\S+', '', x) ## Remove Mentions
        
        x = gsub('[[:cntrl:]]', '', x) ## Remove Controls and special characters
        
        x = gsub('&amp', 'and', x) ## Remove Controls and special characters
        
        x = gsub('[,.:;+-]|\\[|\\]|\\/', ' ', x) ## space replaces some Punctuation
        
        x = gsub('[[:punct:]]', '', x) ## Remove Punctuations
        
        x = gsub("^[[:space:]]*","",x) ## Remove leading whitespaces
        
        x = gsub("[[:space:]]*$","",x) ## Remove trailing whitespaces
        
        x = gsub(' +',' ',x) ## Remove extra whitespaces
        
        return(x)
        
}
