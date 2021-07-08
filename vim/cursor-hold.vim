function CursorHold_Callback(timer_id) abort
  set eventignore-=CursorHold
  doautocmd <nomodeline> CursorHold
  set eventignore+=CursorHold
endfunction

function CursorHoldI_Callback(timer_id) abort
  set eventignore-=CursorHoldI
  doautocmd <nomodeline> CursorHoldI
  set eventignore+=CursorHoldI
endfunction
