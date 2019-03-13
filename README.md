Preface
=======
The information presented here is intended purely divulgatory and no guarentee of fitness for purpose is given.  
The views expressed here are entirely my own and do not reflect KiCad or the venue hosting this talk/workshop.  
I am not a professional, working in an uncontrolled environment, do try this at home.  

This intro is highly condensed, I'll save symbol and footprint creation to the end and skip many things.  

Schematic Capture
=================
If you already have a schematic, this part can be quite fast.  
>You can also do the primary drawing here, SPICE simulation can be a great help here, but you'll have to figure that out with the help of duckduckgo.com.  

Start with familiarizing yourself with hotkeys like ?, R, C, G, X, Y, DEL, etc. many of these are noted in the context menus.  
If there are any duplicated layouts, start with drawing a hierarchical sheet and naming it appropriately.  
Start placing symbols, try keeping the convention of power "going" from top to bottom and signals going left to right.  
Keep things spaced out more than you think you'll need, as long as you can keep an overview of all the parts on a sheet, there's nothing wrong with drawing long "wires".  
If there's obvious ways to connect symbols, rotate and/or mirror the symbols to match this,  
but don't be afraid to use a net label to jump to the other side of the schematic rather than drawing a wire going around everything. (net labels are local to a sheet)  
Copying existing component can speed up drawing quite allot, especially if you already have some metadata set for the component.  

Once you have all the components you need on a sheet, start connecting them.  
>You can select multiple components and use TAB to drag them or M to move them.  
>>You can also drag individual components with G.  

I usually assign component values (4K7, 0.1uF, NE555, etc) while I place the component.  

Annotation
----------
To differentiate parts, every symbol requires a unique name.  
I use the automatic annotation tool with the "entire schematic", "reset but keep multi-unit order", "sort by X" and "x100" options.  
>This makes the Reference Designator a fairly arbitrary number, if you want to give them more meaningful names, feel free to do so, but use "keep existing" when annotating automatically or you'll lose them.  
multi-unit parts on hierarchical sheets are not identical, you can use unit B on an identical copy of a sheet where you use unit A.  
>This can be tricky so double check after annotating.  

Assigning Footprints
--------------------
In the future you should consider doing this while you're placing the symbols (at the same time you assigning values).  
>Especially if you're using allot of components, draw one with the footprint once, then copy it for everything and adjust its value.  

To put the components on a board, we need a footprint, which is the pattern of exposed copper on which the component is soldered (which includes a hole through for the leads if you're using through hole components)  
You can assign a footprint to an individual part via the edit menu or directly with the F hotkey.  
But there is also the Assign Footprints menu which lists all components in the center, categories on the left and footprints in that category on the right.  

ERC
---
Once all the work seems to be done on the schematic, it is Highly recommended to run the Electrical Rules Check.  
This checks what type of connections are made and tries to stop you from, for example, shorting your power to ground.  
It is very pedantic and can generate errors and warnings that don't seem a like problem,  
It is Critical you read through all the errors and warnings and understand why each is occuring.  

Netlist Generation
------------------
To start the PCB layout, we first need to generate a netlist, this describes all the connections we drew in the schematic,  
(which pins connect to which pins) which we have to draw on the PCB.  
This abstracts the schematic layout, only the connections, footprints, name and value go into the netlist.  
>The spacing, position, symbol, etc. don't affect the netlist and are purely there to make it Readable to Humans.  
>Putting a net label on a connection will give it a name which you'll be able to see in PCBnew.  

PCB Layout
==========
Import the netlist, start looking at the ratsnest and move stuff around, give yourself plenty of room to move stuff around as you narrow down the layout.  
Keep in mind which connections should be short (high current paths) but that ground will probably be filled in by a Zone.  
>At import, the footprints should be spread and grouped according to their reference designator, using hierarchical sheets and automatic annotation according to the sheet will result in clusters according to the sheets.  

Design Rules
------------
Filling in your manufacturer's rules (minimum clearances and widths) beforehand can be useful, especially on tight layouts with low currents.  
KiCad's defaults should be fairly safe for all mainstream manufacturers.  

Traces, Vias, Zones
-------------------
The biggest limitation I'm aware of here is the lack of free-form (curved) traces.  
Once you have an approximate layout based on the ratsnest, get used to deleting traces.  
This phase is mostly iterative, you try to connect nets and see what issues arise, find a solution and see what issues arise.  

There are autorouter plugins available, the general recommendation (even with the best autorouters) is to not rely on them (though they will produce an electrically correct result) and if you use them, to only let it do some parts (a bus for example) and to keep it in mind when doing your placement.  
>The main reason for their shortcomings is that the netlist is quite inadequate in describing the physical circuit and the Many factors make it Very difficult.  
>Placement and routing are so strongly correlated that by the time you figure out your placement, connecting everything is either trivial, or reveals an issue.  
>This isn't the same as interactive routing, design rule enforcement etc. can be very helpful.  

By now you should also have a board outline as you narrow in on a final layout.  
(Though this will probably still be adjusted up to the gerber generation phase.)  

Usually a Zone for the GND net will be created the size (or larger) of the board outline, on both sides.  
While this should connect all the GND points, it is very easy to isolate a region the fill cannot reach.  
>A simple way to avoid this is to route GND as well.  

DRC
---
Start using this earlier rather than later, if you have more than 1 monitor, keep this open, I use it to do my zone fills.  

This checks you haven't exceeded clearances etc.  
The same advice as for ERC applies here, Don't ignore Any of the errors or warnings without forethought.  
Unlike ERC, DRC errors and warnings are usually all easily resolvable.  
>I strongly recommend never plotting any file without running a 0 error DRC.  

Gerber Generation
-----------------
Disclaimer: read your manufacturer's specifics before ordering!  
This is a bit hidden under File\>Plot, don't forget File\>Fabrication Outputs\>Drill.  
Set the plotter according to the manufacturer's preferences.  

Make sure to include the edge cut layer, copper layer(s), mask layer(s) and the silkscreen layer(s).  
The edge cut may be done on the edge of the drawn line rather than the center of it, keep this in mind and ask your manufacturer if it's relevant.  
If your board includes any holes, also include the drill file, if you have non plated holes, check with your manufacturer if you should combine them into 1 file.  
If you want to order a stencil (useful for surface mount soldering), also plot and include the paste layer(s).  
>I recommend checking the gerbers both with kicad's gerbview and another tool such as gEDA's gerbv or an online tool.  

Drawing Symbols and Footprints
==============================
The drawing of a new symbol or footprint is fairly similar, you set a libary (or create a project specific one) in the appropriate editing tool, create a new symbol/footprint and use the available tools.  
For a symbol, pay attention to the pin mode.  
For a footprint, pay attention to the layers.  
Once you save this, you'll be able to use it just like any other symbol/footprint (you may have to use the library manager to add the new library).  

Pick & Place
============
I know nothing about this, you'll have to do your own research.  
