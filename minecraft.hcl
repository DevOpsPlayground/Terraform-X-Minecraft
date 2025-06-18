variable "namespace" {
  type    = string
  default = "default"
}
job "minecraft" {
  datacenters = ["dc1"]
  type        = "service"
  node_pool   = "gcp"
  namespace   = var.namespace
  group "minecraft" {
    count = 1

    network {
      port "rcon" {
        to = 25575
      }
      port "dynmap"{
        to = 8123
      }
      port "minecraft" {
        to = 25565
      }
    }

    service {
      name     = "minecraft"
      port     = "minecraft"
      provider = "nomad"
      check {
        name     = "alive"
        type     = "tcp"
        port     = "minecraft"
        interval = "10s"
        timeout  = "2s"
      }
    }

    task "server" {
      driver = "podman"
      env = {
        TYPE="MODRINTH"
        OVERRIDE_SERVER_PROPERTIES="false"
        CREATE_CONSOLE_IN_PIPE="true" 
        MODRINTH_MODPACK="https://github.com/DevOpsPlayground/Terraform-X-Minecraft/raw/refs/heads/feat/movetopack/Playground.mrpack"
        RCON_PASSWORD="PandaTime"
        EULA="TRUE" 
        MEMORY="1G"
      }
      config {
        image   = "docker.io/itzg/minecraft-server"

        ports = [
          "rcon",
          "dynmap",
          "minecraft"
        ]
      }
      resources {
        cpu    = 1000
        memory = 1024
      }
      action "spawn-bot" {
        command = "mc-send-to-console"
        args = [
          "/player bot spawn",
        ]
      }
      action "start-render" {
        command = "mc-send-to-console"
        args = [
          "/dynmap fullrender world:flat",
        ]
      }
      action "stop-render" {
        command = "mc-send-to-console"
        args = [
          "/dynmap cancelrender world",
        ]
      }
      action "presenter-op" {
        command = "mc-send-to-console"
        args = [
          "/op byteford",
        ]
      }
      action "pause-time" {
        command = "/bin/sh"
        args = ["-c",
          <<EOT
            mc-send-to-console /gamerule doWeatherCycle false
            mc-send-to-console /gamerule doDaylightCycle false
            mc-send-to-console /time set 12
          EOT
        ]
      }
    }
  }
}