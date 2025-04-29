classdef text < handle
    properties
        handle
        loc
    end

    methods
        function obj = text(loc, txt, varargin)
            diagrams.utils.register_update(obj)
            obj.loc = loc;

            % --- Parse varargin for 'align'
            align = "";
            ha = 'left';     % default if align not given
            va = 'top';

            % Look for 'align' and remove it from varargin
            i = 1;
            while i <= length(varargin) - 1
                if strcmpi(varargin{i}, 'align')
                    align = string(varargin{i+1});
                    varargin(i:i+1) = [];  % remove both name and value
                    break
                else
                    i = i + 2;
                end
            end

            % If align was provided, override default
            if align ~= ""
                ha = 'center';
                va = 'middle';
                if contains(align, '<'), ha = 'left'; end
                if contains(align, '>'), ha = 'right'; end
                if contains(align, '^'), va = 'top'; end
                if contains(align, 'v'), va = 'bottom'; end
            end

            % --- Create the annotation
            [x, y] = diagrams.utils.ds2fig.ds2fig(loc(1), loc(2), loc(3));
            obj.handle = annotation('textbox', [x y 0 0], ...
                'String', txt, ...
                'Interpreter', 'latex', ...
                'EdgeColor', [1 0 0], ...
                'FontSize', 2*10, ...
                'HorizontalAlignment', ha, ...
                'VerticalAlignment', va, ...
                varargin{:});
        end


        function update(obj)
            [x, y] = diagrams.utils.ds2fig.ds2fig(obj.loc(1), obj.loc(2), obj.loc(3));
            obj.handle.Position(1:2) = [x y];
        end
    end
end
