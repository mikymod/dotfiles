---
name: implement
description: "Implement a piece of work based on a spec or set of tickets."
disable-model-invocation: true
---

Implement the work described by the user in the spec or tickets.

Once done, use `/code-review` skill to review the work.

Commit your work to the current branch.

**Disclaimer**: this skill is programming language agnostic.


## Quality Rules

### 1. Code **must** be easy to change

Being easy to change is the most important property of a codebase as it is the basis for everything else we want to do with the code.
Code that is easy to change can adapt to new technical requirements or business goals with ease.
Code that can’t change is doomed to stagnate, become technically irrelevant and then die.
Design code that is easy to change and adapt to various situations and circumstances.

### 2. Less is more

Keep the implementation small, sharp, easy to understand. Try to write elegant code in a state of grace. Don't settle for the first thing that comes to mind, try to find the most minimal and better working design. \

Strategies for keeping the codebase small:

- Be minimalistic: Implement the tiniest thing that solves the current problem. Don’t expect future needs.
- Build more advanced things out of a few simple building blocks.
- Never leave commented out code in the project. That’s what version history is for.

Strategies to keep conceptual complexity down:

- Don’t introduce unnecessary abstraction layers, prefer simpler concepts. Only abstract when it brings clear value.
- Minimize the use of external libraries. Prefer minimalistic one-file libraries over bigger ones.

- Less is more
- Prefer comments beside the implementation over separate design documents.
- Keep comments instructive and compact: explain why a shape, ordering, cache boundary, or memory choice exists.
- Keep public APIs narrow. CLI/server code should not know tensor internals.

### 3. Keep It Simple

- Fewer levels of abstraction.
- Easier to understand completely (performance implications, threading implications, etc).
- Easier to debug.
- More straightforward and easier to follow logic.

### 4. Explicit is better than implicit

It is better when programmers can see what is going on than when it is hidden. 
Avoid doing cute tricks with templates and macros whenever possible. 
Think about code that is easy to understand and step through in a debugger.

### 5. Avoid coupling

Avoid complicated dependencies between systems. These make the codebase harder to understand and modify. 
It should be possible to modify, optimize or replace each system on its own.
Use abstract interfaces to access shared services such as logging, file systems, memory allocation, etc. 
That way, these systems can be replaced or mocked for tests.

## Style

### Commenting

Exposed API functions need documentation comments, other code only needs to be commented as necessary. 
Write your code clearly and use sensible names to reduce the need for comments.

## Commit Style

Follow this commit style:

```
<one-line description>

<multi-line description of how a problem is solved>

```
