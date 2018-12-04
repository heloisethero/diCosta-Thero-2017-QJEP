Here are the data corresponding to Experiment 1, and the scripts creating Figures 2 and 4(a) - left panel.

THE DATA:

Each file whose name starts by "diCostaThero2017_Expe1_" contains a matrix M, which corresponds to one participant' data. There are 15 different matrices corresponding to the 15 participants in the Experiment 1.

In the matrix M, each line corresponds to one trial. The matrices can have different number of lines, because the participants's number of trials depended on their performances (the better the performance, the fewer trials they had). More precisions about the experimental procedure can be found in the article.

The different columns carry the corresponding information:

- column 1: the condition number. Condition 1 corresponds to the measure of action binding, while condition 2 corresponds to the measure of outcome binding. The data contain only to the 'agency' blocks, and not the 'baseline' blocks executed by the participants before and after the 'agency' blocks.

- column 2: the true clock position that occurred when the participants pressed the button or when the tone was played.

- column 3: the clock position as it was reported by the participant.

- column 4: the participant's performance. 1 indicates that the participant had chosen the high-rewarding key, and 0 the low-rewarding key.

- column 5: the outcome received by the participant. The outcomes could either be 0 (no reward) or 1 (reward).

- column 6: the trial number within a condition.

- column 7: the participant's choice. 1 indicates that the participant had chosen the left key, and 0 the right key.

- column 8: the action-outcome mapping. 0 indicates that in this trial, the right key is high-rewarding, while 0 indicates that the right key is low-rewarding.

- column 9: intentional binding, measured as the difference between the timing shift reported when the key press was followed by a tone, and the the timing shift reported when the key was pressed without a following tone, or when the tone was heard on its own.

THE BEHAVIORAL ANALYSIS:

The Figure2.m file will compute the mean outcome and action binding following a reward or no reward, then plot them to create the same figure as the Figure 2 in the article.

The Figure4Expe1.m will compute the reversal curves for both the participants and the model predictions, then plot them to create a figure similar to the Figure 4 (A) left panel presented in the article.
