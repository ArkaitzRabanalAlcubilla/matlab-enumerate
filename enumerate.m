classdef enumerate < handle
    %ENUMERATE(data) Iterate over data with an index, similar to Python's enumerate.
    %   The enumerate class creates an iterator object that works seamlessly with standard
    %   MATLAB for-loops. It provides access to both the iteration index and the corresponding
    %   value, simplifying loops where both are needed.
    %
    %   ITERATION BEHAVIOR:
    %     * Row vectors (1xN) iterate N times.
    %     * Column vectors (Nx1) iterate 1 time (standard MATLAB behavior).
    %     * Matrices (MxN) iterate N times (columns).
    %
    %   HOW TO USE:
    %   1. STRUCT OUTPUT (default):
    %       Option 1:
    %           for item = enumerate(vec)
    %               idx = item.idx;
    %               val = item.val;
    %           end
    %
    %       Option 2:
    %           for item = enumerate(vec, "struct")
    %               idx = item.idx;
    %               val = item.val;
    %           end
    %
    %   1. ARRAY OUTPUT:
    %           for item = enumerate(vec,'array')
    %               idx = item(1);
    %               val = item(2);
    %           end
    %
    %       Notes:
    %           - Any char or string in the second argument that is not "array" will
    %             make enumerate() to return an "struct".
    %           - If 'data' is an structure or cell, the returned 'item' will always be 
    %             an structure.
    %
    % Copyright (c) 2026 Arkaitz Rabanal Alcubilla
    properties (Access=public, Hidden=false)
        Data                 % The underlying data to iterate over
        ReturnArray = false  % Logical variable indicating the output type
    end

    methods (Access=public, Hidden=false)
        function obj = enumerate(data, type)
            %ENUMERATE Construct an enumerate iterator.
            %   See class help for details.
          
            % Store data into object
            obj.Data = data;
            
            % Determine output format strategy once during handling
            if nargin > 1 && strcmpi(type, "array") && ~iscell(data) && ~isstruct(data)
                obj.ReturnArray = true;
            end
        end
    end
    
    methods (Access=public, Hidden=true)
        function varargout = size(obj, varargin)
            %SIZE Return the dimensions of the underlying data.
            %   Transfers the size query to obj.Data to ensure the for-loop
            %   iterates the correct number of times (columns).
            [varargout{1:nargout}] = size(obj.Data, varargin{:});
        end
        
        function n = numel(obj)
             %NUMEL Return the number of elements in the underlying data.
             n = numel(obj.Data);
        end
        
        function varargout = subsref(obj, SubScriptStruct)
            %SUBSREF Subscripted reference implementation to handle iteration.
            %   This method is called by the for-loop mechanism to retrieve
            %   the next item. It uses the pre-configured OutputFormatter
            %   to return the desired format without branching logic.
            
            % If the loop is requesting data using () (e.g. obj(:, k))
            if strcmp(SubScriptStruct(1).type, '()')
                % Retrieve the value from the underlying data using standard MATLAB indexing.
                % Direct access is used for performance.
                val = obj.Data(SubScriptStruct(1).subs{:});

                % Determine the iteration index 'k'.
                % In a for-loop 'for x = obj', MATLAB typically calls subsref with a subscript
                % of the form  {':', k} (if 2D) or similar.
                % The last subscript represents the current iteration step.
                if isscalar(SubScriptStruct(1).subs)
                    k = SubScriptStruct(1).subs{1};
                else
                    k = SubScriptStruct(1).subs{end}; 
                end
                
                % Format output
                if obj.ReturnArray
                    varargout = {[k,val]};
                else
                    varargout = {struct('idx',k,'val',val)};
                end

            else
                % Handle dot notation (obj.Prop) or braces normally
                varargout = builtin('subsref', obj, SubScriptStruct);
            end
        end
    end
end