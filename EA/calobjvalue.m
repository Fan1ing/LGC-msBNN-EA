function [objvalue] = calobjvalue(pop)
popsize=550;
G_D1 = binary2decimal(pop (:,1:1));
G_D2 = binary2decimal(pop (:,2:2));
G_D3  = binary2decimal(pop (:,3:3));
G_D4  = binary2decimal(pop (:,4:4));
G_D5 = binary2decimal(pop (:,5:5));
G_D6 = binary2decimal(pop (:,6:6));
G_D7 = binary2decimal(pop (:,7:7));

G_pai1 = binary2decimal(pop (:,8:8));
G_pai2 = binary2decimal(pop (:,9:9));
G_pai3 = binary2decimal(pop (:,10:10));
G_pai4 = binary2decimal(pop (:,11:11));
G_pai5 = binary2decimal(pop (:,12:12));
G_pai6 = binary2decimal(pop (:,13:13));
G_pai7 = binary2decimal(pop (:,14:14));
G_pai8 = binary2decimal(pop (:,15:15));
G_pai9 = binary2decimal(pop (:,16:16));


G_A1 = binary2decimal(pop (:,17:17));
G_A2 = binary2decimal(pop (:,18:18));
G_A3 = binary2decimal(pop (:,19:19));
G_A4 = binary2decimal(pop (:,20:20));
G_A5 = binary2decimal(pop (:,21:21));
G_A6 = binary2decimal(pop (:,22:22));
G_A7 = binary2decimal(pop (:,23:23));
G_A8 = binary2decimal(pop (:,24:24));
G_A9 = binary2decimal(pop (:,25:25));
G_A10 = binary2decimal(pop (:,26:26));
G_A11 = binary2decimal(pop (:,27:27));
G_A12 = binary2decimal(pop (:,28:28));

%Default group vectors participating in evolution.
G_D = [G_D1,G_D2,G_D3,G_D4,G_D5,G_D6,G_D7];
G_pai = [ G_pai1,G_pai2,G_pai3,G_pai4,G_pai5,G_pai6,G_pai7,G_pai8,G_pai9];
G_A = [G_A1,G_A2,G_A3,G_A4,G_A5,G_A6,G_A7,G_A8,G_A9,G_A10,G_A11,G_A12];

%Design target molecules using different groups as constants.
%{
G_D = [0,0,1,0,0,0,0];
G_D = repmat(G_D,popsize, 1);
%}
G_A = [0,1,0,0,0,0,0,0,0,0,0,0];
G_A = repmat(G_A,popsize, 1);
%}
%{
G_pai = [0,2,0,0,0,0,0,0,0];
G_pai = repmat(G_pai,popsize, 1);
%}
G_D_small = [0,0,0];
G_D_small = repmat(G_D_small,popsize, 1);

G_D_pai = [1,0,0];
G_D_pai = repmat(G_D_pai,popsize, 1);

G_pai_small = [0,0];
G_pai_small = repmat(G_pai_small,popsize, 1);

G_pai_A = [1,0];
G_pai_A = repmat(G_pai_A,popsize, 1);

G = [G_D_small,G_D,G_D_pai,G_pai,G_pai_small,G_pai_A,G_A];

W_D = [3;9;4;5;7;9;3];

W_pai = [1;1;0;3;2;2;2;2;4;4;3;1;1;1;1;0];

W_A = [6;5;4;8;5;5;3;7;1;6;4;2];
%Conjugate state
C_pai = [G_D_pai,G_pai,G_pai_small,G_pai_A]*W_pai;

C_D = G_D*W_D;

C_A = G_A*W_A;

C = C_pai+C_D+C_A;
%Second-order groups and descriptors
D_RR = G_D*[0;2;1;2;2;0;1];
D_ben = G_D*[1;3;1;1;1;3;1];
D_5ring = G_D*[0;1;1;3;3;0;1];
D_N_RING1 = G_D*[1;0;1;0;0;1;0];
D_N_RING2 = G_D*[0;1;0;1;1;0;1];
D_second = [D_RR,D_ben,D_5ring,D_N_RING1,D_N_RING2];

A_RR = G_A*[0;0;1;1;0;0;0;1;0;0;0;0];
A_6RING = G_A*[0;0;0;1;0;0;1;1;0;0;0;0];
A_5RING = G_A*[1;1;2;1;1;1;0;1;0;0;0;0];
A_CO = G_A*[1;0;2;0;0;0;0;1;0;0;0;0];
A_CN3 = G_A*[3;3;0;2;3;3;0;2;0;4;3;2];
A_O = G_A*[0;1;0;0;1;1;0;0;0;0;0;0];
A_SHUANG = G_A*[0;0;1;1;0;0;0;1;0;0;0;0];
A_second = [A_RR,A_CN3,A_O,A_6RING,A_5RING,A_CO,A_SHUANG];

pai_S = G_pai*[0;0;0;1;1;0;0;0;0];

pai_SN = G_pai*[0;1;1;0;0;0;0;0;0];

pai_ben = G_pai*[0;0;0;0;0;0;0;1;1];

x = [G,C_pai,C_D,C_A,C,D_second,A_second,pai_S,pai_SN,pai_ben];

yD = G_D*[1;1;1;1;1;1;1];
ypai = G_pai*[1;1;1;1;1;1;1;1;1];
yA = G_A*[1;1;1;1;1;1;1;1;1;1;1;1];
x=x';

load('A.mat','net'); 
ya = sim(net,x);
load('E.mat','net'); 
ye = sim(net,x);
load('U.mat','net'); 
yU = sim(net,x);
x= [x;yU;ya;ye];
load('beta.mat','net'); 
beta = sim(net,x);
objvalue=beta;
objvalue = objvalue';
n1 = (2*(yD-ones(popsize,1))).^2;
n2 = (2*(ypai-ones(popsize,1))).^2;
n3 = (2*(yA-ones(popsize,1))).^2;
objvalue = 1./((1./objvalue)+n1+n2+n3);
