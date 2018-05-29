library(xml2)
library(httr)
search <- function(article){
  purl <- paste0('https://scholar.google.com.tw/scholar?hl=zh-TW&as_sdt=0%2C5&q=',article,'&btnG=')
  res <- GET(purl,add_headers(
    "User-Agent"= "Mozilla/5.0 (Windows NT 6.3; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/63.0.3239.132 Safari/537.36",
    "accept"="text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8"
  )
  ,body=list(
    "as_sdt"="0,5",
    "btnG"="",
    "q"=article
  ))
  resstring <- content(res,"text",encoding = "utf-8")
  res2 <- read_html(resstring, encoding = "utf8")  
  data_cid <- xml_attr(xml_find_all(res2,'//*[@id="gs_res_ccl_mid"]/div'),"data-cid")
  return(data_cid)
}