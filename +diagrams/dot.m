classdef dot
    properties
        an
        loc
        size
    end
    
    methods
        function obj = dot(loc, varargin)
            parser = inputParser;
            addParameter(parser,'Color', [0 0 0]);
            addParameter(parser, 'MarkerSize', 4)
            parse(parser,varargin{:});

            obj.size = parser.Results.MarkerSize;

            plot3(loc(1),loc(2),loc(3)); % zoom figure out enough

            obj.loc=loc;
            obj.an = annotation('ellipse', 'Color',parser.Results.Color, 'FaceColor',parser.Results.Color);
            obj.update();
            
        end
        
        function update(obj)
            [x, y] = ds2fig(obj.loc(1),obj.loc(2),obj.loc(3));
            set(obj.an,'Position', [x y 0 0]);
            set(obj.an, 'Units', 'points')
            old = obj.an.Position;
            set(obj.an,'Position', [old(1)-obj.size old(2)-obj.size obj.size*2 obj.size*2]);
            set(obj.an, 'Units', 'normalized')
        end


    end
end
