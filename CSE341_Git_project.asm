
.model small
.stack 100h
.data
;===Prompts===
promptVehicleNo db 'Please enter your vehicle number( 5 digit): $'
promptPhoneNo   db 'Please enter your phone number(11 digit): $'
vehicleNo       db 6 dup(?)    
phoneNo         db 12 dup(?)   

maxVehicles     equ 8
vehicleList     db maxVehicles*6 dup(?)  

;===User Role Selection===
userTypePrompt  db 10,13,'======Welcome to UNI PARKING SYSTEM =====',10,13
                db 'Please select Your User Type:',10,13
                db '1. Admin',10,13
                db '2. User',10,13
                db 'Your choice: $'

;===Admin Login===
adminIdPrompt   db 10,13,'Please enter a 2-digit Admin ID: $'
adminPassPrompt db 10,13,'Please enter a 4-digit Password: $'
loginSuccessMsg db 10,13,'Admin login successful.$'
loginFailMsg    db 10,13,'Invalid credentials.$'
adminId         db '66'      
adminPass       db '6666'    
inputId         db 3 dup(?)
inputPass       db 5 dup(?)

;===Menus===
adminMenu       db 10,13,10,13,'======Admin Menu======',10,13
                db 'Enter 1 to Show Record',10,13
                db 'Enter 2 to Delete Record',10,13
                db 'Enter 3 to Exit',10,13
                db 'Enter 4 to Search Vehicle',10,13
                db 'Your choice: $'

userMenu        db 10,13,10,13,'***User Menu****',10,13
                db 'Enter 1 for Bike',10,13
                db 'Enter 2 for Car',10,13
                db 'Enter 3 for Bus',10,13
                db 'Enter 4 for Cycle',10,13
                db 'Enter 5 to Exit',10,13
                db 'Enter your choice: $'

;===Messages===
msg1  db 'The parking Is Full$'
msg2  db 10,13,'Wrong input.$'
msg7  db 'Total amount collected = $'
msg8  db 'Total numbers of vehicles parked = $'
msg9  db 'Total number of bike parked = $'
msg10 db 'Total number of cars parked = $'
msg11 db 'Total number of buses parked = $'
msg13 db 'Total number of cycles parked = $'
msg12 db '=======Record was deleted successfully=====$'
chargeMsg db 10,13,'Your parking charge is: $'
timeMsg   db 10,13,'Your parking time is 1 hour.$'
sucessMsg db 10,13,'Your vehicle was parked successfully.$'
searchSuccess db 10,13,'Ypur vehicle is found.$'
searchFail    db 10,13,'Your vehicle is not found.$'

;===Variables===
amount dw 0
count  db '0'
bike   db '0'
car    db '0'
bus_count db '0' ; 
cycle  db '0'
vehicleIndex dw 0   


.code
main proc
    mov ax,@data
    mov ds,ax
;-------------------------------------------- 
;Ragib part
start_program:
    call newLine
    mov dx, offset userTypePrompt
    mov ah, 9
    int 21h

    mov ah, 1
    int 21h

    cmp al, '1'
    je admin_login_redirect
    cmp al, '2'
    je user_flow_redirect
    jmp start_program
;-------------------------------------------

admin_login_redirect:
    call clearScreen
    jmp admin_login

user_flow_redirect:
    call clearScreen
    jmp user_flow

;===ADMIN LOGIN===
;Ragib Part(Feature 6)
;-----------------------------------------------------------
admin_login:
    mov dx, offset adminIdPrompt
    mov ah, 9
    int 21h

    mov cx, 2
    mov si, offset inputId
inputAdminId:
    mov ah, 1
    int 21h
    mov [si], al
    inc si
loop inputAdminId

    mov dx, offset adminPassPrompt
    mov ah, 9
    int 21h

    mov cx, 4
    mov si, offset inputPass
inputAdminPass:
    mov ah, 1
    int 21h
    mov [si], al
    inc si
loop inputAdminPass

    cld
    mov ax, ds
    mov es, ax
    mov si, offset adminId
    mov di, offset inputId
    mov cx, 2
    repe cmpsb
    jne login_failed

    mov si, offset adminPass
    mov di, offset inputPass
    mov cx, 4
    repe cmpsb
    jne login_failed

    mov dx, offset loginSuccessMsg
    mov ah, 9
    int 21h
    jmp admin_panel  
    
    
;---------------------------------

login_failed:
    mov dx, offset loginFailMsg
    mov ah, 9
    int 21h
    jmp start_program
    
;----------------------------------------------------------------

;===ADMIN PANEl===
admin_panel_loop:
admin_panel:
    mov dx, offset adminMenu
    mov ah, 9
    int 21h

    mov ah, 1
    int 21h

    cmp al, '1'
    je show_record
    cmp al, '2'
    je delete_record
    cmp al, '3'
    je end_
    cmp al, '4'
    je search_vehicle_panel
    mov dx, offset msg2
    mov ah, 9
    int 21h
    jmp admin_panel_loop

search_vehicle_panel:
    call search_vehicle
    jmp admin_panel_loop

;===SHOW RECORD===  
; Ragi part --------------------------------------
show_record:     ;Feature 5
    call recrd
    jmp admin_panel_loop
;---------------------------------- -----------------
;===DELETE RECORD===
delete_record:
    call delt
    jmp admin_panel_loop

;===SEARCH VEHICLE===  
;Ragib's Part( Feature 5)
;-----------------------------------------------------------
search_vehicle proc
    call newLine
    mov dx, offset promptVehicleNo
    mov ah, 9
    int 21h

    mov cx, 5
    mov si, offset vehicleNo
inputSearchLoop:
    mov ah, 1
    int 21h
    mov [si], al
    inc si
loop inputSearchLoop

    mov cx, vehicleIndex      
    cmp cx, 0
    je search_fail_label
    xor dx, dx                 
search_loop:
    mov ax, dx
    mov bx, 6
    mul bx                    
    lea di, vehicleList
    add di, ax                
    mov cx, 5
    lea si, vehicleNo
    repe cmpsb
    je search_found
    inc dx                    
    cmp dx, vehicleIndex
    jl search_loop
search_fail_label:
    mov dx, offset searchFail
    mov ah, 9
    int 21h
    ret
search_found:
    mov dx, offset searchSuccess
    mov ah, 9
    int 21h
    ret
search_vehicle endp 
;---------------------------------------------------------------------------

;===USER FLOW===
user_flow:
    call newLine
    mov dx, offset promptVehicleNo
    mov ah, 9
    int 21h

    mov cx, 5
    mov si, offset vehicleNo
inputVehicleNoLoop:
    mov ah, 1
    int 21h
    mov [si], al
    inc si
loop inputVehicleNoLoop

    call newLine
    mov dx, offset promptPhoneNo
    mov ah, 9
    int 21h

    mov cx, 11
    mov si, offset phoneNo
inputPhoneNoLoop:
    mov ah, 1
    int 21h
    mov [si], al
    inc si
loop inputPhoneNoLoop

user_menu_loop:
    mov dx, offset userMenu
    mov ah, 9
    int 21h

    mov ah, 1
    int 21h

    cmp al, '1'
    je park_bike
    cmp al, '2'
    je park_car
    cmp al, '3'
    je park_bus
    cmp al, '4'
    je park_cycle
    cmp al, '5'
    je user_exit_redirect
    mov dx, offset msg2
    mov ah, 9
    int 21h
    jmp user_menu_loop

user_exit_redirect:
    call clearScreen
    jmp start_program

;===PARKING REDIRECTS===
park_bike:
    call bike_proc
    jmp user_menu_loop

park_car:
    call caar
    jmp user_menu_loop

park_bus:
    call buss
    jmp user_menu_loop

park_cycle:
    call cycl
    jmp user_menu_loop

end_:
    mov ah,4ch
    int 21h

;===Utility functions===
;Ragib part Newline
newLine proc
    mov ah, 2
    mov dl, 10
    int 21h
    mov dl, 13
    int 21h
    ret
newLine endp
;---------------------------------

clearScreen proc
    mov ah, 0
    mov al, 03h
    int 10h
    ret
clearScreen endp

print_num proc
    mov dx, 0
    mov bx, 10
    mov cx, 0
num_loop1:
    div bx
    push dx
    mov dx, 0
    inc cx
    cmp ax, 0
    jne num_loop1
num_loop2:
    pop dx
    add dx, 48
    mov ah, 2
    int 21h
    loop num_loop2
    ret
print_num endp

;===VEHICLE PARKING PROCEDURES===
bike_proc proc
    cmp vehicleIndex, maxVehicles
    jae parking_full
    mov ax, 30
    add amount, ax
    inc bike           
    inc count
    call save_to_list
    mov dx, offset chargeMsg
    mov ah, 9
    int 21h
    mov ax, 30
    call print_num
    jmp parking_done
bike_proc endp

caar proc
    cmp vehicleIndex, maxVehicles
    jae parking_full
    mov ax, 50
    add amount, ax
    inc car            
    inc count
    call save_to_list
    mov dx, offset chargeMsg
    mov ah, 9
    int 21h
    mov ax, 50
    call print_num
    jmp parking_done
caar endp

buss proc
    cmp vehicleIndex, maxVehicles
    jae parking_full
    mov ax, 100
    add amount, ax
    inc bus_count      
    inc count
    call save_to_list
    mov dx, offset chargeMsg
    mov ah, 9
    int 21h
    mov ax, 100
    call print_num
    jmp parking_done
buss endp

cycl proc
    cmp vehicleIndex, maxVehicles
    jae parking_full
    mov ax, 20
    add amount, ax
    inc cycle          
    inc count
    call save_to_list
    mov dx, offset chargeMsg
    mov ah, 9
    int 21h
    mov ax, 20
    call print_num
    jmp parking_done
cycl endp

save_to_list proc
    mov ax, vehicleIndex
    mov bx, 6
    mul bx
    lea di, vehicleList
    add di, ax
    lea si, vehicleNo
    mov cx, 5
    rep movsb
    mov byte ptr [di], 0
    inc vehicleIndex
    ret
save_to_list endp

parking_done:
    mov dx, offset timeMsg
    mov ah, 9
    int 21h
    mov dx, offset sucessMsg
    mov ah, 9
    int 21h
    ret

parking_full:
    call newLine
    mov dx, offset msg1
    mov ah, 9
    int 21h
    ret

;===RECORDS===
; Ragib Part--------------------------------------------------------------
;Feature 5
;msg7  db 'Total amount collected = $'
;msg8  db 'Total numbers of vehicles parked = $'
;msg9  db 'Total number of bike parked = $'
;msg10 db 'Total number of cars parked = $'
;msg11 db 'Total number of buses parked = $'
;msg13 db 'Total number of cycles parked = $'
recrd proc
    call newLine
    mov dx, offset msg7
    mov ah, 9
    int 21h
    mov ax, amount
    call print_num

    call newLine
    mov dx, offset msg8  ;(Offset loads the memory address)
    mov ah, 9
    int 21h
    mov dl, count
    mov ah, 2
    int 21h

    call newLine
    mov dx, offset msg9
    mov ah, 9
    int 21h
    mov dl, bike       
    mov ah, 2
    int 21h

    call newLine
    mov dx, offset msg10
    mov ah, 9
    int 21h
    mov dl, car        
    mov ah, 2
    int 21h

    call newLine
    mov dx, offset msg11
    mov ah, 9
    int 21h
    mov dl, bus_count  
    mov ah, 2
    int 21h
    
    call newLine
    mov dx, offset msg13
    mov ah, 9
    int 21h
    mov dl, cycle      
    mov ah, 2
    int 21h
    ret
recrd endp   
;----------------------------------------------------------------------

;DELETE RECORD   
;Ragib part   
;(Feature 5)
;-----------------------------------------------------------------
delt proc
    mov bike, '0'      
    mov car, '0'       
    mov bus_count, '0' 
    mov cycle, '0'     
    mov amount, 0
    mov count, '0'
    mov vehicleIndex,0
    lea di, vehicleList
    mov cx,maxVehicles*6
    mov al,0
    rep stosb
    ;repeat store string byte
    ;Repeat storing the byte in AL into memory ECX times

    call newLine
    mov dx, offset msg12
    mov ah, 9
    int 21h
    ret
delt endp
;---------------------------------------------------------------------
end main
