

if ( GetLocale() == "deDE" ) then

DugisLocals = {
	PART_TEXT = "Teil",	
	["|cffff4500This quest is not listed in your current guide"] = "|cffff4500Diese Quest ist nicht in deinem Guide",
	["(.*) is now your home."] = "(.*) ist jetzt Euer Zuhause.",
	["^You .*Hitem:(%d+).*(%[.+%])"] = "^Ihr .*Hitem:(%d+).*(%[.+%])",
	

	["Accept Quest"] = "Quest annehmen",
	["Accept Daily"] = "tägliche Quest annehmen",
	["Ach/Profession"] = "Erfolg/Beruf",
	["Achievements and Professions Guides"] = "Erfolg- und Berufe Leitfaden",	
	["Alchemy"] = "Alchemie",
	["Automatic Waypoints"] = "Automatische Wegpunkte", 
	["Blacksmithing"] = "Schmiedekunst", 
	["Boat to"] = "Schiff nach",
	["Buy Item"] =  "Gegenstand kaufen",
	["Complete"] = "Komplett",
	["Complete Quest"] = "Quest abschliessen",
	["Configuration Settings for DugisGuideViewer"] = "Konfiguration des DugiGuideViewer",
	["Cooking"] = "Kochkunst",
	["Current Guide"] = "Aktueller Leitfaden",
	["Dailies/Events"] = "Dailies/Events",
	["Dailies and Events Guides"] = "Leitfaden für Dailies und Events",	
	["Desecrate this Fire!"] = "Entweiht dieses Feuer!",
	["Display Quest Level"] = "Zeige Queststufe an",
	["Dungeon"] = "Dungeon",
	["Dungeon Guides"] = "Dungeon Leitfaden",	
	["Dungeon Maps"] = "Dungeon-Karte",
	["Enchanting"] = "Verzauberkunst",	
	["Engineering"] = "Ingenieurskunst",	
	["First Aid"] = "Erste Hilfe",	
	["Fishing"] = "Angeln",		
	["Fly to"] = "Fliege zu",
	["Get Flight Path"] = "Flugpunkt holen",
	["Herbalism"] = "Kräuterkunde",		
	["Honor the Flame"] = "Ehrt die Flamme",
	["Inscription"] = "Inschriftenkundler",	
	["Item Button"] = "Gegenstandsfeld",
	["Jewelcrafting"] = "Juwelenschleifen",
	["Kill NPC"] = "Gegner töten",
	["Leatherworking"] = "Lederverarbeitung",	
	["Leveling"] = "Leveln",
	["Leveling Guides"] = "Leitfaden zum Leveln",	
	["Lock Large Frame"] = "Grosses Fenster festsetzen",
	["Lock Small Frame"] = "Kleines Fenster festsetzen",
	["Lock small frame into place"] = "Verhindert das ungewollte verschieben des kleinen Fensters",
	["Lock large frame into place"] = "Verhindert das ungewollte verschieben des grossen Fensters",
	["Manual Mode"] = "Manueller Modus",
	["Maps"] = "Karten",
	["Map each destination with TomTom"] = "Verbinde beide Ziele mit TomTom",
	["Mining"] = "Bergbau",	
	["No Guide Loaded"] = "Kein Guide ausgewählt",
	["No Guide Loaded. Right Click Here To Select One"] = "Kein Guide ausgewählt. Klicken Sie hier, um ein auszuwählen",
	["Note"] = "Hinweis",
	["Optional"] = "Optional",
	["Quest accepted: (.*)"] = "Quest angenommen: (.*)",	
	["Reload"] = "Aktualisieren",	
	["Reset"] = "Zurücksetzen",
	["Reset Frames Position"] = "Setze Fensterposition zurück",
	["Select a Dungeon Map"] = "Wähle eine Dungeonkarte aus",	
	["Select a leveling guide closest to your current level"] = "Wähle einen Leitfaden der deinem aktuellen Spielerlevel am Nächsten ist",
	["Set Hearthstone"] = "Ruhestein setzen",
	["Settings"] = "Einstellungen",
	["Settings for Dugi Guides"] = "Einstellungen des Dugi-Guides",
	["Shows a small window to click when an item is needed for a quest"] = "Zeigt ein kleines Fenster zum anklicken wenn ein Gegenstand für eine Quest benötigt wird",
	["Show Small Frame"] = "Zeige kleinen Fenster",
	["Show the quest level on the large and small frames"] = "Zeige die Queststufe in dem grossen und kleinen Fenster an",
	["Skinning"] = "Kürschnerei",
	["Tailoring"] = "Schneiderei",	
	["This mode lets the user individually complete or skip quests. When unchecked, the guide will skip all quests in the quest sequence"] = "Dieser Modus erlaubt dem Benutzer das individuelle annehmen oder überspringen von Quests. Wenn deaktiviert werden die Quests die im Leitfaden noch aufgelistet werden übersprungen",
	["Too High Level"] = "Zu hohe Stufe",
	["Travel to"] = "Reise nach",
	["Turn in Daily"] = "Tägliche Quest abgeben",
	["Turn in Quest"] = "Quest abgeben",
	["Use Dungeon Finder"] = "Benutze den Dungeonfinder",
	["Use Hearthstone"] = "Ruhestein benutzen",	
	["Use Item"] = "Gegenstand benutzen",
	["Events"] =  "Events",
	["Dailies"] =  "Dailies",
	["Dungeons"] =  "Dungeons",
	["Dailies Guides"] =  "Leitfaden für Daily Quests",
	["Events Guides"] =  "Leitfaden für Events",
	["Achievements Guides"] =  "Leifaden für Erfolge",
	["Professions Guides"] =  "Leitfaden für Berufe",
	["Help"] =  "Hilfe",
	["Automatic Quest Watch"] =  "Automatische Questüberwachung",
	["Small Frame Effect"] =  "Kleines Fenster",
	["Large Frame Border"] =  "Rahmen für grosses Fenster",
	["Step Complete Sound"] =  "Ton abspielen wenn Arbeitsschritt erledigt",
	["Use Carbonite Arrow"] =  "Benutze Carbonite Pfeil",
	["Use TomTom Arrow"] =  "Benutze TomTom Pfeil",
	["Classic Arrow"] =  "Klassischer Pfeil",
	["Show Ant Trail"] =  "Zeige Ameisenspur an",
	["Auto Quest Accept"] =  "Quest automatisch annehmen",
	["Tooltip Coordinates"] =  "Koordinaten in Tooltip anzeigen",
	["Guide Suggest Mode"] =  "Empfehle einen Leitfaden-Modus",
	["Auto Sell Greys"] =  "Graue Gegenstände automatisch verkaufen",
	["Remove Map Fog"] =  "Unerforschte Gebiete sichtbar machen",
	["Small Frame Border"] =  "Rahmen für kleines Fenster",
	["Minimap Blobs"] =  "Ninimap Blobs",
	["Low"] =  "Niedrig",
	["High"] =  "Hoch",
	["None"] =  "Keiner",
	["Current Step"] =  "Aktueller Schritt",
	["Tracked Quests"] =  "Verfolgte Quests",
	["Target Button"] =  "Zielknopf",
	["Minimap Blob Quality"] =  "Minimap Blob Qualität",
	["Auto Tooltip (Seconds)"] =  "Zeige Tooltip (zweite Wahl)",
	["Leveling Mode"] =  "Level Modus",
	["Collect Item"] =  "Nimm Gegenstand auf",
	["Higher Level Quest"] =  "Höherstufige Quest",
	["Accept Daily Quest"] =  "Nimm tägliche Quest an",
	["Suggest"] =  "Empfehlung",
	["Map each destination"] =  "Trage beide Ziele ein",
	["Switch between modern and classic arrow icons"] =  "Wechsle zwischen modernem und klassischem Pfeilsymbol",
	["Display ant trail between waypoints on the world map"] =  "Zeige Ameisenspur zwischen den Wegepunkten auf der Weltkarte an",
	["Automatically accept and turn in quests from NPCs. Disable with shift"] =  "Automatisches annehmen und abgeben der Quests bei NPCs. Mit SHIFTTASTE deaktivieren",
	["Show destination coordinates in the status frame tooltip"] =  "Zeige Zielkoordinaten im Status des Tooltips an",
	["Use the Carbonite arrow instead of the built in arrow"] =  "Benutze den Carbonite-Pfeil anstelle des Standardpfeils",
	["Use the TomTom arrow instead of the built in arrow"] =  "Benutze den TomTom-Pfeil anstelle des Standardpfeils",
	["Suggest guides for your player on level up"] =  "Empfiehlt einen neuen Leitfaden wenn dein Charakter ein neue Stufe erreicht",
	["Automatically sell grey quality items to merchant NPCs"] =  "Automatisches verkaufen der grauen Gegenstände bei einem Händler-NPC",
	["Use the same border that is selected for the large frame"] =  "Benutze den gleichen Rahmen der für das grosse Fenster gewählt wurde",
	["View undiscovered areas of the world map, type /reload in your chat box after change of settings"] =  "Zeige unerforschte Gebiete auf der Weltkarte an. Nach Änderung der Einstellungen /reload im Chatfenster eingeben",
	["Show regional quest destination hints on the Minimap"] =  "Zeige Hinweise für örtliche Quests auf der MiniMap an",
	["Target the NPC needed for the quest step"] =  "Markiert den NPC der für die Quest benötigt wird",
	["Human"] =  "Mensch",
	["Easy"] =  "Einfach",
	["Normal"] =  "Normal",
	["Hard"] =  "Schwierig",
	["You can now advance to"] =  "Du kannst nun fortfahren zu",
	["Dungeons"] =  "Dungeons",
	["Dailies"] =  "Dailies",
	["Events"] =  "Events",
	["Achievements"] =  "Erfolge",
	["Professions"] =  "Berufe",
	["Other"] =  "Anderes",
	["Questing"] =  "Questen",
	["Waypoints"] =  "Wegepunkte",
	["Frames"] =  "Fenster",
	["Search"] =  "Suchen",
	["Title"] =  "Titel",
	["Preload"] =  "Aktualisieren",
	["Record"] =  "Aufzeichnen",
	["Enabled"] =  "Aktivieren",
	["Clear Record"] =  "Lösche Aufzeichnung",
	["For technical support please contact:"] =  "Für technische Unterstützung kontaktieren Sie bitte:",
	["Video tutorials are available from the link below:"] =  "Videoanleitungen sind in den unten angegebenen Link verfügbar",
	["Icon Reference"] =  "Erklärung der Symbole",
	["Show Dugi Arrow"] =  "Zeige Dugipfeil",
	["Show Dugis waypoint arrow"] =  "Zeige Dugis Wegpunkt-Pfeil",
	["Show the corpse arrow to direct you to your body"] =  "Zeige Pfeil der dich zu deinem Leichnam führt",
	["Show Corpse Arrow"] =  "Zeige Pfeil zum Leichnam",
	["Show the On/Off button which enables or disables the guide"] =  "Zeige An/Aus Knopf um den Leitfaden zu aktivieren oder deaktivieren",
	["Show On/Off Button"] =  "Zeige An/Aus Knopf",
	["Shift click a quest step to track in the frame"] =  "SHIFT-Klick auf einen Questabschnitt um sie im Fenster zu verfolgen",
	["Enable Sticky Frame"] =  "Anheften der Fenster aktivieren",
	["Map Coordinates"] =  "Koordinatenanzeige",
	["Show Player and Mouse coordinates at the bottom of the map."] =  "Zeige Spieler- und Mauskoordinaten am Fuss der Karte an",
	["Show Target Button"] =  "Zeige Zielfenster",
	["Show target button frame"] =  "Zeige Zielfensterrahmen",
	["Customize Macro"] =  "Passe Makro an",
	["Customize Target Macro"] =  "Passe Zielmakro an",
	["Apply"] =  "Anwenden",
	["Default"] =  "Standard",
	["Clear"] =  "löschen",
	["Memory"] =  "Arbeitsspeicher",
	["Model Database"] =  "Model-Datenbank",
	["NPC Name Database"] =  "NPC Namen-Datenbank",
	["Quest Level Database"] =  "Queststufen-Datenbank",
	["Apply Memory Settings"] =  "Einstellungen anwenden",
	["Collect Garbage"] =  "Datenmüll sammeln",
	["Allows model viewer to function"] =  "Model Viewer aktivieren",
	["Provides localized NPC names. Required for target button."] =  "Stellt die Lokalen Namen der NPCs bereit. Wird für die Benutzung des Zielknopfs benötigt.",
	["Shows minimum level required for quests"] =  "Zeigt benötigte Mindeststufe für Quests an",
	["Auto Stick"] =  "Automatisch anheften",
}

setmetatable(DugisLocals, {__index=function(t,k) rawset(t, k, k); return k; end})
	
end