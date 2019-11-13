%--------------------------------------------------------------------------

clear   
clc     

diary off;  diary on;   % to save console output

%--------------------------------------------------------------------------

path='data\';

datasets={'ld'};

 classifier='cmf'; 

use_WKNKN =1;      
K = 5;             
eta = 0.7;          

% cv_setting = 'cv_d';   
%cv_setting = 'cv_t';   
cv_setting = 'cv_p';    
% ------------------------------------------

m = 5;  % number of n-fold experiments (repetitions)
n =10; % the 'n' in "n-fold experiment"
% ------------------------------------------


%-------------------------------------------------------------------------

disp('==============================================================');
fprintf('\nClassifier Used: %s',classifier);
switch cv_setting
    case 'cv_d', fprintf('\nCV Setting Used: CV_d g\n');
    case 'cv_t', fprintf('\nCV Setting Used: CV_t \n');
    case 'cv_p', fprintf('\nCV Setting Used: CV_p \n');
end
if use_WKNKN
    fprintf('\nusing WKNKN: K=%i, eta=%g\n',K,eta);
end
fprintf('\n');

% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

for ds=[1]
    disp('--------------------------------------------------------------');

    fprintf('\nData Set: %s\n', datasets{ds});

    % LOAD DATA
    [Y,Sd,St,Did,Tid]=getdata(path,datasets{ds});

    % PREDICT (+ print evaluation metrics)
    crossValidation(Y',Sd,St,classifier,cv_setting,m,n,use_WKNKN,K,eta,use_W_matrix);

    disp('--------------------------------------------------------------');
    diary off;  diary on;
end

% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

disp('==============================================================');
diary off;