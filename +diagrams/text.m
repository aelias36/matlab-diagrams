classdef text < handle
    properties
        handle
        loc
    end

    methods
        function obj = text(loc, txt, varargin)
            diagrams.utils.register_update(obj)
            obj.loc = loc;
            [x, y] = diagrams.utils.ds2fig.ds2fig(loc(1), loc(2), loc(3));
            % Use a 2x scaling for everything
            obj.handle = annotation('textbox', [x y 0 0], 'String', txt, 'Interpreter','latex', 'EdgeColor',[1 0 0], 'FontSize',2*10, varargin{:});
        end

        function update(obj)
            [x, y] = diagrams.utils.ds2fig.ds2fig(obj.loc(1), obj.loc(2), obj.loc(3));
            obj.handle.Position = [x y 0 0];
        end
    end
end