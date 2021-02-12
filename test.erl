-module(test).
-export([modal/0, start/1]).
-include_lib("wx/include/wx.hrl").

modal() ->
    wx:new(),
    M = wxMessageDialog:new(wx:null(), "Hello, World!"),
    wxMessageDialog:showModal(M),
    ok.

start(Seconds) when is_integer(Seconds) ->
    wx:new(),
    Frame = wxFrame:new(wx:null(), ?wxID_ANY, "Countdown"),
    Counter = wxTextCtrl:new(Frame, ?wxID_ANY, [{value, integer_to_list(Seconds)}]),
    Button = wxButton:new(Frame, ?wxID_ANY, [{label, "Start"}, {pos, {0, 50}}]),
    wxFrame:show(Frame),
    countdown(Seconds - 1, Counter),
    ok.

countdown(Seconds, _) when Seconds < 0 ->
    ok;
countdown(Seconds, Counter) ->
    timer:sleep(1000),
    wxTextCtrl:setLabel(Counter, integer_to_list(Seconds)),
    countdown(Seconds - 1, Counter).
