% This script is generating the Figure 2 of the article, plotting action and outcome binding from the first experiment.

%% This part is computing the binding measures

Action_Binding = NaN(500, 15, 2) ;
Outcome_Binding = NaN(500, 15, 2) ;

for participantIndex = 1:15
    
    load (['diCostaThero2017_Expe1_Participant', num2str(participantIndex)]); 

    for trialIndex = 2 : length(M)
        if M(trialIndex, 1) == 1 && M(trialIndex, 6) == M(trialIndex + 1 , 6) - 1
            Action_Binding(trialIndex, participantIndex, M(trialIndex - 1, 5) + 1) = M(trialIndex, 9) ;

        elseif M(trialIndex, 1) == 2
            Outcome_Binding(trialIndex, participantIndex, M(trialIndex, 5) + 1) = M(trialIndex, 9) ;
        end
    end         
end

%% This part is creating the Figure 2
figure (2)
subplot(3,2,1)
hold on
barh(1, nanmean(nanmean(Outcome_Binding(:,:,1))), 'FaceColor', [.35, .35, .35], 'EdgeColor', [.35, .35, .35])
barh(2, nanmean(nanmean(Outcome_Binding(:,:,2))), 'FaceColor', [.85, .85, .85], 'EdgeColor', [.85, .85, .85])
line([nanmean(nanmean(Outcome_Binding(:,:,1))) + nanstd(nanmean(Outcome_Binding(:,:,1)))/sqrt(15) nanmean(nanmean(Outcome_Binding(:,:,1)))-nanstd(nanmean(Outcome_Binding(:,:,1)))/sqrt(15)], [1 1], 'Color', 'black', 'LineWidth', .8)
line([nanmean(nanmean(Outcome_Binding(:,:,2))) + nanstd(nanmean(Outcome_Binding(:,:,2)))/sqrt(15) nanmean(nanmean(Outcome_Binding(:,:,2)))-nanstd(nanmean(Outcome_Binding(:,:,2)))/sqrt(15)], [2 2], 'Color', 'black', 'LineWidth', .8)
hold off
xlim([-150 0])
yticks([])
set(gca,'ycolor',[1 1 1])
xlabel('Outcome binding on trial t (in ms)')

subplot(3,2,2)
hold on
barh(1, nanmean(nanmean(Action_Binding(:,:,1))), 'FaceColor', [.35, .35, .35], 'EdgeColor', [.35, .35, .35])
barh(2, nanmean(nanmean(Action_Binding(:,:,2))), 'FaceColor', [.85, .85, .85], 'EdgeColor', [.85, .85, .85])
line([nanmean(nanmean(Action_Binding(:,:,1))) + nanstd(nanmean(Action_Binding(:,:,1)))/sqrt(15) nanmean(nanmean(Action_Binding(:,:,1)))-nanstd(nanmean(Action_Binding(:,:,1)))/sqrt(15)], [1 1], 'Color', 'black', 'LineWidth', .8)
line([nanmean(nanmean(Action_Binding(:,:,2))) + nanstd(nanmean(Action_Binding(:,:,2)))/sqrt(15) nanmean(nanmean(Action_Binding(:,:,2)))-nanstd(nanmean(Action_Binding(:,:,2)))/sqrt(15)], [2 2], 'Color', 'black', 'LineWidth', .8)
hold off
xlim([0 150])
set(gca,'Ytick',[1, 2],'YTickLabel',{'No reward on trial t', 'Reward on trial t   '})
xlabel('Action binding on trial t + 1 (in ms)')
