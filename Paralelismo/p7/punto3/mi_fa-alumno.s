
    .arch armv8-a
    .text
    .global mi_fetch_and_add
    .type mi_fetch_and_add, %function

mi_fetch_and_add:
   //Poned aqui el codigo
   _loop:
	ldaxr   x2, [x0]        // Load the value at address x0 into x2 (64-bit) with acquire semantics
	add     x3, x2, x1      // Add the value in x1 to the value in x2, store the result in x3
	stlxr   w4, x3, [x0]    // Attempt to store the result back to [x0] with release semantics, set w4 if failed
	cbnz    w4, _loop       // If store failed (w4 != 0), retry the loop

	// The old value is still in w2
	mov     x0, x2          // Move the old value to x0 to use as return value

   ret

