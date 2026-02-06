classdef test_enumerate < matlab.unittest.TestCase
    methods (TestClassSetup)
        function addSourceToPath(testCase)
            % 1. Get the folder where this test file currently lives
            testFolder = fileparts(mfilename('fullpath'));
            
            % 2. Get the project root (one level up from 'tests')
            projectRoot = fileparts(testFolder);
            
            % 3. Add the project root to the path
            addpath(projectRoot);
            
            % 4. Ensure the path is cleaned up (removed) when tests finish
            testCase.addTeardown(@rmpath, projectRoot);
        end
    end
    methods ( Test )
        function testRowVector(testCase)
            % Test iteration over a row vector (1xN) - should iterate N times
            data = [10, 20, 30];
            count = 0;
            for item = enumerate(data)
                count = count + 1;
                testCase.verifyEqual(item.idx, count);
                testCase.verifyEqual(item.val, data(count));
            end
            testCase.verifyEqual(count, 3);
        end

        function testColumnVector(testCase)
            % Test iteration over a column vector (Nx1) - should iterate 1 time (standard MATLAB behavior for matrices)
            % BUT WAIT, standard MATLAB behavior for `for x = matrix` is iterating over columns.
            % A column vector is Nx1. So it has 1 column. So it should iterate 1 time.
            data = [10; 20; 30];
            count = 0;
            for item = enumerate(data)
                count = count + 1;
                testCase.verifyEqual(item.idx, 1);       % It's the first (and only) column
                testCase.verifyEqual(item.val, data);    % The value is the whole column
            end
            testCase.verifyEqual(count, 1);
        end

        function testMatrix(testCase)
            % Test iteration over a matrix (MxN) - should iterate N times (columns)
            data = [1, 2, 3; 4, 5, 6]; % 2x3 matrix
            count = 0;
            for item = enumerate(data)
                count = count + 1;
                testCase.verifyEqual(item.idx, count);
                testCase.verifyEqual(item.val, data(:, count));
            end
            testCase.verifyEqual(count, 3);
        end

        function testCellArray(testCase)
            % Test iteration over a cell array (1xN)
            data = {'a', 'b', 'c'};
            count = 0;
            for item = enumerate(data)
                count = count + 1;
                testCase.verifyEqual(item.idx, count);
                testCase.verifyEqual(item.val, data{count});
            end
            testCase.verifyEqual(count, 3);
        end

        function testStructArray(testCase)
            % Test iteration over a struct array
            s(1).f = 1;
            s(2).f = 2;
            data = s;
            count = 0;
            for item = enumerate(data)
                count = count + 1;
                testCase.verifyEqual(item.idx, count);
                testCase.verifyEqual(item.val, data(count));
            end
            testCase.verifyEqual(count, 2);
        end

        function testArrayOutput(testCase)
             % Test "array" output mode
             data = [10, 20, 30];
             count = 0;
             for item = enumerate(data, "array")
                 count = count + 1;
                 % Item should be [idx, val]
                 testCase.verifyTrue(isnumeric(item));
                 testCase.verifyEqual(numel(item), 2);
                 testCase.verifyEqual(item(1), count);
                 testCase.verifyEqual(item(2), data(count));
             end
        end

        function testInvalidOutputOption(testCase)
            % Test invalid option string falls back to struct
            data = [10, 20];
            count = 0;
            for item = enumerate(data, "invalid_option")
                count = count + 1;
                testCase.verifyTrue(isstruct(item));
                testCase.verifyTrue(isfield(item, 'idx'));
                testCase.verifyTrue(isfield(item, 'val'));
            end
        end

        function testCellArrayWithArrayOption(testCase)
            % Test that "array" option is ignored for cell arrays (falls back to struct)
            % because you can't easily concat [idx, cell_content] into a simple numeric array usually
            data = {'a', 'b'};
            count = 0;
            for item = enumerate(data, "array")
                count = count + 1;
                testCase.verifyTrue(isstruct(item)); 
            end
        end

        function testEmpty(testCase)
            % Test empty input
            data = [];
            count = 0;
            for item = enumerate(data)
                count = count + 1;
            end
            testCase.verifyEqual(count, 0);
        end

        function testSizeAndNumel(testCase)
            % Verify size and numel delegation
            data = zeros(2, 3);
            iter = enumerate(data);
            
            [r, c] = size(iter);
            testCase.verifyEqual([r, c], size(data));
            
            n = numel(iter);
            testCase.verifyEqual(n, numel(data));
        end
    end
end
