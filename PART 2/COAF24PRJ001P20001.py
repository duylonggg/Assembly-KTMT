import tkinter as tk
from tkinter import messagebox

class CPU8086:
    def __init__(self):
        # Các thanh ghi 8086 với phần cao (H) và thấp (L) cho AX, BX, CX, DX, 
        # tất cả đều khởi tạo với giá trị 0
        self.registers = {
            'AX': {'H': 00, 'L': 00},
            'BX': {'H': 00, 'L': 00},
            'CX': {'H': 00, 'L': 00},
            'DX': {'H': 00, 'L': 00},
            'CS': 0000, 'IP': 0000, 'SS': 0000, 'SP': 0000,
            'BP': 0000, 'SI': 0000, 'DI': 0000, 'DS': 0000, 'ES': 0
        }

    def execute_instruction(self, instruction):
        # Phân tách mã lệnh và toán hạng
        parts = instruction.split()
        if len(parts) < 1:
            return "Lệnh không hợp lệ"
        
        cmd = parts[0].upper()
        operands = parts[1:]

        try:
            if cmd == "MOV":
                # Lệnh MOV: MOV REG, VALUE
                reg, value = operands
                reg = reg[:-1]
                if reg in self.registers:
                    if isinstance(self.registers[reg], dict):  # AX, BX, CX, DX
                        if value in self.registers and isinstance(self.registers[value], dict):
                            self.registers[reg]['H'] = self.registers[value]['H']
                            self.registers[reg]['L'] = self.registers[value]['L']
                        elif value.startswith('0x'):
                            self.registers[reg]['L'] = int(value, 16)
                        else:
                            self.registers[reg]['L'] = int(value)
                    else:
                        self.registers[reg] = int(value)
                else:
                    return "Thanh ghi không hợp lệ"

            elif cmd == "ADD":
                reg, value = operands
                reg = reg[:-1]
                if reg in self.registers:
                    if isinstance(self.registers[reg], dict):
                        if value in self.registers and isinstance(self.registers[value], dict):
                            self.registers[reg]['L'] += self.registers[value]['L']
                        else:
                            self.registers[reg]['L'] += int(value)
                    else:
                        if value in self.registers:
                            self.registers[reg] += self.registers[value]
                        else:
                            self.registers[reg] += int(value)
                else:
                    return "Thanh ghi không hợp lệ"

            elif cmd == "SUB":
                reg, value = operands
                reg = reg[:-1]
                if reg in self.registers:
                    if isinstance(self.registers[reg], dict):
                        if value in self.registers and isinstance(self.registers[value], dict):
                            self.registers[reg]['L'] -= self.registers[value]['L']
                        else:
                            self.registers[reg]['L'] -= int(value)
                    else:
                        if value in self.registers:
                            self.registers[reg] -= self.registers[value]
                        else:
                            self.registers[reg] -= int(value)
                else:
                    return "Thanh ghi không hợp lệ"

            elif cmd == "INC":
                reg = operands[0]
                if reg in self.registers:
                    if isinstance(self.registers[reg], dict):
                        self.registers[reg]['L'] += 1
                    else:
                        self.registers[reg] += 1
                else:
                    return "Thanh ghi không hợp lệ"

            elif cmd == "DEC":
                reg = operands[0]
                if reg in self.registers:
                    if isinstance(self.registers[reg], dict):
                        self.registers[reg]['L'] -= 1
                    else:
                        self.registers[reg] -= 1
                else:
                    return "Thanh ghi không hợp lệ"
            
            elif cmd == "MUL":
                reg = operands[0]
                if reg in self.registers and isinstance(self.registers[reg], dict):
                    self.registers["AX"]['L'] *= self.registers[reg]['L']
                else:
                    return "Thanh ghi không hợp lệ"
            
            elif cmd == "DIV":
                reg = operands[0]
                if reg in self.registers and isinstance(self.registers[reg], dict):
                    self.registers["DX"]['L'] = self.registers["AX"]['L'] % self.registers[reg]['L']
                    self.registers["AX"]['L'] = self.registers["AX"]['L'] // self.registers[reg]['L']
                else:
                    return "Thanh ghi không hợp lệ"

            else:
                return "Lệnh không được hỗ trợ"

            # Tăng Instruction Pointer sau mỗi lệnh
            self.registers['IP'] += 1

            return "Lệnh thực hiện thành công"

        except Exception as e:
            return f"Lỗi khi thực hiện lệnh: {str(e)}"

class CPUInterface:
    def __init__(self, root):
        self.cpu = CPU8086()

        # Thiết lập giao diện tkinter
        self.root = root
        self.root.title("Mô phỏng Bộ vi xử lý 8086")

        # Tạo giao diện và các widget
        self.create_widgets()

    def create_widgets(self):

        # Khung hiển thị các thanh ghi
        self.register_frame = tk.Frame(self.root)
        self.register_frame.grid(row=1, column=1, padx=10, pady=5)
        self.register_label = tk.Label(self.register_frame, text="Thanh ghi")
        self.register_label.grid(row=0, column=0, columnspan=3)

        # Các thanh ghi AX, BX, CX, DX với phần cao và thấp
        self.register_labels = {}
        row_index = 1
        for reg in ['AX', 'BX', 'CX', 'DX']:
            tk.Label(self.register_frame, text=reg).grid(row=row_index, column=0)
            h_label = tk.Entry(self.register_frame, width=5)
            l_label = tk.Entry(self.register_frame, width=5)
            h_label.grid(row=row_index, column=1)
            l_label.grid(row=row_index, column=2)
            self.register_labels[reg] = {'H': h_label, 'L': l_label}
            row_index += 1

        # Các thanh ghi bổ sung
        self.additional_registers = ['CS', 'IP', 'SS', 'SP', 'BP', 'SI', 'DI', 'DS', 'ES']
        for reg in self.additional_registers:
            tk.Label(self.register_frame, text=reg).grid(row=row_index, column=0)
            reg_entry = tk.Entry(self.register_frame, width=10)
            reg_entry.grid(row=row_index, column=1, columnspan=2)
            self.register_labels[reg] = reg_entry
            row_index += 1

        # Hiển thị đầu vào và đầu ra
        self.input_label = tk.Label(self.root, text="Nhập Lệnh EMU8086")
        self.input_label.grid(row=0, column=2, padx=10, pady=5)
        self.input_text = tk.Text(self.root, height=10, width=20)
        self.input_text.grid(row=1, column=2, padx=10, pady=5)

        self.output_label = tk.Label(self.root, text="Kết quả")
        self.output_label.grid(row=2, column=2, padx=10, pady=5)
        self.output_text = tk.Text(self.root, height=5, width=20)
        self.output_text.grid(row=3, column=2, padx=10, pady=5)

        # Các nút thực thi
        self.run_button = tk.Button(self.root, text="Chạy", command=self.run_instructions)
        self.run_button.grid(row=2, column=0, padx=10, pady=5)

        self.stop_button = tk.Button(self.root, text="Dừng", command=self.stop_execution)
        self.stop_button.grid(row=3, column=0, padx=10, pady=5)

    def update_register_display(self):
        # Cập nhật giá trị các thanh ghi trong giao diện
        for reg, widgets in self.register_labels.items():
            if isinstance(widgets, dict):  # AX, BX, CX, DX
                h_val = self.cpu.registers[reg]['H']
                l_val = self.cpu.registers[reg]['L']
                widgets['H'].delete(0, tk.END)
                widgets['L'].delete(0, tk.END)
                widgets['H'].insert(0, f"{h_val:02X}")  # Hiển thị giá trị theo định dạng hex
                widgets['L'].insert(0, f"{l_val:02X}")
            else:  # Các thanh ghi khác (CS, IP, SS, SP,...)
                reg_val = self.cpu.registers[reg]
                widgets.delete(0, tk.END)
                widgets.insert(0, f"{reg_val:04X}")  # Hiển thị theo định dạng hex

    def run_instructions(self):
        # Lấy và thực thi lệnh
        instruction = self.input_text.get("1.0", tk.END).strip()  # Loại bỏ ký tự xuống dòng
        result = self.cpu.execute_instruction(instruction)

        # Hiển thị kết quả
        self.output_text.delete(1.0, tk.END)  # Xóa kết quả cũ trước khi in kết quả mới
        self.output_text.insert(tk.END, result + "\n")

        # Cập nhật thanh ghi
        self.update_register_display()

    def stop_execution(self):
        # Dừng việc thực thi, có thể thêm logic tùy ý
        self.output_text.insert(tk.END, "Đã dừng việc thực thi\n")

if __name__ == "__main__":
    root = tk.Tk()
    cpu_interface = CPUInterface(root)
    root.mainloop()
