%loads data into MATLAB, stores in variable "oceandata"
oceandata= load('oceanheatcontent1957-2018.txt');

year= oceandata(:,1);       %takes first column and stores as years
oceanheat= oceandata(:,2);  %takes second column and stores as heat data

%plot of initial data from NASA
subplot(2,2,1);
plot(year,oceanheat,'-.b');
xlabel('year');
ylabel('ocean heat content (zettajoules)');
title('Ocean Heat Content from 1957-2018');

%prompts user to input a value of years into the future for code to use
disp('When prompted, please input a number between 0-150 for best results')
future= input('For how many years after 2018 would you like to predict the change in Ocean Heat Content? ');

%if statements ensure that only numbers in the range of 0-150 are accepted
while future<0     %if statement for numbers less than 0
    disp('Please enter a number between 0-150!')
    future=input('For how many years after 2018 would you like to predict? ');
end

while future>150   %if statement for numbers greater than 150
    disp('Please enter a number between 0-150!')
    future=input('For how many years after 2018 would you like to predict? ');
end

%the actual year into the future being predicted
futureyear= future+2018;

%using inputed number of future years to create new array of year values
newyears= [1957:futureyear];

%finding the linear best fit line
cbestfitline= polyfit(year,oceanheat,1);
linebestfit= polyval(cbestfitline,newyears);

%subplot of linear best fit
subplot(2,2,2);
plot(newyears,linebestfit,'-.r');
xlabel('year');
ylabel('ocean heat content (zettajoules)');
title(['Linear Line of Best Fit for Ocean Heat Content from 1957-',num2str(futureyear)]);

%finding polynomial best fit line (degree of 2)
cbestfitpoly2= polyfit(year,oceanheat,2);
polybestfit2= polyval(cbestfitpoly2,newyears);

%subplot of polynomial best fit (degree of 2)
subplot(2,2,3);
plot(newyears,polybestfit2,'-.g');
xlabel('year');
ylabel('ocean heat content (zettajoules)');
title(['Quadratic Line of Best Fit for Ocean Heat Content from 1957-',num2str(futureyear)]);

%Actual number prediction for the inputed amount of years into the future
linearHeat= max(linebestfit);
poly2Heat= max(polybestfit2);

%displaying the numerical results for the inputed amount of years into
%the future
fprintf('Following a linear best fit, there will be a change of %d zettajoules in ocean heat content %d years into the future (%d).\n', linearHeat, future, futureyear);   
fprintf('Following a polynomial best fit of degree 2, there will be a change of %d zettajoules in ocean heat content %d years into the future (%d).\n', poly2Heat, future, futureyear);
