from data import collect_data, clean_data, explore_data
from model import prepare_features, train_models, evaluate_models
from prediction import predict_future_prices, analyze_results
import pandas as pd

def main():
    print("Starting the Airbnb Pricing Prediction Project...")

    # Step 1: Data Collection, Cleaning, and Exploration
    print("Processing data...")
    combined_data = collect_data()  
    cleaned_data = clean_data(combined_data)
    explore_data(cleaned_data)

    # Step 2: Feature Engineering and Model Preparation
    print("Preparing features for modeling...")
    X_preprocessed, y, preprocessor = prepare_features(cleaned_data)

    # Splitting data into training and testing sets is encapsulated within model.py can be added here to control the split before training

    # Step 3: Model Training and Evaluation
    print("Training and evaluating models...")
    models = train_models(X_preprocessed, y)
    evaluate_models(models, X_preprocessed, y)  # Adjust as needed to use a separate test set

    # Step 4: Future Predictions and Analysis
    # Assuming future data is prepared following the same structure as the training data
    print("Loading future data for predictions...")
    future_data = pd.read_csv('path/to/your/future_data.csv')  # Update the path to your future data
    
    print("Making future predictions...")
    predictions_df = predict_future_prices(models, preprocessor, future_data)
    
    print("Analyzing future predictions results...")
    analyze_results(predictions_df)

    print("Project completed successfully.")

if __name__ == "__main__":
    main()
