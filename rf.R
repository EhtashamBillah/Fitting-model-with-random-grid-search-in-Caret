###########################################
# B. random forest
###########################################
# model fittitng with grid search
control_random <- trainControl(method="repeatedcv",
                               number = 10,
                               repeats = 10,
                               classProbs = T,
                               summaryFunction = twoClassSummary,
                               search = 'random',
                               allowParallel = TRUE)
model_rf<- train(form = Target ~.,
                 data = new_train_data,
                 method = 'rf',
                 preProcess=c("center","scale"),
                 metric = "ROC",
                 trControl = control_random,
                 tuneLength=10)

# optimal hyperparameter
model_rf$bestTune
#performance grid
model_rf
# visualization
plot(model_rf)

# prediction
rf_pred <- predict(model_rf,newdata = test_data[,-18]) 
rf_prob <- predict(model_rf,newdata = test_data[,-18],type = "prob") 
