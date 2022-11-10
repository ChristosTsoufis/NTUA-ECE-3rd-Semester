%Comments are written in english

%Christos Tsoufis 
%03117176
%Signals and Systems
%MATLAB Exercise

%Part A

%A1
a = audiorecorder;
a.StartFcn = 'disp(''Start speaking.'')';
a.StopFcn = 'disp(''End of recording.'')';
recordblocking(a, 2); %recording my voice for 2 seconds

y = getaudiodata(a);
audiowrite('sound.wav', y, 8000);

%A2
y = audioread('sound.wav');
t = linspace(0,2,16000); %time vector
plot(t,y);
xlabel('Time(sec)');
ylabel('Amplitude');
title('Name Signal');

%A3
y = audioread('sound.wav');
%100ms time difference is 800 samples
window = 800; 
%Due to 50% overlap the window moves window/2 positions
step = window / 2; 
size = length(y)/step - 1;
x = y.^2;
energy = zeros(1, size);
first = 1;
last = window;
for i = 1 : size
    energy(i) = sum(x(first:last));
    first = first + step;
    last = last + step;
end
stem(energy);
xlabel('Window');
ylabel('Energy');
title('Energy per 100ms window (50% overlap)');

%A4
y = audioread('sound.wav');
z = y(4200:5000);
sound(z);
audiowrite('rec.wav', z, 8000);
%z corresponds to 'o' 
t = linspace(0, 100, 801);
plot(t,z);
title('Periodic 100ms window of "Name Signal"');
xlabel('Time(ms)');
ylabel('Amplitude');

%A5
z = audioread('rec.wav');
a = fft(z, 1024);
N = length(a);
F = 8000;
DF = F / N;
%Frequency axis
f = [0:DF:F - DF];
%Absolute of fourier transform
x = abs(a);
plot(f, x); 
title('Absolute value of Fourier Transform');
ylabel('|fft(a)|')
xlabel('Frequency(Hz)');
%Logarithm of fourier transform
y = 20*log10(abs(a));
plot(f, y);
title('Absolute value of Fourier Transform in logarithmic scale');
ylabel('20*log10(|fft(a)|');
xlabel('Frequency(Hz)');

%A6
%Fundamental frequency at 93Hz as expected from
%plotting the signal itself where To~11ms. Therefore 
%fo = 1000/11 ~ 91Hz


%Part B

%y[n] = x[n] + ax[n-n0]
%Y[z] = X[z] + az^(-n0)X[z]
%H[z] = (z^n0 + a)/z^n0

%B1
%a = 0.5, n0 = 10
nom = [1 zeros(1, 9) 0.5]; %z^10 + 0.5
denom = [1 zeros(1,10)]; %z^10
%Step response s[n]
[s,n] = stepz(nom, denom, 21);
stem(n,s);
title('Step response s[n]');
%Impulse response h[n]
[h,n] = impz(nom, denom, 21);
stem(n, h);
title('Impulse response h[n]');

%B2
%n0 = 10

%a = 0.1
subplot(2,2,1);
nom = [1 zeros(1, 9) 0.1];
denom = [1 zeros(1,10)];
zplane(nom,denom);
title('a = 0.1');
disp(roots(nom));
disp(roots(denom));
%Note: roots has less accuracy than zplane
%a = 0.01
subplot(2,2,2);
nom = [1 zeros(1, 9) 0.01];
denom = [1 zeros(1,10)];
zplane(nom,denom);
title('a = 0.01');
%a = 0.001
subplot(2,2,3);
nom = [1 zeros(1, 9) 0.001];
denom = [1 zeros(1,10)];
zplane(nom,denom);
title('a = 0.001');

%B3 - B4
%a = 0.5, n0 = 2000
nom = [1 zeros(1, 1999) 0.5];
denom = [1 zeros(1,1999)];
y = audioread('rec.wav');
y = [y; zeros(2000, 1)];
z = filter(nom, denom, y);
plot(z);
title('rec.wav filtered by y');
xlabel('Samples');
ylabel('Amplitude');
sound(z);
%Fourier Transform
a = fft(z, 4096);
N = length(a);
F = 8000;
DF = F / N;
%Frequency axis
f = [0:DF:F - DF];
%Absolute of fourier transform
x = abs(a);
plot(f, x); 
title('Absolute value of Fourier Transform');
ylabel('|fft(a)|')
xlabel('Frequency(Hz)');
%Logarithm of fourier transform
y = 20*log10(abs(a));
plot(f, y);
title('Absolute value of Fourier Transform in logarithmic scale');
ylabel('20*log10(|fft(a)|');
xlabel('Frequency(Hz)');

%Part C

%C1
function y = resonator(x, resonator_frequency, r, sampling_frequency)
    nom = [1];
    denom = [1 -2*r*cos(2*pi*resonator_frequency/sampling_frequency) r^2];
    y = filter(nom, denom, x);
end

%C2
Fs = 800;
Fr = 200;
%For r = 0.95 or 0.5 or 1.2 change value below
r = 0.95;
%Impulse response 
subplot(2,1,1);
t = linspace(0,1,Fs);
h = (t==0);
z = resonator(h, Fr, r, Fs);
plot(t, z);
title(['Impulse response r = ', num2str(r)]);
xlabel('Time(s)');
ylabel('Amplitude');
%Frequency response;
subplot(2,1,2);
a = abs(fft(z, 1024));
DF = Fs / length(a);
f = [0:DF:Fs-DF];
plot(f,a);
title(['Frequency response r = ', num2str(r)]);
ylabel('|fft(a)|');
xlabel('Frequency(Hz)');


%C3
Fs = 8000;
r = 0.95;
t = linspace(0,1,Fs);
h = (t==0);
z1 = resonator(h, 500, r, Fs); %Fr1= 500
z2 = resonator(z1, 1500, r, Fs); %Fr2 = 1500
z3 = resonator(z2, 2500, r, Fs); %Fr3 = 2500
a = abs(fft(z3));
DF = Fs / length(a);
f = [0:DF:Fs-DF];
plot(f,a);
title('Frequency response');
ylabel('|fft(a)|');
xlabel('Frequency(Hz)');

%C4
Fs = 8000;
r = 0.95;
t = linspace(0,0.2, 201);
h = (mod(1000*t,10)== 0);
stem(t, h);
title('Impulse train');
xlabel('Time(s)');
ylabel('Amplitude');
z1 = resonator(h, 500, r, Fs); %Fr1= 500
z2 = resonator(z1, 1500, r, Fs); %Fr2 = 1500
z3 = resonator(z2, 2500, r, Fs); %Fr3 = 2500
a = abs(fft(z3));
DF = Fs / length(a);
f = [0:DF:Fs-DF];
plot(f,a);
title('Frequency response');
ylabel('|fft(a)|');
xlabel('Frequency(Hz)');
sound(a);
%y[n] = x[n] - x[n-1]
%Y[z] = X[z] - 1/z * X[z]
%H[z] = (z-1)/z
nom = [1 -1];
denom = [1 0];
y = filter(nom, denom, a);
sound(y); %The sound resembles "E"