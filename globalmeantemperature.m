%% Global Mean Temperature Data Analysis
clearvars;clc;
%Analyzing temperature data over the past 140 years to find trends and
%extrapolate into the future.

tempdata = load("globalmeantemperature1880-2020.txt");

%Changing the size and position of the figure
f = figure;
f.Position = [930 50 600 700];
sgtitle("Change in Average Temperature over Time");
%% Subplot 1: first plot of unaltered data
subplot(2,2,1);

year = tempdata(:,1);
temp = tempdata(:,2);
plot(year,temp);
axis([1880 2050 -0.6 1.5]);
ylabel("Change in Average Temperature");
xlabel("Year");
title("Raw Data");

%% Subplot 2: plot of smoothed data
subplot(2,2,2);

%calling datasmoothing function at the bottom
tempsmooth = datasmoothing(temp);

plot(year,tempsmooth);
axis([1880 2050 -0.6 1.5]);
ylabel("Change in Average Temperature");
xlabel("Year");
title("Smoothed Data");

%% Subplot 3: line of best fit

%ask for how many years into the future:
futureyears = input("How many years in the future do you want to predict? (0-100) ");

%cleaning input to be <100 and positive integer
if futureyears < 0
    futureyears = futureyears*-1;
end
if futureyears > 100
    futureyears = 100;
end
futureyears = round(futureyears);

%Telling the user what their input was interpreted as
disp("Predicting up to " + futureyears + " years into the future.");

maxyear = 2020+futureyears;

subplot(2,2,3);

%creating new time vector to account for additional years
yearextended = [1880:1:maxyear]';

%line of best fit (degree one polynomial) 
%note: calculated using original data, not smoothed data
slope = polyfit(year,temp,1);
tempFit1 = polyval(slope,yearextended);


%plotting line of best fit onto smoothed data
hold on;
plot(year,tempsmooth);
plot(yearextended,tempFit1);
ylabel("Change in Average Temperature");
xlabel("Year");
title("Line of Best Fit with Smoothed Data");

%from now, axis ranges must be changed to reflect new maximums
maxtemp1 = max([max(tempFit1) max(temp)]);
axis([1880 maxyear -0.6 maxtemp1]);

%% Subplot 4: parabola of best fit
subplot(2,2,4);

%parabola of best fit (degree two polynomial)
quadratic = polyfit(year,temp,2);
tempFit2 = polyval(quadratic,yearextended);

%plotting line of best fit onto smoothed data
hold on;
plot(year,tempsmooth);
plot(yearextended,tempFit2);
ylabel("Change in Average Temperature");
xlabel("Year");
title("Parabola of Best Fit with Smoothed Data");

%from now, axis ranges must be changed to reflect new maximums
maxtemp2 = max([max(tempFit2) max(temp)]);
axis([1880 maxyear -0.6 maxtemp2]);


%% Displaying Numerical Results
lineMax = max(tempFit1);
quadMax = max(tempFit2);

disp("The predicted change in temperature in the year " + ...
    (2020+futureyears) + " using a linear model is " + lineMax + ".");

disp("The predicted change in temperature in the year " + ...
    (2020+futureyears) + " using a parabolic model is " + quadMax + ".");



function smootheddata = datasmoothing(mydata)
    newdata = zeros(size(mydata));
    newdata(1,1) = mydata(1,1);
    newdata(141,1) = mydata(141,1);
    for i = 2:1:140
        newdata(i,1) = (mydata(i-1,1) + mydata(i,1) + mydata(i+1,1)) / 3;
    end
    smootheddata = newdata;
end



