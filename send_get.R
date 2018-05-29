require(httr)
require(xml2)
send_get <- function(page,id,SID,HSID,SSID){
  purl <- sprintf("https://scholar.google.com.tw/scholar?start=%s&cites=%s&as_sdt=2005&sciodt=0,5&hl=zh-TW",page,id)
  res <- GET(purl,add_headers(
    "User-Agent"= "Mozilla/5.0 (Windows NT 6.3; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/66.0.3359.181 Safari/537.36",
    "accept"="text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8"
  ),set_cookies(
    "SID"=SID,
    "HSID"=HSID,
    "SSID"=SSID
  )
  ,body=list(
    "cites"=id,
    "as_sdt"="2005",
    "sciodt"="0,5",
    "hl"="zh-TW"
  ))
  resstring <- content(res,"text",encoding = "utf-8")
  res2 <- read_html(resstring, encoding = "utf8")
  if(page==0){
    allpage <- as.numeric(gsub(",","",sub(".*有\\s(.+)\\s項.*","\\1",xml_text(xml_find_all(res2,'//*[@id="gs_ab_md"]/div/text()[1]')))))
    return(allpage)
  }
  return(res2)
}