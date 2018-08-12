clc
clear

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
QFinal=cell(size(FBS_SEQUENCE));
QFinal_noncl=cell(size(FBS_SEQUENCE));
for ii=1:FBS_NUM
    QFinal{ii}=PA_IL_CL3(Npower,ii,fbsPermutation{ii},NumRealization,CL);
    QFinal_noncl{ii}=PA_IL_CL3(Npower,ii,fbsPermutation{ii},NumRealization,0);
end

%% proximity algorithm
mueNumber=1;
QFinal_px=cell(size(FBS_SEQUENCE));
for ii=1:FBS_NUM
    QFinal_px{ii}=proximity_R3(mueNumber,ii,NumRealization);
end

%% Performance
%MUE Capacity
proposed_MUE=zeros(FBS_NUM,1);
proposed_non_MUE=zeros(FBS_NUM,1);
proximity_MUE=zeros(FBS_NUM,1);
threshold_MUE=ones(FBS_NUM,1);
for ii=1:FBS_NUM
    proposed_MUE(ii)=QFinal{ii}.mue.C;
    proposed_non_MUE(ii)=QFinal_noncl{ii}.mue.C;
    proximity_MUE(ii)=QFinal_px{ii}.mue.C;
end

figure(1);
plot(FBS_SEQUENCE,threshold_MUE,'--k',FBS_SEQUENCE,proposed_MUE,'-*r',...
    FBS_SEQUENCE,proposed_non_MUE,'-*g',FBS_SEQUENCE,proximity_MUE,'-*b');
% plot(FBS_SEQUENCE,threshold_MUE,'--k',FBS_SEQUENCE,proposed_MUE,'-*r');
xlabel('FBS Numbers');
ylabel('Capacity');
% ylim([0,4.5]);
lgd=legend({'threshold','proposed RF','proposed non','proximity RF'},...
    'location','north');
lgd.FontSize=12;
title('MUE Capacity');

%FUEs Capacity
proposed_FUE=zeros(FBS_NUM,FBS_NUM);
proposed_non_FUE=zeros(FBS_NUM,FBS_NUM);
proximity_FUE=zeros(FBS_NUM,FBS_NUM);
threshold_FUE=ones(FBS_NUM,1);

for ii=1:FBS_NUM
    for jj=1:size(QFinal{ii}.FBS,2)
        proposed_FUE(ii,jj)=QFinal{ii}.FBS{jj}.C_FUE;
        proposed_non_FUE(ii,jj)=QFinal_noncl{ii}.FBS{jj}.C_FUE;
        proximity_FUE(ii,jj)=QFinal_px{ii}.FBS{jj}.C_FUE;
    end
end

figure(2);
plot(FBS_SEQUENCE,threshold_FUE,'--k');
hold on;
for ii=1:FBS_NUM
    plot(ii,proposed_FUE(ii,1:ii),'*r',...
        ii,proposed_non_FUE(ii,1:ii),'*g',...
        ii,proximity_FUE(ii,1:ii),'*b','LineStyle','none');
    hold on;
end

xlabel('FBS Numbers');
ylabel('Capacity');
% ylim([0,4.5]);
lgd=legend({'threshold','proposed RF','proposed non','proximity RF'},...
    'location','north');
lgd.FontSize=12;
title('FUEs Capacity');

% Sum Capacity of FUEs
proposed_SFUE=zeros(FBS_NUM,1);
proposed_non_SFUE=zeros(FBS_NUM,1);
proximity_SFUE=zeros(FBS_NUM,1);
for ii=1:FBS_NUM
    proposed_SFUE(ii)=QFinal{ii}.sum_CFUE;
    proposed_non_SFUE(ii)=QFinal_noncl{ii}.sum_CFUE;
    proximity_SFUE(ii)=QFinal_px{ii}.sum_CFUE;
end

figure(3);
plot(FBS_SEQUENCE,proposed_SFUE,'-*r',FBS_SEQUENCE,proposed_non_SFUE,'-*g',...
    FBS_SEQUENCE,proximity_SFUE,'-*b');
% plot(FBS_SEQUENCE,proposed_SFUE,'-*r');
xlabel('FBS Numbers');
ylabel('Capacity');
lgd=legend({'proposed RF','proposed non','proximity RF'},...
    'location','north');
lgd.FontSize=12;
title('SUM Capacity of FUEs');
