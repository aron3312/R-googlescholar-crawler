require(RSelenium)
#send request
find_cookies <- function(account,password){
  mybro <- rsDriver(port = 4445L,
                    browser = 'chrome',check=F)
  mybro1 <- mybro[["client"]]
  mybro1$navigate("https://accounts.google.com/Login")
  x <- mybro1$findElement(using = "css selector","#identifierId")
  x$sendKeysToElement(list(account))
  x2 <-mybro1$findElement(using = "xpath",'//*[@id="identifierNext"]/content')
  x2$clickElement()
  Sys.sleep(3)
  x3 <-mybro1$findElement(using = "xpath",'//*[@id="password"]/div[1]/div/div[1]/input')
  x3$sendKeysToElement(list(password))
  x4 <-mybro1$findElement(using = "xpath",'//*[@id="passwordNext"]/content/span')
  x4$clickElement()
  Sys.sleep(3)
  mybro1$navigate("https://scholar.google.com.tw/scholar")
  Sys.sleep(2)
  all_cookies <- mybro1$getAllCookies()
  need <- unlist(sapply(all_cookies,function(x){
    if(x$name%in%c("SID","HSID","SSID")){
      a <- x$value
      names(a) <- x$name
      return(a)
    }
  }))
  mybro1$closeWindow()
  return(need)
}