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

GitDownload <- function(){
  UserList <- as.character(tkget(window1$env$lst1, 0, "end"))
  RepoList <- as.character(tkget(window1$env$lst2, 0, "end"))
  FileList <- as.character(tkget(window1$env$lst3, 0, "end"))
  URL.Pt1 <- "https://raw.githubusercontent.com"
  URL.Pt2 <- "master"
  for(x in 1:length(UserList)){
    Active.User <- UserList[x]
    
    for(y in 1:length(RepoList)){
      Active.Repo <- RepoList[y]
      
      for(z in 1:length(FileList)){
        Active.File <- FileList[z]
        URL.Merge <- paste(URL.Pt1,Active.User,sep = "/")
        URL.Merge <- paste(URL.Merge,Active.Repo, sep = "/")
        URL.Merge <- paste(URL.Merge,URL.Pt2, sep = "/")
        URL.Merge <- paste(URL.Merge, Active.File, sep = "/")
        
        Dest.File <- paste(Active.User, Active.Repo, sep = "-")
        Dest.File <- paste(Dest.File, Active.File, sep = "-")
        
        download.file(url = URL.Merge, destfile = Dest.File)
      }
    }
  }
}

### Git User Add Function ###
GitAddUser <- function(){
  GitUsername <- as.character(tclvalue(GitInputName))
  GitList <<- c(GitUserList,GitUsername)
  tkinsert(window1$env$lst1, "end", as.character(GitUsername))
}

### Git User Remove Function ###
GitRemoveUser <- function(){
  GitRemoveSelected <- as.integer(tkcurselection(window1$env$lst1))
  GitList <<- GitList[GitUserList != GitRemoveSelected]
  for(i in rev(GitRemoveSelected)){
    tkdelete(window1$env$lst1, i)
  }
}

### Git Repo Add Function ###
GitAddRepo <- function(){
  GitRepo <- as.character(tclvalue(GitRepoName))
  GitRepoList <<- c(GitRepoList,GitRepo)
  tkinsert(window1$env$lst2, "end", as.character(GitRepo))
}

### Git Repo Remove Function ###
GitRemoveRepo <- function(){
  GitRemoveRepoSelected <- as.integer(tkcurselection(window1$env$lst2))
  GitList <<- GitRepoList[GitRepoList != GitRemoveRepoSelected]
  for(i in rev(GitRemoveRepoSelected)){
    tkdelete(window1$env$lst2, i)
  }
}

### Git File Add Function ###
GitAddFile <- function(){
  GitFile <- as.character(tclvalue(GitFileName))
  GitFileList <<- c(GitFileList,GitFile)
  tkinsert(window1$env$lst3, "end", as.character(GitFile))
}

### Git File Remove Function ###
GitRemoveFile <- function(){
  GitRemoveFileSelected <- as.integer(tkcurselection(window1$env$lst3))
  GitList <<- GitFileList[GitFileList != GitRemoveFileSelected]
  for(i in rev(GitRemoveFileSelected)){
    tkdelete(window1$env$lst3, i)
  }
}

### Main Window Setup ###
window1 <- tktoplevel()
tktitle(window1) <- "Git Hub Assignment Collecter"

### Username List ###

window1$env$lst1 <- tk2listbox(window1, height = 4, selectmode = "extended", values = c())
tkgrid(tk2label(window1, text = "List of Github Accounts", justify = "center"), padx = 5, pady = 5, column = 2, row = 1)
tkgrid(window1$env$lst1, padx = 5, pady = 5, column = 2, row = 2)
GitUserList <- c()
tkselection.set(window1$env$lst1, 1)

GitInputName <- tclVar("username")

window1$env$gtent <- tk2entry(window1, width = "30", textvariable = GitInputName)
tkgrid(window1$env$gtent, padx = 5, pady = 5, column = 2, row = 3)

window1$env$gitaddbut <- tk2button(window1, text = "Add User", command = GitAddUser)
tkgrid(window1$env$gitaddbut, padx = 5, pady = 5, column = 1, row = 4)

window1$env$gitremovebut <- tk2button(window1, text = "Remove User", command = GitRemoveUser)
tkgrid(window1$env$gitremovebut, padx = 5, pady = 5, column = 3, row = 4)

### Repository List ###

window1$env$lst2 <- tk2listbox(window1, height = 4, selectmode = "extended", values = c())
tkgrid(tk2label(window1, text = "List of Github Repositories", justify = "center"), padx = 5, pady = 5, column = 2, row = 5)
tkgrid(window1$env$lst2, padx = 5, pady = 5, column = 2, row = 6)
GitRepoList <- c()
tkselection.set(window1$env$lst2, 1)

GitRepoName<- tclVar("Repository name")

window1$env$grent <- tk2entry(window1, width = "30", textvariable = GitRepoName)
tkgrid(window1$env$grent, padx = 5, pady = 5, column = 2, row = 7)

window1$env$repoaddbut <- tk2button(window1, text = "Add Repository", command = GitAddRepo)
tkgrid(window1$env$repoaddbut, padx = 5, pady = 5, column = 1, row = 8)

window1$env$reporemovebut <- tk2button(window1, text = "Remove Repository", command = GitRemoveRepo)
tkgrid(window1$env$reporemovebut, padx = 5, pady = 5, column = 3, row = 8)

### Filename list ###

window1$env$lst3 <- tk2listbox(window1, height = 4, selectmode = "extended", values = c())
tkgrid(tk2label(window1, text = "List of Files to Download", justify = "center"), padx = 5, pady = 5, column = 2, row = 9)
tkgrid(window1$env$lst3, padx = 5, pady = 5, column = 2, row = 10)
GitFileList <- c()
tkselection.set(window1$env$lst3, 1)

GitFileName<- tclVar("Filename")

window1$env$gfent <- tk2entry(window1, width = "30", textvariable = GitFileName)
tkgrid(window1$env$gfent, padx = 5, pady = 5, column = 2, row = 11)

window1$env$fileaddbut <- tk2button(window1, text = "Add Filename", command = GitAddFile)
tkgrid(window1$env$fileaddbut, padx = 5, pady = 5, column = 1, row = 12)

window1$env$fileremovebut <- tk2button(window1, text = "Remove Filename", command = GitRemoveFile)
tkgrid(window1$env$fileremovebut, padx = 5, pady = 5, column = 3, row = 12)

## Download Button ###
window1$env$downloadbut <- tk2button(window1, text = "Download Files", command = GitDownload)
tkgrid(window1$env$downloadbut, padx = 5, pady = 5, column = 2, row = 13)