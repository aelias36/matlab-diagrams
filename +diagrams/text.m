classdef text
    properties
        handle
        loc
    end

    methods
        function obj = text(loc, txt, opts)
            obj.loc = loc;
            if ~exist('opts','var')
             opts = {};
            end
            [x, y] = ds2fig(loc(1), loc(2), loc(3));
            obj.handle = annotation('textbox', [x y 0 0], 'String', txt, 'Interpreter','latex', 'EdgeColor',[1 0 0], 'FontSize',14, opts{:});
        end

        function update(obj)
            [x, y] = ds2fig(obj.loc(1), obj.loc(2), obj.loc(3));
            obj.handle.Position = [x y 0 0];
        end
    end
end