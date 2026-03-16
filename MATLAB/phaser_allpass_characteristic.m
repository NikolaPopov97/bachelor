
%Single allpass filter
a = -0.9;        
B1 = [a 1];      
A1 = [1 a];  

a = -0.7;        
B2 = [a 1];      
A2 = [1 a];  

figure(1)

[H1,F] = freqz(B1,A1,512,44100);
[H2,~] = freqz(B2,A2,512,44100);

phase1 = angle(H1)*180/pi;
phase2 = angle(H2)*180/pi;

% Filter 0.9
[~, idx1] = min(abs(phase1 + 90));  % closest point to -90
f_cross1 = F(idx1);                 % frequency
phase_cross1 = phase1(idx1);        % value (≈ -90)

% Filter 0.7
[~, idx2] = min(abs(phase2 + 90));
f_cross2 = F(idx2);
phase_cross2 = phase2(idx2);

plot(F,angle(H1)*180/pi,'g','LineWidth',2)
hold on
yline(-90, 'k', 'LineWidth', 1);
hold on
xline(732, 'k--', 'LineWidth', 1.5);
hold on
xline(2454, 'k--', 'LineWidth', 1.5);
hold on
plot(F,angle(H2)*180/pi,'r','LineWidth',2)


grid on
title('Фазне карактеристике филтра пропусника свих учестаности са а = -0,9 и а = -0,7 ')
legend('a = -0,9','','','','a = -0,7')
ylabel('Фаза (степени)')
xlabel('Фреквенција (Hz)')

xlim([0 5000])
xticks([0 732 1000 2000 2454 3000 4000 5000])  % include -90
ylim([-180 0])
yticks([-180 -135 -90 -45 0])  % include -90

%SLEDECI FILTERRRR

figure(2)

%Two allpass filters in series connection
a = -0.9;
B3 = [a^2 2*a 1];      
A3 = [1 2*a a^2]; 
[H3,~] = freqz(B3,A3,512,44100);

plot(F,angle(H1)*180/pi,'g','LineWidth',2)
hold on
yline(-90, 'k', 'LineWidth', 1);
hold on
yline(-180, 'k', 'LineWidth', 1);
hold on
xline(732, 'k--', 'LineWidth', 1.5);
hold on
plot(F,unwrap(angle(H3))*180/pi,'r','LineWidth',2)

grid on
title('Фазне карактеристике филтра пропусника свих учестаности и два филтра пропусника на повезана на ред са а = -0,9')
legend('Један филтер','','','','Два филтра везана на ред')
ylabel('Фаза (степени)')
xlabel('Фреквенција (Hz)')

xlim([0 5000])
xticks([0 732 1000 2000 3000 4000 5000])  % include -90
ylim([-360 0])
yticks([-360 -315 -270 -225 -180 -135 -90 -45 0 ])  % include -90

%СЛЕДЕЦА ФИГУУУУРААААААААААААААААААААААААААААА

figure(3)

%Two allpass filters in series connection
a = -0.9;
B4 = [(a^2 + 1) 4*a (1+a^2)];      
A4 = [1 2*a a^2]; 
[H4,~] = freqz(B4,A4,512,44100);
a = -0.7;
B5 = [(a^2 + 1) 4*a (1+a^2)];      
A5 = [1 2*a a^2]; 
[H5,~] = freqz(B5,A5,512,44100);

% --- Magnitude subplot ---
subplot(2,1,1)
plot(F, 20*log10(abs(H4)), 'g', 'LineWidth', 2)
hold on
plot(F, 20*log10(abs(H5)), 'r', 'LineWidth', 2)
xline(732, 'k--', 'LineWidth', 1)
xline(2454, 'k--', 'LineWidth', 1)
grid on
title('Амплитудске карактеристике phaser ефекта са коефицијентима филтра а = -0,9 и а = -0,7')
ylabel('Амплитуда (dB)')
legend('Phaser са a = -0,9', 'Phaser са a = -0,7')
xlim([0 5000])
xticks([0 732 1000 2000 2454 3000 4000 5000])

% --- Phase subplot ---
subplot(2,1,2)
plot(F, unwrap(angle(H4))*180/pi, 'g', 'LineWidth', 2)
hold on
plot(F, unwrap(angle(H5))*180/pi, 'r', 'LineWidth', 2)
xline(732, 'k--', 'LineWidth', 1)
xline(2454, 'k--', 'LineWidth', 1)
grid on
title('Фазне карактеристике phaser ефекта са коефицијентима филтра а = -0,9 и а = -0,7')
ylabel('Фаза (степени)')
xlabel('Фреквенција (Hz)')
legend('Phaser са a = -0,9', 'Phaser са a = -0,7')
xlim([0 5000])
xticks([0 732 1000 2000 2454 3000 4000 5000])
ylim([-180 180])
yticks([-180 -135 -90 -45 0 45 90 135 180])

%A sad jedno ludilo

Fs = 44100;       % Sampling frequency
N = 512;          % Number of frequency points
F = linspace(0, Fs/2, N);  % Frequency vector for plotting

figure(4)
hold on

% Loop over filter coefficients from -0.9 to 0.7 in steps of 0.1
for a = -0.9:0.01:-0.7
    % Compute filter coefficients for 2nd-order all-pass cascade
    B = [(a^2 + 1) 4*a (1 + a^2)];
    A = [1 2*a a^2];
    
    % Frequency response
    [H,~] = freqz(B,A,N,Fs);
    
    % Plot magnitude in dB
    plot(F, 20*log10(abs(H)), 'LineWidth', 1.5)
end

grid on
title('Приказ клизећег прозора Phaser ефекта за a од -0,9 до -0,7 у корацима 0,01')
xlabel('Фреквенција (Hz)')
ylabel('Амплитуда (dB)')
xlim([0 5000])
xticks([0 1000 2000 3000 4000 5000])

% Optional: create a legend for all coefficients
a_values = -0.9:0.1:0.7;
legend_strings = arrayfun(@(x) sprintf('a = %.1f', x), a_values, 'UniformOutput', false);
legend(legend_strings, 'Location', 'northeast')



%{
a = -0.4;        
B1 = [a 1];      
A1 = [1 a];

figure(5)
freqz(B1,A1,512,44100);

 

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
%}







