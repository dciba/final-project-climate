%loads data into MATLAB, stores in variable "oceandata"
oceandata= load('oceanheatcontent1957-2018.txt');

year= oceandata(:,1);       %takes first column and stores as years
oceanheat= oceandata(:,2);  %takes second column and stores as heat data

%plot of initial data from NASA
subplot(2,2,1);
plot(year,oceanheat,'-.b');
xlabel('year');
ylabel('ocean heat content (zettajoules)');
title('Ocean Heat Content from 1992-2017');

%prompts user to input a value of years into the future for code to use
disp('When prompted, please input a number between 0-150 for best results')
future= input('For how many years after 2017 would you like to predict Ocean Heat Content?');

%if statements ensure that only numbers in the range of 0-150 are accepted
if future<0     %if statement for numbers less than 0
    disp('Please enter a number between 0-150!')
    future=input('For how many years after 2017 would you like to predict?');
end

if future>150   %if statement for numbers greater than 150
    disp('Please enter a number between 0-150!')
    future=input('For how many years after 2017 would you like to predict?');
end

%finding the linear best fit line
cbestfitline= polyfit(year,oceanheat,1);
linebestfit= polyval(cbestfitline,future);

%subplot of linear best fit
subplot(2,2,2);
plot(future,linebestfit,'-.r');
xlabel('year');
ylabel('ocean heat content (zettajoules)');
title('Linear Line of Best Fit for Ocean Heat Content from 1992-(year input)');

%finding polynomial best fit line (degree of 5)
cbestfitpoly5= polyfit(year,oceanheat,5);
polybestfit5= polyval(cbestfitpoly5,future);

%subplot of polynomial best fit (degree of 5)
subplot(2,2,3);
plot(future,polybestfit5,'-.g');
xlabel('year');
ylabel('ocean heat content (zettajoules)');
title('Polynomial Line of Best Fit (Degree of 5) from 1992-(year input)');

%finding polynomial best fit line (degree of 10)
cbestfitpoly10= polyfit(year,oceanheat,10);
polybestfit10= polyval(cbestfitpoly10,future);

%subplot of polynomial best fit (degree of 10)
subplot(2,2,4);
plot(future,polybestfit10,'-.m');
xlabel('year');
ylabel('ocean heat content (zettajoules)');
title('Polynomial Line of Best Fit (Degree of 10) from 1992-(year input)');

%Actual number prediction for the inputed amount of years into the future
linearHeat= max(linebestfit);
poly5Heat= max(polybestfit5);
poly10Heat= max(polybestfit10);

%displaying the numerical results for the inputed amount of years into
%the future
fprintf('Following a linear best fit, there will be a change of %d zettajoules in ocean heat content.\n', linearHeat);   
fprintf('Following a polynomial best fit of degree 5, there will be a change of %d zettajoules in ocean heat content.\n', poly5Heat);
fprintf('Following a polynomial best fit of degree 10, there will be a change of %d zettajoules in ocean heat content.\n', poly10Heat);
