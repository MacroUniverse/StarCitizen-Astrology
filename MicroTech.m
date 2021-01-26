T = readtable('MicroTech.csv', 'PreserveVariableNames', true);
dist = T{:,2:end};
N = size(dist,1);
R = 1000; % MicroTech Radius [km]
figure; [X,Y,Z] = sphere(24);
X = X*R; Y = Y*R; Z = Z*R; mesh(X,Y,Z);
axis equal; hold on;
P_OM = 1427*[
    0,0,1; 0,0,-1;  % OM1,2
    1,0,0; -1,0,0;  % OM3,4
    0,-1,0; 0,1,0]; % OM5,6
P = nan(2*N, 3);
for i = 1:N
    inds = find(~isnan(dist(i,:)));
    Ndist = numel(inds);
    if Ndist < 3
        continue;
    end
    i1 = inds(1); i2 = inds(2); i3 = inds(3);
    P(i,:) = pmdL32P(dist(i,i1), dist(i,i2), dist(i,i3),...
            P_OM(i1,:), P_OM(i2,:), P_OM(i3,:));
    P(N+i,:) = pmdL32P(dist(i,i2), dist(i,i1), dist(i,i3),...
            P_OM(i2,:), P_OM(i1,:), P_OM(i3,:));
end
P = real(P);
Scatter3(P);
