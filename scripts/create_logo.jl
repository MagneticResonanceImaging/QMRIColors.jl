using CairoMakie
using QMRIColors
using Colors

M = 50

cmap_T1 = relaxationColorMap("T1")
cmap_T2 = relaxationColorMap("T2")
T = collect(LinRange(0,100,100))

T2 = 100
ST2 = M*exp.(-T./T2)
lines(T,ST2,color = 1:length(T), colormap = cmap_T2)

T1 = 20
ST1 = M*(1 .- 2*exp.(-T./T1))


begin
  f=Figure(figure_padding = 0,size=(400,300))
  ax = Axis(f[1,1], backgroundcolor=:black)
  scatter!(ax,T,ST2,color = 1:length(T), colormap = cmap_T2,markersize=20)
  scatter!(ax,T,ST1,color = 1:length(T), colormap = cmap_T1,markersize=20)
 

pos_text = (0,0)
  text!(ax,pos_text[1] + 20,pos_text[2] - 50,text="QMRI\nColors",
            color=:white,
            fontsize=80)

            # add julia dot
 #           arc!(ax,Point2f(75,10), 4, -π, π,color=RGB(0.22,0.596,0.149),fill=true)
            pos = (62.5,2) .+ pos_text
            font_size_circle = 40
            text!(ax,Point2f(3+pos[1],5.5+pos[2]),text="⚫", fontsize=font_size_circle,color=RGB(0.22,0.596,0.149))
            text!(ax,Point2f(-0+pos[1],0+pos[2]),text="⚫", fontsize=font_size_circle,color=RGB(0.796,0.235,0.2))
            text!(ax,Point2f(6.5+pos[1],0+pos[2]),text="⚫", fontsize=font_size_circle,color=RGB(0.584,0.345,0.698))

            
            xlims!(ax,(0,maximum(T)))
            ylims!(ax,(-M,M))

            hidedecorations!(ax)
            tightlimits!(ax)
            resize_to_layout!(f)
            f
end
save("logo.svg",f)
save("logo.png",f)

