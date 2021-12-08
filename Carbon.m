%%
%Carbon Emissions trend
clear;
clc;

carbonmat = load ('CarbonEmissions.txt','-ascii'); %loads the CO2 Emissions data


year = rot180(carbonmat(:,1)); %year
fossil = rot180(carbonmat(:,2)); % Fossil CO2 Emissions in tons
change = rot180(carbonmat(:,3)); %CO2 Emisions Change in percent
capita = rot180(carbonmat(:,4)); %CO2 Emisions per capita
pop = rot180(carbonmat(:,5)); %population
popchange = rot180(carbonmat(:,6)); %change in population in percentages

figure(1)

subplot(3,1,1), plot(year,fossil,'-r^') %plots in the top the graph that shows the Fossil CO2 Emissions trend
xlabel('Year');
ylabel('Fossil CO2 Emissions(tons)');
title('Fossil CO2 Emissions Over the Years');

subplot(3,1,2), plot(year, capita,'-g*') %plots in the middle the graph that shows the change of CO2 Emissions per capita trend
xlabel('Year');
ylabel('CO2 Emissions per capita');
title('CO2 Emissions per capita Over the Years');

subplot(3,1,3), plot(fossil,capita,'-ob') %plots in the bottom the graph of how Fossil CO2 Emisssions changes with CO2 Emissions per capita
xlabel('Fossil CO2 Emissions(tons)');
ylabel('CO2 Emissions per capita');
title('Fossil CO2 Emissions to CO2 Emissions per Capita');



%Now to predict based on data inputted by the user
y = input('How many years in the future do you want to see a trend for Carbon Emissions? '); %this allows for many inputted years
vec = zeros(y);
for i = 1:y
    x = input('Please input in a percent of how much you want to see the Carbon Emissions change in the next year: '); %change in percent from the previous year of fossil emissions
    vec(i) = x; %puts all the values in the first column of the matrix
end

newdat = vec;

newdat = newdat/100; %converts the percentage to a decimal


anewset = zeros(y);
anewset(1) = (fossil(end))*(newdat(1)) + fossil(end); %now takes the previous years CO2 Emissions and adds the change of CO2 Emissions according to the inputted data
for i = 2:y
    anewset(i) = anewset(i-1)*(newdat(i)) + anewset(i-1); %puts all of this data into the first column of the matrix
end

Years = zeros(y);
for i = 1:y
    Years(i) = i; %finds the amount of years of data inputted
end

Years = Years(:,1); %Years
PredictTrend = anewset(:,1); %New CO2 Emissions




figure(3)
f = polyfit(Years,PredictTrend,1);
g = polyval(f,Years);
plot(Years,g,'r',Years,PredictTrend,'b*') %gives line of best fit of the data inputted of new CO2 Emissions over time

xlabel('Years After 2016');
ylabel('Fossil CO2 Emissions');
title('Predicted CO2 Emissions After 2016');



%sees if the trend is increasing solely based on slope from polyfit
if sign(f(1))>0
    trend = 'increasing';
elseif sign(f(1))<0
    trend = 'decreasing';
else
    trend = 'constant';
end

fprintf('\n According to the values inputted, the Fossil CO2 Emissions will be on average %s \n by %d tons per year for %d years.',trend,abs(f(1)),y); %describes new trend of CO2 Emissions

%Now describing relationship between CO2 and global mean temperature, ocean
%heat content, and arctic sea ice extent

gtemp = load('globalmeantemperature1880-2020.txt','-ascii'); %loads the Global Mean Temperatures data
ocean = load('oceanheatcontent.txt','-ascii'); %loads the ocean heat content data
arctic = load('arctic_sea_ice_extent.txt'); %loads the arctic ice data

fossilyear = rot90(carbonmat(1:38,1),2);%takes the years 1971 to 2016
fossile = rot90(carbonmat(1:38,2),2);%fossil emissions

gtempyear = gtemp(100:137,1); %takes the years 1971 to 2016
gtempdeg = gtemp(:,2); %global mean temperatures
tempsmooth = datasmoothing(gtempdeg); %smooths out the data
tempsmooth = tempsmooth(100:137,1); %takes the global mean temperatures from years 1971 to 2016

oceanyear = ocean(23:60,1);%takes the years 1971 to 2016
oceanheat = ocean(23:60,2);%ocean heat content
oceansmooth = datasmoothing(oceanheat);

arcticyear = arctic(1:38,1);%takes the years 1971 to 2016
arcticice = arctic(1:38,3);%arctic ice content
arcticsmooth = datasmoothing(arcticice);

figure(4)
relation(fossile,tempsmooth);
xlabel('Fossil CO2 Emissions(tons)');
ylabel('Global Average Temperatures');
title('Fossil CO2 Emissions Affecting Global Temperatures Over Time');
a1 = polyfit(fossile,tempsmooth,1); 
b1 = polyval(a1,fossile);
%finds the linear relationship between global temperatures and fossil
%emissions


figure(5)
relation(fossile,oceansmooth);
xlabel('Fossil CO2 Emissions(tons)');
ylabel('Ocean Heat Content');
title('Fossil CO2 Emissions Affecting Ocean Heat Content Over Time');
a2 = polyfit(fossile,oceansmooth,1); 
b2 = polyval(a2,fossile);
%finds the linear relationship between ocean heat content and fossil
%emissions


figure(6)
relation(fossile,arcticsmooth);
xlabel('Fossil CO2 Emissions(tons)');
ylabel('Arctic Sea Ice Content');
title('Fossil CO2 Emissions Affecting Arctic Sea Ice Content Over Time');
a3 = polyfit(fossile,arcticsmooth,1); 
b3 = polyval(a3,fossile);
%finds the linear relationship between Arctic Sea Ice Content and fossil
%emissions


j = PredictTrend(end);
GlobalTemp = 3.4904*10^-11*j - 0.4495;
OceanHeat = 1.2597*10^-9*j - 25.4468;
Arctic = -1.724*10^-10 *j +10.6839;

%Fossil CO2 Emissions last term j = PredictTrend(end)
%Global Mean Temperatures last term  = 3.9550*10^-11*j - 0.588
%Ocean Heat Content last term =  1.2597*10^-9*j - 25.4468
%Arctic Ice last term = -1.724*10^-10 *j +10.6839

fprintf('\n Based on this trend, and since Emissions and the Global Mean Temperatures have a positive linear relationship,\n the Global Temperatures will be at %d by the year %d.',GlobalTemp,y+2016);
fprintf('\n Based on this trend, and since Emissions and the Ocean Heat Content have a positive linear relationship,\n the Ocean Heat Content will be at %d by the year %d.',OceanHeat,y+2016);
fprintf('\n Based on this trend, and since Emissions and the Arctic Ice Content have a negative linear relationship,\n the Arctic Ice Extent will be at %d  by the year %d.',Arctic,y+2016);




function relation(fossil,smooth)
plot(fossil,smooth,'m') %plots the graph the shows how global mean temperatures are affected by fossil CO2 Emissions
hold on
%plots the line of best fit for the above graph
a = polyfit(fossil,smooth,1); 
b = polyval(a,fossil);
plot(fossil,b,'LineWidth',3)
hold off

end


function smootheddata = datasmoothing(mydata) %smooths the data graph by averaging three points and plotting that point
    newdata = zeros(size(mydata));
    [r,c] = size(mydata);
    newdata(1,1) = mydata(1,1);
    newdata(r,1) = mydata(r,1);
    for i = 2:1:(r-1)
        newdata(i,1) = (mydata(i-1,1) + mydata(i,1) + mydata(i+1,1)) / 3;
    end
    smootheddata = newdata;
end


function matri = rot180(vector) %rotates a matrix 180 degrees because the data was flipped

[r, c] = size(vector);
matri = zeros(r,c);
i = 1;
while r>0
   matri(i) = vector(r);
   i = i+1;
   r= r-1;
end
end

    
    
