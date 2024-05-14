class Stack<T> {
  List<T> _items = [];

  void push(T element) {
    _items.add(element);
  }

  T pop() {
    if (_items.isEmpty) {
      throw StateError('Cannot pop from an empty stack');
    }
    return _items.removeLast();
  }

  bool get isEmpty => _items.isEmpty;
}

void main() {
  Stack<int> stack = Stack();

  stack.push(1);
  stack.push(2);
  stack.push(3);

  print('Popping elements:');
  while (!stack.isEmpty) {
    print(stack.pop());
  }
}
