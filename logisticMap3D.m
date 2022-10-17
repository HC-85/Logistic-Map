%The (3D) logistic map
%X_{n+1} = LX_{n}(1-X_{n}) = LX_{n} - LX_{n}^2
clear
x0 = .5;
cyclength = [];
infflag=0;
tic
for j = 0:.01:1
for k = 0:.01:4
L = k + 1i*j
clear x
x(1) = x0;
n = 1;
flag=1;
while flag==1 && n<5000
x(n+1) = L*x(n) - L*x(n).^(2);
check = round(x(1:n),7)==round(x(n+1),7);
if any(check) || any(isnan(x))
    flag=0;
end
n=n+1;
end
cycle = x(find(check)+1:end);
%if (any(isinf(cycle))||isempty(cycle))&&infflag == 0
%    infflag = k;
%end
%if isempty(cycle)
%    cycle = x(1:find(abs(x)==Inf,1)-1);
%end

scatter3(k*ones(1,length(cycle)),j*ones(1,length(cycle)),abs(cycle),0.5,'r','MarkerEdgeAlpha',.5)
if k == 0 && j==0
    hold on
    %title('Absolute')
end
%cyclength = [cyclength [k;length(cycle)]];
end
end
toc
FG = gcf;
FG.Color = [1 1 1]; 
BX = gca;
box; BX.BoxStyle = 'full';
axis vis3d equal
xticks([])
yticks([])
zticks([])
vh = [0:360;0*ones(1,361)]';
vv = [0*ones(1,91),180*ones(1,178),0*ones(1,91);0:179,181:360]';
v = [vh;vv];
OptionZ.FrameRate = 60;OptionZ.Periodic=true;
tic
CaptureFigVid(v,'Test8',OptionZ)
toc
