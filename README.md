# ETL-twiter
ETL using apache airflow to automate the extraction transformation and visualization of tweets which have specific word as investment, energy.

In the extract part, tweets are collected by twitter api, These tweets contain the specific words =["Invest"or"up"or"Energy"or"Price up"or"win"or"stock"or"Natural Gas"or"coal"] then a restriction of minamount of 1000 retweets is imposed.   

In the transform part the tweets are tokenize and clean for a natural language analysis to detect de sentiment with the compund classification of NLKT library where closer to 1 the twwet is positive.

Finally, in the last part of loading the tweets are saved in a dataframe and then in a file csv to be detailed in in a dashboard on Power BI https://app.powerbi.com/links/i2NLKQCtRj?ctid=fabd047c-ff48-492a-8bbb-8f98b9fb9cca&pbi_source=linkShare 

An Airflow DAG is created to automatize this ETL 3 times per day 

https://colab.research.google.com/drive/12UII-mf6rXG2UERUvIDGuIUHFjgs3nrq?hl=es#scrollTo=0uzzNyYXh5No&uniqifier=1 


It was found a correlation betwwen the number of words and retweets, also between the amount of retweets and the compund score of the sentiments 

# SQL 

9 queries are developed to achive insights of colombian electric market

