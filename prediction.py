import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
from sklearn.metrics import mean_absolute_error, mean_squared_error

def predict_future_prices(models, preprocessor, future_data):
    """
    Uses trained models to predict future prices based on input data.
    
    :param models: A dictionary of trained model instances
    :param preprocessor: The preprocessing pipeline used for the initial model training
    :param future_data: A DataFrame containing data for which to predict future prices
    :return: A DataFrame with predictions
    """
    predictions = {}
    X_future_preprocessed = preprocessor.transform(future_data.drop('price', axis=1))
    
    for name, model in models.items():
        predictions[name] = model.predict(X_future_preprocessed)
    
    predictions_df = pd.DataFrame(predictions)
    predictions_df['Actual'] = future_data['price']
    return predictions_df

def analyze_results(predictions_df):
    """
    Analyzes and visualizes the results of future price predictions.
    
    :param predictions_df: A DataFrame containing actual and predicted prices
    """
    for model in predictions_df.columns[:-1]:  # Exclude the actual prices column
        mae = mean_absolute_error(predictions_df['Actual'], predictions_df[model])
        rmse = mean_squared_error(predictions_df['Actual'], predictions_df[model], squared=False)
        print(f"{model} - MAE: {mae:.2f}, RMSE: {rmse:.2f}")
        
        plt.figure(figsize=(10, 6))
        plt.scatter(predictions_df['Actual'], predictions_df[model], alpha=0.5)
        plt.plot([predictions_df['Actual'].min(), predictions_df['Actual'].max()], [predictions_df['Actual'].min(), predictions_df['Actual'].max()], 'k--', lw=4)
        plt.xlabel('Actual Price')
        plt.ylabel('Predicted Price')
        plt.title(f'{model} Predicted vs Actual Prices')
        plt.show()

# Example usage
if __name__ == '__main__':
    # Assuming models and preprocessor are loaded from previous steps
    models = {}  # Placeholder for trained model instances
    preprocessor = None  # Placeholder for the preprocessing pipeline
    future_data = pd.read_csv('future_data.csv')  # Placeholder for future dataset
    
    print("Predicting future prices...")
    predictions_df = predict_future_prices(models, preprocessor, future_data)
    
    print("Analyzing prediction results...")
    analyze_results(predictions_df)
