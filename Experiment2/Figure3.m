% This script is generating the Figure 3 of the article, plotting action binding from the second experiment.

%% This part is computing the action binding measures
Action_Binding = NaN(300, 30, 4) ;

for participantIndex = 1:30
    
    load (['diCostaThero2017_Expe2_Participant', num2str(participantIndex)]); 

    for trialIndex = 1 : 300
        if M(trialIndex, 6) > 1
            if M(trialIndex, 1) == 1
                Action_Binding(trialIndex, participantIndex, M(trialIndex - 1, 5) + 1) = M(trialIndex, 9) ;
            else
                Action_Binding(trialIndex, participantIndex, M(trialIndex - 1, 5) + 3) = M(trialIndex, 9) ;
            end
        end
    end         
end

%% This part is creating the Figure 3
figure(3)
subplot(3, 2, [2, 4])
hold on
barh(1.1, nanmean(nanmean(Action_Binding(:,:,1))), 'FaceColor', [.35, .35, .35], 'EdgeColor', [.35, .35, .35])
barh(1.9, nanmean(nanmean(Action_Binding(:,:,2))), 'FaceColor', [.85, .85, .85], 'EdgeColor', [.85, .85, .85])
barh(3.1, nanmean(nanmean(Action_Binding(:,:,3))), 'FaceColor', [.35, .35, .35], 'EdgeColor', [.35, .35, .35])
barh(3.9, nanmean(nanmean(Action_Binding(:,:,4))), 'FaceColor', [.85, .85, .85], 'EdgeColor', [.85, .85, .85])
line([nanmean(nanmean(Action_Binding(:,:,1))) + nanstd(nanmean(Action_Binding(:,:,1)))/sqrt(30) nanmean(nanmean(Action_Binding(:,:,1)))-nanstd(nanmean(Action_Binding(:,:,1)))/sqrt(30)], [1.1 1.1], 'Color', 'black', 'LineWidth', .8)
line([nanmean(nanmean(Action_Binding(:,:,2))) + nanstd(nanmean(Action_Binding(:,:,2)))/sqrt(30) nanmean(nanmean(Action_Binding(:,:,2)))-nanstd(nanmean(Action_Binding(:,:,2)))/sqrt(30)], [1.9 1.9], 'Color', 'black', 'LineWidth', .8)
line([nanmean(nanmean(Action_Binding(:,:,3))) + nanstd(nanmean(Action_Binding(:,:,3)))/sqrt(30) nanmean(nanmean(Action_Binding(:,:,3)))-nanstd(nanmean(Action_Binding(:,:,3)))/sqrt(30)], [3.1 3.1], 'Color', 'black', 'LineWidth', .8)
line([nanmean(nanmean(Action_Binding(:,:,4))) + nanstd(nanmean(Action_Binding(:,:,4)))/sqrt(30) nanmean(nanmean(Action_Binding(:,:,4)))-nanstd(nanmean(Action_Binding(:,:,4)))/sqrt(30)], [3.9 3.9], 'Color', 'black', 'LineWidth', .8)
hold off
xlim([-10 60])
set(gca,'Ytick',[1.1, 1.9, 3.1, 3.9],'YTickLabel',{'Low tone on trial t', 'High tone on trial t', 'No reward (low tone) on trial t', 'Reward (high tone) on trial t'})
xlabel('\bfAction binding on trial t + 1 (in ms)')

axes('Position',[0 0 1 1],'Visible','off') ;
text(.22, .82, 'LEARNING', 'HorizontalAlignment', 'center', 'FontSize', 12)
text(.22, .78, 'CONDITION', 'HorizontalAlignment', 'center', 'FontSize', 12)
text(.22, .56, 'RANDOM', 'HorizontalAlignment', 'center', 'FontSize', 12)
text(.22, .52, 'CONDITION', 'HorizontalAlignment', 'center', 'FontSize', 12)