%% Arch shaped
clear all;
close all;
clc;
 
e=0.01;
k=4;
a=0.2;
D = 0.68; 
dt=0.001; 
size=102;
time = 10;
 
v= zeros(size,size);
w= zeros(size,size);

fv=zeros(size,size);
fw=zeros(size,size);

vmatrix=zeros(size-2,size-2,length(dt:dt:time));
wmatrix=zeros(size-2,size-2,length(dt:dt:time));
 
v(98:100, 2:5)=0.8; %decide what to excite
%v(yy, xx)
i=0;         

% place electrodes in positions OUTSIDE the medium
t1x = -10; t1y = -10;
t2x = 110 ;t2y = 110; 

% a 3rd (z) dimenison is needed for proper computation;
% leads are placed on the chest, not on the plane of the heart and
% technically 'in' the medium
t1z = 5; t2z = 5;
 
for t=0:dt:time                        
    i=i+1;

% Here, divide
% the heart into 3 (center dividing) regions using
% unexcitable cells. Cells like the septum will never be excited
%v(xx, yy) = 0;
    
%As with Traveling Pulses demo
%apply the same properties to the boundary cells as the interior cells
v(1,:) = v(2,:);
v(size,:) = v((size-1),:);
v(:,1)= v(:,2);
v(:,size) = v(:,(size-1));

%define lead values in the loop, initally, the value should be 'zeroed' to
%determine the change based on electrical activity

Lead1(i) = 0;
Lead2(i) = 0;

   for x=2:(size-1)
      for y=2:(size-1)
       fw(x,y)=v(x,y)-w(x,y);
       fv(x,y)=(1/e)*(k*v(x,y)*(1-v(x,y))*(v(x,y)-a)-w(x,y)+D*(v(x-1,y)+v(x+1,y)+v(x,y-1)+v(x,y+1)-4*v(x,y)));

       %ECG specific content
       ECGval = (v(x-1,y)+v(x+1,y)+v(x,y-1)+v(x,y+1)-4*v(x,y));
       Lead1(i) = Lead1(i) + ECGval/(sqrt((t1x - x)^2 + (t1y - y)^2 + (t1z - 0)^2));
       Lead2(i) = Lead2(i) + ECGval/(sqrt((t2x - x)^2 + (t2y - y)^2 + (t2z - 0)^2));

      end 
   end
 
  v = v+fv*dt;
  w = w+fw*dt;
  
  vmatrix(1:size-2,1:size-2,i) = v(2:size-1,2:size-1);
  wmatrix(1:size-2,1:size-2,i) = w(2:size-1,2:size-1);   
end 

%electrical activity differences across the heart
LeadDiff = Lead1 - Lead2;

b = plot (LeadDiff);
xlabel('Time (ms)'); ylabel('ECG Potential');
 
%plotting the 'heart' should use the same gif processes as the wave demo

title('2D Wave Propagation')
grid on
hold on

c = colorbar('Ticks',[0, 0.2, 0.4, 0.6, 0.8, 1]);
c.Label.String = 'Activation Variable Value of Cells';

zlim ([0, 1])
xlim ([0,100])
xlabel('Bottom of Array')
ylabel('Left Side of Array')

contourf (vmatrix(:,:,1))
gif('archshaped.gif', 'DelayTime',1/15,'LoopCount', 3, 'frame', gcf,'overwrite',true)
for frames = 1:10:i
    contourf(vmatrix(:,:,frames))
    gif
    pause(0.3)
end
%% Spiral shaped

clear all;
close all;
clc;
 
e=0.01;
k=4;
a=0.2;
D = 0.68; 
dt=0.001; 
size=102;
time = 10;
 
v= zeros(size,size);
w= zeros(size,size);

fv=zeros(size,size);
fw=zeros(size,size);

vmatrix=zeros(size-2,size-2,length(dt:dt:time));
wmatrix=zeros(size-2,size-2,length(dt:dt:time));
 
v(48:52, 48:52)=0.8; %decide what to excite
%v(yy, xx)
i=0;         

% place electrodes in positions OUTSIDE the medium
t1x = -10; t1y = -10;
t2x = 110 ;t2y = 110; 

% a 3rd (z) dimenison is needed for proper computation;
% leads are placed on the chest, not on the plane of the heart and
% technically 'in' the medium
t1z = 5; t2z = 5;
 
for t=0:dt:time                        
    i=i+1;

% Here, divide
% the heart into 3 (center dividing) regions using
% unexcitable cells. Cells like the septum will never be excited
%v(xx, yy) = 0;
    
%As with Traveling Pulses demo
%apply the same properties to the boundary cells as the interior cells
v(1,:) = v(2,:);
v(size,:) = v((size-1),:);
v(:,1)= v(:,2);
v(:,size) = v(:,(size-1));

%define lead values in the loop, initally, the value should be 'zeroed' to
%determine the change based on electrical activity

Lead1(i) = 0;
Lead2(i) = 0;

   for x=2:(size-1)
      for y=2:(size-1)
       fw(x,y)=v(x,y)-w(x,y);
       fv(x,y)=(1/e)*(k*v(x,y)*(1-v(x,y))*(v(x,y)-a)-w(x,y)+D*(v(x-1,y)+v(x+1,y)+v(x,y-1)+v(x,y+1)-4*v(x,y)));

       %ECG specific content
       ECGval = (v(x-1,y)+v(x+1,y)+v(x,y-1)+v(x,y+1)-4*v(x,y));
       Lead1(i) = Lead1(i) + ECGval/(sqrt((t1x - x)^2 + (t1y - y)^2 + (t1z - 0)^2));
       Lead2(i) = Lead2(i) + ECGval/(sqrt((t2x - x)^2 + (t2y - y)^2 + (t2z - 0)^2));

      end 
   end
 
  v = v+fv*dt;
  w = w+fw*dt;
  
  vmatrix(1:size-2,1:size-2,i) = v(2:size-1,2:size-1);
  wmatrix(1:size-2,1:size-2,i) = w(2:size-1,2:size-1);   
end 

%electrical activity differences across the heart
LeadDiff = Lead1 - Lead2;

b = plot (LeadDiff);
xlabel('Time (ms)'); ylabel('ECG Potential');
 
%plotting the 'heart' should use the same gif processes as the wave demo

title('2D Wave Propagation')
grid on
hold on

c = colorbar('Ticks',[0, 0.2, 0.4, 0.6, 0.8, 1]);
c.Label.String = 'Activation Variable Value of Cells';

zlim ([0, 1])
xlim ([0,100])
xlabel('Bottom of Array')
ylabel('Left Side of Array')

contourf (vmatrix(:,:,1))
gif('Spiralshaped.gif', 'DelayTime',1/15,'LoopCount', 3, 'frame', gcf,'overwrite',true)
for frames = 1:10:i
    contourf(vmatrix(:,:,frames))
    gif
    pause(0.3)
end
%% random excitation pattern

clear all;
close all;
clc;
 
e=0.01;
k=4;
a=0.2;
D = 0.68; 
dt=0.001; 
size=102;
time = 10;
 
v= zeros(size,size);
w= zeros(size,size);

fv=zeros(size,size);
fw=zeros(size,size);

vmatrix=zeros(size-2,size-2,length(dt:dt:time));
wmatrix=zeros(size-2,size-2,length(dt:dt:time));
 
v(:, 2)=0.8; %decide what to excite
%v(yy, xx)
i=0;         

% place electrodes in positions OUTSIDE the medium
t1x = -10; t1y = -10;
t2x = 110 ;t2y = 110; 

% a 3rd (z) dimenison is needed for proper computation;
% leads are placed on the chest, not on the plane of the heart and
% technically 'in' the medium
t1z = 5; t2z = 5;
 
for t=0:dt:time                        
    i=i+1;

% Here, divide
% the heart into 3 (center dividing) regions using
% unexcitable cells. Cells like the septum will never be excited
%v(xx, yy) = 0;
    
%As with Traveling Pulses demo
%apply the same properties to the boundary cells as the interior cells
v(1,:) = v(2,:);
v(size,:) = v((size-1),:);
v(:,1)= v(:,2);
v(:,size) = v(:,(size-1));

%define lead values in the loop, initally, the value should be 'zeroed' to
%determine the change based on electrical activity

Lead1(i) = 0;
Lead2(i) = 0;

   for x=2:(size-1)
      for y=2:(size-1)
       fw(x,y)=v(x,y)-w(x,y);
       fv(x,y)=(1/e)*(k*v(x,y)*(1-v(x,y))*(v(x,y)-a)-w(x,y)+D*(v(x-1,y)+v(x+1,y)+v(x,y-1)+v(x,y+1)-4*v(x,y)));

       %ECG specific content
       ECGval = (v(x-1,y)+v(x+1,y)+v(x,y-1)+v(x,y+1)-4*v(x,y));
       Lead1(i) = Lead1(i) + ECGval/(sqrt((t1x - x)^2 + (t1y - y)^2 + (t1z - 0)^2));
       Lead2(i) = Lead2(i) + ECGval/(sqrt((t2x - x)^2 + (t2y - y)^2 + (t2z - 0)^2));

      end 
   end
 
  v = v+fv*dt;
  w = w+fw*dt;
  
  vmatrix(1:size-2,1:size-2,i) = v(2:size-1,2:size-1);
  wmatrix(1:size-2,1:size-2,i) = w(2:size-1,2:size-1);   
end 

%electrical activity differences across the heart
LeadDiff = Lead1 - Lead2;

b = plot (LeadDiff);
xlabel('Time (ms)'); ylabel('ECG Potential');
 
%plotting the 'heart' should use the same gif processes as the wave demo

title('2D Wave Propagation')
grid on
hold on

c = colorbar('Ticks',[0, 0.2, 0.4, 0.6, 0.8, 1]);
c.Label.String = 'Activation Variable Value of Cells';

zlim ([0, 1])
xlim ([0,100])
xlabel('Bottom of Array')
ylabel('Left Side of Array')

contourf (vmatrix(:,:,1))
gif('randomshaped.gif', 'DelayTime',1/15,'LoopCount', 3, 'frame', gcf,'overwrite',true)
for frames = 1:10:i
    contourf(vmatrix(:,:,frames))
    gif
    pause(0.3)
end



%% three chambered/four chambered
clear all;
close all;
clc;
 
e=0.01;
k=4;
a=0.2;
D = 0.68; 
dt=0.001; 
size=102;
time = 10;
 
v= zeros(size,size);
w= zeros(size,size);

fv=zeros(size,size);
fw=zeros(size,size);

vmatrix=zeros(size-2,size-2,length(dt:dt:time));
wmatrix=zeros(size-2,size-2,length(dt:dt:time));
 
v(78:82,48:52)=0.8; %decide what to excite

%v(yy, xx)

i=0;         

% place electrodes in positions OUTSIDE the medium
t1x = -10; t1y = -10;
t2x = 110 ;t2y = 110; 

% a 3rd (z) dimenison is needed for proper computation;
% leads are placed on the chest, not on the plane of the heart and
% technically 'in' the medium
t1z = 5; t2z = 5;
 
for t=0:dt:time                        
    i=i+1;

if t > 0.15 && t < 0.25     % tiny time window
    v(80:100, 50:100) = 0;
    v(60:80, 1:100) = 0;
elseif t > 0.25 && t < 1
    v(60:80, 1:50) = 0;
end
%if any(v(50:100,47:49) > 0.6,'all')     
    %v(98:100,52:55) = 0.8;
%end
% Here, divide
% the heart into 3 (center dividing) regions using
% unexcitable cells. Cells like the septum will never be excited
%v(50:100, 50) = 0;
v(1:45, 55) = 0;
v(50,1:45) = 0; 
v(50,50:100) = 0;

%v(yy, xx) = 0;
    
%As with Traveling Pulses demo
%apply the same properties to the boundary cells as the interior cells
v(1,:) = v(2,:);
v(size,:) = v((size-1),:);
v(:,1)= v(:,2);
v(:,size) = v(:,(size-1));

%define lead values in the loop, initally, the value should be 'zeroed' to
%determine the change based on electrical activity

Lead1(i) = 0;
Lead2(i) = 0;

   for x=2:(size-1)
      for y=2:(size-1)
       fw(x,y)=v(x,y)-w(x,y);
       fv(x,y)=(1/e)*(k*v(x,y)*(1-v(x,y))*(v(x,y)-a)-w(x,y)+D*(v(x-1,y)+v(x+1,y)+v(x,y-1)+v(x,y+1)-4*v(x,y)));

       %ECG specific content
       ECGval = (v(x-1,y)+v(x+1,y)+v(x,y-1)+v(x,y+1)-4*v(x,y));
       Lead1(i) = Lead1(i) + ECGval/(sqrt((t1x - x)^2 + (t1y - y)^2 + (t1z - 0)^2));
       Lead2(i) = Lead2(i) + ECGval/(sqrt((t2x - x)^2 + (t2y - y)^2 + (t2z - 0)^2));

      end 
   end
 
  v = v+fv*dt;
  w = w+fw*dt;
  
  vmatrix(1:size-2,1:size-2,i) = v(2:size-1,2:size-1);
  wmatrix(1:size-2,1:size-2,i) = w(2:size-1,2:size-1);   
end 

%electrical activity differences across the heart
LeadDiff = Lead1 - Lead2;

b = plot (LeadDiff, LineWidth=2);
xlabel('Time (ms)'); ylabel('ECG Potential');title('Atrial Fibrillation')
 
%plotting the 'heart' should use the same gif processes as the wave demo

title('2D Wave Propagation')
grid on
hold on

c = colorbar('Ticks',[0, 0.2, 0.4, 0.6, 0.8, 1]);
c.Label.String = 'Activation Variable Value of Cells';

zlim ([0, 1])
xlim([0,100])
xlabel('Bottom of Array')
ylabel('Left Side of Array')

contourf (vmatrix(:,:,1))
gif('threechambered.gif', 'DelayTime',1/15,'LoopCount', 3, 'frame', gcf,'overwrite',true)
for frames = 1:10:i
    contourf(vmatrix(:,:,frames))
    gif
    pause(0.3)
end




