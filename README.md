## NHS appointment No-Show (DNA) predictive analytics

### Project overview

Missed hospital appointments, commonly referred to as Did Not Attend (DNA), cost the NHS significant time, resources, and money.

### This project analyses historical appointment data to:

1. Identify patterns behind missed appointments

2. Build machine learning models to predict no-shows

3. Provide actionable insights for reducing DNAs

4. Create an interactive Power BI dashboard for decision-makers

The workflow combines SQL, Python, and Power BI to replicate a real-world healthcare analytics pipeline.

## Business problem

Healthcare providers within the NHS face a persistent challenge with Did Not Attend (DNA) appointments,
where patients fail to show up for scheduled consultations. These missed appointments lead to underutilised
clinical time, longer waiting lists, delayed patient care, and increased operational costs. With millions of
appointments scheduled annually, even a small percentage of DNAs represents a significant strain on healthcare 
resources. This project aims to analyse historical appointment data to identify patterns associated with missed
appointments and develop predictive models that can help healthcare providers proactively identify high-risk patients
and implement targeted interventions such as reminders or scheduling adjustments to reduce DNA rates.


### Key questions to be addressed in this project include:

1. Which patients are most likely to miss appointments?

2. Are there geographic areas with higher DNA rates?

3. Does the day of the week or appointment type affect attendance?

4. Can we predict high-risk appointments in advance?

🗂 Dataset

The dataset contains medical appointment records, including:

| **Feature**          | **Description**                         |
|----------------------|-----------------------------------------|
| PatientId           | Unique patient identifier               |
| AppointmentID       | Unique appointment identifier           |
| Gender              | Patient gender                          |
| Age                 | Patient age                             |
| Neighbourhood       | Area of residence                       |
| Scholarship         | Whether the patient receives welfare support|
| Hypertension        | Medical condition indicator             |
| Diabetes            | Medical condition indicator             |
| Alcoholism          | Health risk indicator                   |
| SMS_received        | Whether appointment reminder was sent   |
| ScheduledDay        | When appointment was scheduled          |
| AppointmentDay      | Actual appointment date                 |
| No-show             | Whether patient missed appointment      |



### Target variable:

#### No-show

0 = Attended

1 = Did Not Attend


🧹 Data Cleaning (MYSQL)

### Data cleaning and preparation were performed in MySQL.

#### Steps include:

- Removing duplicate records

- Converting date fields

- Creating analytical fields

- Creating a target variable for modeling

- Exporting cleaned dataset

The cleaned dataset was exported for analysis and modelling.

### Python analysis & machine learning

**Python was used for:** 

1. Exploratory Data Analysis (EDA)

2. Feature engineering

3. Model training

4. Model evaluation

**Libraries used:**

- pandas
- numpy
- matplotlib
- seaborn
- scikit-learn
- sqlalchemy

**Exploratory Data Analysis (EDA)**

EDA investigated patterns such as:

1. DNA rate by age

2. DNA rate by neighbourhood

3. Impact of SMS reminders

4. Attendance by day of week

**Example insight:**

Patients who did not receive SMS reminders showed higher no-show rates.


## Predictive modelling

#### Two machine learning models were tested:

### 1️⃣ Logistic regression
- Used as a baseline classification model.

### Results:

| **Metric**   | **Value**     |
|--------------|---------------|
| Accuracy     | ~56%          |
| ROC AUC      | ~0.60         |

Logistic regression struggled due to class imbalance.


### 2️⃣ Random forest
- A tree-based ensemble model was used to improve predictions.

### Results:

| **Metric**        | **Value**     |
|-------------------|---------------|
| Accuracy          | ~69%          |
| Precision (DNA)   | 0.41          |
| Recall (DNA)      | 0.20          |
| ROC AUC           | ~0.60         |

Random Forest performed better overall, but still highlights the challenge of predicting rare events.



### Feature importance

Random forest identified key drivers of missed appointments:

- Age

- Neighbourhood

- SMS reminder status

- Appointment weekday

- Health conditions

These features were used to create a high-risk flag for operational planning.


## 📊 Power BI Dashboard

An interactive Power BI dashboard was built to allow stakeholders to explore insights.

### Dashboard sections

#### 1️⃣ Executive overview
- Total appointments
- Total DNAs
- DNA rate

#### 2️⃣ Operational analysis
- DNAs by weekday
- DNAs by age group
- DNAs by reminder status

#### 3️⃣ Geographic risk
- DNAs by neighbourhood
- High-risk area identification

#### 4️⃣ Predictive insights
- High-risk appointment flag
- Weekly DNA trend


# NHS DNA predictive model dashboard screenshot

![NHS DNA Dashboard Screenshot](https://github.com/CelesNeba/nhs-dna-predictive-model/blob/main/nhs%20dna%20dashboard%20screenshot.PNG)

*Note: The above image is a screenshot of the NHS DNA predictive dashboard, providing insights into appointment attendance and risk analysis.*


## To explore the full project workflow:

To see the **complete step-by-step workflow, code logic, and analysis behind this project**, please navigate to the **project folders located at the top left section of this GitHub repository**.

These folders contain the full technical implementation:

- **`sql/`** – Data cleaning and preparation performed in MySQL  
- **`notebooks/`** – Python notebooks for data exploration, feature engineering, and machine learning modelling  
- **`data/`** – Cleaned and modelling datasets used in the analysis  
- **`powerbi/`** – Power BI dashboard file used for visual analytics  

Together, these components document the **end-to-end analytics pipeline**, from raw healthcare appointment data to predictive modelling and operational insights.



### Key insights

1️⃣ **Age impacts attendance**  
Younger patients had higher no-show rates.

2️⃣ **Geographic variation**  
Some neighbourhoods showed consistently higher DNA rates.

3️⃣ **Reminder effectiveness**  
Patients receiving SMS reminders attended more frequently.

4️⃣ **Weekly patterns**  
DNAs were higher on certain weekdays, suggesting scheduling effects.


### 🚀 Potential impact for healthcare providers

Using these insights, hospitals could:

- Prioritise reminders for high-risk patients

- Overbook high DNA time slots

- Target community outreach in high-risk areas

- Improve appointment scheduling policies

  Even a small reduction in DNAs could save significant healthcare resources.



  ### 🛠 Tools used

| Tool            | Purpose                                   |
|-----------------|-------------------------------------------|
| MySQL         | Data cleaning and preparation             |
| Python        | EDA and machine learning                  |
| Pandas        | Data manipulation                         |
| Scikit-learn  | Predictive modelling                       |
| Power BI      | Dashboard visualisation                     |
| GitHub        | Project version control                     |


# Project structure

nhs-dna-predictive-model

│
├── data

├── images

├── notebooks
│   └── 01_load_and_clean_data.ipynb
│

├── powerbi
│   └── nhs_dna_dashboard.pbix

│
├── sql
│ 
└── data_cleaning.sql

│
└── README.md


### 📌 Future improvements

- Address class imbalance with SMOTE
- Test XGBoost / Gradient Boosting
- Add real-time prediction pipeline
- Deploy dashboard for live hospital monitoring

### My recommendation to decision makers

Based on the analysis, healthcare administrators should consider implementing targeted interventions for patients identified as having a higher risk of missing appointments. For example, prioritising SMS reminders or follow-up calls for high-risk patients, particularly younger individuals and those from neighbourhoods with historically higher DNA rates, could help improve attendance. Additionally, monitoring weekly attendance patterns and adjusting scheduling practices during periods with higher no-show rates may help optimise clinic capacity. 

By combining predictive insights with proactive patient engagement strategies, the NHS can reduce missed appointments, improve resource utilisation, and enhance access to care for patients waiting for appointments.



# 👤 Author

 
**Celestine Neba**  
ETL, Data Engineering & Analytics  
BSc in Computer Science

## About the Author

I am a data engineer and analyst with experience in building fully integrated data solutions, including:

- Data cleaning & transformation
- Database architecture & management
- Machine learning forecasting
- Business intelligence dashboard development

This project demonstrates a complete production-style data workflow from raw data ingestion to executive-level analytics visualisation.
