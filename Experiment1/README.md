Here are the data corresponding to the **Experiment 1**, and the scripts creating the **Figures 2 and 4(a) - left panel**.

### Description of the data

Each file whose name starts by `diCostaThero2017_Expe1_` contains a matrix M, which corresponds to one participant's data. There are 15 different matrices corresponding to the 15 participants in the Experiment 1.

In the matrix M, each line corresponds to one trial. The matrices can have different number of lines, because the participants's number of trials depended on their performances (the better the performance, the fewer trials they had). More precisions about the experimental procedure can be found in the article.

The different columns carry the corresponding information:

| Column number | Description |
| :-----------: |:-------------:|
| 1 | The condition number: 1 corresponds to the measure of action binding, while 2 corresponds to the measure of outcome binding.|
| 2 | The true clock position that occurred when the participants pressed the button or when the tone was played. |
| 3 | The clock position as it was reported by the participant. | 
| 4 | The participant's performance: 1 indicates that the participant had chosen the high-rewarding key, and 0 the low-rewarding key.|
| 5 | The outcome received by the participant. 0 is a low tone, indicating no reward, and 1 is a high tone, indicating a reward. |
| 6 | The trial number within a condition. |
| 7 | The participant's choice: 1 indicates that the participant had chosen the left key, and 0 the right key |
| 8 | The action-outcome mapping: 0 indicates that in this trial, the right key is high-rewarding, while 0 indicates that the right key is low-rewarding. |
| 9 | The intentional binding in ms, measured as the difference between the timing shift reported when the key press was followed by a tone, and the timing shift reported when the key was pressed without a following tone, or when the tone was heard on its own. |

Please note that the data contain only to the *agency* blocks, and not the *baseline* blocks executed by the participants before and after the *agency* blocks, as it is described in the article.

### The scripts to analyse the data

- `Figure2.m`: this script computes the mean outcome and action binding following a reward or no reward, then plot them to create the same figure as the Figure 2 in the article.

- `Figure4AExpe1.m`: this script computes the participants' and the model's reversal curve, then plot them to create a part of the Figure 4 in the article (the left panel of Figure 4(a)).
