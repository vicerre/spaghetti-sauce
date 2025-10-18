Main by Redacted begins here.

Use authorial modesty.

Volume - Actions

[ https://ganelson.github.io/inform-website/book/WI_12_7.html ]
a-hugging is an action applying to one touchable thing.
Understand "hug [something]" as a-hugging.

Understand "poke [something]" as touching.

Volume - Things

A c-shelf is a kind of container.
A c-shelf is usually fixed in place.
A c-shelf is scenery.
The description of a c-shelf is "A shelf."
Understand "shelf" as c-shelf.

A t-fox-tail is a thing.
The printed name of t-fox-tail is "your large, fluffy tail".
The description of t-fox-tail is "It's a fearless plume of scarlet, and sizable enough to hug."
Understand "fluff" as t-fox-tail.
Understand "tail" as t-fox-tail.

Volume - People

Book - Alis

    p-alis is a man.
    The printed name of p-alis is "Alis".
    The description of p-alis is "The Vicerre from the other universe, a sharp-faced and steely-eyed man that causes your hair to fluff. You know him as Alis, and you're the one who boarded him onto Arklight Limited.

    He's wearing an alabaster-white overcoat, and shares Vicerre's countenance, if that countenance had been eroded by a vicious cycle of anguish and loss, then reforged through careful sutures of the soul."

    Understand "Alis" as p-alis.
    Understand "Alistair" as p-alis.
    Understand "Alistair Vicerre" as p-alis.
    Understand "Vicerre" as p-alis.

Book - Solana

    p-solana is a woman.
    The printed name of p-solana is "Solana".
    The description of p-solana is "Your name is Solana Sié.

    In some regards, you're a walking paradox. You weren't always human in your past lives, and judging by the large, fluffy tail stemming behind you, you would contend[--]justifiably[--]that you aren't again.

    Vic once described you as 'bright-eyed and bushy-tailed', and that comment stayed with you since."

    Understand "Sie" as p-solana.
    Understand "Sié" as p-solana.
    Understand "Solana" as p-solana.
    Understand "Solana Sie" as p-solana.
    Understand "Solana Sié" as p-solana.

    t-fox-tail is part of p-solana.

Book - Vicerre

    p-vicerre is a man.
    The printed name of p-vicerre is "Vic".
    [ https://inform-7-handbook.readthedocs.io/en/latest/chapter_5_creating_characters/creating_an_npc/ ]
    The initial appearance of p-vicerre is "Vic is immersed over by the supercomputer, mulling away at his next project."

    The description of p-vicerre is "One part bioengineer, one part inventor, and one part puzzler, Armin Vicerre is a veritable polymath of eccentricities.

    From the raggedy mop on his scalp to his attendance to Ice Cream Sundays, you might not have guessed that he's the resident founder and principal head of Arklight Limited.

    Among other things, he has a penchant for sweet things and the color red[--]perhaps that's why he's obsessed with you."

    [ https://intfiction.org/t/-/45138 ]
    [ https://ganelson.github.io/inform-website/book/WI_7_9.html ]
    After doing something to p-vicerre the first time:
        Now the item described is handled.

    Understand "Armin" as p-vicerre.
    Understand "Armin Vicerre" as p-vicerre.
    Understand "Vic" as p-vicerre.
    Understand "Vicerre" as p-vicerre.

Volume - Action Modifiers

Book - Eating

    Check eating p-vicerre the first time:
        Instead say "You size up Vic's frame, [i]just[/i] withholding the yen to slaver and bare the carnassials in your maw. You're about to polymorph into a vulpid of voluminous heft when, suddenly, the current of time around you dissolves, leaving you locked to your feet.

        ...Look, as much as you could devour your beau in whole, I'm going to file a line-item veto on this one. It's not that you can't, or it's unsafe. It's just that it'd soil the mood I was going for when writing this game, you know?"

    Check eating p-vicerre at least two times:
        Instead say "As much as your nose twitches and your mouth waters, you think better than to goad the attention of the Storyteller again."

Book - Hugging

    [ https://ganelson.github.io/inform-website/book/WI_12_9.html ]
    [ https://inform-7-handbook.readthedocs.io/en/latest/chapter_4_actions/rulebooks_&_stop_the_action/ ]
    [ https://intfiction.org/t/-/2741 ]

Check a-hugging:
	If the noun is p-solana:
		Continue the action;
	If the noun is p-vicerre:
		Continue the action;
	Otherwise if the noun is a person:
		Instead say "You're not sure if [they] accept hugs.";
	Otherwise if the noun is t-fox-tail:
		Continue the action;
	Otherwise:
		Instead say "That's not something you can hug (not awkwardly, at least).".

    Carry out a-hugging p-solana:
        Instead say "With a stern grip and a weighty retain, you clutch yourself, then release. A bubbly sensation then rises in your chest."

    [ https://www.reddit.com/comments/11chziv/ ]
    Carry out a-hugging p-vicerre the first time:
        Instead say "You pull Vic into a deep embrace, and he nearly chokes from the sudden show of affection. He delicately returns the gesture."

    Carry out a-hugging p-vicerre at least two times:
        Instead say "Vic seems awfully flustered by your repeat show of affection, though he takes care to reciprocate once more."

    Carry out a-hugging t-fox-tail:
        Instead say "You give your tail a tight squeeze, and it writhes joyously, its wagging haplessly constrained in your grasp."

Book - Smelling

    Carry out smelling p-alis:
        Instead say "He has a faint metallic odor about him."

    Carry out smelling p-solana:
        Instead say "You smell of thick fox musk and lavender."

    Carry out smelling p-vicerre:
        Instead say "He smells of mothballs and vanilla cream."

Book - Taking

    Check taking p-vicerre:
        Instead say "He's quite taken with you already."

Book - Touching

    Carry out touching p-vicerre the first time:
        Instead say "You gingerly poke Vic on the nose.[paragraph break]Vic's eyes glisten the moment your finger hits the apex.[paragraph break]'What is it, Solana?' he asks, a fuzzy lilt in his tenor."

    Carry out touching p-vicerre the second time:
        Say "You give Vic's nose a second touch.[paragraph break]Vic seems passably nonplussed. If he were a dog, his head would cocked, and he'd be making an funny half-yap toward you."

    Carry out touching p-vicerre the third time:
        Say "You give Vic's nose a third touch.[paragraph break]Vic seems to recognize this tact as a game you're playing."

    Carry out touching p-vicerre at least four times:
        Say "You give Vic's nose another touch.[paragraph break]You're just having fun with him now, and he seems to enjoying your engrossment."

    [ Override Neutral Standard Responses - Touch, Wave ]
    [ https://intfiction.org/t/-/9588/2 ]
    [ https://ganelson.github.io/inform-website/book/WI_14_10.html ]
    [ https://ganelson.github.io/inform-website/book/WI_18_15.html ]
    Report touching p-vicerre:
        Instead do nothing.

Volume - Rooms

    Book - Alis's lab

    r-alis-lab is a room.
    The printed name of r-alis-lab is "Alis's lab".

    Book - Solana's bedroom

    r-solana-bedroom is a room.
    The printed name of r-solana-bedroom is "Solana's bedroom".

    Book - Vicerre's lab

    r-vicerre-lab is a room.
    The printed name of r-vicerre-lab is "Vicerre's lab".
    The description of r-vicerre-lab is "A well-worn sight by now. Knowing the person who oversees the place, it seems uncommonly ascetic, as though an deluge had come and raptured the fixtures within.

    Against the back wall is a shelf laden with assorted samples."

    c-shelf-samples is a c-shelf.
    Understand "samples" as c-shelf-samples.
    The printed name of c-shelf-samples is "the samples shelf".
    The description of c-shelf-samples is "The shelf Vic uses to exhibit his samples, a proud menagerie of his numerous excursions into the multiverse. In the context of their work, the materials on this shelf are prepared, extracted, and weaved into biological syntheses. Among such samples include clippings in glass jars tagged with manila, cast-aside carapaces of hex-touched arachnoids, and effulgent, scintillating motes held in an aqueous solution."

    r-vicerre-lab contains a c-shelf-samples.
    r-vicerre-lab contains p-solana.
    r-vicerre-lab contains p-vicerre.

Volume - Player

The player is p-solana.

Volume - Init

[ https://ganelson.github.io/inform-website/book/WI_14_1.html ]
[ When play begins: ]
    [ Now the story viewpoint is third person singular; ]
    [ Say "Hello, world!". ]

Main ends here.
