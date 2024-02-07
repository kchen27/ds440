import pandas as pd
from sklearn.model_selection import train_test_split, cross_val_score
from sklearn.preprocessing import OneHotEncoder, StandardScaler
from sklearn.compose import ColumnTransformer
from sklearn.pipeline import Pipeline
from sklearn.ensemble import RandomForestRegressor, GradientBoostingRegressor
from sklearn.metrics import mean_squared_error, mean_absolute_error
import xgboost as xgb

def prepare_features(df):
    """
    Prepares the features for modeling, including encoding categorical variables and scaling numerical features.
    
    :param df: A pandas DataFrame
    :return: A DataFrame with processed features and target variable
    """
    # Select features and target
    X = df.drop('price', axis=1)
    y = df['price']
    
    # Define numerical and categorical columns
    numerical_cols = X.select_dtypes(include=['int64', 'float64']).columns
    categorical_cols = X.select_dtypes(include=['object', 'category']).columns
    
    # Create preprocessing pipelines
    numerical_pipeline = Pipeline([
        ('scaler', StandardScaler())
    ])
    
    categorical_pipeline = Pipeline([
        ('encoder', OneHotEncoder(handle_unknown='ignore'))
    ])
    
    preprocessor = ColumnTransformer(
        transformers=[
            ('num', numerical_pipeline, numerical_cols),
            ('cat', categorical_pipeline, categorical_cols)
        ]
    )
    
    # Preprocessing
    X_preprocessed = preprocessor.fit_transform(X)
    
    return X_preprocessed, y, preprocessor

def train_models(X, y):
    """
    Trains multiple machine learning models and returns them.
    
    :param X: Processed feature matrix
    :param y: Target variable
    :return: A dictionary of trained models
    """
    models = {
        'RandomForest': RandomForestRegressor(n_estimators=100),
        'GradientBoosting': GradientBoostingRegressor(n_estimators=100),
        'XGBoost': xgb.XGBRegressor(objective ='reg:squarederror', n_estimators=100)
    }
    
    for name, model in models.items():
        model.fit(X, y)
        print(f"{name} model trained.")
    
    return models

def evaluate_models(models, X, y):
    """
    Evaluates the models using cross-validation and prints the performance metrics.
    
    :param models: A dictionary of trained model instances
    :param X: Processed feature matrix
    :param y: Target variable
    """
    for name, model in models.items():
        scores = cross_val_score(model, X, y, cv=5, scoring='neg_mean_squared_error')
        rmse_scores = (-scores)**0.5
        print(f"{name} RMSE: {rmse_scores.mean():.2f} (+/- {rmse_scores.std() * 2:.2f})")

# Example usage
if __name__ == '__main__':
    # Load your cleaned data
    df = pd.read_csv('cleaned_data.csv')  # Placeholder for the path to your cleaned dataset
    
    print("Preparing features...")
    X_preprocessed, y, preprocessor = prepare_features(df)
    
    # Splitting the data into training and testing sets
    X_train, X_test, y_train, y_test = train_test_split(X_preprocessed, y, test_size=0.2, random_state=42)
    
    print("Training models...")
    models = train_models(X_train, y_train)
    
    print("Evaluating models...")
    evaluate_models(models, X_test, y_test)
