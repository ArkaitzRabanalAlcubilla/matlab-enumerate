%% Basic Usage of enumerate
% This script demonstrates the basic usage of the enumerate class.

% Ensure enumerate.m is in your path.
% If you run this from the examples folder, we add the parent folder:
if exist('enumerate', 'class') ~= 8
    addpath(fullfile(pwd, '..'));
end

%% Iterating over a Cell Array
disp('--- Iterating over Cell Array ---');
cells = {'one', 'two', 'three'};
disp('Cell array:');
disp(cells);
for item = enumerate(cells)
    fprintf('Index: %d, Value: %s\n', item.idx, item.val);
end