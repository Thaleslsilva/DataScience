########################################################################################################
# Crandash App - Dashboard com dados de downloads de pacotes do CRAN
# Bloomfilter é uma função de autenticação no CRAN a fim de coletar os dados para alimentar o dashboard
########################################################################################################

library(digest)
library(bit)

rawToInt <- function(bytes) {
  Reduce(function(left, right) {
    bitwShiftL(left, 8) + right
  }, as.integer(bytes), 0L)
}

BloomFilter <- setRefClass("BloomFilter",
                           fields = list(
                             .m = "integer",
                             .bits = "ANY",
                             .k = "integer",
                             .bytesNeeded = "integer",
                             .bytesToTake = "matrix"
                           ),
                           methods = list(
                             initialize = function(n = 10000, p = 0.001) {
                               m = (as.numeric(n) * log(1 / p)) / (log(2)^2)
                               
                               .m <<- as.integer(m)
                               .bits <<- bit(.m)
                               .k <<- max(1L, as.integer(round((as.numeric(.m)/n) * log(2))))
                               
                               # Este é o número de bytes de dados para cada k indices que precisamos gerar
                               .bytesNeeded <<- as.integer(ceiling(log2(.m) / 8))
                               .bytesToTake <<- sapply(rep_len(.bytesNeeded, .k), function(byteCount) {
                                 # 16 é o número de bytes no hash md5 para autenticação no CRAN
                                 sample.int(16, byteCount, replace = FALSE)
                               })
                             },
                             .hash = function(x) {
                               hash <- digest(x, "md5", serialize = FALSE, raw = TRUE)
                               sapply(1:.k, function(i) {
                                 val <- rawToInt(hash[.bytesToTake[,i]])
                                 # Range desejado
                                 as.integer(val * (as.numeric(.m) / 2^(.bytesNeeded*8)))
                               })
                             },
                             has = function(x) {
                               all(.bits[.hash(x)])
                             },
                             set = function(x) {
                               .bits[.hash(x)] <<- TRUE
                             }
                           )
)
