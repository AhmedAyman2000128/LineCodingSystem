%%%%Initializations%%%%
noOfBits=10000; %Determined in project
pointsInBit=10; %Extend each bit to 10 points
bitRate=100; %assumed bitrate
Tb=1/bitRate; %bit duration
Tpoint=Tb/pointsInBit; %duration for each point in bit
totalTime=Tb*noOfBits; %total time of whole signal
N=pointsInBit*noOfBits;%total no of points after extension
streamOfBits=randi([0 1],1,noOfBits); %random stream of bits
t=0:Tpoint:((N-1)*Tpoint); %time vector
fs=1/Tpoint;
df=1/totalTime;
f=-(0.5*fs):df:(0.5*fs-df); %Frequency vector

%Extend bit in signal to 10 points for each
j=1;
for i=1:N
  signalInBits(i)=streamOfBits(j);
  if(rem(i,pointsInBit)==0)
    j=j+1;
  end
end
%%%%%%%%%%%%%%%%%%unipolar Non return to zero%%%%%%%%%%%%%%%%%%

%line encoding%
errorCheck1=streamOfBits*1.2; %used to check error in case of noise at reciever
%replace 1 by 1.2 and 0 by 0
for i=1:N
  if(signalInBits(i)>0)
    uniNRZ(i)=1.2;
  else
    uniNRZ(i)=0;
  end
end

%eye diagram%
figure
for i=6:2*pointsInBit:10000-14 %200000/40
  plot(t(1:21),uniNRZ(i:i+20))
  hold on
end
title('EyeDiagram OF unipolar NRZ');

%signal in time%
figure
plot(t,uniNRZ)
xlabel('Time');
ylabel('Amplitude');
title('Unipolar NRZ');


%signal in frequency%
signalInFreq=fftshift(fft(uniNRZ)).^2/N;
figure
plot(f,abs(signalInFreq))
xlabel('frequency ');
ylabel('power');
title('power Spectral domain of Unipolar NRZ');





%%%%%%%%%%%%%%%%%%polar Non return to zero%%%%%%%%%%%%%%%%%%
%used to check error in case of noise at reciever
for i=1:length(streamOfBits)
  if(streamOfBits(i)==1)
    errorCheck2(i)=1.2;
  else
    errorCheck2(i)=-1.2;
  end
end
%line encoding%
%replace 1 by 1.2 and 0 by -1.2
for i=1:N
  if(signalInBits(i)>0)
    polarNRZ(i)=1.2;
  else
    polarNRZ(i)=-1.2;
  end
end

%eye diagram%
figure
for i=6:2*pointsInBit:10000-14 %200000/40
  plot(t(1:21),polarNRZ(i:i+20))
  hold on
end
title('EyeDiagram OF polar NRZ');

%signal in time%
figure
plot(t,polarNRZ)
xlabel('Time');
ylabel('Amplitude');
title('polarNRZ');

%signal in frequency%
polarNRZInFreq=fftshift(fft(polarNRZ)).^2/N;
figure
plot(f,abs(polarNRZInFreq))
xlabel('frequency ');
ylabel('power');
title('power Spectral domain of polar NRZ');



%%%%%%%%%%%%%%%%%%unipolar return to zero%%%%%%%%%%%%%%%%%%
%signalInBits changed to uniRZBits
%replace 1 by 1 followed by 0 , and 0 by 0
j=1;
for i=1:noOfBits
  if(streamOfBits(i)==1)
    uniRZBits(j:j+4)=1;
    j=j+5;
    uniRZBits(j:j+4)=0;
    j=j+5;
  else
    uniRZBits(j:j+9)=0;
    j=j+10;
  end
end
%line encoding%
%replace 1 by 1.2 and 0 by 0
for i=1:N
  if(uniRZBits(i)>0)
    uniRZ(i)=1.2;
  else
    uniRZ(i)=0;
  end
end
errorCheck3=streamOfBits*1.2;%used to check error in case of noise at reciever

%eye diagram%
figure
for i=6:2*pointsInBit:10000-14 %200000/40
  plot(t(1:21),uniRZ(i:i+20))
  hold on
end
title('EyeDiagram OF unipolar RZ');

%signal in time%
figure
plot(t,uniRZ)
xlabel('Time');
ylabel('Amplitude');
title('uniRZ');

%signal in frequency%
uniRZInFreq=fftshift(fft(uniRZ)).^2/N;
figure
plot(f,abs(uniRZInFreq))
xlabel('frequency ');
ylabel('power');
title('power Spectral domain of uni RZ');

%%%%%%%%%%%%%%%%%%Bipolar return to zero%%%%%%%%%%%%%%%%%%
%used to check error in case of noise at reciever
cntNoOf1=0;
for i=1:length(streamOfBits)
  if(streamOfBits(i)==1)
    cntNoOf1=cntNoOf1+1;
    if(rem(cntNoOf1,2)==0)
      errorCheck5(i)=-1.2;
    else
      errorCheck5(i)=1.2;
    end
  else
    errorCheck5(i)=0;
  end
end
%replacing 1 by 1.2 followed by 0 and next 1 by -1.2 followed by 0 and 0 by 0
cntNoOf1=0;
j=1;
for i=1:noOfBits
  if(errorCheck5(i)==1.2)
    biPolarRZ(j:j+4)=1.2;
    j=j+5;
    biPolarRZ(j:j+4)=0;
    j=j+5;
  elseif (errorCheck5(i)==-1.2)
    biPolarRZ(j:j+4)=-1.2;
    j=j+5;
    biPolarRZ(j:j+4)=0;
    j=j+5;
  else
    biPolarRZ(j:j+9)=0;
    j=j+10;
  end
end

%eye diagram%
figure
for i=6:2*pointsInBit:10000-14 %200000/40
  plot(t(1:21),biPolarRZ(i:i+20))
  hold on
end
title('EyeDiagram OF Bipolar RZ');
%signal in time%
figure
plot(t,biPolarRZ)
xlabel('Time');
ylabel('Amplitude');
title('biPolarRZ');


%signal in frequency%
biPolarRZInFreq=fftshift(fft(biPolarRZ)).^2/N;
figure
plot(f,abs(biPolarRZInFreq))
xlabel('frequency ');
ylabel('power');
title('power Spectral domain of BipolarRZ');




%%%%%%%%%%%%%%%%%%Manchester%%%%%%%%%%%%%%%%%%
%used to check error in case of noise at reciever
for i=1:length(streamOfBits)
  if(streamOfBits(i)==1)
    errorCheck4(i)=1.2;
  else
    errorCheck4(i)=-1.2;
  end
end
%making 1 represented by 1 followed by 0
%making 0 represented by 0 followed by 1
j=1;
for i=1:noOfBits
  if(streamOfBits(i)==1)
    manchesterBits(j:j+4)=1;
    j=j+5;
    manchesterBits(j:j+4)=-1;
    j=j+5;
  else
    manchesterBits(j:j+4)=-1;
    j=j+5;
    manchesterBits(j:j+4)=1;
    j=j+5;
  end
end

%line encoding%
%putting 1.2 for 1 and -1.2 for -1
for i=1:N
  if(manchesterBits(i)>0)
    manchester(i)=1.2;
  else
    manchester(i)=-1.2;
  end
end

%eye diagram%
figure

for i=6:2*pointsInBit:10000-14 %200000/40
  plot(t(1:21),manchester(i:i+20))
  hold on
end
title('EyeDiagram OF Manchester');
%signal in time%
figure
plot(t,manchester)
xlabel('Time');
ylabel('Amplitude');
title('manchester');

%signal in frequency%
manchesterInFreq=fftshift(fft(manchester)).^2/N;
figure
plot(f,abs(manchesterInFreq))
xlabel('frequency ');
ylabel('power');
title('power Spectral domain of Manchester');



%%%Reciever for different signals%%%
q=1;
for sigma=0.12:0.12:1.2
  noise=sigma*randn(1,length(t));
  recievedUniNRZ=uniNRZ+noise;
  sum=0;%%calculate avg of 20 points
  for i=1:length(recievedUniNRZ)
    sum=sum+recievedUniNRZ(i);
    if(rem(i,pointsInBit)==0)
      avg=sum/pointsInBit;%for one bit that has many points
      if(avg>0.6)
        recievedUniNRZ(i-9:i)=1.2;
      else
        recievedUniNRZ(i-9:i)=0;
      end
      sum=0;
    end
  end
    cnterror=0;
  j=1;
  for i=1:pointsInBit:length(recievedUniNRZ)
     if(recievedUniNRZ(i)!=errorCheck1(j))
      cnterror=cnterror+1;
     end
     j++;
  end
  BERUniNRZ(q)=cnterror/noOfBits;
   if(BERUniNRZ(q)==0)
    BERUniNRZ(q)=0.0001;
  end

  recievedPolarNRZ=polarNRZ;
  recievedPolarNRZ=polarNRZ+noise;
  sum=0;%%calculate avg of 20 points
  for i=1:length(recievedPolarNRZ)
    sum=sum+recievedPolarNRZ(i);
    if(rem(i,pointsInBit)==0)
      avg=sum/pointsInBit;%for one bit that has many points
      if(avg>0)
        recievedPolarNRZ(i-9:i)=1.2;
      else
        recievedPolarNRZ(i-9:i)=-1.2;
      end
      sum=0;
    end
  end

  %decision device%
  cnterror=0;
  j=1;
  for i=1:pointsInBit:length(recievedPolarNRZ)
     if(recievedPolarNRZ(i)!=errorCheck2(j))
      cnterror=cnterror+1;
     end
     j=j+1;
  end
  BERPolarNRZ(q)=cnterror/noOfBits;
  if(BERPolarNRZ(q)==0)
    BERPolarNRZ(q)=0.0001;
  end


  recieveduniRZ=uniRZ;
  recieveduniRZ=uniRZ+noise;
  sum=0;%%calculate avg of 20 points
  i=1;
  while (i<N)
    sum=sum+recieveduniRZ(i);
    if(rem(i,(pointsInBit/2))==0)
      avg=sum/(pointsInBit/2);%for one bit that has many points
      if(avg>0.6)
        recieveduniRZ(i-4:i)=1.2;
        recieveduniRZ(i+1:i+5)=0;
        i=i+5;
      else
        recieveduniRZ(i-4:i+5)=0;
        i=i+5;
      end
      sum=0;
    end
    i=i+1;
  end

  %decision device%
  errorCheck=streamOfBits*1.2;
  cnterror=0;
  j=1;
  for i=1:pointsInBit:length(recieveduniRZ)
     if(recieveduniRZ(i)!=errorCheck3(j))
      cnterror=cnterror+1;
     end
     j++;
  end
  BERuniRZ(q)=cnterror/noOfBits;
  if(BERuniRZ(q)==0)
    BERuniRZ(q)=0.0001;
  end

  recievedBiPolarRZ=biPolarRZ;
  recievedBiPolarRZ=biPolarRZ+noise;
  sum=0;%%calculate avg of 20 points
  i=1;
  while (i<N)
    sum=sum+recievedBiPolarRZ(i);
    if(rem(i,(pointsInBit/2))==0)
      avg=sum/(pointsInBit/2);%for one bit that has many points
      if(avg>0.6)
        recievedBiPolarRZ(i-4:i)=1.2;
        recievedBiPolarRZ(i+1:i+5)=0;
        i=i+5;
      elseif(avg<-0.6)
        recievedBiPolarRZ(i-4:i)=-1.2;
        recievedBiPolarRZ(i+1:i+5)=0;
        i=i+5;
      else
        recievedBiPolarRZ(i-4:i+5)=0;
        i=i+5;
      end
      sum=0;
    end
    i=i+1;
  end

  %decision device%
  cnterror=0;
  j=1;
  for i=1:pointsInBit:length(recievedBiPolarRZ)
     if(recievedBiPolarRZ(i)!=errorCheck5(j))
      cnterror=cnterror+1;
     end
     j++;
  end
  BERBiPolarRZ(q)=cnterror/noOfBits;
  if(BERBiPolarRZ(q)==0)
    BERBiPolarRZ(q)=0.0001;
  end

  recievedmanchester=manchester;
  recievedmanchester=manchester+noise;
  sum=0;%%calculate avg of 20 points
  i=1;
  while (i<N)
    sum=sum+recievedmanchester(i);
    if(rem(i,(pointsInBit/2))==0)
      avg=sum/(pointsInBit/2);%for one bit that has many points
      if(avg>0)
        recievedmanchester(i-4:i)=1.2;
        recievedmanchester(i+1:i+5)=-1.2;
        i=i+5;
      else
        recievedmanchester(i-4:i)=-1.2;
        recievedmanchester(i+1:i+5)=1.2;
        i=i+5;
      end
      sum=0;
    end
    i=i+1;
  end

  %decision device%
  cnterror=0;
  j=1;
  for i=1:pointsInBit:length(recievedmanchester)
     if(recievedmanchester(i)!=errorCheck4(j))
      cnterror=cnterror+1;
     end
     j++;
  end
  BERManchester(q)=cnterror/noOfBits;
  if(BERManchester(q)==0)
    BERManchester(q)=0.0001;
  end




  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%Bonus for loop to count number of errors%%%%%%%%%%%%%%%%%%%%%
%% We count number of alternative  ones that come after each other and have same voltage level
for i=1:pointsInBit:N
  if(recievedBiPolarRZ(i)!=0)
 firstOneBit=recievedBiPolarRZ(i);
j=i;
 break
end
end
counter1=0;
for i=j+1:pointsInBit:N
if(recievedBiPolarRZ(i)!=0)
secondOneBit=recievedBiPolarRZ(i);
if(firstOneBit==secondOneBit)
 counter1++;
end
firstOneBit=secondOneBit;
end
end
BER_C1(q)=counter1/10000;
if(BER_C1(q)==0)
BER_C1(q)=0.0001
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%Bonus  end of for loop %%%%%%%%%%%%%%%%%%%%%%%%%%%%
q=q+1;
end
%Plot of BER versus Sigma
x=[0.12 0.24 0.36 0.48 0.6 0.72 0.84 0.9 1.08 1.2];
xi=linspace(0.12,1.2,100);
BERuniRZi=interp1(x,BERuniRZ,xi);
BERUniNRZi=interp1(x,BERUniNRZ,xi);
BERPolarNRZi=interp1(x,BERPolarNRZ,xi);
BERManchesteri=interp1(x,BERManchester,xi);
BERBiPolarRZi=interp1(x,BERBiPolarRZ,xi);
figure
semilogy(xi,BERuniRZi);
hold on
semilogy(xi,BERUniNRZi);
hold on
semilogy(xi,BERPolarNRZi);
hold on
semilogy(xi,BERManchesteri);
hold on

semilogy(xi,BERBiPolarRZi);
legend('uniRZ','UniNRZ','PolarNRZ','Manchester','BiPolarRZ')
xlabel('Sigma');
ylabel('BER');



%%%%%%%%%%%%%%Bonus    plot of bonus curve%%%%%%%%%%%%%%%%%%%%%

BER_C1i=interp1(x,BER_C1,xi);
figure

semilogy(xi,BER_C1i)
legend('error by alternative method of ones ')
xlabel('Sigma');
ylabel('Error percentage of alternative onesclose');
title('Bonus');
%%%%%%%%%%%%%%Bonus%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%Thank you%%%%%%%%%%%%%%%%%%%%%

