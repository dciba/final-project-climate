%%
%Carbon Emissions trend
clear;
clc;

carbonmat = load ('CarbonEmissions.txt','-ascii');
gtemp = load('globalmeantemperature1880-2020.txt','-ascii');
gtempyear = gtemp(92:137,1);
gtempdeg = gtemp(:,2);
tempsmooth = datasmoothing(gtempdeg);
tempsmooth = tempsmooth(92:137,1);


year = rot180(carbonmat(:,1)); %year
fossil = rot180(carbonmat(:,2)); % Fossil CO2 Emissions in tons
change = rot180(carbonmat(:,3)); %CO2 Emisions Change in percent
capita = rot180(carbonmat(:,4)); %CO2 Emisions per capita
pop = rot180(carbonmat(:,5)); %population
popchange = rot180(carbonmat(:,6)); %change in population in percentages

figure(1)

subplot(3,1,1), plot(year,fossil,'-r^')
xlabel('Year');
ylabel('Fossil CO2 Emissions(tons)');
title('Fossil CO2 Emissions Over the Years');

subplot(3,1,2), plot(year, capita,'-g*')
xlabel('Year');
ylabel('CO2 Emissions per capita');
title('CO2 Emissions per capita Over the Years');

subplot(3,1,3), plot(fossil,capita,'-ob')
xlabel('Fossil CO2 Emissions(tons)');
ylabel('CO2 Emissions per capita');
title('Fossil CO2 Emissions to CO2 Emissions per Capita');

figure(2)

plot(fossil,tempsmooth,'m')
xlabel('Fossil CO2 Emissions(tons)');
ylabel('Global Average Temperatures');
title('Fossil CO2 Emissions Affecting Global Temperatures Over Time');
hold on
a = polyfit(fossil,tempsmooth,1);
b = polyval(a,fossil);
plot(fossil,b,'LineWidth',3)
hold off
%GlobalTemp = 3.9550*10^-11*Fossil - 0.588

%do a question asking by what increase or decrease in the next decade
y = input('How many years in the future do you want to see a trend for Carbon Emissions? ');
vec = zeros(y);
for i = 1:y
    x = input('Please input in a percent of how much you want to see the Carbon Emissions change in the next year: ');
    vec(i) = x;
end

newdat = vec;

newdat = newdat/100;


anewset = zeros(y);
anewset(1) = (fossil(1))*(newdat(1)) + fossil(1);
for i = 2:y
    anewset(i) = anewset(i-1)*(newdat(i)) + anewset(i-1);
end

Years = zeros(y);
for i = 1:y
    Years(i) = i;
end

Years = Years(:,1);
PredictTrend = anewset(:,1);


figure(3)
f = polyfit(Years,PredictTrend,1);
g = polyval(f,Years);
plot(Years,g,'r',Years,PredictTrend,'b*')

xlabel('Years After 2016');
ylabel('Fossil CO2 Emissions');




if sign(f(1))>0
    trend = 'increasing';
elseif sign(f(1))<0
    trend = 'decreasing';
else
    trend = 'constant';
end

fprintf('\n According to the values inputted, the Fossil CO2 Emissions will be on average %s \n by %d tons in %d years.',trend,abs(f(1)),y);
z = a(1)*f(1)-0.588;
fprintf('\n Based on this trend, and since Emissions and the Global Mean Temperatures have a linear relationship,\n the Global Temperatures will be at %d by the year %d.',z,y+2016);








function matri = rot180(vector)

[r, c] = size(vector);
matri = zeros(r,c);
i = 1;
while r>0
   matri(i) = vector(r);
   i = i+1;
   r= r-1;
end
end

function smootheddata = datasmoothing(mydata)
    newdata = zeros(size(mydata));
    newdata(1,1) = mydata(1,1);
    newdata(141,1) = mydata(141,1);
    for i = 2:1:140
        newdata(i,1) = (mydata(i-1,1) + mydata(i,1) + mydata(i+1,1)) / 3;
    end
    smootheddata = newdata;
end
    
