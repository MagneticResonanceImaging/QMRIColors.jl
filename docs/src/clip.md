# Important tips

The relaxationColorMap() function selects the appropriate color-map (in this case, Lipari for T1) and applies logarithm-processing on that color map. The resulting colormap is returned.
The "imclip" image should retain the distinction between the "invalid" value of 0 (which is to be displayed as black) and "valid" values that are below loLev (these should be shown in a dark shade of blue). Depending on the calibration of your screen, you may or may not see that distinction.

A simplified processing can be done by

```julia
using QMRIColors
cmap = relaxationColorMap("T1")
VIEW(x,c=cmap) # Do not use range limits here! 
```
Again, "VIEW" refers to your favorite viewing software.

If the simplified processing is invoked WITH use of range limits, then the 
distinction is lost between invalid values and low-but-valid values. See second image in the 
example below: it represents a circular object with a T1 value that is gradually increasing
from top to bottom, but only valid within a circular "object", the outside thereof representing 
unknown T1 values.

Let's build an example to see the effect.

## Create a Synthetic phantom

```@example clip
using QMRIColors
using CairoMakie

# -----  Make test object: gradually increasing T1, but invalid outside a circle
size = 256; center = size÷2+1; radius = 100; origin = CartesianIndex(center,center)
d(x::CartesianIndex, y::CartesianIndex) = √( (x[1]-y[1])^2 + (x[2]-y[2])^2 )
row = [10*i for i in 1:size]
testT1= zeros(size,size)
testT1 .= row

# Set invalid values to 0
allidx = CartesianIndices(testT1)
invalid = allidx[ d.(origin, allidx) .> radius];
testT1[invalid] .= 0
nothing
```
## Display the example in 3 ways
  
```@example clip
# -------------------- Display test object the correct and the wrong way
loLev = 700
upLev = 2000
begin
  f=CairoMakie.Figure()
  ax=Axis(f[1,1],aspect = DataAspect(),title = "Using imClip")
  cmap,imClip = relaxationColorMap("T1",testT1,loLev,upLev)
  h=heatmap!(ax,rotr90(imClip),colormap=cmap,colorrange=(loLev,upLev))
  Colorbar(f[1,2],h)
  hidedecorations!(ax)

  ax=Axis(f[2,1],aspect = DataAspect(),title = "wrong: simplified, \n with range")
  cmap = relaxationColorMap("T1")
  h=heatmap!(ax,rotr90(testT1),colormap=cmap,colorrange=(loLev,upLev))
  Colorbar(f[2,2],h)
  hidedecorations!(ax)

  ax=Axis(f[3,1],aspect = DataAspect(),title = "OK: simplified, \n no range")
  cmap = relaxationColorMap("T1")
  h=heatmap!(ax,rotr90(testT1),colormap=cmap)
  Colorbar(f[3,2],h)
  hidedecorations!(ax)

  # clean up plot
  colsize!(f.layout, 1, Aspect(1,1))
  resize_to_layout!(f)
  f
end
```

## Conclusion


Use the clip version of the images + colormap + the color range

```julia
 cmap,imClip = relaxationColorMap("T1",testT1,loLev,upLev)
heatmap(rotr90(imClip),colormap=cmap,colorrange=(loLev,upLev))
```