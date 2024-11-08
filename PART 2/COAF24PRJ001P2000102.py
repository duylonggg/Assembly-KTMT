# COAF24PRJ001P2000102.py

import tkinter as tk

# Hàm để hiển thị cửa sổ CMD giả lập
def show_cmd_window():
    # Tạo cửa sổ CMD giả lập
    cmd_root = tk.Tk()
    cmd_root.title("emulator screen (80x25 chars)")

    # Tạo một khung Text widget để mô phỏng cửa sổ CMD
    text_widget = tk.Text(cmd_root, height=10, width=50, bg='black', fg='white', font=('Courier', 12))
    text_widget.pack(padx=10, pady=10)

    # Đặt chế độ chỉ đọc để người dùng không thể chỉnh sửa
    text_widget.config(state=tk.DISABLED)

    # Hiển thị dòng "Hello, World!" trong cửa sổ CMD mô phỏng
    text_widget.config(state=tk.NORMAL)  # Cho phép thay đổi nội dung
    text_widget.insert(tk.END, "Hello, World!\n")  # Thêm văn bản vào cuối
    text_widget.config(state=tk.DISABLED)  # Chế độ chỉ đọc lại

    # Trả về đối tượng cửa sổ cmd_root
    return cmd_root

# Hàm để đóng cửa sổ CMD
def close_cmd_window(cmd_root):
    # Đóng cửa sổ CMD
    cmd_root.destroy()
