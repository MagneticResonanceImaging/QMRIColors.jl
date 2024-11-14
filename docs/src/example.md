```@example 2
using FileIO
using Downloads

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
  ax=Axis(f[1,1],aspect=DataAspect(),title = "clip")
  h=heatmap!(ax,rotr90(imClip),colormap=cmap,colorrange=(loLev,upLev))
  Colorbar(f[1,2],h)
  hidedecorations!(ax)

  ax=Axis(f[1,3],aspect=DataAspect(),title = "no clip")
  h=heatmap!(ax,rotr90(x),colormap=cmap,colorrange=(loLev,upLev))
  Colorbar(f[1,4],h)
  hidedecorations!(ax)
  f
end
```
