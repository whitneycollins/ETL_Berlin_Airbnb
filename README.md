# ETL_Berlin_Airbnb
Group ETL Project

ETL Project: Berlin AirBnb

Overview: 


For this project, we chose datasets found in Kaggle composed of information on AirBnb’s located in Berlin, Germany. One dataset contained items such as names and locations of the listings, the other was a large amount of review summaries about said listings. This gave us the opportunity to attempt to combine the two sets so that a new dataset reflected the basic information about the listing combined with its corresponding review summaries.

	Extract: your original data sources and how the data was formatted.


One of the datasets was larger than the standard max limit for .csv files to GitHub. That required a vfs install to push the files up to our repository.
		Sources:
Project Proposal
Berlin Airbnb listings.csv
Berlin Airbnb reviews_summary.csv

Transform: what data cleaning or transformation was required


Data transformation and cleaning included: 
Using csv to json conversion
Dropping excess fields in datasets
Renaming fields as needed.

Note: many queries were unsuccessful at first. Our data_etl.ipynb notebook still contains a few of the unsuccessful queries we used to try to transform the data.

We used pymongo to initialize a connection to MongoDB where we created a database and collections from our data. Here, we could work within the mongo shell to create a pipeline using stages where queries are added. We queried using $group but our output somehow changed the listing_id for each row after grouping. This made the data unclear to which listing the comments were made. 

Using postgreSQL and pandas, the original csv files were converted to dataFrames and connected to pgAdmin, we used GROUP BY to create a new csv file that was perfectly formatted to have all the comments in one dictionary for each listing. This was exported as combined_comments.csv file which allowed us to do a couple things: 

Read combined_comments.csv back into pandas, use a concatenate query to join the listings and results dataFrames. We finally retrieved our goal table (complete.csv in finalOutput folder).


Coming back to MongoDB, we used the combined_comments.csv file to load the data into a collection within MongoDB. Inside the mongo shell, our first stage used $group to create a new output using the same listings and results files, thus creating an array of the reviews/comments objects within each listing document. In a second stage of the pipeline, we first used $limit to reduce the number of documents in the output followed by $out, to allow the output to be saved to a new collection within our database. The final table was exported to final.csv.



Load: the final database, tables/collections, and why this was chosen


We used pgAdmin to group our reviews by listing. Then created dataFrames to be cleaned and joined. Within Mongo, we were able to produce a final output within our Mongo database featuring our aggregated data. MongoDB required lots of new knowledge but the challenge was fun and educational. 

	Relational vs Non-Relational


PostgreSQL is a relational database, so this database was great for grouping the data and creating the dictionary of comments since ist data is stored in tables and rows. For projects requiring that related data be kept in tables or csv files, postgeSQL is the way to go. 

MongoDB is non-relational, meaning the data is stored in collections of JSON documents. We believe this is why we had difficulty with grouping the csv in the beginning. This database would be helpful to create new, elaborate datasets. There are lots of calculation functions in the aggregation tab that I hope to use in the future.

Within MongoDB, we created a new collection (see: final.csv in folder: finalOutput)) that included: id, name, neighbourhood, lat, long, number of reviews, and listing comments/reviews. This file can be used for specific location if we are looking to stay in a particular area close to places we hope to visit during our trip. We can go further with this set using API keys to locate the coordinates and map out the Airbnb listings.

Our complete.csv (folder: finalOutput) is a table with columns: id, name, neighbourhood, price and comments/reviews. This file is better for helping travelers stay on budget since it lists prices and geographic regions. 

Further, if time permitted, we could also add in the available dates of each listing from a calendar_summary.csv file to help plan out the dates we wanted to visit.


Within the MongoDB, the aggregations tab allows for queries to manipulate your data. Here you see a pipeline with several stages ($lookup, $limit, $out).
