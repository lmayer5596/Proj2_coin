library(caret)
library(data.table)
library(Metrics)


test <- fread('./project/volume/data/interim/test.csv')
train <- fread('./project/volume/data/interim/train.csv')
submit <- fread('./project/volume/data/interim/format.csv')

train_y <- train$result

dummies <- dummyVars(result ~ ., data = train)
train <- predict(dummies, newdata = train)
test <- predict(dummies, newdata = test)

train <- data.table(train)
train$result <- train_y
test <- data.table(test)

glm_model <- glm(result~., family = binomial, data = train)

saveRDS(dummies, './project/volume/models/coin_glm.dummies')
saveRDS(glm_model, './project/volume/models/coin_glm.model')

test$result <- predict(glm_model, newdata = test, type = 'response')

submit$result <- test$result

fwrite(submit, './project/volume/data/processed/submit_1.csv')
