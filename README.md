This is Group 10

Outline and primary responsibilities:

||Data
|||data_collection.py
|||    - Access the dataset
|||    - Extract and aggregate data
|||data_cleaning.py
|||    - Clean the data (missing values, outliers)
|||    - Filter dataset (cities/metro area limits)
|||data_exploration.py
|||    - Exploratory data analysis to understand distributions, correlations, and patterns
|||    - Visiualize functions for analysis and reporting (create plots)
||Model
|||feature_engineering.py
|||    - New features for the model
|||        - Encoding categorical variables, creating interaction terms, and other transformations
|||    - Handle any specific data preparation steps required for the machine learning models
|||model_training.py
|||    - Split dataset into training and testing sets
|||    - Implementation of machine learning models
|||        - Logistic Regression, Random Forest, Gradient Boosting, XGBoost, and aspects of Hedonic Model Regression
|||model_evaluation.py
|||    - Evaluate model performance using appropriate metrics (RMSE, MAE)
|||    - Generate predictions for 2023 listings and compare
||Prediction
|||future_predictions
|||    - Extend model five years into the future based on accuracy and reliability of the current model
|||    - Consider external factors like economic events/policy changes/COVID-19 could impact predictions
|||results_analysis
|||    - Analyze disparities between predicted and actual prices, with a focus on identifying contributing factors
||main.py
|||    - Main script that orchestrates the execution
|||    - call other functions