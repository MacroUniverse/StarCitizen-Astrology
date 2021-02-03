% Celestial Sphere

% === params ===
Nm = 1920; Nn = 1080;
ViewAng = pi/2;
f = Nm/2/tan(ViewAng/2);
file = 'C:\Users\addis\Documents\GitHub\StarCitizen-Astronomy\star-map\ginput.csv';
img_names = 1:7;
% ==============
close all;
T = readtable(file, 'PreserveVariableNames', true);
data = T{1:end,:};
star_nums = data(:,1);
xy = data(:,2:3);
img_nums = data(:,4);
Nimg = max(img_nums);
Nstar = numel(star_nums) - (Nimg-1)*2;

cam33 = [1,0,0;0,1,0;0,0,1];
Pcam = [0,0,0]; Ploc = [0,0,0];
cam=[cam33;Pcam;Ploc;Nm,Nn,f];
figure; [X,Y,Z] = sphere(24);
cameratoolbar;
mesh(X,Y,Z, 'FaceAlpha','0','EdgeColor','c');
hold on; axis equal; 
scatter3(0,0,0, 'k');
ind_img = 1;
xyz = zeros(Nstar, 3);
th = zeros(1,Nstar); ph = th;
mn = xy - [1+Nm,1+Nn]/2;
for i = 1:numel(star_nums)
    ind_star = star_nums(i);
    calib = false;
    if ind_img ~= img_nums(i)
        ind_img = img_nums(i);
        Pmn2 = [xyz([star_nums(i),star_nums(i+1)],:), mn(i:i+1,:)];
        cam=ori(Pmn2,cam);
        % continue;
        calib = true;
    end
    if i > 2 &&img_nums(i-2) ~= img_nums(i)
        % continue;
        calib = true;
    end
    [th(ind_star),ph(ind_star)] = mn2sphere(mn(i,:),cam);
    [x,y,z] = Sph2Cart(1,th(ind_star),ph(ind_star));
    xyz(ind_star,:) = [x,y,z];
    if calib
        scatter3(x,y,z, 'k', 'MarkerFaceColor', 'r');
    else
        scatter3(x,y,z, 'k');
        text(x*1.1,y*1.1,z*1.1,num2str(ind_star));
    end
end
