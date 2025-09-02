# Query Samples for WDRep
The following are examples of how to populate drop-down values in the WDRep application.

## Prefixes
Prefixes are used before a person's name.  Examples include:

* Dr.
* Hon.
* Mrs.
* Sen.

To retrieve the proper values from the database, the following query will be used:

```sql

select id, 
       description
from   prefixsuffix
where  recordstatusid = 1
and    category = 'Prefix';

```

## Suffixes
Suffixes are used after a person's name.  Examples include:

* Esq.
* MD
* Jr.
* VII

To retrieve the proper values from the database, the following query will be used:

```sql

select id, 
       description
from   prefixsuffix
where  recordstatusid = 1
and    category = 'Suffix';

```

## Countries
To retrieve the proper values from the database, the following query will be used:

```sql

select id, 
       geographyname
from   geography
where  recordstatusid = 1
and    geographytypeid = 
       (
		select geographytypeid
	       from   geographytypes
	       where  description = 'Country'
       )
order  by geographyname;
```

## States
To retrieve the proper values from the database, the following query will be used:

```sql

select id, 
       geographyname
from   geography
where  recordstatusid = 1
and    parentid = :countryId
and    geographytypeid = 
       (
		select geographytypeid
	       from   geographytypes
	       where  description = 'State'
       )
order  by geographyname;
```

This query will only be used for the United States and Canada.

## Sex
To retrieve the proper values from the database, the following query will be used:

```sql

select description
from   sexes
where  recordstatusid = 1
order  by description;
```

## Email Address for Contact Information Tab
To retrieve the proper values from the database, the following query will be used:

```sql
select e.*
from   emails e,
       coreidentityemails ce
where  ce.recordstatusid = 1
and    ce.coreidentityid = :coreIdentityId
and    ce.contactsequence = 1
and    e.emailid = ce.emailid;

```

## Postal Address for Contact Information Tab
To retrieve the proper values from the database, the following query will be used:

```sql
select a.*
from   postaladdresses a,
       coreidentitypostaladdresses cp
where  cp.recordstatusid = 1
and    cp.coreidentityid = :coreIdentityId
and    cp.contactsequence = 1
and    a.postaladdressid = cp.postaladdressid;


```

## Phone Number for Contact Information Tab
To retrieve the proper values from the database, the following query will be used:

```sql
select p.*
from   phones p,
       coreidentityphones cp
where  cp.recordstatusid = 1
and    cp.coreidentityid = :coreIdentityId
and    cp.contactsequence = 1
and    p.phoneid = cp.phoneid;


```