function [predictLabels, accuracy, predictValues] = NPSVM_Predict( model, instancesToPredict )
% Predict labels by Nonparallel Support Vector Classification, could handle multi-classes.
%   [predictLabels, accuracy, predictValues] = NPSVM_Predict( model,
%   instancesToPredict ) makes a predict for the new instances based on the
%   model trained by Nonparallel Support Vector Machine.
%
%   Parameters
%
%   input:
%   model -- the model struct trained from NPSVM_Train() function.
%   instancesToPredict -- n * m matrix representing n instances with m
%   features.
%
%   output:
%   predictLabels -- n * 1 vector containing the prediction labels for each
%   instance.
%   accuracy -- the prediction accuracy for each category, but unavailable
%   in current version.
%   predictValues -- the prediction decision value for each category, but unavailable
%   in current version.
%
%
%   Author: Xi Zhao
%   Date: 2014.09.26
%
optionStr = '-q -b 0';
%
newLabels = zeros( size( instancesToPredict, 1 ) , 1 );
%
[predictLabels, accuracy, predictValues]  = npsvmpredict( newLabels, instancesToPredict, model, optionStr);
%
end
