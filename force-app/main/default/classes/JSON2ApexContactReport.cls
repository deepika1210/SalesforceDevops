public class JSON2ApexContactReport {
    
    public ReportMetadata reportMetadata {get;set;} 
	public ReportExtendedMetadata reportExtendedMetadata {get;set;} 
	public Boolean hasDetailRows {get;set;} 
	public GroupingsDown groupingsDown {get;set;} 
	public GroupingsDown groupingsAcross {get;set;} 
	public FactMap factMap {get;set;} 
	public Boolean allData {get;set;} 

	public JSON2ApexContactReport(JSONParser parser) {
		while (parser.nextToken() != System.JSONToken.END_OBJECT) {
			if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
				String text = parser.getText();
				if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
					if (text == 'reportMetadata') {
						reportMetadata = new ReportMetadata(parser);
					} else if (text == 'reportExtendedMetadata') {
						reportExtendedMetadata = new ReportExtendedMetadata(parser);
					} else if (text == 'hasDetailRows') {
						hasDetailRows = parser.getBooleanValue();
					} else if (text == 'groupingsDown') {
						groupingsDown = new GroupingsDown(parser);
					} else if (text == 'groupingsAcross') {
						groupingsAcross = new GroupingsDown(parser);
					} else if (text == 'factMap') {
						factMap = new FactMap(parser);
					} else if (text == 'allData') {
						allData = parser.getBooleanValue();
					} else {
						System.debug(LoggingLevel.WARN, 'JSON2Apex consuming unrecognized property: '+text);
						consumeObject(parser);
					}
				}
			}
		}
	}
	
	public class StandardDateFilter {
		public Object startDate {get;set;} 
		public Object endDate {get;set;} 
		public String durationValue {get;set;} 
		public String column {get;set;} 

		public StandardDateFilter(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'startDate') {
							startDate = parser.readValueAs(Object.class);
						} else if (text == 'endDate') {
							endDate = parser.readValueAs(Object.class);
						} else if (text == 'durationValue') {
							durationValue = parser.getText();
						} else if (text == 'column') {
							column = parser.getText();
						} else {
							System.debug(LoggingLevel.WARN, 'StandardDateFilter consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}
	
	public class TTclass {
		public String key {get;set;} 
		public List<Aggregates> aggregates {get;set;} 
		public List<Rows> rows {get;set;} 

		public TTclass(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'key') {
							key = parser.getText();
						} else if (text == 'aggregates') {
							aggregates = arrayOfAggregates(parser);
						} else if (text == 'rows') {
							rows = arrayOfRows(parser);
						} else {
							System.debug(LoggingLevel.WARN, 'T!T consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}
	
	public class Contact_MobilePhone {
		public String name {get;set;} 
		public String label {get;set;} 
		public String dataType {get;set;} 

		public Contact_MobilePhone(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'name') {
							name = parser.getText();
						} else if (text == 'label') {
							label = parser.getText();
						} else if (text == 'dataType') {
							dataType = parser.getText();
						} else {
							System.debug(LoggingLevel.WARN, 'Contact_MobilePhone consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}
	
	public class GroupingsDown {
		public Object groupings {get;set;} 

		public GroupingsDown(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'groupings') {
							groupings = parser.readValueAs(Object.class);
						} else {
							System.debug(LoggingLevel.WARN, 'GroupingsDown consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}
	
	public class DetailColumnInfo {
		public Contact_MobilePhone Contact_MobilePhone {get;set;} // in json: Contact.MobilePhone
		public Contact_MobilePhone Contact_Id {get;set;} // in json: Contact.Id
		public Contact_MobilePhone Contact_Email {get;set;} // in json: Contact.Email
		public Contact_MobilePhone Contact_Account_Name {get;set;} // in json: Contact.Account.Name
		public Contact_MobilePhone Contact_Name {get;set;} // in json: Contact.Name
		public Contact_MobilePhone Contact_LastName {get;set;} // in json: Contact.LastName
		public Contact_MobilePhone Contact_FirstName {get;set;} // in json: Contact.FirstName

		public DetailColumnInfo(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'Contact.MobilePhone') {
							Contact_MobilePhone = new Contact_MobilePhone(parser);
						} else if (text == 'Contact.Id') {
							Contact_Id = new Contact_MobilePhone(parser);
						} else if (text == 'Contact.Email') {
							Contact_Email = new Contact_MobilePhone(parser);
						} else if (text == 'Contact.Account.Name') {
							Contact_Account_Name = new Contact_MobilePhone(parser);
						} else if (text == 'Contact.Name') {
							Contact_Name = new Contact_MobilePhone(parser);
						} else if (text == 'Contact.LastName') {
							Contact_LastName = new Contact_MobilePhone(parser);
						} else if (text == 'Contact.FirstName') {
							Contact_FirstName = new Contact_MobilePhone(parser);
						} else {
							System.debug(LoggingLevel.WARN, 'DetailColumnInfo consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}
	
	public class ReportExtendedMetadata {
		public Object groupingColumnInfo {get;set;} 
		public DetailColumnInfo detailColumnInfo {get;set;} 
		public AggregateColumnInfo aggregateColumnInfo {get;set;} 

		public ReportExtendedMetadata(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'groupingColumnInfo') {
							groupingColumnInfo = parser.readValueAs(Object.class);
						} else if (text == 'detailColumnInfo') {
							detailColumnInfo = new DetailColumnInfo(parser);
						} else if (text == 'aggregateColumnInfo') {
							aggregateColumnInfo = new AggregateColumnInfo(parser);
						} else {
							System.debug(LoggingLevel.WARN, 'ReportExtendedMetadata consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}
	
	public class FactMap {
		public TTclass TTclass {get;set;} 

		public FactMap(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'T!T') {
							TTclass= new TTclass(parser);
						} else {
							System.debug(LoggingLevel.WARN, 'FactMap consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}
	
	public class Aggregates {
		public Integer value {get;set;} 
		public String label {get;set;} 

		public Aggregates(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'value') {
							value = parser.getIntegerValue();
						} else if (text == 'label') {
							label = parser.getText();
						} else {
							System.debug(LoggingLevel.WARN, 'Aggregates consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}
	
	public class ReportFilters {
		public String value {get;set;} 
		public String operator {get;set;} 
		public String filterType {get;set;} 
		public String column {get;set;} 

		public ReportFilters(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'value') {
							value = parser.getText();
						} else if (text == 'operator') {
							operator = parser.getText();
						} else if (text == 'filterType') {
							filterType = parser.getText();
						} else if (text == 'column') {
							column = parser.getText();
						} else {
							System.debug(LoggingLevel.WARN, 'ReportFilters consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}
	
	public class AggregateColumnInfo {
		public RowCount RowCount {get;set;} 

		public AggregateColumnInfo(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'RowCount') {
							RowCount = new RowCount(parser);
						} else {
							System.debug(LoggingLevel.WARN, 'AggregateColumnInfo consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}
	
	public class RowCount {
		public String name {get;set;} 
		public String label {get;set;} 
		public Object downGroupingContext {get;set;} 
		public String dataType {get;set;} 
		public Object acrossGroupingContext {get;set;} 

		public RowCount(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'name') {
							name = parser.getText();
						} else if (text == 'label') {
							label = parser.getText();
						} else if (text == 'downGroupingContext') {
							downGroupingContext = parser.readValueAs(Object.class);
						} else if (text == 'dataType') {
							dataType = parser.getText();
						} else if (text == 'acrossGroupingContext') {
							acrossGroupingContext = parser.readValueAs(Object.class);
						} else {
							System.debug(LoggingLevel.WARN, 'RowCount consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}
	
	public class ReportType {
		public String type {get;set;} 
		public String label {get;set;} 

		public ReportType(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'type') {
							type = parser.getText();
						} else if (text == 'label') {
							label = parser.getText();
						} else {
							System.debug(LoggingLevel.WARN, 'ReportType consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}
	
	public class ReportMetadata {
		public Object topRows {get;set;} 
		public Object standardFilters {get;set;} 
		public StandardDateFilter standardDateFilter {get;set;} 
		public Object sortBy {get;set;} 
		public Boolean showSubtotals {get;set;} 
		public Boolean showGrandTotal {get;set;} 
		public String scope {get;set;} 
		public ReportType reportType {get;set;} 
		public String reportFormat {get;set;} 
		public List<ReportFilters> reportFilters {get;set;} 
		public Object reportBooleanFilter {get;set;} 
		public String name {get;set;} 
		public String id {get;set;} 
		public Object historicalSnapshotDates {get;set;} 
		public Boolean hasRecordCount {get;set;} 
		public Boolean hasDetailRows {get;set;} 
		public Object groupingsDown {get;set;} 
		public Object groupingsAcross {get;set;} 
		public Object division {get;set;} 
		public String developerName {get;set;} 
		public List<String> detailColumns {get;set;} 
		public Object description {get;set;} 
		public Object customSummaryFormula {get;set;} 
		public Object currencyCode {get;set;} 
		public Object crossFilters {get;set;} 
		public Object buckets {get;set;} 
		public List<String> aggregates {get;set;} 

		public ReportMetadata(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'topRows') {
							topRows = parser.readValueAs(Object.class);
						} else if (text == 'standardFilters') {
							standardFilters = parser.readValueAs(Object.class);
						} else if (text == 'standardDateFilter') {
							standardDateFilter = new StandardDateFilter(parser);
						} else if (text == 'sortBy') {
							sortBy = parser.readValueAs(Object.class);
						} else if (text == 'showSubtotals') {
							showSubtotals = parser.getBooleanValue();
						} else if (text == 'showGrandTotal') {
							showGrandTotal = parser.getBooleanValue();
						} else if (text == 'scope') {
							scope = parser.getText();
						} else if (text == 'reportType') {
							reportType = new ReportType(parser);
						} else if (text == 'reportFormat') {
							reportFormat = parser.getText();
						} else if (text == 'reportFilters') {
							reportFilters = arrayOfReportFilters(parser);
						} else if (text == 'reportBooleanFilter') {
							reportBooleanFilter = parser.readValueAs(Object.class);
						} else if (text == 'name') {
							name = parser.getText();
						} else if (text == 'id') {
							id = parser.getText();
						} else if (text == 'historicalSnapshotDates') {
							historicalSnapshotDates = parser.readValueAs(Object.class);
						} else if (text == 'hasRecordCount') {
							hasRecordCount = parser.getBooleanValue();
						} else if (text == 'hasDetailRows') {
							hasDetailRows = parser.getBooleanValue();
						} else if (text == 'groupingsDown') {
							groupingsDown = parser.readValueAs(Object.class);
						} else if (text == 'groupingsAcross') {
							groupingsAcross = parser.readValueAs(Object.class);
						} else if (text == 'division') {
							division = parser.readValueAs(Object.class);
						} else if (text == 'developerName') {
							developerName = parser.getText();
						} else if (text == 'detailColumns') {
							detailColumns = arrayOfString(parser);
						} else if (text == 'description') {
							description = parser.readValueAs(Object.class);
						} else if (text == 'customSummaryFormula') {
							customSummaryFormula = parser.readValueAs(Object.class);
						} else if (text == 'currencyCode') {
							currencyCode = parser.readValueAs(Object.class);
						} else if (text == 'crossFilters') {
							crossFilters = parser.readValueAs(Object.class);
						} else if (text == 'buckets') {
							buckets = parser.readValueAs(Object.class);
						} else if (text == 'aggregates') {
							aggregates = arrayOfString(parser);
						} else {
							System.debug(LoggingLevel.WARN, 'ReportMetadata consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}
	
	public class DataCells {
		public String value {get;set;} 
		public String label {get;set;} 

		public DataCells(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'value') {
							value = parser.getText();
						} else if (text == 'label') {
							label = parser.getText();
						} else {
							System.debug(LoggingLevel.WARN, 'DataCells consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}
public List<DataCells> DataCellslist {get;set;} 	
	public class Rows {
		public List<DataCells> dataCells {get;set;} 

		public Rows(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'dataCells') {
							dataCells = arrayOfDataCells(parser);
						} else {
							System.debug(LoggingLevel.WARN, 'Rows consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}
	
	
	public static JSON2ApexContactReport parse(String json) {
		System.JSONParser parser = System.JSON.createParser(json);
		return new JSON2ApexContactReport(parser);
	}
	
	public static void consumeObject(System.JSONParser parser) {
		Integer depth = 0;
		do {
			System.JSONToken curr = parser.getCurrentToken();
			if (curr == System.JSONToken.START_OBJECT || 
				curr == System.JSONToken.START_ARRAY) {
				depth++;
			} else if (curr == System.JSONToken.END_OBJECT ||
				curr == System.JSONToken.END_ARRAY) {
				depth--;
			}
		} while (depth > 0 && parser.nextToken() != null);
	}
	





    private static List<Rows> arrayOfRows(System.JSONParser p) {
        List<Rows> res = new List<Rows>();
        if (p.getCurrentToken() == null) p.nextToken();
        while (p.nextToken() != System.JSONToken.END_ARRAY) {
            res.add(new Rows(p));
        }
        return res;
    }











    private static List<DataCells> arrayOfDataCells(System.JSONParser p) {
        List<DataCells> res = new List<DataCells>();
        if (p.getCurrentToken() == null) p.nextToken();
        while (p.nextToken() != System.JSONToken.END_ARRAY) {
            res.add(new DataCells(p));
        }
        return res;
    }




    private static List<String> arrayOfString(System.JSONParser p) {
        List<String> res = new List<String>();
        if (p.getCurrentToken() == null) p.nextToken();
        while (p.nextToken() != System.JSONToken.END_ARRAY) {
            res.add(p.getText());
        }
        return res;
    }







    private static List<ReportFilters> arrayOfReportFilters(System.JSONParser p) {
        List<ReportFilters> res = new List<ReportFilters>();
        if (p.getCurrentToken() == null) p.nextToken();
        while (p.nextToken() != System.JSONToken.END_ARRAY) {
            res.add(new ReportFilters(p));
        }
        return res;
    }


    private static List<Aggregates> arrayOfAggregates(System.JSONParser p) {
        List<Aggregates> res = new List<Aggregates>();
        if (p.getCurrentToken() == null) p.nextToken();
        while (p.nextToken() != System.JSONToken.END_ARRAY) {
            res.add(new Aggregates(p));
        }
        return res;
    }



}
//
// Generated by JSON2Apex http://json2apex.herokuapp.com/
//
// The supplied json has fields with names that are not valid in apex
// and so can only be parsed with explicitly generated code, this option
// was auto selected for you.