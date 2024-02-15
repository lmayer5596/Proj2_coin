#takes the edited datasets from the interim folder
test <- fread('./project/volume/data/interim/test.csv')
train <- fread('./project/volume/data/interim/train.csv')
submit <- fread('./project/volume/data/interim/format.csv')

#saves training result column
train_y <- train$result

#creates a dummy variable to start prediction based on the row_sum column
dummies <- dummyVars(result ~ ., data = train)
train <- predict(dummies, newdata = train)
test <- predict(dummies, newdata = test)

#reformats the output into a data.table
train <- data.table(train)
train$result <- train_y
test <- data.table(test)

#uses a logistic model to fit the train data
glm_model <- glm(result~., family = binomial, data = train)

#saves dummy variable and model
saveRDS(dummies, './project/volume/models/coin_glm.dummies')
saveRDS(glm_model, './project/volume/models/coin_glm.model')

#predicts the result on the test data
test$result <- predict(glm_model, newdata = test, type = 'response')

#puts the final result into the submission file format
submit$result <- test$result

#saves the final submission as a csv
fwrite(submit, './project/volume/data/processed/submit_3.csv')
