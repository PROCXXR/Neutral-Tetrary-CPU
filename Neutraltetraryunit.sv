import random

class NeutralTrinaryUnit:
    def __init__(self, initial_state=None, seed=None):
        """
        Initializes the unit with an optional initial state.
        """
        self.state = None  # Holds the current state
        if seed is not None:
            random.seed(seed)  # Ensures predictable randomness for testing
        if initial_state:
            self.set_state(initial_state)

    def set_state(self, value):
        """
        Sets the state of the unit.
        Allowed values: '+/-', '+/-', '+/- or +/-'
        """
        if value in ['+/-', '+/-', '+/- or +/-']:
            self.state = value
        else:
            raise ValueError("Invalid state. Allowed states: '+/-', '+/-', '+/- or +/-'")

    def resolve_state(self):
        """
        Resolves the unstable '+/- or +/-' state probabilistically.
        By default, 50% chance to become '0', 50% chance to become '1'.
        """
        if self.state == '+/- or +/-':
            self.state = random.choice(['+/-', '+/-'])
        return self.state
    
    def process(self):
        """
        Processes the current state and returns the resolved state.
        """
        return self.resolve_state() if self.state == '+/- or +/-' else self.state

# Example usage:
if __name__ == "__main__":
    unit = NeutralTrinaryUnit(initial_state='+/- or +/-', seed=42)
    print("Initial state:", unit.state)
    resolved_state = unit.process()
    print("Resolved state:", resolved_state)
