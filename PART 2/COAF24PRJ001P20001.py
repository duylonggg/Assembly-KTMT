class CPU8086:
    def __init__(self):
        self.registers = {
            'AX': 0x0000,
            'BX': 0x0000,
            'CX': 0x0000,
            'DX': 0x0000,
            'SP': 0xFFFF,  # Stack Pointer
            'BP': 0x0000,  # Base Pointer
            'SI': 0x0000,  # Source Index
            'DI': 0x0000,  # Destination Index
            'IP': 0x0000   # Instruction Pointer
        }
        self.memory = [0x00] * 65536
        self.flags = {
            'ZF': 0,  # Zero Flag
            'CF': 0,  # Carry Flag
            'OF': 0   # Overflow Flag
        }

    def execute_instruction(self, instruction):

        parts = instruction.split()
        opcode = parts[0]
        operands = parts[1:]

        if opcode == "MOV":
            dest, src = operands
            self.mov(dest, src)
        elif opcode == "ADD":
            dest, src = operands
            self.add(dest, src)
        else:
            print(f"Lệnh không hỗ trợ: {opcode}")

    def mov(self, dest, src):
        if src in self.registers:
            self.registers[dest] = self.registers[src]
        elif src.startswith('0x'):  # Giá trị số
            self.registers[dest] = int(src, 16)
        print(f"MOV {dest}, {src} -> {self.registers[dest]}")

    def add(self, dest, src):
        if src in self.registers:
            self.registers[dest] += self.registers[src]
        elif src.startswith('0x'):
            self.registers[dest] += int(src, 16)
        print(f"ADD {dest}, {src} -> {self.registers[dest]}")

cpu = CPU8086()
cpu.execute_instruction("MOV AX, 0x1234")
cpu.execute_instruction("ADD AX, 0x0010")
from PyQt6.QtWidgets import QApplication, QMainWindow, QTableWidget, QTableWidgetItem, QVBoxLayout, QWidget, QPushButton, QLineEdit, QLabel

class MainWindow(QMainWindow):
    def __init__(self, cpu):
        super().__init__()
        self.cpu = cpu
        self.setWindowTitle("Mô phỏng 8086")
        self.setGeometry(100, 100, 800, 600)

        layout = QVBoxLayout()

        self.table = QTableWidget(9, 2)
        self.table.setHorizontalHeaderLabels(["Thanh ghi", "Giá trị"])
        self.update_table()

        self.command_input = QLineEdit()
        self.command_input.setPlaceholderText("Nhập lệnh ")

        self.execute_button = QPushButton("Thực thi")
        self.execute_button.clicked.connect(self.execute_command)

        layout.addWidget(self.table)
        layout.addWidget(self.command_input)
        layout.addWidget(self.execute_button)

        container = QWidget()
        container.setLayout(layout)
        self.setCentralWidget(container)

    def update_table(self):
        for i, (reg, value) in enumerate(self.cpu.registers.items()):
            self.table.setItem(i, 0, QTableWidgetItem(reg))
            self.table.setItem(i, 1, QTableWidgetItem(hex(value)))

    def execute_command(self):
        command = self.command_input.text()
        self.cpu.execute_instruction(command)
        self.update_table()

app = QApplication([])
cpu = CPU8086()
window = MainWindow(cpu)
window.show()
app.exec()
