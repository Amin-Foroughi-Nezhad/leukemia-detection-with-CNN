clc;close all;clear all; warning off; 
I=imread('F2.jpg');
I=imresize(I,[200,300]);
size(I);
figure;
imshow(I);

rgb = imopen(I,strel('disk',1));

figure;
imshow(rgb);
title('background');
gray_image = rgb2gray(rgb);
imshow(gray_image);

[centers, radii] = imfindcircles(rgb,[2 80],'ObjectPolarity','dark','Sensitivity',0.9)
imshow(rgb);

CNN_read = imread('F2.jpg');
Neurons = size(CNN_read);
cell = length(centers);
M = mean(radii);
max = max(radii);
h_Layers = viscircles(centers,radii);
red=rgb(:,:,1);green= rgb(:,:,2); blue= rgb(:,:,3);
CNN_Features=red>25 & red<199 &green<130 & blue>140 & blue<225;
out1=imfill(CNN_Features,'holes');
out2=bwmorph(out1,'erode');
out3=bwmorph(out2,'dilate',1.2);
out3=imfill(out3,'holes');
out3=bwareaopen(out3,100);

figure;
imshow(out3);
title('Cancer cells')
out3=im2bw(out3);
[l,NUM]=bwlabel(out3,4);

cancer=(NUM/cell)*100;
  disp('Myeloid cells percentage is');
    disp(cancer);
if cancer<0.8
    disp('Healthy. No Problem');
elseif cancer<1 & cancer>0.5
        disp('High myeloid cell concentration.');

    elseif cancer > 1 & cancer < 8
            disp('Initial Stage Leukemia');
        
        elseif cancer > 8
                disp('Advanced Stage Leukemia');
            
end