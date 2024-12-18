
    .global mi_mutex_lock
    .align 2
    .type mi_mutex_lock,%function

mi_mutex_lock:
    .cfi_startproc
_lock:
    	ldaxr   x1, [x0]        // Load the value at address x0 into x1 with acquire semantics
    	cmp     x1, #0          // Compare the value with 0 (unlocked)
    	b.ne    _lock           // If not zero, branch back to _lock to retry
    	mov     x1, #1          // Prepare the value 1 to store
    	stlxr   w2, x1, [x0]    // Attempt to store 1 into [x0] with release semantics, set w2 if failed
    	cbnz    w2, _lock       // If store failed (w2 != 0), retry the loop
	ret
    .cfi_endproc

    .global mi_mutex_unlock
    .align 2
    .type mi_mutex_unlock,%function
mi_mutex_unlock:
    .cfi_startproc
    stlr    xzr, [x0]       // Store 0 (unlocked) into the mutex location with release semantics
    ret
    .cfi_endproc
