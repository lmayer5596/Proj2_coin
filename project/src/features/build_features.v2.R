#reads in raw data
test <- fread('./project/volume/data/raw/test_file.csv')
train <- fread('./project/volume/data/raw/train_file.csv')
submit <- fread('./project/volume/data/raw/samp_sub.csv')

#creates a column of the sum of all variable row values, then saves only row_sum and result
train$row_sum <- rowSums(train[, !c('id', 'result')])
train <- train[, c('row_sum', 'result')]

#creates a column of the sum of all variable row values, then saves row_sum and creates an empty results column
test$row_sum <- rowSums(test[, !c('id')])
test <- test[, c('row_sum')]
test$result <- 0

#empties the result column for submission
submit$result <- 0

#saves the edited datasets into the interim folder
fwrite(train, './project/volume/data/interim/train.csv')
fwrite(test, './project/volume/data/interim/test.csv')
fwrite(submit, './project/volume/data/interim/format.csv')
