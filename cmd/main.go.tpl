package main

import (
	"flag"
	"log"

	"github.com/spf13/pflag"
	"github.com/spf13/viper"
)

func main() {

	// using standard library "flag" package
	flag.String("flagname", "default value", "help message for flagname")

	pflag.CommandLine.AddGoFlagSet(flag.CommandLine)
	pflag.Parse()
	viper.BindPFlags(pflag.CommandLine)

	val := viper.GetString("flagname") // retrieve value from viper

	log.Println("Flag value {dynamic_value}", val)
}
