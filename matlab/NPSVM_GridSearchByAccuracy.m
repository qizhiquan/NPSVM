function [bestAccuracy, bestC, bestEpsilon, bestRBFDelta] = NPSVM_GridSearchByAccuracy( InstancesMatrix, LabelVector, FoldNum, NPSVMParameters, CParaSet, EpsilonParaSet, RBFParaSet )
% Select the best model( best parameters ) from the pregiven parameter candidates according to the average n-fold cross-validation classification
% accuracy on single dataset, only 'linear' and 'rbf' kernel are available in current version.
%   [bestAccuracy, bestC, bestEpsilon, bestRBFDelta] = NPSVM_GridSearchByAccuracy( InstancesMatrix, LabelVector, FoldNum, NPSVMParameters, CParaSet, EpsilonParaSet, RBFParaSet )
%   use grid search to get the best model( which mean best parameters ),
%   for each try in the grid search, n-fold NPSVM_CrossValidation()
%   function is performed and the average classification accuracy is
%   obtained. By comparing the accuracy, the model( the parameters ) with
%   the best generalization performance is returned.
%
%   Parameters
%
%   input:
%   InstancesMatrix -- n * m matrix representing n instances with m
%   features for training.
%   LabelVector -- n * 1 vector as the training labels.
%   FoldNum -- fold number for cross-validation.
%   NPSVMParameters -- the parameter struct for training.
%   CParaSet -- the parameter candidate set for C.
%   EpsilonParaSet -- the parameter candidate set for Epsilon.
%   RBFParaSet -- the parameter candidate set for RBF kernel parameter delta.
%
%   output:
%   bestAccuracy -- average classification accuracy on n fold.
%   bestC -- C parameter of the best model.
%   bestEpsilon -- Epsilon parameter of the best model.
%   bestRBFDelta -- RBF delta parameter of the best model.
%
%
%   Author: Xi Zhao
%   Date: 2014.09.26
%
% chech the dimension
if( size( InstancesMatrix, 1 ) ~= size( LabelVector, 1 ) )
    printf( 'Number of instances and labels do not match!' );
    return;
end
%
bestAccuracy = -inf;
bestC = -1;
bestEpsilon = -1;
bestRBFDelta = -1;
% for each C parameter
for i=1:size( CParaSet, 1 )
    % C parameter
    currCValue = CParaSet( i, 1 );
    % for each Epsilon parameter
    for j=1:size( EpsilonParaSet, 1 )
        % Epsilon parameter
        currEpsilon = EpsilonParaSet( j, 1 );
        % rbf kernel
        if( strcmp( NPSVMParameters.KernelType , 'rbf'))
            % for each RBF parameter
            for k=1:size( RBFParaSet, 1 )
                % rbf parameter
                currDelta = RBFParaSet( k, 1 );
                % model parameter
                NPSVMParameters.C = currCValue;
                NPSVMParameters.Epsilon = currEpsilon;
                NPSVMParameters.KernelParas = [currDelta];
                % print current parameters
                fprintf('C= %f, Epsilon= %f, RBF Delta= %f \n', currCValue, currEpsilon, currDelta );
                % cross validation
                [currCrossValidationAverageAccuracy] = NPSVM_CrossValidation( InstancesMatrix, LabelVector, NPSVMParameters, FoldNum );
                % best accuracy
                if( bestAccuracy < currCrossValidationAverageAccuracy )
                    bestAccuracy = currCrossValidationAverageAccuracy;
                    bestC = currCValue;
                    bestEpsilon = currEpsilon;
                    bestRBFDelta = currDelta;
                end
            end
        else
            % model parameter
            NPSVMParameters.C = currCValue;
            NPSVMParameters.Epsilon = currEpsilon;
            NPSVMParameters.KernelParas = [];
            % print current parameters
            fprintf('C= %f, Epsilon= %f \n', currCValue, currEpsilon );
            % cross validation
            [currCrossValidationAverageAccuracy] = NPSVM_CrossValidation( InstancesMatrix, LabelVector, NPSVMParameters, FoldNum );
            % best accuracy
            if( bestAccuracy < currCrossValidationAverageAccuracy )
                bestAccuracy = currCrossValidationAverageAccuracy;
                bestC = currCValue;
                bestEpsilon = currEpsilon;
            end
        end
    end
end
%
end