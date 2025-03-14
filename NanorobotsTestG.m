%Jose Guerrero-Sastre
%March, 2025.
% Related Paper: A response-threshold method for early cancer diagnosis and monitoring via swarms of nanorobots
%Execution of the FSM from the parameters of the Phi Table
clear;
load('testParams');
Mmax = 100; %Num of nanorobots

TH1=0.7; % It must arrive 70% of the robots
TH2=40.0;
TH3=60.0;
MaxSimul = 100;



nExperiments=length(testsTH2);
finalResults=[];
TH1V=[0,0.3,0.5];
muV=[2,4,5,7];


%* new hd
testsTH2=5:1:20;
testsTH2=[testsTH2;testsTH2];
%* end new hd


nExperiments=length(testsTH2);
%******************************
for mui=muV
for TH1=TH1V
for iExp=1:nExperiments
  PossAvg = Phimutable(2:10,mui);
  mu = Phimutable(1,mui);
  
  TH2=testsTH2(1,iExp);
  TH3=testsTH2(2,iExp);
  
numCancer=0;
numNoCancer = 0;
numReinject = 0;
nIncert = 0;
for i=1:MaxSimul 
%Start a single simulation
Marrived=0;
cState=0;
totalActivation = 0;
keepProcess=1;

while (keepProcess)
switch cState %States of the FSM
    case 0
        injectRobots;
        Marrived=M+Marrived;
        numReinject = numReinject + 1;
        S1=Marrived/Mmax;
        P01=S1^2/(S1^2+TH1^2);
        totalActivation=totalActivation + sum(activationLevel);
        r1=rand;
       if r1 <= P01
           cState=1;
       end
    case 1
        S2=totalActivation/Mmax;
        if (S2<=TH2)
            Marrived=0;
            totalActivation = 0;
            cState=2;
        end
        if ((S2 > TH2) && (S2<=TH3))
            nIncert = nIncert + 1;

            
            cState=0;
        end
        if (S2>TH3)
            cState=3;
        end     
    case 2
        %disp('The Patient is OK');
        keepProcess=0;
        numNoCancer=numNoCancer+1;
    case 3
        %disp('Possible cancer has been detected, treatment must be started.');
        keepProcess=0;
        numCancer=numCancer+1;
end
end
end
finalResults=[finalResults; mu, TH1,TH2,TH3, numReinject,nIncert,numCancer,numNoCancer];
end
save('finalRes');
end
end



    