import tkinter as tk
from COAF24PRJ001P2000102 import show_cmd_window, close_cmd_window  

# Tạo cửa sổ chính
root = tk.Tk()
root.title("origin source code")

# Tạo một Frame để chứa mã và thanh cuộn
frame = tk.Frame(root)
frame.grid(row=0, column=0, padx=10, pady=10)

# Tạo Canvas để có thể cuộn
canvas = tk.Canvas(frame, width=400, height=250, bg='white')
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

# Tạo Label cho từng dòng trong nội dung mã assembly, bỏ qua các dòng trống
lines = [line for line in code_text.strip().split('\n') if line.strip() != '']  # Lọc bỏ dòng trống
labels = []
for index, line in enumerate(lines):
    label = tk.Label(text_frame, text=line, bg='white', fg='black', font=('Courier', 9), anchor='w', justify='left')
    label.grid(row=index, column=0, sticky="w")
    labels.append(label)

# Cập nhật vùng cuộn
text_frame.update_idletasks()
canvas.config(scrollregion=canvas.bbox("all"))

# Biến lưu trạng thái bước thực hiện
current_step = 2  # Bắt đầu từ dòng `MOV DX, OFFSET msg` (dòng thứ 3)
cmd_shown = False  # Cờ kiểm tra xem cửa sổ CMD đã mở chưa
cmd_root = None  # Biến lưu đối tượng cmd

# Hàm để bôi vàng từng dòng một từ dòng `MOV DX, OFFSET msg`
def next_step():
    global current_step, cmd_shown, cmd_root
    if current_step > 0 and current_step < len(labels):
        # Đặt lại màu của dòng trước đó
        if current_step > 2:
            labels[current_step - 1].config(bg='white')
        # Bôi vàng dòng hiện tại
        labels[current_step].config(bg="yellow")
        
        # Nếu chạy đến dòng thứ 4 (current_step = 4), gọi hàm vẽ cửa sổ CMD (chỉ gọi một lần)
        if current_step == 4 and not cmd_shown:
            cmd_shown = True  # Đánh dấu rằng cửa sổ CMD đã được mở
            cmd_root = show_cmd_window()  # Lưu đối tượng cửa sổ CMD

        # Đóng cửa sổ CMD sau khi kết thúc chương trình
        if current_step == len(labels) - 1:
            cmd_shown = False
            if cmd_root:
                close_cmd_window(cmd_root)  # Đóng cửa sổ CMD
        
        current_step += 1
    elif current_step == len(labels):  # Khi đã đến dòng cuối
        labels[current_step - 1].config(bg="white")  # Xóa bôi vàng dòng cuối
        current_step = 2  # Reset về dòng `MOV DX, OFFSET msg`

# Nút để thực hiện bước tiếp theo
step_button = tk.Button(root, text="Next Step", command=next_step, font=("Arial", 12))
step_button.grid(row=1, column=0, pady=10)

# Hiển thị cửa sổ
root.mainloop()
