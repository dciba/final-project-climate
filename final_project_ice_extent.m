clear;clc;close all;

%%Arctic Ice Extent

%Load Data
load arctic_sea_ice_extent.txt
year = arctic_sea_ice_extent(:,1);
extent = arctic_sea_ice_extent(:,3);

%Linear Regression
years = year - 1979;
m = (43*sum(years.*extent)-(sum(years)*sum(extent)))/(43*sum(years.^2)-(sum(years))^2);
b = (sum(extent)-m*sum(years))/43;
regression = m * years + b;

%Figure
figure()
subplot(2,1,1)
plot(year,extent)
xlabel('Year')
ylabel('Millions of Square Kilometers')
title('Ice Extent')

subplot(2,1,2)
plot(years,regression)
hold on
subplot(2,1,2)
scatter(years,extent)
xlabel('Years Since 1979')
ylabel('Millions of Square Kilometers')
title('Linear Regression')

%Prediction
yearinput = input('Enter Year to Predict Ice Extent: ');
xval = yearinput - 1979;
prediction = m * xval + b;
disp(['There will be an estimated amount of ',num2str(prediction),...
    ' Million Kilometers of Ice in the Arctic in ',num2str(yearinput),...
    ' at the current rate of decrease.'])
