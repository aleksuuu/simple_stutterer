{
	"patcher" : 	{
		"fileversion" : 1,
		"appversion" : 		{
			"major" : 8,
			"minor" : 6,
			"revision" : 4,
			"architecture" : "x64",
			"modernui" : 1
		}
,
		"classnamespace" : "box",
		"rect" : [ 801.0, 466.0, 640.0, 480.0 ],
		"bglocked" : 0,
		"openinpresentation" : 0,
		"default_fontsize" : 12.0,
		"default_fontface" : 0,
		"default_fontname" : "Arial",
		"gridonopen" : 1,
		"gridsize" : [ 15.0, 15.0 ],
		"gridsnaponopen" : 1,
		"objectsnaponopen" : 1,
		"statusbarvisible" : 2,
		"toolbarvisible" : 1,
		"lefttoolbarpinned" : 0,
		"toptoolbarpinned" : 0,
		"righttoolbarpinned" : 0,
		"bottomtoolbarpinned" : 0,
		"toolbars_unpinned_last_save" : 0,
		"tallnewobj" : 0,
		"boxanimatetime" : 200,
		"enablehscroll" : 1,
		"enablevscroll" : 1,
		"devicewidth" : 0.0,
		"description" : "",
		"digest" : "",
		"tags" : "",
		"style" : "",
		"subpatcher_template" : "",
		"assistshowspatchername" : 0,
		"boxes" : [ 			{
				"box" : 				{
					"args" : [ "pod" ],
					"bgmode" : 0,
					"border" : 0,
					"clickthrough" : 0,
					"enablehscroll" : 0,
					"enablevscroll" : 0,
					"id" : "obj-2",
					"lockeddragscroll" : 0,
					"lockedsize" : 0,
					"maxclass" : "bpatcher",
					"name" : "oopsy.maxpat",
					"numinlets" : 1,
					"numoutlets" : 0,
					"offset" : [ 0.0, 0.0 ],
					"patching_rect" : [ 486.0, 83.0, 128.0, 128.0 ],
					"viewvisibility" : 1
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-1",
					"maxclass" : "newobj",
					"numinlets" : 1,
					"numoutlets" : 1,
					"outlettype" : [ "signal" ],
					"patcher" : 					{
						"fileversion" : 1,
						"appversion" : 						{
							"major" : 8,
							"minor" : 6,
							"revision" : 4,
							"architecture" : "x64",
							"modernui" : 1
						}
,
						"classnamespace" : "dsp.gen",
						"rect" : [ 59.0, 106.0, 1201.0, 697.0 ],
						"bglocked" : 0,
						"openinpresentation" : 0,
						"default_fontsize" : 12.0,
						"default_fontface" : 0,
						"default_fontname" : "Arial",
						"gridonopen" : 1,
						"gridsize" : [ 15.0, 15.0 ],
						"gridsnaponopen" : 1,
						"objectsnaponopen" : 1,
						"statusbarvisible" : 2,
						"toolbarvisible" : 1,
						"lefttoolbarpinned" : 0,
						"toptoolbarpinned" : 0,
						"righttoolbarpinned" : 0,
						"bottomtoolbarpinned" : 0,
						"toolbars_unpinned_last_save" : 0,
						"tallnewobj" : 0,
						"boxanimatetime" : 200,
						"enablehscroll" : 1,
						"enablevscroll" : 1,
						"devicewidth" : 0.0,
						"description" : "",
						"digest" : "",
						"tags" : "",
						"style" : "",
						"subpatcher_template" : "",
						"assistshowspatchername" : 0,
						"boxes" : [ 							{
								"box" : 								{
									"code" : "/*\n    Modified from Waveset chopper / repeater by Graham Wakefield (2012)\n*/\n\n// the segment storage (each segment on its own channel):\nData segment_data(10004, 1); // 10004\n\nParam midi_cc64; // 0–1.\n\n// hold the current playback segment:\n// Param hold(0, min=0, max=1);\n\nParam min_len(2500, min=1000, max=10000);\nParam max_len(4000, min=1000, max=10000);\nParam fade_len(300, min=10, max=500);\nParam gap_len(100, min=0, max=200);\n\n// the number of samples since the last capture:\nHistory write_index(10000);\n// the sample index of playback:\nHistory play_index(0);\n\nHistory prev_hold;\n\nHistory segment_len(10000);\n\nhold = (midi_cc64 > 0);\noutput = in1;\n// record the next 2940 samps if hold state switches from false to true\nif (hold) {\n\tif (!prev_hold) {\n\t\twrite_index = 0;\n\t\tplay_index = 0;\n\t\tsegment_len = scale(noise(), -1, 1, min_len, max_len);\n\t}\n\tif (write_index < segment_len) {\n\t\tamp = 1;\n\t\tif (write_index < fade_len) {\n\t\t\tamp = write_index / fade_len;\n\t\t} else if (write_index > segment_len - fade_len - gap_len) {\n\t\t\tamp = clip((segment_len - write_index - 1) / fade_len, 0, 1);\n\t\t}\n\t\tpoke(segment_data, in1 * amp, write_index);\n\t\twrite_index += 1;\n\t} else {\n\t\toutput += peek(segment_data, play_index);\n\t\tplay_index = wrap(play_index + 1, 0, segment_len);\n\t}\n} else {\n\tif (play_index < segment_len - 1) {\n\t\toutput += peek(segment_data, play_index);\n\t\tplay_index = play_index + 1; // no wrap this time because of the if; this is to prevent clicks\n\t}\n}\n\nout1 = output;\n\nprev_hold = hold;",
									"fontface" : 0,
									"fontname" : "<Monospaced>",
									"fontsize" : 12.0,
									"id" : "obj-5",
									"maxclass" : "codebox",
									"numinlets" : 1,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"patching_rect" : [ 50.0, 58.0, 934.0, 496.0 ]
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-1",
									"maxclass" : "newobj",
									"numinlets" : 0,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"patching_rect" : [ 50.0, 14.0, 28.0, 22.0 ],
									"text" : "in 1"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-4",
									"maxclass" : "newobj",
									"numinlets" : 1,
									"numoutlets" : 0,
									"patching_rect" : [ 50.0, 574.0, 35.0, 22.0 ],
									"text" : "out 1"
								}

							}
 ],
						"lines" : [ 							{
								"patchline" : 								{
									"destination" : [ "obj-5", 0 ],
									"source" : [ "obj-1", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-4", 0 ],
									"source" : [ "obj-5", 0 ]
								}

							}
 ]
					}
,
					"patching_rect" : [ 323.0, 148.0, 118.0, 22.0 ],
					"saved_object_attributes" : 					{
						"exportfolder" : "Macintosh HD:/Users/alexander/Documents/Max 8/Projects/simple_stutterer/",
						"exportname" : "stutterer_daisy"
					}
,
					"text" : "gen~ stutterer_daisy",
					"varname" : "stutterer_daisy"
				}

			}
 ],
		"lines" : [  ],
		"parameters" : 		{
			"obj-2::obj-32" : [ "live.text[2]", "FILTER", 0 ],
			"obj-2::obj-33" : [ "live.text[1]", "FILTER", 0 ],
			"obj-2::obj-34" : [ "live.text[3]", "FILTER", 0 ],
			"parameterbanks" : 			{
				"0" : 				{
					"index" : 0,
					"name" : "",
					"parameters" : [ "-", "-", "-", "-", "-", "-", "-", "-" ]
				}

			}
,
			"inherited_shortname" : 1
		}
,
		"dependency_cache" : [ 			{
				"name" : "oopsy.maxpat",
				"bootpath" : "~/Documents/Max 8/Packages/oopsy/patchers",
				"patcherrelativepath" : "../../Packages/oopsy/patchers",
				"type" : "JSON",
				"implicit" : 1
			}
, 			{
				"name" : "oopsy.node4max.js",
				"bootpath" : "~/Documents/Max 8/Packages/oopsy/javascript",
				"patcherrelativepath" : "../../Packages/oopsy/javascript",
				"type" : "TEXT",
				"implicit" : 1
			}
, 			{
				"name" : "oopsy.snoop.js",
				"bootpath" : "~/Documents/Max 8/Packages/oopsy/javascript",
				"patcherrelativepath" : "../../Packages/oopsy/javascript",
				"type" : "TEXT",
				"implicit" : 1
			}
, 			{
				"name" : "stutterer_daisy.gendsp",
				"bootpath" : "~/Documents/Max 8/Projects/simple_stutterer",
				"patcherrelativepath" : ".",
				"type" : "gDSP",
				"implicit" : 1
			}
 ],
		"autosave" : 0
	}

}
