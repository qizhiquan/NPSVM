Matalb interface for Nonparallel Support Vector Machine (Version 0.2)

*****************************************************************************************
**

This is a matlab interface for nonparallel support vector machine model. You could use these code to construct classification model based on the recently proposed nonparallel support vector machine method.

Demo.m: the sample code for illustrating how to use these functions.

NPSVM_Parameters.m: matlab struct for model parameters.

NPSVM_Train.m: train a model by nonparallel support vector machine.

NPSVM_Predict.m: predict labels of the new instances.

NPSVM_CrossValidation.m: run n-fold cross validation and get the average classification accuracy.

NPSVM_GridSearchByAccuracy.m: run grid search and select the best model( best parameters ) from the given parameter candidates according to the average n-fold cross validation classification accuracy.

npsvmpredict.mexw64, npsvmpredict.mexw64, npsvmtrain.mexw32, npsvmpredict.mexw32: matlab mex files for 32-bit and 64-bit Windows.

32-bit mex files:
npsvmtrain.mexw32: 32-bit nonparallel support vector machine model constructor.
npsvmpredict.mexw32: 32-bit nonparallel support vector machine predictor.

64-bit mex files:
npsvmtrain.mexw64: 64-bit nonparallel support vector machine model constructor.
npsvmpredict.mexw64: 64-bit nonparallel support vector machine predictor.

iris_0_1.csv: a sample dataset for testing the sample code.


*****************************************************************************************
**

This package is free for non-commercial use. If it help you please cite the papers:

We were inspired from LIBSVM and SVM-Light in the organization of the code. You can find the resource from these url:

LIBSVM:http://www.csie.ntu.edu.tw/~cjlin/libsvm/

SVM-Light:http://svmlight.joachims.org/





