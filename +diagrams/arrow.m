classdef arrow < handle
    properties
        an
        h_line
        tail
        head
    end
    
    methods
        function obj = arrow(tail, head, varargin)
            diagrams.utils.register_update(obj)

            parser = inputParser;
            addParameter(parser,'LineStyle','-');
            addParameter(parser,'HeadStyle','vback2');
            addParameter(parser,'TailStyle','none');
            addParameter(parser,'Color', [0 0 0]);
            addParameter(parser,'LineWidth', 0.5);
            parse(parser,varargin{:});

            plot3(tail(1),tail(2),tail(3)); % zoom figure out enough
            plot3(head(1),head(2),head(3));
            obj.h_line = diagrams.line(tail, head, ...
                LineStyle=parser.Results.LineStyle, ...
                LineWidth=parser.Results.LineWidth, ...
                Color=parser.Results.Color);

            obj.tail=tail; obj.head=head;
            [x_tail, y_tail] = diagrams.utils.ds2fig.ds2fig(tail(1), tail(2), tail(3));
            [x_head, y_head] = diagrams.utils.ds2fig.ds2fig(head(1), head(2), head(3));
            obj.an = annotation('doublearrow', ...
                [x_tail x_head], [y_tail y_head], ...
                LineStyle='none',...%parser.Results.LineStyle, ...
                Head2Style=parser.Results.HeadStyle, ...
                Head1Style=parser.Results.TailStyle, ...
                Color=parser.Results.Color, ...
                 LineWidth=parser.Results.LineWidth);

        end
        
        function update(obj)
            [x_tail, y_tail] = diagrams.utils.ds2fig.ds2fig(obj.tail(1), obj.tail(2), obj.tail(3));
            [x_head, y_head] = diagrams.utils.ds2fig.ds2fig(obj.head(1), obj.head(2), obj.head(3));
            set(obj.an,'X',[x_tail x_head],'Y',[y_tail y_head]);
            
            
            % Move line to avoid overlap with arrowhead
            set(obj.an, 'Units', 'points');
            current_len = norm(obj.an.Position(3:4));
            set(obj.an, 'Units', 'normalized');

            if obj.an.Head2Style ~= "none"
                new_line_head = obj.tail+(obj.head-obj.tail)*(current_len-7)/current_len;
            else
                new_line_head = obj.head;
            end
            
            if obj.an.Head1Style ~= "none"
                new_line_tail = obj.head+(obj.tail-obj.head)*(current_len-7)/current_len;
            else
                new_line_tail = obj.tail;
            end

                diagrams.utils.plot3_mat_update(obj.h_line, [new_line_tail, new_line_head]);
        end


    end
end
