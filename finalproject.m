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