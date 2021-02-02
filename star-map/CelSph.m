% Celestial Sphere

% === params ===
Nm = 1920;
Nn = 1080;
f = Nm/2/tan(ViewAng/2);
% ==============
cam = [1,0,0;0,1,0;0,0,1];
cam?
[m,n] = ginput(1);
[theta,phi] = mn2sphere(mn,cam);