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

## Examples
<p align="center">
  <img width="644" height="412" src="https://user-images.githubusercontent.com/4022499/184445889-66569f27-19f2-408c-acd6-d280295f489e.svg">
  <img width="645.333" height="768" src="https://user-images.githubusercontent.com/4022499/184707576-c31d84b5-294b-4a54-86f6-a3cbe002e479.svg">
  <img width="544" height="556" src="https://user-images.githubusercontent.com/4022499/185184780-5a7d1ec6-d80b-4ee8-b633-7d02305f479d.svg">
</p>

## Instructions
Download the library code and make sure the `+diagrams` folder is inside a folder in the MATLAB path.

Example code is shown in [`usage.m`](usage.m), as well as in the [`examples`](/examples) folder.

Set up a new figure by running `h_fig = diagrams.setup()`. Then, add graphics objects to the figure by calling the diagrams library, or by using matlab functions like `plot`  and `plot3`.

Certain graphics objects must be redrawn depending on the camera angle. At the end of your script, you should call `diagrams.redraw()`. You can also press any keyboard key to call `diagrams.redraw()` if you're moving the camera position interactively.

To export the figure, call `diagrams.save(h_fig, name, location)`. This will save the figure in both `.eps` and `.svg` format.

The figure is designed to be displayed 3.5 in wide to fit the width of an IEEE journal article. However, there is a 2x scaling factor so that the MATLAB figure window is a reasonable size on a computer screen. To include the figure in LaTeX, you should use `\includegraphics[scale=0.5]{diagram.eps}`.

## Contributing
If you have any improvements you'd like to make, or even ideas or requests for improvements, please start a GitHub issue.

## Acknowledgements
[ds2fig](https://www.mathworks.com/matlabcentral/fileexchange/43896-3d-data-space-coordinates-to-normalized-figure-coordinates-conversion)
