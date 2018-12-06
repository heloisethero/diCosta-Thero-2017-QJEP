% This script is generating part (b) of Figure 4 of the article, plotting
% the normalized learning rate asymmetry and the post-error boost in action
% binding for each participant, from the learning condition of Experiment 2. 

%% This part is computing the participants' post-error boost of action binding.
postErrorBoostActionBinding = NaN(1,30) ;

for participantIndex = 1:30
    Action_Binding = NaN(300, 2) ;
    load (['diCostaThero2017_Expe2_Participant', num2str(participantIndex)]); 

    for trialIndex = 1 : 300
        if M(trialIndex, 6) > 1 && M(trialIndex, 1) == 2
            Action_Binding(trialIndex, M(trialIndex - 1, 5) + 1) = M(trialIndex, 9) ;
        end
    end 
    
    postErrorBoostActionBinding(participantIndex) = nanmean(Action_Binding(:,1)) - nanmean(Action_Binding(:,2)) ;
end


%% This part is computing the participants' learning rate asymmetry.
learningRateAsymmetry = NaN(1, 30) ;
options = optimset('Algorithm', 'interior-point', 'Display', 'off', 'MaxIter', 10000) ;

for participantIndex = 1:30
    BestFitting_Parameters_Total = NaN(3, 10) ;
    NegativelogLikelihood = NaN(1, 10) ;

    % First we fit the model's parameters to the participants' data.
    load (['diCostaThero2017_Expe2_Participant', num2str(participantIndex)]);
    
    % We find the best-fitting parameters by performing a gradient-descent from various random starting points
    for iterationIndex = 1:10
        [BestFitting_Parameters_Total(:, iterationIndex), NegativelogLikelihood(iterationIndex)] = ...
            fmincon(@(x) ReinforcementLearningLikelihood(x, M((M(:,1)==2), [7, 5, 6])), ...
            [10*rand(1) rand(1,2)], [],[],[],[], zeros(1,3), [Inf 1 1],[], options) ; 
    end
    [~, argmax] = max(NegativelogLikelihood) ;
    learningRateAsymmetry(participantIndex) = ...
        (BestFitting_Parameters_Total(3, argmax) - BestFitting_Parameters_Total(2, argmax)) ./ ...
        (BestFitting_Parameters_Total(3, argmax) + BestFitting_Parameters_Total(2, argmax)) ;
end

%% This part is plotting Figure 4(b)
linearCoefficients = polyfit(learningRateAsymmetry, postErrorBoostActionBinding, 1) ;

figure(4)
subplot(3, 2, 3:6)
hold on
plot(learningRateAsymmetry, postErrorBoostActionBinding, 'd', 'MarkerSize', 10, 'MarkerEdgeColor', 'b', 'MarkerFaceColor', [.7 .7 .7])
plot(linspace(-1, 1, 100), polyval(linearCoefficients, linspace(-1, 1, 100)), 'k-', 'LineWidth', 1);
line([0 0], [-50 85], 'Color', 'black', 'LineWidth', .8, 'LineStyle','--')
line([-1 1], [0 0], 'Color', 'black', 'LineWidth', .8, 'LineStyle','--')
hold off

text(0, 100, 'Post-error boost', 'HorizontalAlignment', 'center','FontSize', 12)
text(0, 90, 'in action binding', 'HorizontalAlignment', 'center','FontSize', 12)
text(0.7, -10, 'Normalized learning', 'HorizontalAlignment', 'center','FontSize', 12)
text(0.7, -20, 'rate asymmetry', 'HorizontalAlignment', 'center','FontSize', 12)
text(-0.4, 60, 'EXP. 2', 'HorizontalAlignment', 'center','FontSize', 14)
ylim([-40 105])

%% This function returns the negative log likelihood of a reinforcement learning model given its parameters and the participants' data.
function NegativelogLikelihood = ReinforcementLearningLikelihood(parameters, data)

NegativelogLikelihood = 0 ;

for trialIndex = 1 : length(data)
    % Action values initialization
    if data(trialIndex, 3) == 1, ActionValues = [0.5 0.5] ; end
    
    % Likelihood computation
    NegativelogLikelihood = NegativelogLikelihood - parameters(1) * ActionValues(data(trialIndex, 1) + 1) + ...
        log(sum(exp(parameters(1) * ActionValues)));
        
    % Action value update
    delta = data(trialIndex, 2) - ActionValues(data(trialIndex, 1) + 1) ;
    ActionValues(data(trialIndex, 1) + 1) = ActionValues(data(trialIndex, 1) + 1) + ...
        parameters(2) * delta * (delta > 0) + parameters(3) * delta * (delta <= 0) ;
    
    % Action value normalization
    ActionValues(2 - data(trialIndex, 1)) = 1 - ActionValues(data(trialIndex, 1) + 1) ;
end

end