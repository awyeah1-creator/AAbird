// wagtail_prompts.dart

String wagtailFactPrompt(String topic) {
  // You can use topic to add more customization, or ignore if not used
  return "Give me a short, humorous true fact about the Willie Wagtail bird, with a reference or twist connected to Perth, Western Australia. Do not include reference numbers, citations, or footnotes—just the fact as friendly text.";
}

String rsmFactPrompt(String topic) {
  // Likewise, topic is present but not used—this keeps the signature compatible
  return "Give me a short, humorous true fact about RSM Australia, with a reference or twist connected to Perth, Western Australia. Do not include reference numbers, citations, or footnotes—just the fact as friendly text.";
}

String perthWeatherPrompt(String topic) {
  // You might want to improve this to reference weather if topic is set
  return "Give me a short, humorous true fact about the weather in Perth, Western Australia. Make sure to include a funny twist or local Perth reference, and keep it friendly (no references, citations, or footnotes).";
}

// This is your main dynamic prompt function
String openFactPrompt(String extraContext) {
  return "Give me a short, humorous true fact, with a reference or twist connected to Perth, Western Australia. Do not include reference numbers, citations, or footnotes—just the fact as friendly text about $extraContext.";
}

// String wagtailFactPrompt() {
//   return "Give me a humorous, true fact about the Willie Wagtail bird, with a reference or twist connected to Perth, Western Australia.";
// }
// String wagtailFactPrompt() {
//   return "Give me a short, humorous (2-3 sentences max) true fact about the Willie Wagtail bird, with a reference or twist connected to Perth, Western Australia.";
// }
// String wagtailFactPrompt() {
//   return "Give me a short, humorous true fact about the Willie Wagtail bird, with a reference or twist connected to Perth, Western Australia. Do not include reference numbers, citations, or footnotes—just the fact as friendly text.";
// }
// String rsmFactPrompt() {
//   return "Give me a short, humorous true fact about RSM Australia, with a reference or twist connected to Perth, Western Australia. Do not include reference numbers, citations, or footnotes—just the fact as friendly text.";
// }
// String perthWeatherPrompt() {
//   return "Give me a short, humorous true fact about RSM Australia, with a reference or twist connected to Perth, Western Australia. Do not include reference numbers, citations, or footnotes—just the fact as friendly text.";
// }
// String openFactPrompt(String extraContext) {
//   return "Give me a short, humorous true fact , with a reference or twist connected to Perth, Western Australia. Do not include reference numbers, citations, or footnotes—just the fact as friendly text about " + extraContext;
// }