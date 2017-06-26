library(testthat)

options(encoding="UTF-8")

if(
  compare(
    XMSG("Unable to rename \"@1\" to \"@2\"", "foo", "bar"),
    "⇚⇚⇚⇚Unable to rename \"foo\" to \"bar\"⇚⇚⇚⇚"
  )$equal
  + 
  compare(
    XMSG("Unable to rename \"@11\" to \"@2\"", "foo", "bar"),
    "Unable to rename \"@11\" to \"bar"
  )$equal
  +
  compare(
    XMSG("Unable to rename \"@1\" to \"@11\"", "foo", "bar"),
    "Unable to rename \"foo to \"@11\""
  )$equal
  +
  compare(
    XMSG("Unable to rename \"@1\" to \"@1\"", "foo", "bar"),
    "Unable to rename \"foo to \"foo"
  )$equal
  < 4
) {
  print("The test script ap_xmsg_test.r failed!")
} else {
  print("The test script ap_xmsg_test.r succeeded.")
}
