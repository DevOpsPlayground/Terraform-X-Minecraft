# Terraform-X-Minecraft
## Intro

Welcome to your introduction to Infrastucture as Code with Terraform. Today we are going to shlw the basic principals of IaC as well as Terraform functionality by managing the infrastructure in the Minecraft world. 

## Initial setup

As long as you are registered for the event you can request your environment at [lab.devopsplayground.org](https://lab.devopsplayground.org/)
We created a virtual machine for you with terminal and IDE as well as running minecraft server. We installed the mode so you can render the world in the browser. There are different views availible, but for this workshops we are going to use flat and 3d view as shown on the screenshot below:

<center>

![map](./lab_1/images/mc-map.png)

</center>

This setup while does not require you to install anything comes with some limitations. The rendering needs to be triggered from the minecraft server. For your convinience we added the following commands you can use on the instance:

```bash
render-flat # renders the flat map
render-3d # renders the 3d map
render-stop # stops rendering *note - full 3d render takes ~30mins so we advise you to build any 3d structure near to the spawn point (152,64,152), rendering is executed in radius of the spwan so you should see the results in a few minutes if you build there
mc-logs # logs of minecraft server - you can see the status and progress of your rendering as well as any calls terraform makes to the srever
```
#### <b>Note:</b> If you have your own Minrcraft licence and Minecraft client installed - feel free to login to the server and see the changes to you world in the real time without the need to render.

## Agenda
The session should take ~60 minutes and attendees does not need to have any previous experience. If you are already a terraform guru - at the end of the session we encourage everyone to build something cool - that will be your time to shine!

### <b>Here is what we are going to cover:</b>

### [Lab_1 - Let's start with the dot](./lab_1/README.md): 

    - Terraform setup - configuring and inititalising the provider
    - Creating and deploying your first terraform resource and talking about terraform state
    - Using vaiables
    - Creating and managing multiple resources
    - Buiilding your first minecaft structure
    
### [Lab_2 - I am going to build a wall](./lab_2/README.md):

    - Introducing basic functions
    - Using functions to define the structures
    - Introducing terraform modules
    - Using Terraform modules and Terraform functions to build more complex strucures 

### [Lab_3 -  Time to get creative!](./lab_3/README.md):

    - Minecraft alphabet 
    - Panda module
    - Show us what you have got!