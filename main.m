clc,clear;
% close all;
s=rng(1);
N =10;
b = rand(N,1)+1i*rand(N,1);

iter_num = 10;
W = zeros(N,iter_num+1);
val = zeros(1,iter_num+1);
w0 = rand(N,1)+1i*rand(N,1);
Pmax = 1;
w0 =0.1*sqrt(Pmax)*w0/norm(w0);
A = rand(N)+1i*rand(N);
A = A*A';
gamma = 0;
for iter=1:iter_num
    g_w = 2*(b*b')*w0;
    cvx_begin quiet
    variable w(N,1) complex
%     maximize (abs(b'*w0)^2+real(g_w'*(w-w0))-gamma*w'*A*w)
    maximize (real(g_w'*(w-w0)))
    subject to
        square_pos(norm(w))<=Pmax
    cvx_end
    w0=w;
    W(:,iter+1)=w;
    val(iter+1)=abs(b'*w)^2;
    disp(iter)
end
disp(norm(w)^2)
figure
plot(val,'b-o','linewidth',1.5)
grid on
title(['gamma=',num2str(gamma)]);