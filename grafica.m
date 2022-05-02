%-------------------------------------------------------------
%    DEI - Machine Learning 2020
%    function adapted from a function with the same name by 
%    Jorge Henriques
%-------------------------------------------------------------

% This function draws one, two or three inputs, each one given by a 256x1
% vetor,  binary image of a character drawn in a 16x16 grid (obtained with
% mpaper)
% The function grafica may have one, two or three arguments (nargin gives
% its number).
% Before grafication it is needed to apply the Matlab function reshape that
% transforms each vector 256x1 in a matrix (reticulate) 16x16, with 0's and 1's.
% This reticultate is then drawn line by line.Is a cell contains 0, a red
% square is drawn, if it contains 1, a blue square with a *inside is drawn. 
%    RESHAPE(X,M,N) returns the M-by-N matrix whose elements
%    are taken columnwise from X.  An error results if X does
%   not have M*N elements.
 
%    RESHAPE(X,M,N,P,...) returns an N-D array with the same
%    elements as X but reshaped to have the size M-by-N-by-P-by-...
%    M*N*P*... must be the same as PROD(SIZE(X)).

% It can be used writing in the Matlab command line for example grafica
% (P(:1),P(:,2),P(:,3), obtaining the three digits of the three first squares of the grid of 
% mpaper.
% It can happen that that the small squares appear very near. In this case
% augment the size of the image window, using the mouse.


function xx=grafica(X,Y,Z)

n=nargin;

clf
[nL,nC]=size(X);
M=[];
for i=1:nC
    M=[M reshape(X(:,i),16,16)];
end
X=M;
[nL,nC]=size(X);

hold on
incx= 0.15;
incy=-0.02;
yini=1;
xini=1;

% define the sclases of the axes 
axis([xini 8.5 0.5 1.05]);

% plots the first argument
for i=1:nL
    for j=1:nC
        if (X(i,j)==0)
            plot(xini+j*incx,yini+i*incy,'sr');
        else
            plot(xini+j*incx,yini+i*incy,'sk',xini+j*incx,yini+i*incy,'*');
        end
    end
end

% grafica o segundo argumento, se existir
% plots the second argument, if it exists.
if n>1
    %---------------------------------
    Y=reshape(Y,16,16);
    for i=1:nL
        for j=1:nC
            if (Y(i,j)==0)
                plot(xini+(j+nC)*incx,yini+i*incy,'sr');
            else
                plot(xini+(j+nC)*incx,yini+i*incy,'sk',xini+(j+nC)*incx,yini+i*incy,'*');
            end
        end
    end
end

% grafica o terceiro argumento, se existir
% plots the third argument, if it exists 

if n>2
    %---------------------------------
    Z=reshape(Z,16,16);
    for i=1:nL
        for j=1:nC
            if (Z(i,j)==0)
                plot(xini+(j+2*nC)*incx,yini+i*incy,'sr');
            else
                plot(xini+(j+2*nC)*incx,yini+i*incy,'sk',xini+(j+2*nC)*incx,yini+i*incy,'*');
            end
        end
    end
end


