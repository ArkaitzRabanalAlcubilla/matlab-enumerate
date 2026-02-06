%% Basic Usage of enumerate
% This script demonstrates the basic usage of the enumerate class.

% Ensure enumerate.m is in your path.
% If you run this from the examples folder, we add the parent folder:
if exist('enumerate', 'class') ~= 8
    addpath(fullfile(pwd, '..'));
end

%% Array Output Format
% You can request the output to be an array [index, value] explicitly.
% This allows accessing elements by index (item(1) is index, item(2) is value).
% Converting to array can be useful for performance or coding style perferences.
% Note: This only works for numeric data where index and value can be concatenated.
disp('--- Array Output Format ---');
nums = [10, 20, 30, 40];
disp('Vector:');
disp(nums);
for item = enumerate(nums, "array")
    % item(1) is the index, item(2) is the value
    fprintf('Index: %d, Value: %d\n', item(1), item(2));
end