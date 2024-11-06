import tkinter as tk

# Tạo cửa sổ chính
root = tk.Tk()
root.title("origin source code")

# Tạo một Frame để chứa mã và thanh cuộn
frame = tk.Frame(root)
frame.grid(row=0, column=0, padx=10, pady=10)

# Tạo Canvas để có thể cuộn
canvas = tk.Canvas(frame, width=250, height=190, bg='white')
canvas.grid(row=0, column=0)

# Tạo thanh cuộn dọc
v_scroll = tk.Scrollbar(frame, orient="vertical", command=canvas.yview)
v_scroll.grid(row=0, column=1, sticky="ns")

# Tạo thanh cuộn ngang
h_scroll = tk.Scrollbar(frame, orient="horizontal", command=canvas.xview)
h_scroll.grid(row=1, column=0, sticky="ew")

# Cấu hình canvas để sử dụng các thanh cuộn
canvas.configure(yscrollcommand=v_scroll.set, xscrollcommand=h_scroll.set)

# Tạo Frame bên trong Canvas để chứa nội dung văn bản
text_frame = tk.Frame(canvas, bg='white')
canvas.create_window((0, 0), window=text_frame, anchor="nw")

# Nội dung mã assembly (Hello World trong EMU8086)
code_text = """
; Hello World program in EMU8086

ORG 100h         ; set origin to 100h (required for COM files)

MOV DX, OFFSET msg   ; point DX to the message
MOV AH, 09h          ; function 09h (Display string) in DOS interrupt
INT 21h              ; call DOS interrupt

MOV AH, 4Ch          ; function 4Ch (terminate program)
INT 21h              ; call DOS interrupt to exit

msg DB 'Hello, World!$' ; define message string with '$' as end marker
"""

# Tạo Label cho từng dòng trong nội dung mã assembly
lines = code_text.strip().split('\n')
for index, line in enumerate(lines):
    label = tk.Label(text_frame, text=line, bg='white', fg='black', font=('Courier', 9), anchor='w', justify='left')
    label.grid(row=index, column=0, sticky="w")

# Cập nhật vùng cuộn
text_frame.update_idletasks()
canvas.config(scrollregion=canvas.bbox("all"))

# Hiển thị cửa sổ
root.mainloop()
