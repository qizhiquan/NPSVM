% this file is a sample code for nonparallel support vector machine for
% classification.

% path of the data
filePath = 'iris_0_1.csv';

% last column is the label with 1 and -1
dataMatrix = dlmread(filePath);
attribData = dataMatrix( :, 1:end-1);
labelData = dataMatrix( :, end);

% set the training parameters
npsvmPara = NPSVM_Parameters();
npsvmPara.KernelType = 'rbf';      
npsvmPara.C = 100;
npsvmPara.KernelParas = [ 0.1 ]; 
npsvmPara.Epsilon = 0.05;

% train classification model with nonparallel support vector machine
[model] = NPSVM_Train( attribData, labelData, npsvmPara );

% predict new instances
[predictLabels, accuracy, predictValues] = NPSVM_Predict( model, attribData );

% n-fold cross validation on single dataset
[crossValidationAverageAccuracy] = NPSVM_CrossValidation( attribData, labelData, npsvmPara, 10 );

% set grid search parameter, here we have three parameter candidate sets
paraIndex = [ -8; -5; -2; 0; 2; 5; 8 ];
paraVec = power( 2, paraIndex );
CParaSet = paraVec;
EpsilonParaSet = paraVec;
RBFParaSet = paraVec;
% grid search and get the best parameters according to classification accuracy
[bestAccuracy, bestC, bestEpsilon, bestRBFDelta] = NPSVM_GridSearchByAccuracy( attribData, labelData, 10, npsvmPara, CParaSet, EpsilonParaSet, RBFParaSet );
%