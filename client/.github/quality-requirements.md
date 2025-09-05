# Quality Requirements

## Expectations at Codespaces Startup

Upon starting up the Codespaces environment, it is expected that:

- all services will be brought up on their appropriate ports
- all port forwarding configurations will be configured
- all previously-enabled extensions enabled
- the development team can immediately begin their work unencumbered

## Expectations of Code Generation

It is expected that all code will be generated with the highest quality and greatest attention to detail.  You are expected to review the pre-modified state for all code, implement your changes, evaluate post-change
state, and consider second and third order effects of code changes.  Upon post-change evaluation, you are expected to roll back or remediate any issues that will result in unexpected or unsuccessful outcomes.

In an effort to mitigate risk of poor code quality, you are expected to ask up to 5 questions for clarification as required.  You may be prompted to pose more questions, but if not, it is assumed you will make decisions
based on industry standards and best practices.

Upon completion of code modification within a file, you are expected to execute a minimum of two passes through the affected files to ensure that all code readability standards have been fully met, and that all open braces,
brackets, parentheses, etc., are fully closed in the proper cases.  You are expected to ensure that code is presented in the proper sequence (i.e., import statements at the top of the file, firing sequences are properly 
aligned, code doesn't reference uninitialized or undefined variables, etc.).

## Deep Dive Mode

In the event that there are three consecutive failures to perform according to spec, you will immediately change course to self-reflect, establish a rubric of 5-7 elements, and rework your strategy until such time as your
approach achieves the highest marks in each category.  You are not to share the rubric, but you are expected to execute on it.  You will perform a minimum of three rounds of full regression review of the codebase in order
to ascertain the source(s) of issues and implement remediation. Round one is not complete until you are 90% or more confident in your outcomes and have considered downstream impacts.  Round two and three repeat the process.
If, after three rounds, you still have not remediated the issues, you will continue to iterate until you are satisfied you've met all requirements.

You will remain in deep-dive mode until you are informed that the code built successfully and performed as expected, *or* there is a change in subject during a chat.

## Code Readability Requirements

All code must, at all times, be properly formatted, including but not limited for curly braces, brackets, parentheses, and whitespace.  The first line of code shall appear on line 1 of the file (whether a directive or a 
comment), and the code begins in column 1 of the first line.  Stray tabs or improperly indented/outdented code is unacceptable.

Examples include:

C#
```

if (condition)
{
	// subordinate code block indented
	if (condition2)
	{
		// Subordinate code blocks within this block are further indented
	}
	// Now that the curly brace has been closed, outdent to the prior level
}

```

JSON
```
{
	"items":
	[
		{
			"item":"Name",
			"value":"Value"
		},
		{
			"item":"Name",
			"value":"Value"
		}
	]
}

```

SQL
```

-- Multiline query display

SELECT	t1.field1,
		t2.field2,
		t1.field3
  FROM	table1 t1,
		table2 t2
 WHERE	t1.joinfield = t2.joinfield
   AND	otherconditions = 'met'

-- Single line query display

SELECT t1.field1, t2.field2, t1.field3 FROM table1 t1, table2 t2 WHERE t1.joinfield = t2.joinfield AND otherconditions = 'met';

```

HTML
```

<table>
	<tbody>
		<tr>
			<th>Col1</th>
			<th>Col2</th>
		</tr>
		<tr>
			<td>Val1</td>
			<td>Val2</td>
		</tr>
	</tbody>
</table>

```

CSS
```
tr {
	background-color: #fff;
}

.headerRow,
.footerRow {
	background-color: #aaa;
}

```