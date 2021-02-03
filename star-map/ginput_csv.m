close all;
path = 'C:\Users\addis\Documents\GitHub\StarCitizen-Astronomy\star-map\';
imfiles = '3.png';
figure; imshow(I); hold on;
I = imread([path imfiles]);
xy = zeros(100,2);
for i = 1:100
    xy(i,:) = ginput(1);
    disp(xy(i,:));
end
