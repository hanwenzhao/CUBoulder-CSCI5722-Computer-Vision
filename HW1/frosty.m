function [outImg] = frosty(inImg, n, m)
%%%%%%%%%%%%%%%%%%%%%%%%%%
% Hanwen Zhao
% CSCI 5722
% Assignment 1
% Instructor: Ioana Fleming
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
tic
% get the size of the input image
[mm,nn,~] = size(inImg);
% create a paded array
padding_size = max(fix(n/2),fix(m/2))+1;
processImg = padarray(double(inImg),[padding_size,padding_size],NaN);
% contain for output
outImg = zeros(mm,nn,3);
% contain for random generation
G = zeros(n,m);
if mod(n,2) == 0
    n1 = (n/2)-1;
    n2 = n/2;
else
    n1 = fix(n/2);
    n2 = fix(n/2);
end
if mod(m,2) == 0
    m1 = (m/2)-1;
    m2 = m/2;
else
    m1 = fix(m/2);
    m2 = fix(m/2);
end
% loop through all points
for i = padding_size+1:mm+padding_size
    for j = padding_size+1:nn+padding_size
        while 1
            G(:,:) = 0;
            ii = randperm(n); jj = randperm(m);
            G(ii(1),jj(1)) = 1;
            if ~isnan(nansum(nansum(G.*processImg(i-n1:i+n2,j-m1:j+m2,1))))
                break
            end
        end
        outImg(i-padding_size,j-padding_size,1:3) = nansum(...
            nansum(G.*processImg(i-n1:i+n2,j-m1:j+m2,1:3)));
    end
end
outImg = uint8(outImg);
toc
end