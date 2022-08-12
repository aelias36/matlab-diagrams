classdef arrow < handle
    properties
        an
        tail
        head
    end
    
    methods
        function obj = arrow(tail, head, varargin)
            diagrams.register_update(obj)

            parser = inputParser;
            addParameter(parser,'LineStyle','-');
            addParameter(parser,'HeadStyle','vback2');
            addParameter(parser,'TailStyle','none');
            addParameter(parser,'Color', [0 0 0]);
            addParameter(parser,'LineWidth', 0.5);
            parse(parser,varargin{:});

            plot3(tail(1),tail(2),tail(3)); % zoom figure out enough
            plot3(head(1),head(2),head(3));

            obj.tail=tail; obj.head=head;
            [x_tail, y_tail] = ds2fig(tail(1), tail(2), tail(3));
            [x_head, y_head] = ds2fig(head(1), head(2), head(3));
            obj.an = annotation('doublearrow', ...
                [x_tail x_head], [y_tail y_head], ...
                LineStyle=parser.Results.LineStyle, ...
                Head2Style=parser.Results.HeadStyle, ...
                Head1Style=parser.Results.TailStyle, ...
                Color=parser.Results.Color, ...
                 LineWidth=parser.Results.LineWidth);%, ...
%                 Head1Length=5, ...
%                 Head2Length=5, ...
%                 Head1Width=5, ...
%                 Head2Width=5);
        end
        
        function update(obj)
            [x_tail, y_tail] = ds2fig(obj.tail(1), obj.tail(2), obj.tail(3));
            [x_head, y_head] = ds2fig(obj.head(1), obj.head(2), obj.head(3));
            set(obj.an,'X',[x_tail x_head],'Y',[y_tail y_head]);
        end


    end
end
