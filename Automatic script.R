#Automatic script



library(taskscheduleR)

# Create a task scheduler job that runs the script every hour
# taskscheduler_create(
#   taskname = "Hello World Hourly",
#   rscript = "hello_world.R",
#   schedule = "0 * * * *"
# )



myscript <- "C:/HC_worlds/Hiscore tracker/api_data.r"
cat(readLines(myscript), sep = "\n")


runon <- format(Sys.time() + 62, "%H:%M")
taskscheduler_create(taskname = "test", rscript = myscript, 
                     schedule = "ONCE", starttime = runon)



taskscheduler_create(taskname = "myfancyscriptdaily", rscript = myscript, 
                     schedule = "DAILY", starttime = "09:10", startdate = format(Sys.Date()+1, "%d/%m/%Y"))
