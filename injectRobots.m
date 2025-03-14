%Jose Guerrero-Sastre
%March, 2025.
% Related Paper: A response-threshold method for early cancer diagnosis and monitoring via swarms of nanorobots

NFCRoute=29.0;
ro = NFCRoute/96.0; %Ro value obtained from results (probability of following a routs that gets to FC)

M = binornd(Mmax,ro);
qiTable=[2.0, 6.0, 2.0, 4.0 , 4.0, 1.0, 2.0 , 2.0, 6.0];
qiTable = qiTable./NFCRoute;
qdistribution=cumsum(qiTable);
%PossAvg obtined from the previous step
%PossAvg=[22.0675, 22.8383, 63.869, 51.8692, 61.1231, 44.9863, 32.9865, 42.2404, 23.6923];
activationLevel=[];

for i=1:M
%Point 3 Results.pdf document
u1=rand; %Step 1: Genereate an uniform random

%Step 2: Generate a random value from the ditribution of qiTable (get j)
interNumT=find(qdistribution>=u1);
interNum=interNumT(1); %This is the j value

%u2=rand; %Step 3: Generate a random uniform
%Step 4: Generate a poasson rv
phiValueK=PossAvg(interNum);
activationLevel = [activationLevel, poissrnd(phiValueK)];
end