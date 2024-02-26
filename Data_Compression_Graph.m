%This MATLAB File Plots the Data Compression of Singular Value
%Decomposition with the Best Rank k Approximation

m=1000; %Size of one dimension of a matrix A
n=1000; %Size of the second dimension of a matrix A
k=zeros(1,min(m,n)); %Creates a vector for the values of k
compression=zeros(1,min(m,n)); %Creates a vector for the values of the compression
for i=1:min(m,n) %Starts a loop to calculate the compression for all values of k
    k(1,i)=i; %Writes the values of k
    compression(1,i)=(m*n)/(k(1,i)*(m+n+1)); %Calculates the Compression
end %Ends the loop
figure %Starts a figure for the graph
plot(k,compression,'linewidth',2) %Plots the data set
title('Data Compression of Best Rank k Approximation') %Adds a title
xlabel('Values of k') %Labels x axis
ylabel('Amount of Compression (Times Smaller)') %Labels y axis