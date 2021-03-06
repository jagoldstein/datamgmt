#' add_creator_id
#'
#' This function allows you to add an ORCID or reference ID to a creator in EML.
#' @param eml EML script to modify
#' @param orcid ORCID in the format 'https://orcid.org/WWWW-XXXX-YYYY-ZZZZ'
#' @param id reference ID. Character string to set reference ID for creators with additional roles (i.e. metadataProvider, etc.)
#' @param surname creator surname (last name), defaults to first creator if not specified. Not case-sensitive.
#'
#' @keywords eml creator orcid id
#'
#' @details
#' The function invisibly returns the full EML, which
#' can be saved to a variable. It also prints the changed creator
#' entry so that it's easy to check that the appropriate change was
#' made. All prameters other than the EML are optional, but since
#' the point of the function is to modify either the orcid, ref id,
#' or both, you need to specify at least one. Requires the
#' crayon package.
#'
#' @export
#'
#' @examples
#' \dontrun{
#' cnTest <- dataone::CNode('STAGING')
#' mnTest <- dataone::getMNode(cnTest,'urn:node:mnTestARCTIC')
#' eml_pid <- arcticdatautils::create_dummy_metadata(mnTest)
#' eml1 <- EML::read_eml(rawToChar(getObject(mnTest, eml_pid)))
#' add_creator_id(eml1, orcid = "https://orcid.org/WWWW-XXXX-YYYY-ZZZZ")
#' }
#'
add_creator_id <- function(eml,
                           orcid = NULL,
                           id = NULL,
                           surname = NULL) { #not sensitive to capitalization

    if (!requireNamespace("crayon")) {
   stop(call. = FALSE,
       "The crayon package is required. Please install it and try again.")
 }

    #variable checks:
    for (args in c(orcid, id, surname)) {
        if (!(is.null(args) | is.character(args))) {
            stop(paste(args, "must be a character string."))
        }
    }
    if (is.null(orcid) & is.null(id)) {
        stop("Need either an orcid or id.")
    }

    #grab creators and save to new variable
    creatorList <- eml@dataset@creator

    #determine surname position to access correct creator
    #if none are specified, the first creator will be modified
    if (is.null(surname)) {
        cat(crayon::green("Since surname was not specified, the first creator entry will be modified. "))
        pos <- 1
    } else {
        #make vector of creator surnames
        surNames <- rep(NA, times = length(creatorList))
        for (i in 1:length(creatorList)) {
            creator1 <- creatorList[[i]]
            surName1 <- creator1@individualName[[1]]@surName@.Data
            surNames[i] <- surName1
        }

        #if specified surname exists, then edit entry (caps-proof)
        surname_u <- toupper(surname)
        surNames_u <- toupper(surNames)
        if (surname_u %in% surNames_u) {
            pos <- which(surNames_u == surname_u)
        } else {
            stop(crayon::red("Surname not found. Check your spelling."))
        }
    }

    #add orcid if specified
    if (!is.null(orcid)) {
        creatorList[[pos]]@userId <- c(methods::new('userId',
                                           .Data = orcid,
                                           directory = "https://orcid.org"))
    }

    #add reference id if specified
    if (!is.null(id)) {
        creatorList[[pos]]@id[[1]] <- as.character(id)
    }

    #add updated creatorList back into eml
    eml@dataset@creator@.Data <- creatorList

    cat(crayon::green("The following entry has been changed:"))
    print(creatorList[[pos]]) #prints changed entry
    invisible(eml) #returns full eml
}
