==Preface==
The information presented here is purely intended and no guarantee of fitness for purpose is given.
I am not a professional, working in an uncontrolled environment, do try this at home.

==Schematic Capture==

===Annotation===

===Assigning Footprints===

====Drawing Symbols and Footprints====

===ERC===

===Netlist Generation===

=PCB Layout=
Import the netlist, start looking at the ratsnest and move stuff around, give yourself plenty of room to move stuff around as you narrow down the layout.  
Keep in mind which connections should be short (high current paths) but that ground will probably be filled in by a Zone.  
Note: Using hierarchical sheets in your schematic will separate the imported netlist's footprints accordingly.  

==Design Rules==
Filling in your manufacturer's rules (minimum clearances and widths) beforehand can be useful, especially on tight layouts with low currents.  
KiCad's defaults should be fairly safe for all mainstream manufacturers.  

==Traces, Vias, Zones==
The biggest limitation I'm aware of here is the lack of free-form (curved) traces.  
Once you have an approximate layout based on the ratsnest, get used to deleting traces.  
This phase is mostly iterative, you try to connect nets and see what issues arise, find a solution and see what issues arise.  
Note: There are autorouter plugins available, the general recommendation (even with the best autorouters) is to not rely on them (though they will produce an electrically correct result) and if you use them, to only let it do some parts (a bus for example) and to keep it in mind when doing your placement.  
	The main reason for their shortcomings is that the netlist is quite inadequate in describing the physical circuit and the Many factors make it Very difficult.  
	Placement and routing are so strongly correlated that by the time you figure out your placement, connecting everything is either trivial, or reveals an issue.  
	This isn't the same as interactive routing, design rule enforcement etc. can be very helpful.  

By now you should also have a board outline as you should be narrowing in on a final layout.  
(Though this will probably still be adjusted up to the gerber generation phase.)  

==DRC==
Start using this earlier rather than later, if you have more than 1 monitor, keep this open, I use it to do my zone fills.  

==Gerber Generation==
Disclaimer: read your manufacturer's specifics!  
A bit hidden under File\>Plot, don't forget File\>Fabrication Outputs\>Drill.  

==Pick & Place==
I know nothing about this, you'll have to do your own research.  
