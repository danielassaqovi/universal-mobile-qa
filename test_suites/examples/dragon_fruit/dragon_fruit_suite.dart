/// Example custom suite; locators remain in configs/apps/dragon_fruit.yaml.
const supportedClasses = [
  'Black Rot',
  'Fungi',
  'Healthy Fruit',
  'Healthy Leaf',
  'Rust',
  'Scab',
  'Stem Canker',
  'Sunburn'
];
const dragonFruitScenarios = [
  'open application',
  'select image',
  'run classification',
  'verify classification result',
  'reject invalid image',
  'back and retry'
];
