:- module(with_memory_file, [with_memory_file/3]).
:- use_module(library(memfile)).

memory_file_to_type(Handle, atom(Atom)) :-
    memory_file_to_atom(Handle, Atom).

memory_file_to_type(Handle, codes(Codes)) :-
    memory_file_to_codes(Handle, Codes).

memory_file_to_type(Handle, string(String)) :-
    memory_file_to_string(Handle, String).

with_memory_file(Type, Mode, Goal) :-
    setup_call_cleanup(
        (new_memory_file(Handle), open_memory_file(Handle, Mode, OutputStream)),
        call(Goal, OutputStream),
        (close(OutputStream), memory_file_to_type(Handle, Type), free_memory_file(Handle))
    ).

:- begin_tests(with_memory_file).

test(with_memory_file) :-
    with_memory_file(atom(Atom), write, [Stream]>>write(Stream, foo)),
    Atom = foo,
    with_memory_file(string(String), write, [Stream]>>write(Stream, foo)),
    String = "foo",
    with_memory_file(codes(Codes), write, [Stream]>>write(Stream, foo)),
    Codes = [102, 111, 111].

:- end_tests(with_memory_file).
