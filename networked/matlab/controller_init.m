function controller_init(arg)

% Distributed control system: controller node
%
% Receives messages from the sensor node, computes control signal
% and sends it to the actuator node. Also contains a high-priority
% disturbing task.

% Initialize TrueTime kernel
ttInitKernel('prioDM') % deadline-monotonic scheduling

% Create task data (local memory)
data.beta=1;
data.h = 0.001;
%data.h = [0.010;0.010];
%data.K = 23.16;
%data.K=[-75.4995,92.7410,344.5808,26.0758];
% K 对应倒立摆模型中一个1x4的matrix
%change K into 2x2 mat
data.K =  1740; %kp
data.Ki = 5000;
data.Kd = 350;
data.Td = data.Kd/data.K;
data.Ti = data.K/data.Ki;
data.N = 100.0;
data.ad = data.Td/(data.N*data.h+data.Td);
data.bd = data.N*data.K*data.ad;
data.yold = 0;
data.Dold = 0;
data.Iold = 0;
data.u = 0;
% Sporadic controller task, activated by arriving network message
deadline = data.h;
ttCreateTask('controller_task', deadline, 'controller_code', data);
ttAttachNetworkHandler('controller_task');
%Periodic dummy task with higher priority
starttime = 0.0;
period = 0.007;
data = period*arg;
ttCreatePeriodicTask('dummy_task', starttime, period, 'dummy_code', data);
