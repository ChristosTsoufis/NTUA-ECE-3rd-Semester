
% Signals & Systems Matlab Exercise 2020-2021
% Christos Tsoufis
% A.M.: 03117176


%{
##     ## ######## ########   #######   ######         #
###   ### ##       ##     ## ##     ## ##    ##      # #
#### #### ##       ##     ## ##     ## ##              #
## ### ## ######   ########  ##     ##  ######         #  
##     ## ##       ##   ##   ##     ##       ##        # 
##     ## ##       ##    ##  ##     ## ##    ##        #
##     ## ######## ##     ##  #######   ######     ########  
%}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Exercise 1.1 
% Design of Lowpass Filters

% Question (a)

a = 1
c=0.55
P1 = 2
P2 = 5

b1 = [1 0 P1];    % arithmitis
b2 = [1 0 0 0 0 P2];    % arithmitis

% Question (b)

figure
freqz(b1,a);

%figure
%freqz(b2,a);

% Question (c)

figure
zplane(b1,a)

figure
zplane(b2,a)

% Question (d)

figure
impz(b1,a)

figure
impz(b2,a)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Exercise 1.2 Design of Bandwidth Filters

% Question (a)

% Diagramma polwn kai midenikwn
p = [0.65+0.65i 0.65-0.65i]'; 
z = [0.8+0.8i 0.8-0.8i]';
figure
zplane (z,p)

% Finding a,b
[b,a] = zp2tf(z,p,1);

% Question (b)

% Design of Amplitude and Phase Response
figure
freqz (b,a)

% Question (c)

% Impulse Response of the System
figure
impz(b,a)

% Step Response of the System
figure
stepz(b,a,80)

% Question (d)

p1 = [0.7+0.7i 0.7-0.7i]';
figure
zplane (z,p1)
figure
[b1,a1] = zp2tf(z,p1,1/3);
impz(b1,a1,80)
figure
freqz(b1,a1)

p2 = [0.707+0.707i 0.707-0.707i]';
figure
zplane (z,p2)
[b2,a2] = zp2tf(z,p2,1/3);
figure
impz(b2,a2,80)

p3 = [0.75+0.75i 0.75-0.75i]';
figure
zplane (z,p3)
[b3,a3] = zp2tf(z,p3,1/3);
figure
impz(b3,a3,80)

% Question (e)

p4 = [0.4+0.7i 0.4-0.7i]';

% Diagram of Poles & Zeros 
figure
zplane (z,p4)

% Finding a,b (a)
[b4,a4] = zp2tf(z,p4,1/3);

% Design of Amplitude and Phase Response (b)
figure
freqz (b4,a4)

% Question (st)

z1 = [0.77+0.2i 0.77-0.2i]';
figure
% Diagram of Poles & Zeros 
zplane (z1,p)
% Finding a,b (a)
[b_1,a_1] = zp2tf(z1,p,1/3);
% Design of Amplitude and Phase Response (b)
figure
freqz (b_1,a_1)

z2 = [0.2+0.77i 0.2-0.77i]';
figure
% Diagram of Poles & Zeros 
zplane (z2,p)
% Finding a,b (a)
[b_2,a_2] = zp2tf(z2,p,1/3);
% Design of Amplitude and Phase Response (b)
figure
freqz (b_2,a_2)

z3 = [0.4+0.7i 0.4-0.7i]';
figure
% Diagram of Poles & Zeros 
zplane (z3,p)
% Finding a,b (a)
[b_3,a_3] = zp2tf(z3,p,1/3);
% Design of Amplitude and Phase Response (b)
figure
freqz (b_3,a_3)

z4 = [0.7+0.4i 0.7-0.4i]';
figure
% Diagram of Poles & Zeros 
zplane (z4,p)
% Finding a,b (a)
[b_4,a_4] = zp2tf(z4,p,1/3);
% Design of Amplitude and Phase Response (b)
figure
freqz (b_4,a_4)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%{
##     ## ######## ########   #######   ######       ###
###   ### ##       ##     ## ##     ## ##    ##     #   # 
#### #### ##       ##     ## ##     ## ##          #    #
## ### ## ######   ########  ##     ##  ######        #   
##     ## ##       ##   ##   ##     ##       ##      #   
##     ## ##       ##    ##  ##     ## ##    ##     #   
##     ## ######## ##     ##  #######   ######     ########  
%}


% Exercise 2.1

% Question (a)

% Loading sound segments
fs = 44100;
[aud,fs] = audioread('C:\viola_series.wav');
sound(aud,fs);
%pause(3)

% Plot the signal (time)
[l,v] = size(aud);

dt=1./fs;
dt_ms=dt.*1000;

t = (0:l-1).*dt_ms;

figure
n0 = 11000;

plot(t(10000:n0),aud(10000:n0))
xlabel(' Time (ms) ')
ylabel(' Audio ')


% Question (b)

% 1st Implementation in Matlab
% normalize signals [-1 1]

range = max(aud(:)) - min(aud(:));
m = (aud - min(aud(:))) / range;
aud = 2 * m - 1;

% Energy of signal & amplitude graph

w = linspace(0,1,1000)';
energy = conv(aud.*aud,w.*w,'same');
figure

plot(t,aud)
xlabel(' Time(ms) ')
ylabel(' Audio ')

% 2nd Implementation in Octave
% pkg load ltfat
% pkg load signal

audio = normalize(aud,'peak');
audi = buffer(audio,1000);
aud_nrg = zeros(1,89);
for i=1:1:89
    aud_nrg(i)=0;
    for j=1:1:1000
        aud_nrg(i)=aud_nrg(i)+abs(audi(j,i))^2;
    end
end

n = 0:length(audio)/89:length(audio)-length(audio)/89;
figure
aud_energ = normalize(aud_nrg,'peak');
plot(0:1:length(audio)-1,audio,n,aud_energ)
title('Energy of signal')


% Question (c) & (e)

% DFT and spectrum plot

% 1st Implementation

nfft = 2^nextpow2(l);

fasma = fft(aud,nfft)./l;

nmax = nfft/2+1;

nf = [1:1:nmax];

f = fs./2.*linspace(0,1, nmax);

sp = 2.*abs(fasma(1:nmax));

np=7400;
figure

plot(f(1:np),sp(1:np))
xlabel(' frequency(Hz) ')
ylabel(' Spectrum ')

% 2nd Implementation

figure
signal = fft(aud);
wfl=2*pi*(-(length(aud))/2:(length(aud))/2-1)/(length(aud));
plot(wfl/pi, abs(fftshift(signal)))
xlim([-0.3 0.3])


% Question (st)

% Bandwidth IIR  Filter
% now we use viola_note.wav

% 4th harmonic
% frequency of 4th harmonic=961 Hz previous next +- 240 Hz

h4=961;
[n4,Wn4] = buttord([h4-100 h4+100]/22050,[h4-500 h4+500]/22050,10,60);
[b_but4,a_but4]=butter(n4,Wn4);
aud_4 = filter(b_but4,a_but4,aud);

% 2nd harmonic
% frequency of 2nd harmonic=481 Hz previous next +- 240 Hz

h2=481;
% due to the fact that the limits of buttord must be within [0,1] 
% 400 is used instead of 500
[n2,Wn2] = buttord([h2-100 h2+100]/22050,[h2-400 h2+400]/22050,10,60);
[b_but2,a_but2]=butter(n2,Wn2);
aud_2 = filter(b_but2,a_but2,aud);

% FFT 

fasma_4 = fft(aud_4,nfft)./l;
fasma_2 = fft(aud_2,nfft)./l;

sp_4 = 2.*abs(fasma_4(1:nmax));
sp_2 = 2.*abs(fasma_2(1:nmax));

% plot np points of spectrum

np=7400; 
figure
subplot (311)
plot(f(1:np),sp(1:np))

subplot (312)
plot(f(1:np),sp_4(1:np))

subplot (313)
plot(f(1:np),sp_2(1:np))

xlabel('frequency (Hz)');

% plot timeseries segments  1000 samples

figure
n1=1000;
n2=2000;

plot(t(n1:n2),aud(n1:n2))

xlabel('time (ms)');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Exercise 2.2

% Question (a)

% Loading sound segments
fs = 44100;
[aud,fs] = audioread('C:\piano_note.wav');
sound(aud,fs);
%pause(3)

% Plot the signal (time)
[l,v] = size(aud);

dt=1./fs;
dt_ms=dt.*1000;

t = (0:l-1).*dt_ms;

figure
n0 = 11000;

plot(t(10000:n0),aud(10000:n0))
xlabel(' Time (ms) ')
ylabel(' Audio ')


% Question (b)

% DFT and spectrum plot

% 1st Implementation

nfft = 2^nextpow2(l);

fasma = fft(aud,nfft)./l;

nmax = nfft/2+1;

nf = [1:1:nmax];

f = fs./2.*linspace(0,1, nmax);

sp = 2.*abs(fasma(1:nmax));

np=7400;
figure

plot(f(1:np),sp(1:np))
xlabel(' frequency(Hz) ')
ylabel(' Spectrum ')

% 2nd Implementation

figure
signal = fft(aud);
wfl=2*pi*(-(length(aud))/2:(length(aud))/2-1)/(length(aud));
plot(wfl/pi, abs(fftshift(signal)))
xlim([-0.3 0.3])
