T = readtable('MicroTech.csv', 'PreserveVariableNames', true);
dist = T{:,2:end};
N = size(dist,1);
R = 1000; % MicroTech Radius [km]
figure; [X,Y,Z] = sphere(24);
X = X*R; Y = Y*R; Z = Z*R; mesh(X,Y,Z, 'FaceAlpha','0.7','EdgeColor','c');
axis equal; hold on;
P_OM = 1427*[
    0,0,1; 0,0,-1;  % OM1,2
    1,0,0; -1,0,0;  % OM3,4
    0,-1,0; 0,1,0]; % OM5,6
P = nan(N, 3);
P1 = P; P2 = P; P3 = P; P4 = P;
for i = 1:N
    inds = find(~isnan(dist(i,:)));
    Ndist = numel(inds);
    if Ndist < 4
        continue;
    end
    i1 = inds(1); i2 = inds(2); i3 = inds(3); i4 = inds(4);
    P1(i,:) = pmdL32P(dist(i,i1), dist(i,i2), dist(i,i3),...
            P_OM(i1,:), P_OM(i2,:), P_OM(i3,:));
    P2(i,:) = pmdL32P(dist(i,i2), dist(i,i1), dist(i,i3),...
            P_OM(i2,:), P_OM(i1,:), P_OM(i3,:));
    P3(i,:) = pmdL32P(dist(i,i2), dist(i,i3), dist(i,i4),...
            P_OM(i2,:), P_OM(i3,:), P_OM(i4,:));
    P4(i,:) = pmdL32P(dist(i,i3), dist(i,i2), dist(i,i4),...
            P_OM(i3,:), P_OM(i2,:), P_OM(i4,:));
    [~, ind] = min([norm(P1(i,:)-P3(i,:)), norm(P1(i,:)-P4(i,:)),...
        norm(P2(i,:)-P3(i,:)), norm(P2(i,:)-P4(i,:))]);
    if ind == 1
        P(i,:) = (P1(i,:)+P3(i,:))/2;
    elseif ind == 2
        P(i,:) = (P1(i,:)+P4(i,:))/2;
    elseif ind == 3
        P(i,:) = (P2(i,:)+P3(i,:))/2;
    elseif ind == 4
        P(i,:) = (P2(i,:)+P4(i,:))/2;
    end
    text(P(i,1)*1.1,P(i,2)*1.1,P(i,3)*1.1,T{i,1}{1});
end
P = real(P);
Scatter3(P);
