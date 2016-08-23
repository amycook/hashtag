#' Word Scorer
#'
#' These two functions score each word in each tweet and returns a list of dataframes - one dataframe for each
#' tweet
#' @param tweet.vec vector of tweets as strings
#' @keywords tokenizer
#' @export
#' @examples
#' token.nrc(tweet.vec = tweetsDF$text)
#' 
#' 

token.nrc <- function(tweet.vec = x){
        output <- vector(mode = "list", length = length(tweet.vec))
        
        for(i in seq_along(tweet.vec)){
                by.word <- data_frame("token" = get_tokens(tweet.vec[i]))
                by.word <- cbind(by.word, get_nrc_sentiment(by.word$token))
                #filter for rows with entries greater than 0:
                output[[i]] <- by.word[rowSums(by.word %>% select(-token)) != 0,]
        }
        
        names(output) = tweet.vec
        return(output)
}

token.afinn <- function(tweet.vec = tweet.vec){
        output <- vector(mode = "list", length = length(tweet.vec))
        
        for(i in seq_along(tweet.vec)){
                by.word <- data_frame("token" = c(get_tokens(tweet.vec[i])))
                
                by.word <- cbind(by.word, 'afinn' = get_sentiment(by.word$token, method = 'afinn'))
                total <- data_frame('token' = c("TOTAL"),
                                    'afinn' = get_sentiment(tweet.vec[i], method = 'afinn'))
                
                by.word <- rbind(by.word, total)
                
                #filter for rows with entries greater than 0:
                output[[i]] <- by.word[rowSums(by.word %>% select(-token)) != 0,]
        }
        
        names(output) = tweet.vec
        return(output)
}
