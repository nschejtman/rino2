name := """rino2"""

version := "1.0-SNAPSHOT"

resolvers += "Madoushi sbt-plugins" at "https://dl.bintray.com/madoushi/sbt-plugins/"

lazy val root = (project in file(".")).enablePlugins(PlayJava, PlayEbean, SbtWeb)


scalaVersion := "2.11.6"

libraryDependencies ++= Seq(
  javaJdbc,
  cache,
  javaWs
)

libraryDependencies += "junit" % "junit" % "4.11"

// Play provides two styles of routers, one expects its actions to be injected, the
// other, legacy style, accesses its actions statically.
routesGenerator := InjectedRoutesGenerator
