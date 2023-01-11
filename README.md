# ETL-twiter
ETL using apache airflow to automate the extraction transformation and visualization of tweets which have specific word as investment, energy.

in the extract part de api collects tweets which contain the specific query search for the words query=["Invest"or"up"or"Energy"or"Price up"or"win"or"stock"or"Natural Gas"or"coal"] and filters them wuth the restriction of minamount of retweets whic is 1000 

in the transform part the tweets are tokenize and clean for a natural language analysis to detect de sentiment in the compund classification of NLKT library where closer to 1 the twwet is positive 

in the last part of loading the tweets are saved in a dataframe and the in a file csv. 

An Airflow DAG is created to automatize this ETL 3 times per day 

https://colab.research.google.com/drive/12UII-mf6rXG2UERUvIDGuIUHFjgs3nrq?hl=es#scrollTo=0uzzNyYXh5No&uniqifier=1 


At the it was found a correlation betwwen the number of words and retweets, also between the amount of retweets and the compund score of the sentiments 

many of the tweets with the word invest com with an URL 
