Here are the data corresponding to the **Experiment 2**, and the scripts creating the **Figure 3**, and some parts of the **Figure 4** (4b and the right panel of 4a).

### Description of the data

Each file whose name starts by `diCostaThero2017_Expe2_` contains a matrix M, which corresponds to one participant's data. There are 30 different matrices corresponding to the 30 participants in the Experiment 2.

In the matrix M, each line corresponds to one trial. All the matrices have exactly 300 lines, as this experiment had a fixed number of trials.

The different columns carry the corresponding information:

| Column number | Description |
| :-----------: |:-------------:|
| 1 | The condition number: 1 corresponds to the random condition (50% / 50% contingencies), while 2 corresponds to the learning condition (80% / 20% contingencies).|
| 2 | The original action binding in ms without taking the baseline into account. |
| 3 | The mean action binding during the baseline blocks in ms. | 
| 4 | The participant's performance: 1 indicates that the participant had chosen the high-rewarding key, and 0 the low-rewarding key.|
| 5 | The outcome received by the participant. 0 is a low tone, indicating no reward in the learning condition, and 1 is a high tone, indicating a reward in the learning condition. |
| 6 | The trial number within a block. Each condition was composed of five blocks of 30 trials. |
| 7 | The participant's choice: 1 indicates that the participant had chosen the left key, and 0 the right key |
| 8 | The action-outcome mapping: 0 indicates that in this trial, the right key is high-rewarding, while 0 indicates that the right key is low-rewarding. |
| 9 | The intentional binding in ms, measured as the difference between column 2 and 3. |
| 10 | The reaction time for pressing the key in ms. |

Please note that the data contain only to the *agency* blocks, and not the *baseline* blocks executed by the participants before and after the *agency* blocks, as it is described in the article.

### The scripts to analyse the data

- `Figure3.m`: this script computes the mean action binding following a high or low tone, then plot them to create the same figure as the Figure 3 in the article.

- `Figure4AExpe2.m`: this script computes the the participants' and the model's reversal curve, then plot them to create a part of the Figure 4 (the right panel of Figure 4(a)).

- `Figure4B.m`: this script plots the normalized learning rate asymmetry and the post-error boost in action binding for each participant to create the same figure as Figure 4(b).
