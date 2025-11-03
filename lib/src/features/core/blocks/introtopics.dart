class IntroTopics {
  static const Map<String, Map<String, String>> lessons = {
    'AND': {
      'title': 'AND GATES',
      'content': '''

The AND gate is a basic digital logic gate that implements the logical conjunction operation. This is characterized by its rule that its output is HIGH, 1, only when all its inputs are HIGH at the same time. Every AND gate implements the Boolean expression Q = A.  B and is an essential gate in circuits that require multiple, specific conditions to be met before activating a function.''',
    },
    'NAND': {
      'title': 'NAND GATES',
      'content': '''

The NAND gate forms one of the fundamental building blocks of digital electronics and symbolic logic. Its naming is a contraction of "NOT AND," which succinctly describes its logical function: a NAND gate performs a logical AND operation and then immediately inverts (negates) the result. Otherwise stated, a NAND gate outputs LOW (0) only when ALL of its inputs are HIGH (1). For any other combination of inputs-if even only one single input is LOW-the output is HIGH (1).

 ''',
    },
    'OR': {
      'title': 'OR GATES',
      'content': '''
A basic logic gate in digital electronics, the OR gate applies the logical operation of disjunction, which corresponds to the common use of the word "or." Its output is HIGH (1) if at least one of its inputs is HIGH (1). This is the Boolean expression Q = A + B (a logical addition), where the OR gate is used in any circuit where any one of several possible conditions must activate a function.
 ''',
    },
    'NOR': {
      'title': 'NOR GATES',
      'content': '''
A NOR gate is a digital logic gate that implements logical negation of disjunction; it only produces a high output if both of its inputs are low. In effect, it therefore has the same effect as an OR gate followed by a NOT gate, from which its alternative name, NOT-OR, is derived. Since any other logic gate can be created using only NOR gates, they are therefore deemed a universal gate.
''',
    },
    'NOT': {
      'title': 'NOT GATES',
      'content': '''
The NOT gate (also known as an Inverter) is the most basic digital logic gate, with one input and one output, that always outputs the logical inverse of the input. If the input is HIGH (1), the output will be LOW (0), and vice versa. This simple gate is used to perform logical negation in digital electronics and is also used to create the 1's complement of binary numbers or control the ability of other circuits.
''',
    },
    'XOR': {
      'title': 'XOR GATES',
      'content': '''
The XOR gate (Exclusive-OR) is a basic digital logic gate that produces a HIGH (1) signal only when both inputs are unequal. In the case of a two-input gate, the output is 1 when one input is equal to 1 and the other is equal to 0, while the output is 0 when both inputs are equal (both 0 or both 1). The XOR gate is very important to digital systems and used in applications such as binary addition, where it provides the sum bit, and in error detection, where it can be used as an inequality checking tool or parity check. 
''',
    },
    'XNOR': {
      'title': 'XNOR GATES',
      'content': '''
An XNOR gate (Exclusive-NOR) is a digital logic gate that functions as an equality sensor, outputting a HIGH (1) value only if all of its inputs are equal. That is, the output value is, 1 if the inputs are all 0s, and the output value is, 1 if the inputs are all 1s. The XNOR gate is the logical complement of the Exclusive-OR gate. An XNOR gate is widely used in circuits for binary data comparison, such as parity checking, and error detection.
''',
    },
    'BUFFER': {
      'title': 'BUFFER GATES',
      'content': '''
The buffer gate is an uncomplicated digital logic gate with one input and one output, and the logic state of its output will always equal its input. While it does not actually perform any operation or change the logic level of the signal, its purpose is to increase the current of a weak signal through an output. With this increased current, one output can drive more inputs on additional gates (solving the "fan-out" issue), or drive larger current loads like an LED or relay.
''',
    }, // Pwede kang magdagdag ng iba pang blocks dito
  };
}
