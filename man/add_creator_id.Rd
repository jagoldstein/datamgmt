% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/add_creator_id.R
\name{add_creator_id}
\alias{add_creator_id}
\title{add_creator_id}
\usage{
add_creator_id(eml, orcid = NULL, id = NULL, surname = NULL)
}
\arguments{
\item{eml}{EML script to modify}

\item{orcid}{ORCID in the format 'https://orcid.org/WWWW-XXXX-YYYY-ZZZZ'}

\item{id}{reference ID. Character string to set reference ID for creators with additional roles (i.e. metadataProvider, etc.)}

\item{surname}{creator surname (last name), defaults to first creator if not specified. Not case-sensitive.}
}
\description{
This function allows you to add an ORCID or reference ID to a creator in EML.
}
\details{
The function invisibly returns the full EML, which
can be saved to a variable. It also prints the changed creator
entry so that it's easy to check that the appropriate change was
made. All prameters other than the EML are optional, but since
the point of the function is to modify either the orcid, ref id,
or both, you need to specify at least one. Requires the
crayon package.
}
\examples{
\dontrun{
cnTest <- dataone::CNode('STAGING')
mnTest <- dataone::getMNode(cnTest,'urn:node:mnTestARCTIC')
eml_pid <- arcticdatautils::create_dummy_metadata(mnTest)
eml1 <- EML::read_eml(rawToChar(getObject(mnTest, eml_pid)))
add_creator_id(eml1, orcid = "https://orcid.org/WWWW-XXXX-YYYY-ZZZZ")
}

}
\keyword{creator}
\keyword{eml}
\keyword{id}
\keyword{orcid}
