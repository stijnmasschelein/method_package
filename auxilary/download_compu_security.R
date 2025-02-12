library(tidyverse)
library(RPostgres)
library(dbplyr)

wrds <- dbConnect(Postgres(),
                  host='wrds-pgdata.wharton.upenn.edu',
                  port=9737,
                  dbname='wrds',
                  user='stimas',
                  sslmode='require')

compu_sic <- tbl(wrds, in_schema("comp", "security")) %>%
  select(gvkey, isin, cusip, tic, ibtic) %>%
  filter(!is.na(isin)) %>%
  collect()

write_csv(compu_sic, "data/wrds/na_compu_security.csv")
