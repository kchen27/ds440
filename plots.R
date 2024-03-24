library(ggplot2)
library(cowplot) # for arranging plots

# Residuals vs Fitted
plot_residuals_fitted <- function(model) {
  residuals <- resid(model)
  fitted <- fitted(model)
  ggplot() +
    geom_point(aes(x = fitted, y = residuals), alpha = 0.5) +
    geom_hline(yintercept = 0, linetype = "dashed", color = "red") +
    labs(title = "Residuals vs Fitted", x = "Fitted Values", y = "Residuals") +
    theme_minimal()
}

# Normal Q-Q plot
plot_qq <- function(model) {
  ggplot() +
    geom_qq(aes(sample = resid(model))) +
    geom_qq_line(aes(sample = resid(model))) +
    labs(title = "Normal Q-Q", x = "Theoretical Quantiles", y = "Standardized Residuals") +
    theme_minimal()
}

# Scale-Location (Spread vs Level)
plot_scale_location <- function(model) {
  residuals <- resid(model)
  fitted <- fitted(model)
  ggplot() +
    geom_point(aes(x = fitted, y = sqrt(abs(residuals))), alpha = 0.5) +
    geom_smooth(aes(x = fitted, y = sqrt(abs(residuals))), se = FALSE) +
    labs(title = "Scale-Location", x = "Fitted Values", y = "Sqrt(|Residuals|)") +
    theme_minimal()
}

# Residuals vs Leverage
plot_leverage <- function(model) {
  ggplot() +
    geom_point(aes(x = hatvalues(model), y = resid(model)), alpha = 0.5) +
    labs(title = "Residuals vs Leverage", x = "Leverage", y = "Residuals") +
    theme_minimal()
}

# Cook's distance
plot_cooks_distance <- function(model) {
  cooks_dist <- cooks.distance(model)
  ggplot() +
    geom_bar(aes(x = seq_along(cooks_dist), y = cooks_dist), stat = "identity", alpha = 0.5) +
    labs(title = "Cook's Distance", x = "Observation", y = "Cook's Distance") +
    theme_minimal()
}

# Combine all plots into one figure
combined_plots <- function(model) {
  plot1 <- plot_residuals_fitted(model)
  plot2 <- plot_qq(model)
  plot3 <- plot_scale_location(model)
  plot4 <- plot_leverage(model)
  plot_grid(plot1, plot2, plot3, plot4, labels = "AUTO")
}

# Plot for linear model
combined_plots(linear_model)

# Since dynamic models are a bit different, you might want to plot their residuals over time
plot_dynamic_resid <- function(model) {
  residuals <- resid(model)
  time <- time(residuals)
  ggplot() +
    geom_line(aes(x = time, y = residuals), alpha = 0.5) +
    geom_hline(yintercept = 0, linetype = "dashed", color = "red") +
    labs(title = "Residuals over Time", x = "Time", y = "Residuals") +
    theme_minimal()
}

# Plot for dynamic model
plot_dynamic_resid(dynamic_model)
