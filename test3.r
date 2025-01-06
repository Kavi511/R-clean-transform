# Use plot_ly for the Payment Distribution
if (nrow(payment_distribution) > 0) {
  plot3 <- plot_ly(
    payment_distribution,
    labels = ~Payment,
    values = ~Total_Sales,
    type = 'pie',
    textinfo = 'label+percent',
    insidetextorientation = 'radial'
  ) %>%
    layout(title = "Sales Distribution by Payment Method")
  
  print(plot3)
} else {
  print("No data available for payment distribution.")
}
