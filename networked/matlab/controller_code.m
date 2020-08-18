function [exectime, data] = controller_code(seg, data)
switch seg
 case 1
  y = ttGetMsg;         % Obtain sensor value
  if isempty(y)
    disp('Error in controller: no message received!');
    y = 0.0;
    %y = [0.0; 0.0];
  end
  r = ttAnalogIn(1);  
  % Read reference value
  %P = data.K*(r-y);
  %I = data.Iold+data.Ti*data.h*(r-y);
  %D = data.ad*data.Dold + data.bd*(data.yold-y);
  %data.u = P + I + D;
  %data.Iold = I;
  %data.Dold = D;
  %data.yold = y;
  data = pidcalc(data,r,y);
  exectime = 0.0005;
 case 2
  ttSendMsg(2, data.u, 80);    % Send 80 bits to node 2 (actuator)
  exectime = -1; % finished
end
