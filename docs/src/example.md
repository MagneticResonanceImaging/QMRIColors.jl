The generated colormap can be easily integrated with multiple plotting library like :
- Makie.jl
- PyPlot.jl

# Makie example

For `Makie.jl` the colormap can be directly used like `heatmap(x,colormap=cmap,colorrange=(loLev,upLev))`

```@example 2
using FileIO
using Downloads
using qMRIColors
using CairoMakie

url = "https://github.com/mfuderer/colorResources/raw/refs/heads/main/sampleT1map.jld"
dest_path = "sampleT1map.jld"
# Download the file
Downloads.download(url, dest_path)
x = FileIO.load("sampleT1map.jld")["sampleT1map"]

loLev = 700
upLev = 1500
cmap,imClip = relaxationColorMap("T1",x,loLev,upLev)
begin
  f=CairoMakie.Figure()
  ax=Axis(f[1,1],aspect = DataAspect(),title = "clip")
  h=heatmap!(ax,rotr90(imClip),colormap=cmap,colorrange=(loLev,upLev))
  Colorbar(f[1,2],h)
  hidedecorations!(ax)

  ax=Axis(f[2,1],aspect = DataAspect(),title = "no clip")
  h=heatmap!(ax,rotr90(x),colormap=cmap,colorrange=(loLev,upLev))
  Colorbar(f[2,2],h)
  hidedecorations!(ax)

  # clean up plot
  colsize!(f.layout, 1, Aspect(1,1))
  resize_to_layout!(f)
  f
end
```


# PyPlot example

PyPlot requires to first onvert the cmap to an exploitable format by PyPlot :

```@example 2
using PyPlot

cmap_py = PyPlot.ColorMap("relaxationColor", cmap, length(cmap), 1.0) # translating the colormap to a format digestible by 
    
figure()
PyPlot.imshow(imClip, vmin=loLev, vmax =upLev, interpolation="bicubic", cmap=cmap_py)
colorbar()
savefig("pyplot.png"); nothing # hide
```

![pyplot](pyplot.png)