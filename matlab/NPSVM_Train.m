function [model] = NPSVM_Train( InstancesMatrix, LabelVector, NPSVMParameters )
% Train model by Nonparallel Support Vector Machine, could handle multi-classes.
%   [model] = NPSVM_Train( InstancesMatrix, LabelVector, NPSVMParameters ) trains a model based on the Nonparallel Support Vector Machine model, the solver used here is SMO.
%
%   Parameters
%
%   input:
%   InstancesMatrix -- n * m matrix representing n instances with m
%   features.
%   LabelVector -- n * 1 vector as the training labels.
%   NPSVMParameters -- the parameter struct for training.
%
%   output:
%   model -- the trained model struct base on the given parameters.
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
optionStr = ['-q -s 5 -c ' num2str( NPSVMParameters.C ) ' -p ' num2str(NPSVMParameters.Epsilon) ' -m ' num2str(NPSVMParameters.CacheSize) ' -h ' num2str(NPSVMParameters.ShrinkingFlag)  ];
%
switch NPSVMParameters.KernelType
    case 'linear' 
        optionStr = [ optionStr ' -t 0' ];
    case 'rbf' 
        optionStr = [ optionStr ' -t 2 -g ' num2str( NPSVMParameters.KernelParas(1)) ];
    case 'polynomial'
        optionStr = [ optionStr ' -t 1 -g ' num2str( NPSVMParameters.KernelParas(1)) ' -r ' num2str( NPSVMParameters.KernelParas(2)) ' -d ' num2str( NPSVMParameters.KernelParas(3)) ];
    case 'sigmoid'
        optionStr = [ optionStr ' -t 3 -g ' num2str( NPSVMParameters.KernelParas(1)) ' -r ' num2str( NPSVMParameters.KernelParas(2))];
    case 'precomputed'
        optionStr = [ optionStr ' -t 4'];
    otherwise
        printf( 'Wrong Kernel Type! Use the string linear,rbf,polynomial,sigmoid and precomputed instead.' );
        return;
end 
%
model = npsvmtrain( LabelVector, InstancesMatrix, optionStr);
%
end