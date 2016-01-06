function [CrossValidationAverageAccuracy] = NPSVM_CrossValidation( InstancesMatrix, LabelVector, NPSVMParameters, FoldNum )
% Run n-fold cross validation and return the average classification
% accuracy.
%   [CrossValidationAverageAccuracy] = NPSVM_CrossValidation( InstancesMatrix, LabelVector, NPSVMParameters, FoldNum )
%   makes a n-fold cross validation and calculate the average classification accuracy.

%   Parameters

%   input:
%   InstancesMatrix -- n * m matrix representing n instances with m
%   features.
%   LabelVector -- n * 1 vector as the training labels.
%   NPSVMParameters -- the parameter struct for training.
%   FoldNum -- the number of the fold.
%   
%   output:
%   CrossValidationAverageAccuracy -- averaged n-fold cross validation
%   classification accuracy.
%
%
%   Author: Xi Zhao
%   Date: 2014.09.26
%
if( size( InstancesMatrix, 1 ) ~= size( LabelVector, 1 ) )
    printf( 'Number of instances and labels do not match!' );
    return;
end
%
optionStr = ['-q -s 5 -c ' num2str( NPSVMParameters.C ) ' -p ' num2str(NPSVMParameters.Epsilon) ' -m ' num2str(NPSVMParameters.CacheSize) ' -h ' num2str(NPSVMParameters.ShrinkingFlag) ' -v ' num2str(FoldNum)  ];
%
switch NPSVMParameters.KernelType
    case 'linear' 
        optionStr = [ optionStr ' -t 0' ];
    case 'rbf' 
        optionStr = [ optionStr ' -t 2 -g ' num2str( NPSVMParameters.KernelParas(1)) ];
    case 'polynomial'
        optionStr = [ optionStr ' -t 1 -g ' num2str( NPSVMParameters.KernelParas(1)) ' -r' num2str( NPSVMParameters.KernelParas(2)) ' -d' num2str( NPSVMParameters.KernelParas(3)) ];
    case 'sigmoid'
        optionStr = [ optionStr ' -t 3 -g ' num2str( NPSVMParameters.KernelParas(1)) ' -r' num2str( NPSVMParameters.KernelParas(2))];
    case 'precomputed'
        optionStr = [ optionStr ' -t 4'];
    otherwise
        printf( 'Wrong Kernel Type! Use the string "linear", "rbf", "polynomial", "sigmoid" or "precomputed" instead.' );
        return;
end 
%
CrossValidationAverageAccuracy = npsvmtrain( LabelVector, InstancesMatrix, optionStr) / 100;
%
end