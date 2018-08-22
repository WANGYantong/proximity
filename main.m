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
% mueNumber=1;
% QFinal_px=cell(size(FBS_SEQUENCE));
% for ii=1:FBS_NUM
%     QFinal_px{ii}=proximity_R3(mueNumber,ii,NumRealization);
% end

%% Performance
%MUE Capacity
proposed_MUE=zeros(FBS_NUM,3);
proposed_non_MUE=zeros(FBS_NUM,3);
% proximity_MUE=zeros(FBS_NUM,1);
threshold_MUE=ones(FBS_NUM,1);
for ii=1:FBS_NUM
    for jj=1:3
        proposed_MUE(ii,jj)=QFinal{ii,jj}.mue.C;
        proposed_non_MUE(ii,jj)=QFinal_noncl{ii,jj}.mue.C;
        %     proximity_MUE(ii)=QFinal_px{ii}.mue.C;
    end
end

figure(1);
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
plot(FBS_SEQUENCE,threshold_MUE,'--k',...
    FBS_SEQUENCE,proposed_MUE(:,1),'-*r',...
    FBS_SEQUENCE,proposed_MUE(:,2),'-*g',...
    FBS_SEQUENCE,proposed_MUE(:,3),'-*b',...
    FBS_SEQUENCE,proposed_non_MUE(:,1),'--*r',...
    FBS_SEQUENCE,proposed_non_MUE(:,2),'--*g',...
    FBS_SEQUENCE,proposed_non_MUE(:,3),'--*b');
xlabel('FBS Numbers');
ylabel('Capacity');
lgd=legend({'threshold','pro_cl(loc1)','pro_cl(loc2)','pro_cl(loc3)',...
    'pro_non(loc1)','pro_non(loc2)','pro_non(loc3)'},...
    'location','north');
lgd.FontSize=10;
title('MUE Capacity');


%FUEs Capacity
% proposed_FUE=zeros(FBS_NUM,FBS_NUM);
% proposed_non_FUE=zeros(FBS_NUM,FBS_NUM);
% proximity_FUE=zeros(FBS_NUM,FBS_NUM);
% threshold_FUE=ones(FBS_NUM,1);
% 
% for ii=1:FBS_NUM
%     for jj=1:size(QFinal{ii}.FBS,2)
%         proposed_FUE(ii,jj)=QFinal{ii}.FBS{jj}.C_FUE;
%         proposed_non_FUE(ii,jj)=QFinal_noncl{ii}.FBS{jj}.C_FUE;
%         proximity_FUE(ii,jj)=QFinal_px{ii}.FBS{jj}.C_FUE;
%     end
% end
% 
% figure(2);
% plot(FBS_SEQUENCE,threshold_FUE,'--k');
% hold on;
% for ii=1:FBS_NUM
%     plot(ii,proposed_FUE(ii,1:ii),'*r',...
%         ii,proposed_non_FUE(ii,1:ii),'*g',...
%         ii,proximity_FUE(ii,1:ii),'*b','LineStyle','none');
%     hold on;
% end
% 
% xlabel('FBS Numbers');
% ylabel('Capacity');
% % ylim([0,4.5]);
% lgd=legend({'threshold','proposed RF','proposed non','proximity RF'},...
%     'location','north');
% lgd.FontSize=12;
% title('FUEs Capacity');

% Sum Capacity of FUEs
proposed_SFUE=zeros(FBS_NUM,3);
proposed_non_SFUE=zeros(FBS_NUM,3);
proximity_SFUE=zeros(FBS_NUM,3);
for ii=1:FBS_NUM
    for jj=1:3
        proposed_SFUE(ii,jj)=QFinal{ii,jj}.sum_CFUE;
        proposed_non_SFUE(ii,jj)=QFinal_noncl{ii,jj}.sum_CFUE;
        %     proximity_SFUE(ii)=QFinal_px{ii}.sum_CFUE;
    end
end

figure(3);
% plot(FBS_SEQUENCE,proposed_SFUE,'-*r',FBS_SEQUENCE,proposed_non_SFUE,'-*g',...
%     FBS_SEQUENCE,proximity_SFUE,'-*b');
% % plot(FBS_SEQUENCE,proposed_SFUE,'-*r');
% xlabel('FBS Numbers');
% ylabel('Capacity');
% lgd=legend({'proposed RF','proposed non','proximity RF'},...
%     'location','north');
% lgd.FontSize=12;
% title('SUM Capacity of FUEs');
plot(FBS_SEQUENCE,proposed_SFUE(:,1),'-*r',...
    FBS_SEQUENCE,proposed_SFUE(:,2),'-*g',...
    FBS_SEQUENCE,proposed_SFUE(:,3),'-*b',...
    FBS_SEQUENCE,proposed_non_SFUE(:,1),'--*r',...
    FBS_SEQUENCE,proposed_non_SFUE(:,2),'--*g',...
    FBS_SEQUENCE,proposed_non_SFUE(:,3),'--*b');
xlabel('FBS Numbers');
ylabel('Capacity');
lgd=legend({'pro_cl(loc1)','pro_cl(loc2)','pro_cl(loc3)',...
    'pro_non(loc1)','pro_non(loc2)','pro_non(loc3)'},...
    'location','north');
lgd.FontSize=10;
title('SUM Capacity of FUEs');
