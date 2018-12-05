Here are the data corresponding to Experiment 2, and the scripts creating Figures 3, the right panel of 4(a) and 4(b).

THE DATA:

Each file whose name starts by "diCostaThero2017_Expe2_" contains a matrix M, which corresponds to one participant' data. There are 30 different matrices corresponding to the 30 participants in the Experiment 2.

In the matrix M, each line corresponds to one trial. All the matrices have exactly 300 lines, as this experiment had a fixed number of trials.

The different columns carry the corresponding information:

- column 1: the condition number. Condition 1 corresponds to the random condition (50% / 50% contingencies), while condition 2 corresponds to the learning condition (80% / 20% contingencies). The data contain only to the 'agency' blocks, and not the 'baseline' blocks executed by the participants before and after the 'agency' blocks.

- column 2: the original action binding (without taking the baseline into account).

- column 3: the mean action binding during the baseline blocks.

- column 4: the participant's performance. 1 indicates that the participant had chosen the high-rewarding key, and 0 the low-rewarding key.

- column 5: the outcome received by the participant. The outcomes could either be 0 (a low tone, indicating no reward in the learning condition) or 1 (a high tone, indicating a reward in the learning condition).

- column 6: the trial number within a block (each condition was composed of five blocks of 30 trials).

- column 7: the participant's choice. 1 indicates that the participant had chosen the left key, and 0 the right key.

- column 8: the action-outcome mapping. 0 indicates that in this trial, the right key is high-rewarding, while 0 indicates that the right key is low-rewarding.

- column 9: the intentional binding, measured as the difference between the timing shift reported when the key press was followed by a tone, and the the timing shift reported when the key was pressed without a following tone.

- column 10: the reaction time for pressing the key (in ms).

THE BEHAVIORAL ANALYSIS:

The Figure3.m file will compute the mean action binding following a high or low tone, then plot them to create the same figure as the Figure 3 in the article.

The Figure4AExpe2.m file will compute the the participants' and the model's reversal curve, then plot them to create a part of the Figure 4 (the right panel of Figure 4(a)).

The Figure4B.m file will plot the normalized learning rate asymmetry and the post-error boost in action binding for each participant to create the same figure as Figure 4(b).