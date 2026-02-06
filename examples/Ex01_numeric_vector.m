%% Basic Usage of enumerate
% This script demonstrates the basic usage of the enumerate class.

% Ensure enumerate.m is in your path.
% If you run this from the examples folder, we add the parent folder:
if exist('enumerate', 'class') ~= 8
    addpath(fullfile(pwd, '..'));
end

%% Iterating over a numeric array
disp('--- Iterating over numbers ---');
nums = [10, 20, 30, 40];
disp('Vector:');
disp(nums);
for item = enumerate(nums)
    fprintf('Index: %d, Value: %d\n', item.idx, item.val);
end
