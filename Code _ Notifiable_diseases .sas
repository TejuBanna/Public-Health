

data PHAC.disease_data;
set work.import;
run;

/* Step 1: Create a frequency table of diseases */
proc freq data=PHAC.disease_data;
   tables disease / out=work.disease_freq; /* Create a frequency table */
run;

/* Step 2: Sort the frequencies in descending order */
proc sort data=work.disease_freq;
   by descending count;
run;

/* Step 3: Get the top 5 diseases */
data work.top5_diseases;
   set work.disease_freq;
   if _N_ <= 5;  /* Limit to the top 5 diseases */
run;

proc sgplot data=work.top5_diseases;
   vbar disease / response=count datalabel; /* Create a vertical bar chart */
   title "Top 5 Notifiable Diseases by Frequency for Age<5 in Canada";
   xaxis label="Disease"; /* Label for the X-axis */
   yaxis label="Number of reported cases"; /* Label for the Y-axis */
run;