% This script is generating part of Figure 4 (only the right panel of part (a)) of the article, 
% plotting the participants' reversal curve and comparing it with the model's simulations.

%% This part is computing the participants' reversal measures.

Reversal_Measures_Participants = NaN(20, 30, 13) ;

for participantIndex = 1:30
    
    load (['diCostaThero2017_Expe2_Participant', num2str(participantIndex)]); 
    reversalIndex = 0 ;

    for trialIndex = 1 : 300
        if mod(trialIndex, 30) == 1 || M(trialIndex, 1) == 1 % We withsdraw the first trial of each block and the random condition
        else
            if M(trialIndex, 8) ~= M(trialIndex-1, 8)
                reversalIndex = reversalIndex + 1 ;
                Reversal_Measures_Participants(reversalIndex, participantIndex, 1:3) = M(trialIndex-3:trialIndex-1, 4) ; % Here we select the trials before reversal
                for trialIndex2 = 0:9
                    if trialIndex+trialIndex2 <= length(M) && M(trialIndex+trialIndex2, 8) == M(trialIndex, 8)
                        Reversal_Measures_Participants(reversalIndex, participantIndex, 4+trialIndex2) = M(trialIndex+trialIndex2, 4) ; % Here we select the trials after the reversal
                    end
                end
            end
        end
    end 
end

%% This part is computing the model's reversal measures.

Reversal_Measures_Model = NaN(20*10, 30, 13) ;
options = optimset('Algorithm', 'interior-point', 'Display', 'off', 'MaxIter', 10000) ;
BestFitting_Parameters = NaN(30, 3) ;
BestFitting_Parameters_Total = NaN(30, 3, 10) ;
NegativelogLikelihood = NaN(30, 10) ;

for participantIndex = 1:30
    % First we fit the model's parameters to the participants' data.
    load (['diCostaThero2017_Expe2_Participant', num2str(participantIndex)]);
    
    % We find the best-fitting parameters by performing a gradient-descent from various random starting points
    for iterationIndex = 1:10
        [BestFitting_Parameters_Total(participantIndex, :, iterationIndex), NegativelogLikelihood(participantIndex, iterationIndex)] = ...
            fmincon(@(x) ReinforcementLearningLikelihood(x, M((M(:,1)==2), [7, 5, 6])), ...
            [10*rand(1) rand(1,2)], [],[],[],[], zeros(1,3), [Inf 1 1],[], options) ; 
    end
    [~, argmax] = max(NegativelogLikelihood(participantIndex,:)) ;
    BestFitting_Parameters(participantIndex, :) = BestFitting_Parameters_Total(participantIndex, :, argmax) ;
    
    %Then, using the best-fitting parameters, we ran the model 10 times on each of the participants' dataset.
    for iterationIndex = 0:9
        Mmodel = ReinforcementLearningSimulation(BestFitting_Parameters(participantIndex, :), M);
        
        % And we compute the reversal measures for each simulation
        reversalIndex = 0 ;
        for trialIndex = 1 : 300
            if mod(trialIndex, 30) == 1 || M(trialIndex, 1) == 1 % We withsdraw the first trial of each block and the random condition
            else
                if Mmodel(trialIndex, 8) ~= Mmodel(trialIndex-1, 8)
                    reversalIndex = reversalIndex + 1 ;
                    Reversal_Measures_Model(reversalIndex + 20 * iterationIndex, participantIndex, 1:3) = Mmodel(trialIndex-3:trialIndex-1, 4) ; % Here we select the trials before reversal
                    for trialIndex2 = 0:9
                        if trialIndex+trialIndex2 <= length(Mmodel) && Mmodel(trialIndex+trialIndex2, 8) == Mmodel(trialIndex, 8)
                            Reversal_Measures_Model(reversalIndex + 20 * iterationIndex, participantIndex, 4+trialIndex2) = Mmodel(trialIndex+trialIndex2, 4) ; % Here we select the trials after the reversal
                        end
                    end
                end
            end
        end
    end
end

%% This part is computing the participants' and the models' reversal measures.

figure(4)
subplot(3,2,2)
hold on;

% The participants' reversal measures
y = reshape(mean(nanmean(Reversal_Measures_Participants)), 1, 13) ;
sem = reshape(std(nanmean(Reversal_Measures_Participants)), 1, 13)/sqrt(30) ;
patch([1:13, 13:-1:1], [y+sem, y(end:-1:1)-sem(end:-1:1)], [.35, .35, .35], 'EdgeColor','none')
plot(y,'-','LineWidth',2,'Color','k','LineWidth',2);
text(10, 0.35, 'Participants'' data', 'HorizontalAlignment', 'center')

% The model's reversal measures
errorbar(reshape(mean(nanmean(Reversal_Measures_Model)), 1, 13), reshape(std(nanmean(Reversal_Measures_Model)), 1, 13)/sqrt(30), ...
    'x', 'Markersize', 0.1, 'LineWidth', 2, 'Color', [.7 .7 .7])
text(10, 0.2, 'Model predictions', 'HorizontalAlignment', 'center', 'Color', [.7 .7 .7])

xlim([1 13])
ylim([0 1.02])
set(gca,'Xtick',4:9,'XTickLabel',{'0', '1', '2', '3', '4', '5'})
line([3 3], [0 1.1], 'Color', 'k')
line([0 13], [.5 .5], 'Color', 'k')
xlabel('Trial number after a reversal')
text(7, 0.98, 'EXP. 2', 'HorizontalAlignment', 'center','FontSize', 12)

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

%% This function returns the choices and rewards of a reinforcement learning model given its parameters.
function M = ReinforcementLearningSimulation(parameters, Mold)

M = Mold ;

for trialIndex = 1:300
    % Action values initialization
    if M(trialIndex, 6) == 1, ActionValues = [0.5 0.5] ; end
    
    % the model's choice
    M(trialIndex, 7) = 1 * (rand < 1 /(1 + exp(parameters(1) * (ActionValues(1) - ActionValues(2))))) ; % the choice based on the action values.
    M(trialIndex, 4) = (1 - M(trialIndex, 7)) * (M(trialIndex, 8) == 0) + M(trialIndex, 7) * (M(trialIndex, 8) == 1) ; % the performance

    % the model's received reward
    if rand < 0.8 % this will happen with an 80% probability...
        M(trialIndex, 5) = 1 * (M(trialIndex, 4) == 1) + 0 * (M(trialIndex, 4) == 0) ;
    else % ...and this will happen a 20% probability
        M(trialIndex, 5) = 0 * (M(trialIndex, 4) == 1) + 1 * (M(trialIndex, 4) == 0) ;
    end

    % the action value update & normalization
    delta = M(trialIndex, 5) - ActionValues(M(trialIndex, 7) + 1) ;
    ActionValues(M(trialIndex, 7) + 1) = ActionValues(M(trialIndex, 7) + 1) + ...
        parameters(2) * delta * (delta > 0) + parameters(3) * delta * (delta <= 0) ;
    ActionValues(2 - M(trialIndex, 7)) = 1 - ActionValues(M(trialIndex, 7) + 1) ;
end

end