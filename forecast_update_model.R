
##Check working directory
getwd()
setwd("C:/Users/ayesh/Dropbox/Courses/Boston_EcologicalForecasting/additional_code")

#Read in data
gflu = read.csv("http://www.google.org/flutrends/about/data/flu/us/data.txt",skip=11)
names(gflu)

y = ts(gflu$Massachusetts)
arima_model = arima(y,order = c(3,0,1))
forecast = predict(arima_model, n.ahead = 10) #predict the model 10 steps ahead

#Plot the model and store it as a jpeg
jpeg("test_forecastplot.jpeg")
plot(y, type = 'l', ylab = "Flu Index", lwd = 2, xlim = c(540,640), ylim = c(0,4000)) #focus on end of time series to view prediction
lines(forecast$pred, col = "dodgerblue2", lwd = 2)
dev.off()

#Write out predictions to csv file
predictions = data.frame(time = time(forecast$pred),
                          prediction = forecast$pred,
                          stde = forecast$se)

write.csv(predictions, "test_predictions.csv")
 
### set up predictive model to run in linux and update model every day (if data are being updated)
# Use "cron" in linux
# cron takes information on when you want to run something and what you want to run
# Use following command in linux:
#$  crontab -e
#$  26 2 * * * Rscript/Users/ayesh/Dropbox/Courses/Boston_EcologicalForecasting/additional_code/Update_model.R   #This asks for every day and 

#$  crontab -l           #Lists the output from the crontab

#OR
#Type in "scheduler" in windows command window and set up a scheduled task through scheduler