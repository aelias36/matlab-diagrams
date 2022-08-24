function [XFIG, YFIG, DEEP] = ds2fig(varargin)
%DS2FIG Transform data space coordinates to normalized figure coordinates.
%   [XFIG,YFIG,DEEP] = DS2FIG(X,Y,Z) transforms corresponding elements of
%       data stored in data space coordinates X,Y,Z to normalized figure
%       coordinates (XFIG, YFIG). if the point is closer to you, the value
%       in DEEP will be bigger. the DEEP velue of points which on the view
%       plane containing 'CameraTarget' is 0.
%       X,Y,Z must be the same size.
%       XFIG,YFIG,DEEP will be the same size as X,Y,Z.
%    [XFIG,YFIG,DEEP] = DS2FIG(X,Y) use Z always be 0.
%    [XFIG,YFIG,DEEP] = DS2FIG(axes_handle,...) use axes_handle instead of gca
%
% Example:
%   % creat a surface and draw
%   [x, y, z] = peaks;
%   z = z + 10;
%   surf(x, y, z);
%   shading interp;
%   axis tight;
%   set(gca, 'Projection', 'perspective', 'CameraUpVector', [2, 1, 0], ...
%       'XDir', 'reverse', 'ZScale', 'log');
%   % find maximum and minimum
%   [zMax, maxIdx] = max(z(:));
%   [zMin, minIdx] = min(z(:));
%   idx = [minIdx, maxIdx];
%   % use this function to translate maximum and minimum point
%   [xFig, yFig] = ds2fig(x(idx), y(idx), z(idx));
%   % annotate it
%   annotation('textarrow', [.9, xFig(1)], [.2, yFig(1)], 'String', 'MIN');
%   annotation('textarrow', [.2, xFig(2)], [.8, yFig(2)], 'String', 'MAX');
%
% Conditions it will work:
%   setting valid properties of axes including: 'Camera*', 'Projection',
%       'View', 'DataAspectRatio*', 'PlotBoxAspectRatio*', 'XLim', 'YLim',
%       'ZLim', 'XDir', 'YDir', 'ZDir', 'XScale', 'YScale', 'ZScale'.
%   modify axes appearance by using 'axis *' and 'view(*)'.
%   using 'Zoom In', 'Zoom Out', 'Pan', 'Rotate 3D' in Figure Tool.
% Conditions it will not work:
%   while using log scale axes, if you set the low boundary of 'XLim' less
%       than or equal to 0, then matlab will auto calculate a valid one
%       and use it, but this program can't get the actually low boundary.
%
% NOTE:
%   This program written through observing the behavior of how matlab render
%   axes content into figure. It may not work properly in some cases that
%   I omitted. It work fine in MATLAB 8.0, and should work properly at
%   other version, since the render algorithm may change rarely.

% Copyright (c) 2013, MinLong Kwong <komelong@gmail.com>

% Revision history:
%   10/10/2013  Original code release.


% check if axes handle is available
if length(varargin{1}) == 1 && ishandle(varargin{1}) ...
        && strcmp(get(varargin{1}, 'type'), 'axes')
	hAxes = varargin{1};
	varargin = varargin(2:end);
else
	hAxes = gca;
end

% get data space coordinates from arguments
if length(varargin) == 1
    error('too fiew arguments');
elseif length(varargin) >= 4
    error('too many arguments');
else
    X = varargin{1};
    Y = varargin{2};
    if length(varargin) == 3
        Z = varargin{3};
    else
        Z = zeros(size(X));
    end
end

% check if all arguments are same size
dataSize = size(X);
if ~(all(size(Y) == dataSize) && all(size(Z) == dataSize))
    error('X,Y,Z should be the same size');
end

% build data space coordinates
X = X(:);
Y = Y(:);
Z = Z(:);
dataCoord = [X, Y, Z, ones(size(X))]';
dataCoord = AdjustLogScaleData(hAxes, dataCoord);

% transform and build figure coordinates
matrixTransform = AxesTransformToFigure(hAxes);
figureCoord = matrixTransform * dataCoord;
% perspective division
XFIG = reshape(figureCoord(1, :) ./ figureCoord(4, :), dataSize);
YFIG = reshape(figureCoord(2, :) ./ figureCoord(4, :), dataSize);
DEEP = reshape(figureCoord(3, :) ./ figureCoord(4, :), dataSize);
end




function coordLiner = AdjustLogScaleData(hAxes, coordLogOrLiner)
% adjust axes data for log scale

coordLiner = coordLogOrLiner;
% obtain data
isLogScale = strcmp(get(hAxes, {'XScale', 'YScale', 'ZScale'}), 'log'); 
lim = get(gca, {'XLim', 'YLim', 'ZLim'});
% adjust
for i = 1:3
    if isLogScale(i)
        if lim{i}(1) <= 0
            error(['low boundary of ''', 'W'+i, 'Lim'' should not less', ...
                ' than or equal to 0 in log scale axes, consider set ''', ...
                'W'+i, 'LimMode'' to ''auto''.']);
        end
        rate = (log(coordLogOrLiner(i, :)) - log(lim{i}(1))) ...
            / (log(lim{i}(2)) - log(lim{i}(1)));
        coordLiner(i, :) = rate * (lim{i}(2) - lim{i}(1)) + lim{i}(1);
    end
end
end




function matrixTransform = AxesTransformToFigure(hAxes)
% get transform matrix which transform axes coordinate to figure coordinate

matrixTransform = [];

%%%% obtain data needed
% camera
viewAngle = get(hAxes, 'CameraViewAngle');
viewTarget = get(hAxes, 'CameraTarget');
viewPosition = get(hAxes, 'CameraPosition');
viewUp = get(hAxes, 'CameraUpVector');
% axes direction
axesDirection = strcmp(get(hAxes, {'XDir', 'YDir', 'ZDir'}), 'normal');
% data scale
dataZLim = get(hAxes, 'ZLim');
dataRatio = get(hAxes, 'DataAspectRatio');
if any(dataRatio == 0), return, end
plotBoxRatio = get(hAxes, 'PlotBoxAspectRatio');
if any(plotBoxRatio == 0), return, end
% is perspective
isPerspective = strcmp(get(hAxes, 'Projection'), 'perspective');
% axes position
axesUnitsOriginal = get(hAxes, 'Units');
set(hAxes, 'Units', 'normalized'); 
positionNormal = get(hAxes, 'Position');
set(hAxes, 'Units', 'pixels'); 
positionPixel = get(hAxes, 'Position');
set(hAxes, 'Units', axesUnitsOriginal);
% stretch
stretchMode = strcmp(get(hAxes, {'CameraViewAngleMode', ...
    'DataAspectRatioMode', 'PlotBoxAspectRatioMode'}), 'auto');
stretchToFill = all(stretchMode);
stretchToFit = ~stretchToFill && stretchMode(1);
stretchNone = ~stretchToFill && ~stretchToFit;


%%%% model view matrix
% move data space center to viewTarget point
matrixTranslate = eye(4);
matrixTranslate(1:3, 4) = -viewTarget;
% rescale data
% note: matlab will rescale data space by dividing DataAspectRatio
%       and normalize z direction to 1 to makeup the 'PlotBox'
scaleFactor = dataRatio / dataRatio(3) * (dataZLim(2) - dataZLim(1));
scaleDirection = axesDirection * 2 - 1;
matrixRescale = diag([scaleDirection ./ scaleFactor, 1]);
% rotate the 'PlotBox'
vecticesZUp = matrixRescale * ...
    [matrixTranslate * [viewPosition, 1]', [viewUp, 1]'];
zVector = vecticesZUp(1:3, 1);
upVector = vecticesZUp(1:3, 2);
viewDistance = sqrt(dot(zVector, zVector));
zDirection = zVector / viewDistance;
yVector = upVector - zDirection * dot(zDirection, upVector);
yDirection = yVector / sqrt(dot(yVector, yVector));
matrixRotate = blkdiag( ...
    [cross(yDirection, zDirection), yDirection, zDirection]', 1);

%%%% projection matrix
% note: matlab will project the rotated 'PlotBox' to an area of 
%       [-0.5, 0.5; -0.5, 0.5]
matrixProjection = eye(4);
matrixProjection(4, 3) = -isPerspective / viewDistance;
projectionArea = 2 * tan(viewAngle * pi / 360) * viewDistance;
matrixProjection = diag([ones(1, 3), projectionArea]) * matrixProjection;

%%%% stretch matrix
% stretch the projective 'PlotBox' into the position retangle of the axes
% note: stretch will first detect data region
if stretchToFill || stretchToFit
    plotBox = [0 0 0; 0 0 1; 0 1 0; 0 1 1; 1 0 0; 1 0 1; 1 1 0; 1 1 1]' - .5;
    plotBox = diag(plotBoxRatio / plotBoxRatio(3)) * plotBox;
    edgeVertices = matrixProjection * matrixRotate * [plotBox; ones(1, 8)];
    edgeVertices(1, :) = edgeVertices(1, :) ./ edgeVertices(4, :);
    edgeVertices(2, :) = edgeVertices(2, :) ./ edgeVertices(4, :);
    edgeVertices = edgeVertices(1:2, :)';
    % note: the low boundary and the high boundary of data region may be
    %       difference in perspective projection, so the figure should move
    %       to center, but here no need to do so, because matlab ignore it
    dataRegion = max(edgeVertices) - min(edgeVertices);
    % note: matlab have a strange addition stretch in stretch to fit mode.
    %       one side of the data region will hit the position rectangle,
    %       and matlab will assume data region of that side to be 1 keeping
    %       aspect ratio.
    if stretchToFit
        strangeFactor = dataRegion ./ positionPixel(3:4);
        if strangeFactor(1) > strangeFactor(2)
            dataRegion = dataRegion / dataRegion(1);
        else
            dataRegion = dataRegion / dataRegion(2);
        end
    end
else
    % note: if no stretch, it will use projection area as data region
    dataRegion = [1, 1];
end
% note: stretch than apply a stretchFactor to the data, such that it fit
%       in the axes position retangle
if stretchToFit || stretchNone
    stretchFactor = dataRegion ./ positionPixel(3:4);
    stretchFactor = stretchFactor / max(stretchFactor);
else
    stretchFactor = [1, 1];
end
matrixStretch = diag([stretchFactor ./ dataRegion, 1, 1]);

%%%% view port matrix
matrixViewPort = diag([positionNormal(3:4), 1, 1]);
matrixViewPort(1:2, 4) = positionNormal(1:2) + positionNormal(3:4) / 2;

%%%% return transformation matrix
matrixTransform = matrixViewPort * matrixStretch * matrixProjection * ...
    matrixRotate * matrixRescale * matrixTranslate;
end

