Border(Margin(5, 5, 20, 0),{
    VStack(Stretch(0, 0), {
    Label("", MinSize(400,200), Stretch(0,0), ID("text1")),
    FlexibleSpace(),
    }),
	VStack(Stretch(0, 0), {
		HStack(Stretch(0, 0), {
			ImageButton("gfx/ankh.png", MinSize(26), Stretch(0), ID('Button_1')),
            Label("Hello", MinSize(60, 26), Stretch(0), ID("text")),
            ImageButton("gfx/ankh.png", MinSize(26), Stretch(0), ID('Button_2')),
		}),
        TextView("Hello HelloHelloHelloHelloHelloHelloHelloHelloHelloHello asdas", MinSize(400,200), Stretch(0,0), ID("testview1")),
        FlexibleSpace(),
	}),
})