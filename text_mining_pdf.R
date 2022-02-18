library(pdftools)
txt <- pdf_text("./paper/1_Nivolumab versus Docetaxel.pdf")
# first page text
cat(txt[1])

NCT_index <- stringr::str_locate(txt[1],"NCT")
NCT_num   <- substr(txt[1],NCT_index[1], NCT_index[1]+10)

# Table of contents
toc <- pdf_toc("./paper/1_Nivolumab versus Docetaxel.pdf")

# Show as JSON
jsonlite::toJSON(toc, auto_unbox = TRUE, pretty = TRUE)

# Author, version, etc
info <- pdf_info("./paper/1_Nivolumab versus Docetaxel.pdf")
firstauthor < strsplit(info$keys$Author, ",")[[1]][1]
pubyear <- format(as.Date(info$created),"%Y")
Title <- info$keys$Title[1]

# Table with fonts
fonts <- pdf_fonts("1403.2805.pdf")
