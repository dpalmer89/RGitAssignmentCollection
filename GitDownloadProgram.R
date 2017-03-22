### Install Missing Packages & Load Required Packages ###
list.of.packages <- c("tidyverse", "tcltk", "tcltk2")
for(i in 1:length(list.of.packages)){
  Packagepresent <- require(list.of.packages[i], character.only = TRUE)
  if(Packagepresent == FALSE){
    install.packages(list.of.packages[i], dependencies = TRUE)
    require(list.of.packages[i],character.only = TRUE)
  }
}

### Git Download Function ###


### Git User Add Function ###
GitAddUser <- function(){
  GitUsername <- as.character(tclvalue(GitInputName))
  GitList <<- c(GitUserList,GitUsername)
  tkinsert(window1$env$lst1, "end", as.character(GitUsername))
}

### Git User Remove Function ###
GitRemoveUser <- function(){
  GitRemoveSelected <- GitUserList[as.numeric(tkcurselection(window1$env$lst1)) + 1]
  GitList <<- GitList[GitUserList != GitRemoveSelected]
  tk2list.delete(window1$env$lst1, 0, tkcurselection(window1$env$lst1))
}

### Main Window Setup ###
window1 <- tktoplevel()
tktitle(window1) <- "Git Hub Assignment Collecter"

window1$env$lst1 <- tk2listbox(window1, height = 6, selectmode = "single")
tkgrid(tk2label(window1, text = "List of Github Accounts", justify = "center"), padx = 5, pady = 5)
tkgrid(window1$env$lst1, padx = 10, pady = 10)
GitUserList <- c()
tkselection.set(window1$env$lst1, 1)

GitInputName <- tclVar("username")

window1$env$gtent <- tk2entry(window1, width = "30", textvariable = GitInputName)
tkgrid(window1$env$gtent, padx = 10, pady = 10)

window1$env$gitaddbut <- tk2button(window1, text = "Add User", command = GitAddUser)
tkgrid(window1$env$gitaddbut, padx = 5, pady = 5)

window1$env$gitremovebut <- tk2button(window1, text = "Remove User", command = GitRemoveUser)
tkgrid(window1$env$gitremovebut, padx = 5, pady = 5)