PFAS
===
# About PFAS


This work provides the code to generate Pareto Front that get ranked gracefully. This code contains two part. 
- The first part is the main function, which contains file reading, data input, call function, fronts output. 
- The second part is the PFASfunction, which performs the calculation using the input data. 

The PFASfunction function takes four columns as input：
- First raw is sequence ID
- Second raw is sequence
- Third raw and fourth raw is T and B cell scores. 

The larger the T and B cell scores, the better the performance, and the goal of the PFASfunction function is to maximize the two scores. Finally, the PFASfunction function generates fronts,and ranks the input samples according to the front ranks.


# User guideline


### PFASfunction - ParetoFront code
1. Set file path
```matlab=
file_path = 'D:\ParetoFront_path\';
```

2.	download all table in a file
```matlab=
file = dir([file_path,'*input.xlsx']);
input = readcell(strcat(file.folder,'\',file.name));
```

3.	set a project name
```matlab=
projectname = 'Example_';
```

4.	do the Pareto Front approach

```matlab=
output = ParetoFront_PFAVC(input);
```

5.	output the result

```matlab=
writecell(output,strcat(file_path ,projectname,' paretoFront.xlsx'));
```
### PFASfunction - Inputs and output
#### Inputs:
- input  : cells, first raw is sequence ID, second raw is sequence, third
raw and fourth raw is T and B scores.
 
#### Outputs:
- output    : input data with Pareto-filtered ranking
 
- Example:
    - ```input```
    >{'ID'}    {'SEQUENCE'}    {'T cell score'}    {'B cells core'}
    
    >3×4 cell array
    >{[1]}    {'MIILIFLIFSNIVLS'}    {[0.6600]}    {[0.3778]}
    >{[2]}    {'IILIFLIFSNIVLSI'}    {[0.4730]}    {[0.2589]}
    >{[3]}    {'ILIFLIFSNIVLSID'}    {[0.7265]}    {[0.2693]}
 
    - ```output = ParetoFront_PFAVC(input)```
    - ```output```
    >{'ID'}    {'SEQUENCE'}    {'T cell score'}    {'B cells core'} {'Pareto Front rank'}
    >9×5 cell array 
    >{[ 236]}    {'KHVEEIESPPPESNE'}    {[0.1632]}    {[0.9737]}    {[1]}
    >{[ 237]}    {'HVEEIESPPPESNEE'}    {[0.1296]}    {[     1]}    {[1]}
    >{[ 238]}    {'VEEIESPPPESNEEE'}    {[0.2677]}    {[0.9270]}    {[1]}
    >{[3530]}    {'FRTQLEDTRREVNNL'}    {[0.5550]}    {[0.8956]}    {[1]}
    >{[  94]}    {'TYQVVWNQIINYTIK'}    {[0.9329]}    {[0.7240]}    {[2]}
    >{[ 147]}    {'FVKYTNESILEYNWN'}    {[0.9590]}    {[0.6944]}    {[2]}
    >{[ 233]}    {'KRKKHVEEIESPPPE'}    {[0.3829]}    {[0.9011]}    {[2]}
    >{[ 235]}    {'KKHVEEIESPPPESN'}    {[0.3060]}    {[0.9012]}    {[2]}
    >{[ 265]}    {'PSPREPLLPKPYSRY'}    {[0.7068]}    {[0.8483]}    {[2]}