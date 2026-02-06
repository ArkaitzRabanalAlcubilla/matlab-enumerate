%% Basic Usage of enumerate
% This script demonstrates the basic usage of the enumerate class.

% Ensure enumerate.m is in your path.
% If you run this from the examples folder, we add the parent folder:
if exist('enumerate', 'class') ~= 8
    addpath(fullfile(pwd, '..'));
end

%% Iterating over a vector of strings
disp('--- Iterating over a vector ---');
vec = ["apple", "banana", "cherry"];
disp('String vector:');
disp(vec);
for item = enumerate(vec)
    fprintf('Index: %d, Value: %s\n', item.idx, item.val);
end