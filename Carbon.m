%%
%Carbon Emissions trend

carbonmat = load ('CarbonEmissions.txt','-ascii');

year = carbonmat(:,1); %year
fossil = carbonmat(:,2); % Fossil CO2 Emissions in tons
change = carbonmat(:,3); %CO2 Emisions Change in percent
capita = carbonmat(:,4); %CO2 Emisions per capita
pop = carbonmat(:,5); %population
popchange = carbonmat(:,6); %change in population in percentages

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


figure(2)
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

fprintf('\n According to the values inputted, the Fossil CO2 Emissions will be on average %s \n by a value of %d in %d years.',trend,abs(f(1)),y);

