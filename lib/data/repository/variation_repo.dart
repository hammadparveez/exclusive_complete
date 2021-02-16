class VariationRepo<T> {
  T _value;

  T get value => _value;

  T getSelectedItem(T v) {
    _value = v;
    return _value;
  }
}
