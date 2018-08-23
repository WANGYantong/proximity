clc
clear

addpath(genpath(pwd));
%% parameters setting
Npower=31;

FBS_NUM=16;
FBS_SEQUENCE=1:FBS_NUM;
fbsPermutation=cell(size(FBS_SEQUENCE));
for ii=1:FBS_NUM
    fbsPermutation{ii}=FBS_SEQUENCE(1:ii);
end

NumRealization=1000;

CL=1;
%% proposed algorithm
QFinal=cell(size(FBS_SEQUENCE,2),3);
QFinal_noncl=cell(size(FBS_SEQUENCE,2),3);
for ii=1:FBS_NUM
    for jj=1:3
        QFinal{ii,jj}=PA_IL_CL3(jj,Npower,ii,fbsPermutation{ii},NumRealization,CL);
        QFinal_noncl{ii,jj}=PA_IL_CL3(jj,Npower,ii,fbsPermutation{ii},NumRealization,0);
    end
end

%% proximity algorithm
mueNumber=1;
QFinal_px=cell(size(FBS_SEQUENCE,2),3);
for ii=1:FBS_NUM
    for jj=1:3
        QFinal_px{ii,jj}=proximity_R3(jj,ii,NumRealization);
    end
end

%% Performance
%MUE Capacity
proposed_MUE=zeros(FBS_NUM,3);
proposed_non_MUE=zeros(FBS_NUM,3);
proximity_MUE=zeros(FBS_NUM,3);
threshold_MUE=ones(FBS_NUM,1);
for ii=1:FBS_NUM
    for jj=1:3
        proposed_MUE(ii,jj)=QFinal{ii,jj}.mue.C;
        proposed_non_MUE(ii,jj)=QFinal_noncl{ii,jj}.mue.C;
        proximity_MUE(ii,jj)=QFinal_px{ii,jj}.mue.C;
    end
end

%figure(1);
% plot(FBS_SEQUENCE,threshold_MUE,'--k',FBS_SEQUENCE,proposed_MUE,'-*r',...
%     FBS_SEQUENCE,proposed_non_MUE,'-*g',FBS_SEQUENCE,proximity_MUE,'-*b');
% % plot(FBS_SEQUENCE,threshold_MUE,'--k',FBS_SEQUENCE,proposed_MUE,'-*r');
% xlabel('FBS Numbers');
% ylabel('Capacity');
% % ylim([0,4.5]);
% lgd=legend({'threshold','proposed RF','proposed non','proximity RF'},...
%     'location','north');
% lgd.FontSize=12;
% title('MUE Capacity');
figure(1);
plot(FBS_SEQUENCE,threshold_MUE,'--k',...
    FBS_SEQUENCE,proposed_MUE(:,1),'-*r',...
    FBS_SEQUENCE,proposed_non_MUE(:,1),'-*g',...
    FBS_SEQUENCE,proximity_MUE(:,1),'-*b');

xlabel('FBS Numbers');
ylabel('Capacity');
lgd=legend({'threshold','Cooperative QL','Formulated QL','Distributed QL'...
    },'location','north');
lgd.FontSize=12;
title('MUE Capacity, MUE(204, 207)');

figure(2);
plot(FBS_SEQUENCE,threshold_MUE,'--k',...
    FBS_SEQUENCE,proposed_MUE(:,2),'-*r',...
    FBS_SEQUENCE,proposed_non_MUE(:,2),'-*g',...
    FBS_SEQUENCE,proximity_MUE(:,2),'-*b');

xlabel('FBS Numbers');
ylabel('Capacity');
lgd=legend({'threshold','Cooperative QL','Formulated QL','Distributed QL'...
    },'location','north');
lgd.FontSize=12;
title('MUE Capacity, MUE(150, 150)');

figure(3);
plot(FBS_SEQUENCE,threshold_MUE,'--k',...
    FBS_SEQUENCE,proposed_MUE(:,3),'-*r',...
    FBS_SEQUENCE,proposed_non_MUE(:,3),'-*g',...
    FBS_SEQUENCE,proximity_MUE(:,3),'-*b');

xlabel('FBS Numbers');
ylabel('Capacity');
lgd=legend({'threshold','Cooperative QL','Formulated QL','Distributed QL'...
    },'location','north');
lgd.FontSize=12;
title('MUE Capacity, MUE(-200, 0)');

%%%%%%%%%%%%FUEs Capacity%%%%%%%%%%%%
proposed_FUE=zeros(FBS_NUM,FBS_NUM,3);
proposed_non_FUE=zeros(FBS_NUM,FBS_NUM,3);
proximity_FUE=zeros(FBS_NUM,FBS_NUM,3);
threshold_FUE=ones(FBS_NUM,1);

for ii=1:FBS_NUM
    for kk=1:3
        for jj=1:size(QFinal{ii,kk}.FBS,2)            
            proposed_FUE(ii,jj,kk)=QFinal{ii,kk}.FBS{jj}.C_FUE;
            proposed_non_FUE(ii,jj,kk)=QFinal_noncl{ii,kk}.FBS{jj}.C_FUE;
            proximity_FUE(ii,jj,kk)=QFinal_px{ii,kk}.FBS{jj}.C_FUE;
        end
    end
end

figure(4);
plot(FBS_SEQUENCE,threshold_FUE,'--k');
hold on;
for ii=1:FBS_NUM
    plot(ii,proposed_FUE(ii,1:ii,1),'*r',...
        ii,proposed_non_FUE(ii,1:ii,1),'*g',...
        ii,proximity_FUE(ii,1:ii,1),'*b','LineStyle','none');
    hold on;
end

xlabel('FBS Numbers');
ylabel('Capacity');
% ylim([0,4.5]);
lgd=legend({'threshold','Cooperative QL','Formulated QL','Distributed QL'...
    },'location','north');
lgd.FontSize=12;
title('FUEs Capacity, MUE(204, 207)');

figure(5);
plot(FBS_SEQUENCE,threshold_FUE,'--k');
hold on;
for ii=1:FBS_NUM
    plot(ii,proposed_FUE(ii,1:ii,2),'*r',...
        ii,proposed_non_FUE(ii,1:ii,2),'*g',...
        ii,proximity_FUE(ii,1:ii,2),'*b','LineStyle','none');
    hold on;
end

xlabel('FBS Numbers');
ylabel('Capacity');
% ylim([0,4.5]);
lgd=legend({'threshold','Cooperative QL','Formulated QL','Distributed QL'...
    },'location','north');
lgd.FontSize=12;
title('FUEs Capacity, MUE(150, 150)');

figure(6);
plot(FBS_SEQUENCE,threshold_FUE,'--k');
hold on;
for ii=1:FBS_NUM
    plot(ii,proposed_FUE(ii,1:ii,3),'*r',...
        ii,proposed_non_FUE(ii,1:ii,3),'*g',...
        ii,proximity_FUE(ii,1:ii,3),'*b','LineStyle','none');
    hold on;
end

xlabel('FBS Numbers');
ylabel('Capacity');
% ylim([0,4.5]);
lgd=legend({'threshold','Cooperative QL','Formulated QL','Distributed QL'...
    },'location','north');
lgd.FontSize=12;
title('FUEs Capacity, MUE(-200, 0)');

% Sum Capacity of FUEs
proposed_SFUE=zeros(FBS_NUM,3);
proposed_non_SFUE=zeros(FBS_NUM,3);
proximity_SFUE=zeros(FBS_NUM,3);
for ii=1:FBS_NUM
    for jj=1:3
        proposed_SFUE(ii,jj)=QFinal{ii,jj}.sum_CFUE;
        proposed_non_SFUE(ii,jj)=QFinal_noncl{ii,jj}.sum_CFUE;
        proximity_SFUE(ii,jj)=QFinal_px{ii,jj}.sum_CFUE;
    end
end

% figure(3);
% plot(FBS_SEQUENCE,proposed_SFUE,'-*r',FBS_SEQUENCE,proposed_non_SFUE,'-*g',...
%     FBS_SEQUENCE,proximity_SFUE,'-*b');
% % plot(FBS_SEQUENCE,proposed_SFUE,'-*r');
% xlabel('FBS Numbers');
% ylabel('Capacity');
% lgd=legend({'proposed RF','proposed non','proximity RF'},...
%     'location','north');
% lgd.FontSize=12;
% title('SUM Capacity of FUEs');
figure(7);
plot(FBS_SEQUENCE,proposed_SFUE(:,1),'-*r',...
    FBS_SEQUENCE,proposed_non_SFUE(:,1),'-*g',...
    FBS_SEQUENCE,proximity_SFUE(:,1),'-*b');
xlabel('FBS Numbers');
ylabel('Capacity');
lgd=legend({'Cooperative QL','Formulated QL','Distributed QL'...
    },'location','north');
lgd.FontSize=12;
title('Sum Capacity of FUEs, MUE(204, 207)');

figure(8);
plot(FBS_SEQUENCE,proposed_SFUE(:,2),'-*r',...
    FBS_SEQUENCE,proposed_non_SFUE(:,2),'-*g',...
    FBS_SEQUENCE,proximity_SFUE(:,2),'-*b');
xlabel('FBS Numbers');
ylabel('Capacity');
lgd=legend({'Cooperative QL','Formulated QL','Distributed QL'...
    },'location','north');
lgd.FontSize=12;
title('Sum Capacity of FUEs, MUE(150, 150)');

figure(9);
plot(FBS_SEQUENCE,proposed_SFUE(:,3),'-*r',...
    FBS_SEQUENCE,proposed_non_SFUE(:,3),'-*g',...
    FBS_SEQUENCE,proximity_SFUE(:,3),'-*b');
xlabel('FBS Numbers');
ylabel('Capacity');
lgd=legend({'Cooperative QL','Formulated QL','Distributed QL'...
    },'location','north');
lgd.FontSize=12;
title('Sum Capacity of FUEs, MUE(-200, 0)');
