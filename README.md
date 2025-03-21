# MATLAB Diagrams Library

Create paper-quality vector graphics geometry diagrams in 2D and 3D

[![View MATLAB Diagrams on File Exchange](https://www.mathworks.com/matlabcentral/images/matlab-file-exchange.svg)](https://www.mathworks.com/matlabcentral/fileexchange/116840-matlab-diagrams)

### Capabilities
  * Angle Arc   
  * Arrow 
  * Circle
  * Cone 
  * Cylinder
  * Cylinder Line (for connecting two cylinders)
  * Dot
  * Line
  * Perpendicular Mark
  * Plane
  * Robot Diagram (compatible with [general-robotics-toolbox](https://github.com/rpiRobotics/general-robotics-toolbox))
  * Sphere
  * Text

## Papers using this library
Open an issue to add your paper to this list!

#### [IK-Geo: Unified robot inverse kinematics using subproblem decomposition](https://www.sciencedirect.com/science/article/pii/S0094114X25000606)
Alexander J. Elias and John T. Wen, 2025
Mechanism and Machine Theory 209, 105971

#### [Redundancy parameterization and inverse kinematics of 7-DOF revolute manipulators](https://www.sciencedirect.com/science/article/pii/S0094114X24002519)
Alexander J. Elias and John T. Wen, 2024
Mechanism and Machine Theory 204, 105824

#### [Path Planning and Optimization for Cuspidal 6R Manipulators](https://arxiv.org/abs/2501.18505)
Alexander J. Elias and John T. Wen, 2025
arXiv preprint arXiv:2501.18505


## Examples
<p align="center">
  <img width="644" height="412" src="https://user-images.githubusercontent.com/4022499/184445889-66569f27-19f2-408c-acd6-d280295f489e.svg">
  <img width="645.333" height="768" src="https://user-images.githubusercontent.com/4022499/184707576-c31d84b5-294b-4a54-86f6-a3cbe002e479.svg">
  <img width="544" height="556" src="https://user-images.githubusercontent.com/4022499/185184780-5a7d1ec6-d80b-4ee8-b633-7d02305f479d.svg">
 <img width="657.33331" height="802.66669" src="https://github.com/aelias36/matlab-diagrams/assets/4022499/007a1a1b-5208-4515-afa1-8ca591e8a7bf.svg">
</p>

## Instructions
Download the library code and make sure the `+diagrams` folder is inside a folder in the MATLAB path.

Example code is shown in [`usage.m`](usage.m), as well as in the [`examples`](/examples) folder.

Set up a new figure by running `h_fig = diagrams.setup()`. Then, add graphics objects to the figure by calling the diagrams library, or by using matlab functions like `plot`  and `plot3`.

Certain graphics objects must be redrawn depending on the camera angle. At the end of your script, you should call `diagrams.redraw()`. You can also press any keyboard key to call `diagrams.redraw()` if you're moving the camera position interactively.

To export the figure, call `diagrams.save(h_fig, name, location)`. This will save the figure in both `.eps` and `.svg` format.

The figure is designed to be displayed 3.5 in wide to fit the width of an IEEE journal article. However, there is a 2x scaling factor so that the MATLAB figure window is a reasonable size on a computer screen. To include the figure in LaTeX, you should use `\includegraphics[scale=0.5, clip]{diagram.eps}`. Adding `clip` makes sure any white space doesn't overlap with text.

If you're submitting to arXiv and want to use pdfLaTeX, you will need to convert the `eps` files to `pdf` files. [arXiv doesn't do this conversion](https://info.arxiv.org/help/submit_tex.html#figure-inclusion-in-latex-submissions). If you have miktex installed, run the command
```bat
epstopdf --outfile=diagram-converted-to.pdf diagram.eps
```
Or, run the following `.bat` file on Windows:
```bat
for %%I in (*.eps) do (
    epstopdf --outfile="%%~nI-converted-to.pdf" "%%I"
)
```
Then, you can include the PDF file using  `\includegraphics[scale=0.5, clip]{diagram-converted-to.pdf}`

## Creating GIFs
### Method 1: `exportgraphics()`
To make sure the gif stays the same size, make a rectangle that fills the whole frame.
```MATLAB
annotation('rectangle',[0 0 1 1]);
```
You may want to use `campos()`, `camva()`, and `camtarget()` to lock the camera view.

At the end of the animation loop, use `exportgraphics` to save each frame to a file.
```MATLAB
exportgraphics(gca, "filename.gif", "Append", i ~= 1)
```
### Method 2: `imwrite()`
This method gives more control over delay time and other options.
```MATLAB
filename = "file_name.gif";
clear im
for i = 1:N
    % Code here
    frame = getframe(h_fig);
    im{i} = frame2im(frame);
end

for idx = 1:length(im)
    [A, map] = rgb2ind(im{idx}, 256);
    if idx == 1
        imwrite(A, map, filename, "gif", "LoopCount", Inf, "DelayTime", 0.5);
    else
        imwrite(A, map, filename, "gif", "WriteMode", "append", "DelayTime", 0.5);
    end
end
```

## Contributing
If you have any improvements you'd like to make, or even ideas or requests for improvements, please start a GitHub issue.

## Acknowledgements
[ds2fig](https://www.mathworks.com/matlabcentral/fileexchange/43896-3d-data-space-coordinates-to-normalized-figure-coordinates-conversion)
