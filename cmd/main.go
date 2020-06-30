package main

import (
	"flag"
	"log"

	"github.com/spf13/pflag"
	"github.com/spf13/viper"
)

func main() {

	// using standard library "flag" package
	flag.Int("flagname", 1234, "help message for flagname")

	pflag.CommandLine.AddGoFlagSet(flag.CommandLine)
	pflag.Parse()
	viper.BindPFlags(pflag.CommandLine)

	i := viper.GetInt("flagname") // retrieve value from viper

	log.Println("Flag value 2", i)
}
