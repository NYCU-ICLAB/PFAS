function output = PFASfunction(input)
% =========================================================================
% ============ input analysis data ========================================
% =========================================================================
% clc;clear;close all;
% file_path = 'D:\PFASfunction_datafile\';
% 
% % download all table in a file
% file = dir([file_path,'*input.xlsx']);
% [~, ~, input] = xlsread(strcat(file.folder,'\',file.name));
% input = readcell(strcat(file.folder,'\',file.name));
% projectname = 'Example_';
% 
% output = ParetoFront_PFAVC(input);
% xlswrite(strcat(file_path ,projectname,' paretoFront.xlsx'),output);
% writecell(output,strcat(file_path ,projectname,' paretoFront.xlsx'));

% =========================================================================
% ============ INPUT and OUTPUT of ParetoFront_PFAVC ======================
% =========================================================================
% Inputs:
% - input  : cells, first raw is sequence ID, second raw is sequence, third
% raw and fourth raw is T and B scores.
% 
% Outputs:
% - output    : input data with Pareto-filtered ranking
% 
% Example:
% input =
% 3×4 cell array
%     {[1]}    {'MIILIFLIFSNIVLS'}    {[0.6600]}    {[0.3778]}
%     {[2]}    {'IILIFLIFSNIVLSI'}    {[0.4730]}    {[0.2589]}
%     {[3]}    {'ILIFLIFSNIVLSID'}    {[0.7265]}    {[0.2693]}
% 
% output = ParetoFront_PFAVC(input)
% output =
% 9×5 cell array
% 
%     {[ 236]}    {'KHVEEIESPPPESNE'}    {[0.1632]}    {[0.9737]}    {[1]}
%     {[ 237]}    {'HVEEIESPPPESNEE'}    {[0.1296]}    {[     1]}    {[1]}
%     {[ 238]}    {'VEEIESPPPESNEEE'}    {[0.2677]}    {[0.9270]}    {[1]}
%     {[3530]}    {'FRTQLEDTRREVNNL'}    {[0.5550]}    {[0.8956]}    {[1]}
%     {[  94]}    {'TYQVVWNQIINYTIK'}    {[0.9329]}    {[0.7240]}    {[2]}
%     {[ 147]}    {'FVKYTNESILEYNWN'}    {[0.9590]}    {[0.6944]}    {[2]}
%     {[ 233]}    {'KRKKHVEEIESPPPE'}    {[0.3829]}    {[0.9011]}    {[2]}
%     {[ 235]}    {'KKHVEEIESPPPESN'}    {[0.3060]}    {[0.9012]}    {[2]}
%     {[ 265]}    {'PSPREPLLPKPYSRY'}    {[0.7068]}    {[0.8483]}    {[2]}

% ====== initialization =====
pf_input = input;
p_record =[];
idxs_record = [];
pf_input_tmp = pf_input;
output = [];
% ====== paretoFront ========
set_number = 1;
while size( p_record,1) < size(pf_input,1)
    
    [ p, idxs] = paretoFront(  cell2mat(pf_input_tmp(:,3:4)) );    
    p_record =[p_record ;p];
    idxs_record = [idxs_record ;pf_input_tmp(idxs,:)];
    output = [output; [idxs_record repelem(num2cell(set_number),size(idxs_record,1))']];
    idxs_record = [];
    pf_input_tmp (idxs,:) = [];
    set_number = set_number + 1;
end
end

function [ j, idx] = paretoFront( j )
[i, dim] = size(j);
idx = [1 : i]';
while i >= 1
    old_size = size(j,1);
    indices = sum( bsxfun( @ge, j(i,:), j ), 2 ) == dim;
    indices(i) = false;
    j(indices,:) = [];
    idx(indices) = [];
    i = i - 1 - (old_size - size(j,1)) + sum(indices(i:end));
end
end