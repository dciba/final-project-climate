%Analyzing temperature data over the past 140 years to find trends and
%extrapolate into the future.

tempdata = load("globalmeantemperature1880-2020.txt");

%first plot of unaltered data
subplot(2,2,1);
x1 = tempdata(:,1);
y1 = tempdata(:,2);
plot(x1,y1);

%smoothing data
y2 = datasmoothing(y1);

subplot (2,2,2);
plot(x1,y2);




function smootheddata = datasmoothing(mydata)
    newdata = zeros(size(mydata));
    newdata(1,1) = mydata(1,1);
    newdata(141,1) = mydata(141,1);
    for i = 2:1:140
        newdata(i,1) = (mydata(i-1,1) + mydata(i,1) + mydata(i+1,1)) / 3;
    end
    smootheddata = newdata;
end



%%
%Carbon Emissions trend

carbonmat = load ('CarbonEmissions.txt','-ascii');

year = carbonmat(:,1); %year
fossil = carbonmat(:,2); % Fossil CO2 Emissions in tons
change = carbonmat(:,3); %CO2 Emisions Change in percent
capita = carbonmat(:,4); %CO2 Emisions per capita
pop = carbonmat(:,5); %population
popchange = carbonmat(:,6); %change in population in percentages

subplot(3,1,1), plot(year,fossil,'r')
subplot(3,1,2), plot(year, capita,'g')
subplot(3,1,3), plot(fossil,capita,'b')




meantempdat = load("globalmeantemperature1880-2020.txt");

temp = meantempdat(92:137,2);

figure(2)
plot(fossil,temp,'c');



