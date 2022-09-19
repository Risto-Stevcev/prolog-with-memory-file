# prolog-with-memory-file

Like [`with_output_to`](https://www.swi-prolog.org/pldoc/doc_for?object=with_output_to/2) but for memory files

```prolog
?- with_memory_file(string(String), write, [Stream]>>write(Stream, foo)).
String = "foo".
```

## License

See LICENSE
