%% Signal Processing using MATLAB
% Brief demonstration of various signal processing techniques using MATLAB
% Demo Subjects: 
%    1. Introduction to MATLAB
%    2. Introduction to "Signal and Systems" basic MATLAB functions 
%     
% Reference: Signals & Systems, (Openheim and Whilsky)
%            
% Project: du
% Course: Signals & Systems 2020, ECE, NTUA
% http://cvsp.cs.ntua.gr/courses/systems
%
% Based on demo for SS-07
% Updated and Created: 17 Dec., 2020, Nancy Zlatintsi (nzlat@cs.ntua.gr)



clear all; close all; clc;

%% 'Welcome to MATLAB '

% For any help, TYPE => help(...), i.e., help('plot')


% ctrl + c => in order to stop a process

% Read an audio signal => test with any wav file
[yc,fs] = audioread('piano_E4.wav');
figure;
plot(yc);
sound(yc,fs);
axis('tight')


%% Introduction to Vectors, Matrices
% The following serves as an introduction to the basic MATLAB
% definitions of matrices and vectors.
% 
% We show how to define a vector and it's transpose. Then, we define a
% matrix setting it's elements or by concatenating different vectors.
% 
% We introduce matrix definitions like: ones, zeros, and all the available operations 


% Definition of Vectors and Matrices

Vector = [1 3 4 4 12 22 15 33 3 3 4 12]

% Transpose a vector using [...]'
TransVector = [1 3 4 4 12 22 15 33 3 3 4 12]'

% Transpose vector using ';'
TransVector = [1; 3; 4; 4; 12; 22; 15; 33; 3; 3; 4; 12]


% MATRIX creation
Mat1a = [1 2 3; 33 3 23; 1 11 23]

Mat1b = [[1 2 3]', [33 3 23]', [1 11 23]']

% MATRIX concatenation
Mat2a = [Mat1a, Mat1a]

Mat2b = [Mat1a; Mat1a]


% MATLAB predifined commands
% matrix with ones
I=ones(4,3)

% Vector with zeros 
Z=zeros(5,1)

Z=zeros(1,5)

%Vector adressing

Vector = [1 3 4 4 12 22 15 33 3 3 4 12]

% select the fourth Vector value
value_4 = Vector(4)
%or more
more_values = Vector(1:2:end)

% Find the length of a vector
len_sig = length(more_values)

% Create a vector with linspace
lin_ex1 = linspace(1,10,5)

%Elementary Vector and Matrix Operations

I+I

%
I-I

Mat2a*Mat2b

% Pointwise Operations
Mat2a.^2

%
Mat2a.*Mat2a

%
Vector = [1 3 4 4 12 22 15 33 3 3 4 12]
Vector.^2


%% Introduction To Basic Function and Control Flows
% Introducing the "plot" tool, for-loops and IF-THEN commands
%
% Plot is a powerfull tool and the begginers are strongly urgued to
% read the manual. To do so, type "help plot" and "doc plot"
%
% Introduction to Matlab control-flow commands and options
%


Vector = [1 3 4 4 12 22 15 33 3 3 4 12];
clf;

%Plotting Vectors, the Vector is defined before in the script
figure;
plot(Vector);
title('Plot of a Vector');
xlabel('Index k');
ylabel('Amplitude of Vector[k]');


% an other plot of the same Vector BUT transposed using red color for the line
figure;
plot( Vector','r');
title('Plot of the Transposed Vector');



% Introducing Control Blocks => for loop to create a vector and ploti it
Vector=[];
for i=1:10
    Vector(i)=i;
end
Vector
figure;
plot(Vector)
%
% NOTE that MATLAB can perfom Matrix manipulation in PARALLEL
% Writing scripts in a "clever" way (in parallel) can speed up
% SIGNIFICANTLY the execution scripts
%
disp('hold on ')
disp('plot((1:10),''r.-'') ')
disp('hold off ')
hold on   % To superimpose different plots, should turn on the "hold" option by typing "hold on"
plot((1:10),'r.-')
hold off



%% Introduction To Signal Processing
% 
% Introduction to basic mathematical functions like exp, log and sin/cos
%
% Herein, we introduce basic "Signal and Systems" functions like the auto- (and cross-) correlation tool "xcorr"
% and different windows like hamming and bartlett. Matlab supports a very
% wide variety of such functions. For further information, type "help" 


% ploting a dirac using stem? you see the difference of plot vs. stem?
Dirac=zeros(11,1);
Dirac(6)=1;
figure; 
stem((-5:5),Dirac)
title('Discrete-Time Dirac')
xlabel('Time (in samples)')


% ploting a sinusoid
SigLen = 150; % signal length
t=0:SigLen; % create the time, i.e., x-axis vector


% Sinusoid (simple)
% x = sin(2*pi*n/N), Ts=1/N, fo=1Hz 
Signal=sin(2*pi*t/SigLen);
figure; 
subplot(2,1,1) %using subplot to create to plots in one figure
plot(t,Signal)
title('Discrete-Time Sinusoid')
subplot(2,1,2)
stem(t,Signal,'.')
xlabel('Time (in samples)')



% Plotting a cosine Parameters of a cosine
A = 10; f0 = 1000; phi = pi/3;     % 1. the three parameters, A=amplitude, f0=frequency, and phi=phase angle.
T0 = 1/f0;                         % 2. the period, T0, is 1 over the frequency.
tt = -2*T0 : T0/40 : 2*T0;         % 3. tt is the time axis for the plot, start 2 periods before 0 and quit 2 periods after.
Signal = A*cos(2*pi*f0*tt + phi);  % 4. the values of the cosine are computed.
figure;
stem(tt,Signal,'.'); hold on;      % 5. the plot
plot(tt,Signal,'r'); hold off;     % 6. the samples
title('Sinusoid: x(t) = 10 cos(2*pi*1000*t + pi/3)'); % 7. title
xlabel('Time (sec)');              % 8. label axis 
grid on                            % 9. show the grid


% Cosine of Different frequencies
SigLen = 150;
t=0:SigLen;
Signal1=cos(2*pi*t/SigLen*2);
Signal2=cos(2*pi*t/SigLen*3);
Signal3=cos(2*pi*t/SigLen*4);
figure;
subplot(2,1,1)
hold on
plot(Signal1,'r')
plot(Signal2)
plot(Signal3,'g')
title('Plot of Cosines with Different Frequencies')
legend('f=2 Hz','f=3 Hz','f=4 Hz')
hold off
subplot(2,1,2)
hold on
stem((0:5:150),Signal1(1:5:end),'r')
stem((0:5:150),Signal2(1:5:end))
stem((0:5:150),Signal3(1:5:end),'g')
hold off


% Implementing and plotting a rect window 
disp('wRect = rectwin(SigLen); ')
disp('plot(wRect)')
disp('title(''Rectangular Window of 150 samples length'') ')
wRect = rectwin(SigLen);
figure;
plot(wRect)
title('Rectangular Window of 150 samples length')

% A bartlett window is chosen
% similar to a triangular window as returned by the triang function. 
% However, the Bartlett window always has zeros at the first and last samples, 
% while the triangular window is nonzero at those points.

wBart = bartlett(SigLen);
figure;
plot(wBart)
title('Bartlett Window of 150 samples length')

%% SAMPLING
% x(t) = 20cos(2pi(40)t-0.4pi); 40Hz CT sinusoid;


f0 = 40;
T0 = 1/f0;
Ts = [5 2.5 0.1]/1000;
figure;
for i=1:3
    tn = (-T0 : Ts(i) : T0);  
    xn = 20*cos(2*pi*f0*tn-0.4*pi);
    subplot(3,1,i);
    stem(tn,xn,'r.');
    hold on;
    plot(tn,xn); 
    title(['Samples of Sinusoid: Ts = ' num2str(Ts(i)) ' sec']);
end;
hold off;


%% Using FFT 

SigLen = 151;
t=1:SigLen;

% define the signals 
Signal1=cos(2*pi*t/SigLen*2);
Signal3=cos(2*pi*t/SigLen*4);

% fft of a signal: plot Magnitude and Angle

fftSignal=fft(Signal1);
figure; 
subplot(3,1,1)
plot(Signal1)
title('Time-Domain Signal')
subplot(3,1,2)
plot(20*log(abs(fftSignal)))
ylabel('Magnitude (In db)')
subplot(3,1,3)
plot(angle(fftSignal))
ylabel('Angle')
xlabel('Frequency')

% fft of Signal1, using more samples, something that we have to do!
fftSignal=fft(Signal1,512);
figure;
subplot(3,1,1)
plot(Signal1)
title('Time-Domain Signal')
subplot(3,1,2)
plot(20*log(abs(fftSignal(2:end))))
ylabel('Magnitude (In db)')
subplot(3,1,3)
plot(angle(fftSignal))
ylabel('Angle')
xlabel('Frequency')


% disp('% Highlight (in red) conjugate symmetry...');
subplot(3,1,2)
hold on
plot(20*log(abs(fftSignal(2:end/2))),'r')
title('DFT of the Signal 1')
ylabel('Magnitude (In db)')
subplot(3,1,3)
hold on
plot(angle(fftSignal(1:end/2)),'r')
ylabel('Angle')
xlabel('Frequency')



%% Convolution in the Time 

% define the signals
SigLen = 151;
t=1:.35:SigLen;

Signal1=sin(2*pi*t.^2/SigLen);
Signal2=exp(-3.5*(-1:.15:1).^2);
ConvSigTime = conv(Signal1,Signal2);

% create the plot
figure; 
subplot(3,1,1)
plot(Signal1)
title('Signal1')

subplot(3,1,2)
plot(Signal2,'r')
title('Signal2')

subplot(3,1,3)
plot(ConvSigTime)
title('Convolution of 2 Signals in the Time Domain')
xlabel('Time (in Samples)')


%% Convolution in the Frequency Domain
% FFT with sufficient number of samples

% define the signals
Signal1_FFT=fft(Signal1,512);
Signal2_FFT=fft(Signal2,512);
ConvSigFreq=Signal1_FFT.*Signal2_FFT;
ConvSigTime_Freq=ifft(ConvSigFreq);

% create the plot
figure;
subplot(3,1,1)
plot(20*log(abs(Signal1_FFT)))
ylabel('Magnitude (in db)')
title('Magnitude of Signal1''s DFT')

subplot(3,1,2)
plot(20*log(abs(Signal2_FFT)))
ylabel('Magnitude (in db)')
title('Magnitude of Signal2''s DFT')

subplot(3,1,3)
hold on
plot(20*log(abs(ConvSigFreq)))
ylabel('Magnitude (in db)')
title('Magnitude of Convolved Signals'' DFT')

