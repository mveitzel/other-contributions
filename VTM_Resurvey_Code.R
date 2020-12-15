# see http://cran.r-project.org/web/packages/rjson/rjson.pdf
# migrate to Karthiks R connector later

library(rjson)

url <- "http://ecoengine.berkeley.edu/api/photos/?format=json&page_size=30&collection_code=VTM"

testdat <- fromJSON(,url, method="C", unexpected.escape = "skip")
dput(testdat,"test.data.txt")

convertToDataFrame<-function(dat){
	#set up data frame (tell data.frame not to make characters factors)
	test<-data.frame(
		GeometryType=character(),
		Longitude=numeric(),
		Latitude=numeric(),
		Author=character(),
		Locality=character(),
		County=character(),
		PhotographerNotes=character(),
		URL=character(),
		BeginDate=character(),
		EndDate=character(),
		Record=character(),
		RemoteResource=character(),
		CollectionCode=character(),stringsAsFactors=FALSE)

	for(i in 1:length(dat$features)){
		## if the input has "null" (missing values), make sure there are NAs in the data.frame
		test[i,]<-rep(NA,ncol(test)) 
		## and always check if the value is null before you try to assign the value
		if(class(dat$features[[i]]$geometry$type)!="NULL")
			test[i,"GeometryType"]<-dat$features[[i]]$geometry$type
		if(class(dat$features[[i]]$geometry$coordinates[1])!="NULL")
			test[i,"Longitude"]<-dat$features[[i]]$geometry$coordinates[1]
		if(class(dat$features[[i]]$geometry$coordinates[2])!="NULL")
			test[i,"Latitude"]<-dat$features[[i]]$geometry$coordinates[2]
		if(class(dat$features[[i]]$properties$authors)!="NULL")
			test[i,"Author"]<-dat$features[[i]]$properties$authors
		if(class(dat$features[[i]]$properties$locality)!="NULL")
			test[i,"Locality"]<-dat$features[[i]]$properties$locality
		if(class(dat$features[[i]]$properties$county)!="NULL")
			test[i,"County"]<-dat$features[[i]]$properties$county
		if(class(dat$features[[i]]$properties$photog_notes)!="NULL")
			test[i,"PhotographerNotes"]<-dat$features[[i]]$properties$photog_notes
		if(class(dat$features[[i]]$properties$url)!="NULL")
			test[i,"URL"]<-dat$features[[i]]$properties$url
		if(class(dat$features[[i]]$properties$begin_date)!="NULL")
			test[i,"BeginDate"]<-dat$features[[i]]$properties$begin_date
		if(class(dat$features[[i]]$properties$end_date)!="NULL")
			test[i,"EndDate"]<-dat$features[[i]]$properties$end_date
		if(class(dat$features[[i]]$properties$record)!="NULL")
			test[i,"Record"]<-dat$features[[i]]$properties$record
		if(class(dat$features[[i]]$properties$remote_resource)!="NULL")
			test[i,"RemoteResource"]<-dat$features[[i]]$properties$remote_resource
		if(class(dat$features[[i]]$properties$collection_code)!="NULL")
			test[i,"CollectionCode"]<-dat$features[[i]]$properties$collection_code
		}

	test$BeginDate<-as.Date(test$BeginDate)
	test$EndDate<-as.Date(test$EndDate)

	return(test)
}

convertToDataFrame(testdat)
