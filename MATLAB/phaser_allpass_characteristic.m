
%Single allpass filter
a = -0.7;        
B1 = [a 1];      
A1 = [1 a];  

figure(1)
freqz(B1,A1,512,44100);

a = -0.4;        
B1 = [a 1];      
A1 = [1 a];

figure(5)
freqz(B1,A1,512,44100);

%Two allpass filters in series connection
B2 = [a^2 2*a 1];      
A2 = [1 2*a a^2];  

figure(2)
freqz(B2,A2,512,44100);

%Phaser with -0.7 coeff
B3 = [(a^2 + 1) 4*a (1+a^2)];      
A3 = [1 2*a a^2];  

figure(3)
freqz(B3,A3,512,44100);

%Phaser with -0.9 coeff
a1 = -0.9;
B4 = [(a1^2 + 1) 4*a1 (1+a1^2)];     
A4 = [1 2*a1 a1^2];  

figure(4)
freqz(B4,A4,512,44100);







