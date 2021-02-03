close all;
path = 'C:\Users\addis\Documents\GitHub\StarCitizen-Astronomy\star-map\';
imfiles = '7.png';
I = imread([path imfiles]);
figure; imshow(I); hold on;
xy = zeros(100,2);
for i = 1:100
    xy(i,:) = ginput(1); % break here to adjust image
    disp(xy(i,:));
end
