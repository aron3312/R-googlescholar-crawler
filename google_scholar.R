source('find_cookies.R')
source('search.R')
source('send_get.R')
source('parsed_article.R')
#important SID、HSID、SSID
#login to get
#########################run##########################

#first use selenium login google get cookies
cookies_all <-  find_cookies(account="",password = "")

#get one page 10 result
result <- send_get(SID = as.character(cookies_all[names(cookies_all)=="SID"]),HSID=as.character(cookies_all[names(cookies_all)=="HSID"]),SSID=as.character(cookies_all[names(cookies_all)=="SSID"]),page=1,id='15918970914154895420')

#you can use xml2 package to parse or chinese can use parsed result
