% Celestial Sphere

% === params ===
Nm = 1920; Nn = 1080;
ViewAng = pi/2;
f = Nm/2/tan(ViewAng/2);
path = 'C:\Users\addis\Documents\GitHub\StarCitizen-Astronomy\star-map\';
imfiles = ['1-13.png'];
% ==============
close all;
cam33 = [1,0,0;0,1,0;0,0,1];
Pcam = [0,0,0]; Ploc = [0,0,0];
cam=[cam33;Pcam;Ploc;Nm,Nn,f];
I = imread([path imfiles]);
figure(2); scatter3(0,0,0, 'k'); hold on;
figure(1); imshow(I); hold on;
for i = 1:100
mn = ginput(1) - [1+Nm,1+Nn]/2;
[th(i),phi(i)] = mn2sphere(mn,cam);
disp([th(i),phi(i)]);
[x,y,z] = Sph2Cart(th(i),phi(i),1);
scatter3(x,y,z, 'k');
cam=ori(Pmn2,cam);
end
