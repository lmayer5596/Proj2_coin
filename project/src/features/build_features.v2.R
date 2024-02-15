
test <- fread('./project/volume/data/raw/test_file.csv')
train <- fread('./project/volume/data/raw/train_file.csv')
submit <- fread('./project/volume/data/raw/samp_sub.csv')

train$row_sum <- rowSums(train[, !c('id', 'result')])
train <- train[, c('row_sum', 'result')]

test$row_sum <- rowSums(test[, !c('id')])
test <- test[, c('row_sum')]
test$result <- 0

submit$result <- 0

fwrite(train, './project/volume/data/interim/train.csv')
fwrite(test, './project/volume/data/interim/test.csv')
fwrite(submit, './project/volume/data/interim/format.csv')
