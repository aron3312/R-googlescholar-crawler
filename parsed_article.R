require(xml2)
parsed_article <- function(res_list){
  t <- lapply(1:10,function(x){
    title <- xml_text(xml_find_all(res_list,sprintf('//*[@id="gs_res_ccl_mid"]/div[%s]/div/h3/a',x)))
    href <- xml_attr(xml_find_all(res_list,sprintf('//*[@id="gs_res_ccl_mid"]/div[%s]/div/h3/a',x)),"href")
    author <-  paste(xml_text(xml_find_all(res_list,sprintf('//*[@id="gs_res_ccl_mid"]/div[%s]/div[2]/div[1]/a',x))),collapse = ";")
    if(nchar(author)<1){
      index <-  xml_text(xml_find_all(res_list,sprintf('//*[@id="gs_res_ccl_mid"]/div[%s]/div/div[1]',x)))
      index  <- index[length(index)]
      index2 <- unlist(strsplit(index,'-'))
      author <- index2[1]
      book <- paste(index2[c(length(index2)-1):c(length(index2))],collapse = ";")
      cite_num <- as.numeric(sub(".*引用(.+)次.*","\\1",xml_text(xml_find_all(res_list,sprintf('//*[@id="gs_res_ccl_mid"]/div[%s]/div/div[3]/a[3]',x)))))
      result <- data.frame(title=title,href=href,author=author,book=book,cite_num=cite_num)
      return(result)
    }
    book <- xml_text(xml_find_all(res_list,sprintf('//*[@id="gs_res_ccl_mid"]/div[%s]/div[2]/div[1]/text()[%s]',x,length(xml_find_all(res_list,sprintf('//*[@id="gs_res_ccl_mid"]/div[%s]/div[2]/div[1]/a',x))))))
    cite_num <- as.numeric(sub(".*引用(.+)次.*","\\1",xml_text(xml_find_all(res_list,sprintf('//*[@id="gs_res_ccl_mid"]/div[%s]/div/div[3]/a[3]',x)))))
    result <- data.frame(title=title,href=href,author=author,book=book,cite_num=cite_num)
    return(result)
  })
  tt <- do.call("rbind",lapply(t,as.data.frame))
  return(tt)
}