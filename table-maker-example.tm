\table-start
<<example1.png
>>this text goes in a cell to the right of example1.png
this text\nhas a newline and goes across the table
\h1 this text goes across the table in a h1 tag, here is a backslash: \
here are two backslashes with no intervening spaces: \\
<<example2.png
>>this text goes in a cell to the right of example2.png
\table-end

what this translates to:

<table style="border-spacing:5px"><tbody>
<tr><td><image style="width:450px" src="example1.png"></td>
<td>this text goes in a cell to the right of example1.png</td></tr>
<tr><td>this text<br/>has a newline and goes across the table</td></tr>
<tr><td><h1>this text goes across the table in a h1 tag, here is a backslash: \</h1></td></tr>
<tr><td>here are two backslashes with no intervening spaces: \\</td></tr>
<tr><td><image style="width:450px" src="example2.png"></td>
<td>this text goes in a cell to the right of example2.png</td></tr>
</tbody></table>
