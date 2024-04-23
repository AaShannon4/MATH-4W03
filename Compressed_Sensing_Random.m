%%MATLAB file for compressed sensing of picture

clear
close all
clc

%%For a random square matrix
N=10; %Size of image matrix
SourceImage=randn(N,N); %Create a matix of random values between 0 and 1
K=N*N/2; %Sparsity
x=reshape(transpose(SourceImage),[N*N,1]); %Reshapes the matrix into a 1 dimensional vector
Phi=randn(K,N*N); %Sensing matrix Phi
y=Phi*x; %Observations that are being made
Theta = zeros(K,N*N);
for ii = 1:N*N
    ek = zeros(1,N*N);
    ek(ii) = 1;
    psi = idct(ek)';
    Theta(:,ii) = Phi*psi;
end

%___l2 NORM SOLUTION___ s2 = Theta\y; %s2 = pinv(Theta)*y
s2 = pinv(Theta)*y;

%___BP SOLUTION___
s1 = l1eq_pd(s2,Theta,Theta',y,5e-3,20); % L1-magic toolbox
%x = l1eq_pd(y,A,A',b,5e-3,32);

%___DISPLAY SOLUTIONS___
plot(s2,'b'), hold
plot(s1,'r.-')
legend('least squares','basis pursuit')
title('solution to y = \Theta s')

%___IMAGE RECONSTRUCTIONS___
x2 = zeros(N*N,1);
for ii = 1:N*N
    ek = zeros(1,N*N);
    ek(ii) = 1;
    psi = idct(ek)';
    x2 = x2+psi*s2(ii);
end

x1 = zeros(N*N,1);
for ii = 1:N*N
    ek = zeros(1,N*N);
    ek(ii) = 1;
    psi = idct(ek)';
    x1 = x1+psi*s1(ii);
end

figure('name','Compressive sensing image reconstructions')
subplot(1,3,1), imagesc(reshape(x,N,N)), xlabel('original'), axis image
subplot(1,3,2), imagesc(reshape(x2,N,N)), xlabel('least squares'), axis image
subplot(1,3,3), imagesc(reshape(x1,N,N)), xlabel('basis pursuit'), axis image