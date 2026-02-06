%% Basic Usage of enumerate
% This script demonstrates the basic usage of the enumerate class.

% Ensure enumerate.m is in your path.
% If you run this from the examples folder, we add the parent folder:
if exist('enumerate', 'class') ~= 8
    addpath(fullfile(pwd, '..'));
end

%% Iterating over a Matrix (Column-wise)
% Standard MATLAB behavior iterates matrices column by column.
disp('--- Iterating over Matrix Columns ---');
M = [1 2 3; 4 5 6]; % 2x3 Matrix
disp('Matrix:');
disp(M);
for item = enumerate(M)
    fprintf('Column %d is: [%d, %d]\n', item.idx, item.val(1), item.val(2));
end
