a = load('globalmeantemperature1880-2020.txt','-ascii');
b = load('CarbonEmissions.txt','-ascii');
c = load('arctic_sea_ice_extent.txt','-ascii');
d = load('oceanheatcontent.txt','-ascii');


d(:,1) = floor(d(:,1));
year = [1979:2016];
atemp = a(100:137,2);
bemissions = rot90(b(1:38,2),2);
cice = c(1:38,3);
dheat = d(23:60,2);

figure(1)
subplot(3,1,1), plot(bemissions,atemp,'r');
xlabel('CO2 Emissions');
ylabel('Global Mean Temperature');

subplot(3,1,2), plot(bemissions,cice,'b');
xlabel('CO2 Emissions');
ylabel('Arctic Sea Ice Extent');

subplot(3,1,3), plot(bemissions,dheat,'g');
xlabel('CO2 Emissions');
ylabel('Ocean Heat Content');

figure(2)

subplot(4,1,1), plot(year,atemp,'b');
xlabel('Year');
ylabel('Global Mean Temperature');

subplot(4,1,2), plot(year,bemissions,'r');
xlabel('Year');
ylabel('CO2 Emissions');

subplot(4,1,3), plot(year,cice,'g');
xlabel('Year');
ylabel('Arctic Sea Ice Extent');

subplot(4,1,4), plot(year,dheat,'m');
xlabel('Year');
ylabel('Ocean Heat Content');
