 clc
clear all；
data = load('C:\Users\Arthas\Desktop\train.csv');
MAE=0;
Mape=0;
MSE=0;
i=1;
R=0;
R2=0;
MAE_train=0;
Mape_train=0;
MSE_train=0;
R2_train=0;
R_train=0;
FAN = [];
while i<=100
    data = data(randperm(size(data,1)),:); 
    ind = round(0.9 * size(data,1)); 
    trainData = data(1:ind, 1:end); 
    testData = data(ind+1:end, 1:end);
     P_train = trainData(:,1:57);
     T_train_niu = trainData(:,58:58);
     T_train_a = trainData(:,59:59);
     T_train_E = trainData(:,60:60);
     
     
     T_train_beta = trainData(:,61:61);
     P_train_beta=trainData(:,1:60);
     
     
     P_test = testData(:,1:57);
     T_test = testData(:,61:61);
     
     
     T_train_niu = T_train_niu';
     T_train_a = T_train_a';
     T_train_E = T_train_E';
     T_train_beta=T_train_beta';
     P_train_beta=P_train_beta';
     P_train=P_train';
     P_test =  P_test';
     T_test = T_test';
     
    net = feedforwardnet([22,16],'trainbr');
    net.trainParam.epochs = 1000;
    net.trainParam.goal = 2;
    net.trainParam.mu = 0.001;
    net = train(net,P_train,T_train_niu);
    t_sim_niu = sim(net,P_test);
     
    net = feedforwardnet([22,16],'trainbr');
    net.trainParam.epochs = 1000;
    net.trainParam.goal = 1200;
    net.trainParam.mu = 0.001;
    net = train(net,P_train,T_train_a);
    t_sim_a = sim(net,P_test);
    
    
    net = feedforwardnet([22,16],'trainbr');
    net.trainParam.epochs = 1000;
    net.trainParam.goal = 0.012;
    net.trainParam.mu = 0.001;
    net = train(net,P_train,T_train_E);
    t_sim_E = sim(net,P_test);
    
    P_test = [P_test;t_sim_niu;t_sim_a;t_sim_E];
    
    
    P_train=P_train_beta;
    T_train=T_train_beta;
    
    net = feedforwardnet([60,35],'trainbr');
    net.trainParam.epochs = 100;
    net.trainParam.goal = 0.01;
    net.trainParam.mu = 0.001;
    net = train(net,P_train,T_train);
    t_sim_train = sim(net,P_train);
    t_sim = sim(net,P_test);
    x1 = corrcoef(t_sim,T_test);
    r = x1(1,2);
    r2 = x1(1,2)^2;
    mae_train = mean(abs(t_sim_train - T_train));
    mse_train = mean((abs((t_sim_train - T_train).^2)));
    mape_train = mean(abs((t_sim_train - T_train)./T_train));
    x1_train = corrcoef(t_sim_train,T_train);
    r_train = x1_train(1,2);
    r2_train = x1_train(1,2)^2;
    mae = mean(abs(t_sim - T_test));
    mse = mean((abs((t_sim - T_test).^2)));
    mape = mean(abs((t_sim - T_test)./T_test));
    %fan=[mape_train;mape];
    %FAN = [FAN,fan];
    R2=R2+r2;
    R=R+r;
    MAE=(MAE+mae);
    MSE=(MSE+mse);
    Mape=(Mape+mape);
    MAE_train=(MAE_train+mae_train);
    MSE_train=(MSE_train+mse_train);
    Mape_train=(Mape_train+mape_train);
    R2_train=R2_train+r2_train;
    R_train=R_train+r_train;
    i=i+1;
end
MAE=MAE/(i-1);
Mape=Mape/(i-1);
MSE=MSE/(i-1);
R2=R2/(i-1);
R=R/(i-1);
MAE_train=MAE_train/(i-1);
Mape_train=Mape_train/(i-1);
MSE_train=MSE_train/(i-1);
R2_train=R2_train/(i-1);
R_train=R_train/(i-1);
fprintf ('MAE=%d/', MAE);
fprintf ('MSE=%d/', MSE);
fprintf ('Mape=%d/', Mape);
fprintf ('R=%d/', R);
fprintf('R2=%d/', R2);
fprintf ('MAE_train=%d/', MAE_train);
fprintf ('MSE_train=%d/', MSE_train);
fprintf ('Mape_train=%d/',Mape_train);
fprintf ('R_train=%d/',R_train);
fprintf('R2_train=%d/',R2_train);
    
    