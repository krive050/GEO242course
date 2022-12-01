close all; clear all; clc;

% read in the csv file for the table
% created a excel converted to csv file
M=readtable('gcent.csv'); % load in the file

%lets read in the data and set as log10
leng=log10(M.Length1);
mag=M.Mwg1;
slip=log(M.Slip1);
wid=log(M.Width1);
depth=log(M.Depth1);
% convert the magntiude to seismic moment
logmw= log10(10.^((1.5)*(M.Mwg1+6.03)));

%% lets the whole line to evaluate the slope 
A=[leng ones(size(leng))];
d=[logmw];
m=A\d;
x_line=[-1:0.1:2]';
A_line= [x_line ones(size(x_line))];
y_line=A_line*m;

%% lets plot the first half where the data breaks
S=[leng logmw];
S1=sortrows(S);
first=S1(S1(:)<0.9,:);
second = S1((S1(:,1)>0.9),:);

AA= [first(1:end,1) ones(size(first(1:end,1)))];
dd=[first(1:end,2)];
mm=AA\dd;
xx_line=[-1:0.1:0.9]';
AA_line= [xx_line ones(size(xx_line))];
yy_line=AA_line*mm;

%% lets plot the back half

AAA= [second(1:end,1) ones(size(second(1:end,1)))];
ddd=[second(1:end,2)];
mmm=AAA\ddd;
xxx_line=[.5:0.1:2]';
AAA_line= [xxx_line ones(size(xxx_line))];
yyy_line=AAA_line*mmm;
%% now lets plot them all
figure
plot(leng, logmw ,'blacko')
hold on
plot(x_line, y_line, 'r')
hold on
plot(xx_line, yy_line, 'g')
hold on
plot(xxx_line, yyy_line, 'b')
hold on % not yet
legend('Location', 'SouthEast')    % add a location of legend 
title('Log-Log Plot - Length vs. Seismic Moment');
xlabel('Length(km)')
ylabel('Seismic Moment (Nm)')
% add legend
legend('EQ Parameters','Slope=1.4','Slope=1.0','Slope=1.7')

%saveas(gcf,'logMwLength.pdf')



