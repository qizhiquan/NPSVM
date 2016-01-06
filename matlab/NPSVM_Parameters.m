classdef NPSVM_Parameters < handle
% The parameters struct design for NPSVM_Train() function
% For the meaning of these parameters, see paper "Nonparallel Support Vector Machine for Pattern Classification".
%
%
%   Author: Xi Zhao
%   Date: 2014.09.26
%
%
    properties
        % C parameter
        C;
        % Epsilon parameter
        Epsilon
        % kernel type string
        % 'linear':  u'*v
        % 'rbf': exp( - KernelParas(1) * |u-v|^2)
        % 'polynomial': ( KernelParas(1) * u' * v + KernelParas(2) )^ KernelParas(3)
        % 'sigmoid': tanh( KernelParas(1) * u' * v + KernelParas(2) )
        % 'precomputed': precomputed kernel matrix
        KernelType;
        % kernel parameters as list above.
        KernelParas;
        % 
        CacheSize;
        %
        ShrinkingFlag;
        %
    end
    methods
        % default parameters
        function obj = NPSVM_Parameters()
            obj.C = 100;
            obj.Epsilon = 0.1;
            obj.KernelType = 'rbf';
            obj.KernelParas = [ 0.05 ];
            obj.CacheSize = 100;
            obj.ShrinkingFlag = true;
        end
    end
end