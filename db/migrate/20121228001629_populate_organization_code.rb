class PopulateOrganizationCode < ActiveRecord::Migration
  CODES = {"Department Of Agriculture" => "AG", "National Foundation on the Arts and the Humanities" => "AH", "Department Of Commerce" => "CM", "Department of Defense" => "DD", "Department Of Justice" => "DJ", "Department Of Labor" => "DL", "Department Of Energy" => "DN", "Department Of Education" => "ED", "Executive Office Of The President" => "EOP", "Court Services and Offender Supervision Agency for DC" => "FQ", "General Services Administration" => "GS", "Department Of Health And Human Services" => "HE", "Department Of Homeland Security" => "HS", "Department Of Housing And Urban Development" => "HU", "Department Of The Interior" => "IN", "Judicial Branch" => "JL", "Legislative Branch" => "LL", "National Aeronautics and Space Administration" => "NN", "Other Agencies and Independent Organizations" => "OT", "Department Of State" => "ST", "Department Of Transportation" => "TD", "Department Of The Treasury" => "TR", "Department Of Veterans Affairs" => "VA", "Non-Federal Civilian Customers" => "ZZ", "U.S. Air Force - Agency Wide" => "AF00", "Air Force Inspection Agency (FO)" => "AF02", "Air Force Operational Test and Evaluation Center" => "AF03", "Air Force Communications Agency (Historical)" => "AF04", "Air Force Intelligence Analysis Agency" => "AF05", "Air Force Audit Agency" => "AF06", "Air Force Office of Special Investigations" => "AF07", "Headquarters, U.S. Air Force Security Forces Center" => "AF08", "Air Force Personnel Center" => "AF09", "U.S. Air Force Academy" => "AF0B", "U.S. Air Forces, Europe" => "AF0D", "Air Force Reserve Personnel Center" => "AF0I", "Air Education and Training Command" => "AF0J", "Headquarters, Air Force Reserve Command" => "AF0M", "Immediate Office, Headquarters, USAF" => "AF0N", "Pacific Air Forces" => "AF0R", "Air Force Intelligence, Surveillance, & Reconnaissance Agency" => "AF0U", "Air Force Special Operations Command" => "AF0V", "Air Force Manpower Agency" => "AF11", "Air Force Public Affairs Agency" => "AF12", "HQ USAF and Support Elements" => "AF13", "Air Force Installation Contracting Agency" => "AF14", "Air Force C2 & Intelligence, Surveillance & Reconnaissance" => "AF1A", "Air Combat Command" => "AF1C", "Air Force Logistics Management Agency" => "AF1G", "Air Force Cyber Command" => "AF1K", "Air Mobility Command" => "AF1L", "Air Force Materiel Command" => "AF1M", "Air Force Real Property Agency" => "AF1P", "HQ AF Flight Standards Agency" => "AF1Q", "United States Africa Command" => "AF1R", "Headquarters, Air Force Space Command" => "AF1S", "Engineering and Support Agency" => "AF1W", "Air Force Civilian Career Training" => "AF1Y", "Air Force Agency for Modeling/Simulation" => "AF20", "Air Force Nuclear Weapons Agency" => "AF21", "HQ USAF Direct Support Element" => "AF24", "Air Force Wide Support Element" => "AF25", "Air Force National Security Emergency Preparedness" => "AF29", "Air Force Cost Analysis Agency" => "AF2A", "Air Force Personnel Operations Agency" => "AF2D", "Air Force Legal Operations Agency" => "AF2E", "Air Force Medical Support Agency" => "AF2F", "Air Force Operations Group" => "AF2H", "Air National Guard Readiness Center" => "AF2I", "Air Force Historical Research Agency" => "AF2K", "Air Force Technical Applications Center" => "AF2L", "Air Force Review Boards Agency" => "AF2M", "Air Force Studies and Analyses Agency" => "AF2N", "Headquarters, Air Weather Agency" => "AF2Q", "Air Force Program Executive Office" => "AF2R", "Air Force Elements NORAD" => "AF2S", "Air Force Safety Center" => "AF2T", "Air Force Services Agency" => "AF2U", "11th Wing" => "AF2W", "Air Force Medical Operations Agency" => "AF2Z", "Air National Guard" => "AF34", "Air Elements Defense Intelligence Agency" => "AF35", "Air Force Element OSD" => "AF39", "Air Force Elements, U.S. Central Command" => "AF3C", "Air Force Elements, U.S. Special Operations Command" => "AF3D", "Air Force Elements, NATO" => "AF3G", "Air Force Elements, U.S. European Command" => "AF3K", "Air Force Elements, U.S. Southern Command" => "AF3M", "Air Force Elements, U.S. Joint Forces Command" => "AF3N", "Air Force Elements, U.S. Pacific Command" => "AF3O", "Air Force Elements, U.S. Strategic Command" => "AF3Q", "Air Force Elements, U.S. Transportation Command" => "AF3T", "Air Force Elements" => "AF3V", "Air Force Center for Engineer & Environment" => "AF3W", "Air Force Frequency Management Agency" => "AF3Y", "U.S. Northern Command" => "AF4D", "Air Force District of Washington" => "AF4W", "Air Force Financial Services" => "AF5J", "Air Force Petroleum Agency" => "AF5K", "Air Force Global Strike Command" => "AFGS", "Air National Guard Units (Title 32)" => "AFNG", "U.S. Special Operations Command (ANG, Title 32)" => "AFZG", "Air Force, Special Operations Command" => "AFZS", "Department of Agriculture - Agency Wide" => "AG00", "Office of the Secretary of Agriculture" => "AG01", "Agricultural Marketing Service" => "AG02", "Agricultural Research Service" => "AG03", "Agriculture, Rural Housing Service" => "AG07", "Risk Management Agency" => "AG08", "Foreign Agricultural Service" => "AG10", "Forest Service" => "AG11", "Office of Communications" => "AG13", "Office of the General Counsel" => "EDEG", "Rural Utility Service" => "AG15", "Natural Resources Conservation Service" => "AG16", "Economic Research Service" => "AG18", "National Agricultural Statistics Service" => "AG20", "National Institute of Food and Agriculture" => "AG22", "Office of the Inspector General" => "IN24", "Food and Nutrition Service" => "AG30", "Rural Business-Cooperative Service" => "AG32", "Animal and Plant Health Inspection Service" => "AG34", "Grain Inspection, Packers and Stockyards Administration" => "AG36", "Food Safety and Inspection Service" => "AG37", "Office of the Chief Economist" => "AG38", "Office of Budget and Program Analysis" => "AG42", "Agriculture, Office of the Chief Financial Officer" => "AG90", "Office of Advocacy and Outreach. Effective March 1, 2010." => "AGAO", "Civil Rights" => "AGCR", "Departmental Administration" => "AGDA", "Office of Environmental Markets" => "AGEM", "Office of the Executive Secretariat" => "AGES", "Farm Service Agency" => "AGFA", "Homeland Security Staff" => "AGHL", "Office of the Chief Information Officer" => "HUQQ", "National Appeals Division" => "AGNA", "Foundation on the Arts and the Humanities - Agency Wide" => "AH00", "National Endowment for the Arts" => "AH01", "National Endowment for the Humanities" => "AH02", "Institute of Museum and Library Services" => "AH03", "U.S. Army - Agency Wide" => "AR00", "U.S. Army Cyber Command" => "AR2A", "U.S. Army Central" => "AR3A", "U.S. Army North" => "AR5A", "U.S. Army Accession Command" => "ARAA", "U.S. Army Acquisition Support Center" => "ARAE", "U.S. Military Entrance Processing Command" => "ARAP", "U.S. Army Intelligence and Security Command" => "ARAS", "U.S. Army Test and Evaluation Command" => "ARAT", "Army Installation Management Command" => "ARBA", "U.S. Army Criminal Investigation Command" => "ARCB", "U.S. Army Corps of Engineers" => "ARCE", "Office of the Chief of Staff of the Army" => "ARCS", "59th Ordnance Brigade" => "ARE0", "Immediate Office of the Commander-in-Chief of the U.S. Army" => "ARE1", "21st Theater Sustainment Command (TSC)" => "ARE2", "U.S. Army Southern European Task Force" => "ARE3", "U.S. Army V Corps" => "ARE5", "1st Personnel Command" => "AREB", "U.S. Military Community Activity, Heidelberg" => "ARED", "Seventh Army Training Command" => "AREN", "U.S. Army Forces Command" => "ARFC", "U.S. Army Network Enterprise Technology Command/9th Army Signal Command" => "ARG6", "Office of the Chief of the National Guard Bureau" => "ARGB", "U.S. Army Reserve Command" => "ARHR", "U.S. Army Health Services Command" => "ARHS", "U.S. Army Element SHAPE" => "ARJ1", "Joint Activities" => "ARJA", "U.S. Military Academy" => "ARMA", "U.S. Army Medical Command" => "ARMC", "Surgeon General" => "ARMD", "U.S. Army Military District of Washington" => "ARMW", "Army National Guard Units (Title 32)" => "ARNG", "U.S. Army, Pacific" => "ARP1", "Eighth U.S. Army" => "ARP8", "Office of the Secretary of the Army" => "ARSA", "Field Operating Offices of the Office of the Secretary of the Army" => "ARSB", "U.S. Army Space and Missile Defense Command/U. S. Army Forces Strategic Command" => "ARSC", "HQDA Field Operating Agencies and Staff Support Agencies" => "ARSE", "Miscellaneous Field Operating Agencies" => "ARSF", "Joint Services and Activities Supported by the Office, Secretary of the Army" => "ARSJ", "U.S. Army South" => "ARSO", "U.S. Special Operations Command (Army)" => "ARSP", "U.S. Army Southern Command" => "ARSU", "U.S. Army Training and Doctrine Command" => "ARTC", "U.S. Army War College" => "ARTW", "Headquarters, AMC" => "ARX2", "Headquarters, Staff Support Activities, AMC" => "ARX3", "Training Activities, AMC" => "ARX4", "U.S. Army Aviation and Missile Command" => "ARX6", "Army Tank-Automotive and Armament Command (TACOM)" => "ARX7", "U.S. Army Communications Electronics Command" => "ARX8", "U.S. Army Chemical Materials Agency" => "ARXB", "U.S. Army Sustainment Command" => "ARXC", "U.S. Army Contracting Command" => "ARXD", "Materiel Acquisition Activities" => "ARXK", "Materiel Acquisition Project Managers" => "ARXL", "U.S. Army Security Assistance Command" => "ARXP", "U.S. Army Joint Munitions Command" => "ARXQ", "U.S. Army Research, Development and Engineering Command" => "ARXR", "U.S. Army Military Surface Deployment and Distribution Command" => "ARXT", "Materiel Readiness Activities" => "ARXX", "Department of Commerce - Agency Wide" => "CM00", "Technology Administration" => "CM33", "Office of the Secretary" => "VAAA", "Economic Development Administration" => "CM52", "Bureau of Economic Analysis" => "CM53", "National Oceanic and Atmospheric Administration" => "CM54", "Commerce, International Trade Administration" => "CM55", "Patent and Trademark Office" => "CM56", "National Institute of Standards and Technology" => "CM57", "Minority Business Development Agency" => "CM59", "National Telecommunications and Information Administration" => "CM61", "National Technical Information Service" => "CM62", "Bureau of the Census" => "CM63", "Economics and Statistics Administration" => "CM65", "Bureau of Industry and Security" => "CM67", "Department of the Air Force" => "AF", "Department of the Army" => "AR", "Department of Defense - Agency Wide" => "DD00", "Office of the Secretary of Defense" => "DD01", "Organization of the Joint Chiefs of Staff" => "DD02", "Defense Information Systems Agency" => "DD04", "Defense Intelligence Agency" => "DD05", "Defense Security Cooperation Agency" => "DD06", "Defense Logistics Agency" => "DD07", "U.S. Court of Appeals for the Armed Forces" => "DD08", "Defense Contract Audit Agency" => "DD10", "National Geospatial-Intelligence Agency" => "DD11", "Defense Security Service" => "DD12", "Defense Advanced Research Projects Agency" => "DD13", "Uniformed Services University of the Health Sciences" => "DD15", "Department of Defense Education Activity" => "DD16", "Washington Headquarters Services" => "DD21", "Office of Economics Adjustment" => "DD23", "Defense Legal Services Agency" => "DD25", "Office of Inspector General" => "TR95", "Missile Defense Agency" => "DD27", "National Security Agency/Central Security Service" => "DD28", "Defense Technology Security Administration" => "DD29", "Defense Commissary Agency" => "DD34", "Defense Finance and Accounting Service" => "DD35", "Army and Air Force Exchange Service (nonappropriated fund)" => "DD36", "Defense Human Resources Activity" => "DD48", "Defense Prisoner of War/Missing Personnel Office" => "DD58", "Consolidated Metropolitan Technical Personnel Center" => "DD59", "TRICARE Management Activity" => "DD60", "Defense Threat Reduction Agency" => "DD61", "Defense Career Management and Support Agency" => "DD62", "Defense Contract Management Agency" => "DD63", "Eastern Regional Support Center" => "DD64", "Pentagon Force Protection Agency" => "DD65", "Department of Defense Counterintelligence Field Activity" => "DD66", "Unified Combatant Command Headquarters" => "DD67", "Department of Defense Test Resource Management Center" => "DD68", "National Defense University" => "DD69", "Armed Forces Radiobiology Research Institute" => "DD70", "Defense Microelectronics Activity" => "DD71", "Pentagon Renovation Program Office" => "DD72", "Virginia Contracting Activity" => "DD73", "Defense Technical Information Center" => "DD74", "Defense Civilian Personnel Advisory Services" => "DD75", "U.S. Transportation Command" => "DD76", "Business Transformation Agency" => "DD77", "Defense Programs Support Activity" => "DD78", "Joint Improvised Explosive Device Defeat Organization" => "DD79", "Defense Media Activity" => "DD80", "Defense Acquisition University" => "DD81", "Department of the Navy" => "NV", "Department of Justice - Agency Wide" => "DJ00", "Offices, Boards and Divisions" => "DJ01", "Federal Bureau of Investigation" => "DJ02", "Justice, Bureau of Prisons/Federal Prison System" => "DJ03", "Drug Enforcement Administration" => "DJ06", "Office of Justice Programs" => "DJ07", "U.S. Marshals Service" => "DJ08", "Executive Office for U.S. Attorneys and the Office of the U.S. Attorneys" => "DJ09", "Justice, Office of the Inspector General" => "DJ10", "Justice, U.S. Trustee Program" => "DJ11", "Executive Office for Immigration Review" => "DJ12", "Community Relations Service" => "DJ14", "Bureau of Alcohol, Tobacco, Firearms, and Explosives" => "DJ15", "Department of Labor - Agency Wide" => "DL00", "Office of the Secretary of Labor" => "DLAA", "Office of the Assistant Secretary for Administration and Management" => "DLAM", "Bureau of International Labor Affairs" => "DLBL", "Office of Congressional and Intergovernmental Affairs" => "GS20", "Office of the Chief Financial Officer" => "HUFF", "Office of Disability Employment Policy" => "DLEH", "Employment Standards Administration" => "DLES", "Employment and Training Administration" => "DLET", "Bureau of Labor Statistics" => "DLLS", "Mine Safety and Health Administration" => "DLMS", "Office of Federal Contract Compliance Programs" => "DLOF", "Office of Labor-Management Standards" => "DLOL", "Office of Workers' Compensation Programs" => "DLOW", "Office of Public Affairs" => "DLPA", "Office of the Assistant Secretary for Policy" => "DLPE", "Employee Benefits Security Administration" => "DLPW", "Occupational Safety and Health Administration" => "DLSH", "Office of the Solicitor" => "IN21", "Veterans Employment and Training Services" => "DLVE", "Women's Bureau" => "DLWB", "Wage and Hour Division" => "DLWH", "Department of Energy" => "DN00", "Bonneville Power Administration" => "DN03", "Federal Energy Regulatory Commission (FERC)" => "DNFE", "National Nuclear Security Administration" => "DNNN", "Southwestern Power Administration" => "DNSW", "Western Area Power Administration" => "DNWP", "Department of Education - Agency Wide" => "ED00", "Immediate Office of the Secretary of Education" => "EDEA", "Office of the Deputy Secretary of Education" => "EDEB", "Office for Civil Rights" => "EDEC", "Office of Planning, Evaluation and Policy Development" => "EDED", "Office of the Under Secretary" => "EDEE", "Office of Special Education and Rehabilitative Services" => "EDEH", "Office of Legislation and Congressional Affairs" => "EDEJ", "Office of Intergovernmental and Interagency Affairs" => "EDEK", "Office of Management" => "EDEM", "Federal Student Aid" => "EDEN", "Office of Communications and Outreach" => "EDEO", "Office of Postsecondary Education" => "EDEP", "Office of Safe and Drug-Free Schools" => "EDEQ", "Institute of Education Sciences" => "EDER", "Office of Elementary and Secondary Education" => "EDES", "Office of English Language Acquisition" => "EDET", "Office of Innovation and Improvement" => "EDEU", "Office of Vocational and Adult Education" => "EDEV", "National Institute for Literacy" => "EDEX", "Advisory Councils and Committees" => "EDEY", "National Assessment Governing Board" => "EDEZ", "Office of Management and Budget" => "BO00", "Council of Economic Advisers" => "CE00", "Office of Policy Development" => "DC00", "Office of Administration" => "EC00", "Council on Environmental Quality/Office of Environmental Quality" => "EQ00", "Executive Residence at the White House" => "EX00", "National Commission on Fiscal Responsibility and Reform" => "KR00", "National Security Council" => "NS00", "Office of National Drug Control Policy" => "QQ00", "Office of the U.S. Trade Representative" => "TN00", "Office of Science and Technology Policy" => "TS00", "White House Office" => "WH01", "Office of the President" => "WH03", "Office of the Former President" => "WHX1", "Office of the President Elect" => "WHY1", "Court Services and Offender Supervision Agency for DC - Agency Wide" => "FQ00", "Office of the Director" => "FQ01", "Pretrial Services Agency" => "FQ02", "General Services Administration - Agency Wide" => "GS00", "Immediate Office of the Administrator" => "GS01", "Office of Administrative Services" => "GS02", "Public Buildings Service" => "GS03", "Office of Civil Rights" => "GS04", "Office of Small Business Utilization" => "GS10", "Office of General Counsel" => "HUCC", "Civilian Board of Contract Appeals" => "GS13", "Office of the Chief People Officer" => "GS14", "Office of the Chief Acquisition Officer" => "GS16", "Office of Citizen Services and Innovative Technologies" => "GS19", "Offices of the Regional Administrators" => "GS22", "Office of Governmentwide Policy" => "GS26", "Office of Childcare" => "GS29", "Federal Acquisition Service" => "GS30", "Office of Emergency Response and Recovery" => "GS31", "Office of Communications and Marketing" => "GS32", "Department of Health and Human Services - Agency Wide" => "HE00", "Office of the Secretary of Health and Human Services" => "HE10", "Program Support Center" => "HE11", "Administration for Community Living" => "HE12", "Office of the Assistant Secretary of Health" => "HE31", "Substance Abuse and Mental Health Services Administration" => "HE32", "Agency for Healthcare Research and Quality" => "HE33", "Health Resources and Services Administration" => "HE34", "Agency for Toxic Substances and Disease Registry" => "HE35", "Food and Drug Administration" => "HE36", "Indian Health Service" => "HE37", "National Institutes of Health" => "HE38", "Centers for Disease Control and Prevention" => "HE39", "Centers for Medicare & Medicaid Services" => "HE70", "Administration for Children and Families" => "HE90", "Department of Homeland Security - Agency Wide" => "HS00", "DHS Headquarters" => "HSAA", "Citizenship and Immigration Services" => "HSAB", "U.S. Coast Guard" => "HSAC", "U.S. Secret Service" => "HSAD", "Immigration and Customs Enforcement" => "HSBB", "Transportation Security Administration" => "HSBC", "Customs and Border Protection" => "HSBD", "Federal Law Enforcement Training Center" => "HSBE", "National Protection and Programs Directorate" => "HSCA", "Federal Emergency Management Agency" => "HSCB", "Domestic Nuclear Detection Office" => "HSDA", "Science and Technology Directorate" => "HSFA", "Department of Housing and Urban Development - Agency Wide" => "HU00", "Office of the Senior Coordinator for New England" => "HU01", "Office of the Senior Coordinator for New York/New Jersey" => "HU02", "Office of the Senior Coordinator for Mid-Atlantic" => "HU03", "Office of the Senior Coordinator for Southeast/Caribbean" => "HU04", "Office of the Senior Coordinator for Midwest" => "HU05", "Office of the Senior Coordinator for Southwest" => "HU06", "Office of the Senior Coordinator for Great Plains" => "HU07", "Office of the Senior Coordinator for Rocky Mountains" => "HU08", "Office of the Senior Coordinator for Pacific/Hawaii" => "HU09", "Office of the Senior Coordinator for Northwest/Alaska" => "HU10", "Office of the Secretary of Housing and Urban Development" => "HUAA", "Office of the Chief Human Capital Officer" => "HUBB", "Assistant Secretary for Community Planning and Development" => "HUDD", "Assistant Secretary for Fair Housing and Equal Opportunity" => "HUEE", "Office of Departmental Operations and Coordination" => "HUII", "Assistant Secretary for Congressional and Intergovernmental Relations" => "HUJJ", "Center for Faith-Based and Community Initiatives" => "HUKA", "Office of Field Policy and Management" => "HUKK", "Office of Healthy Homes and Lead Hazard Control" => "HULL", "Assistant Secretary for Housing-Federal Housing Commissioner" => "HUMM", "Office of the Chief Procurement Officer" => "HUNN", "Assistant Secretary for Public and Indian Housing" => "HUPP", "Assistant Secretary for Policy Development and Research" => "HURR", "Government National Mortgage Association (Ginnie Mae)" => "HUTT", "Office of Departmental Equal Employment Opportunity" => "HUUU", "Office of Disaster Management and National Security" => "HUVV", "Assistant Secretary for Public Affairs" => "HUWW", "Office of Strategic Planning and Management" => "HUXX", "Office of Sustainable Housing and Communities" => "HUYY", "Department of Interior - Agency Wide" => "IN00", "Office of the Secretary of the Interior" => "IN01", "Bureau of Land Management" => "IN05", "Interior, Bureau of Indian Affairs" => "IN06", "Bureau of Reclamation" => "IN07", "Geological Survey" => "IN08", "National Park Service" => "IN10", "Interior, US Fish and Wildlife Service" => "IN15", "Office of Surfacing Mining, Reclamation and Enforcement" => "IN22", "Bureau of Ocean Energy Management, Regulation, and Enforcement" => "IN23", "Bureau of Safety and Environmental Enforcement" => "IN26", "Bureau of Ocean Energy Management" => "IN27", "National Indian Gaming Commission" => "IN99", "Judicial Branch - Agency Wide" => "JL00", "Supreme Court of the United States" => "JL01", "U.S. Courts" => "JL02", "U. S. Sentencing Commission" => "JL03", "Administrative Office of the U.S. Courts" => "JL04", "Architect of the Capitol" => "LA00", "Botanic Garden" => "LB00", "Library of Congress" => "LC00", "Congressional Budget Office" => "LD00", "Government Accountability Office" => "LG00", "Legislative Branch - Agency Wide" => "LL00", "Senate" => "LL01", "House of Representatives" => "LL02", "U.S. Capitol Police" => "LL03", "Government Printing Office" => "LP00", "John C. Stennis Center for Public Service Training and Development" => "LQ00", "U.S. Tax Court" => "LT00", "Financial Crisis Inquiry Commission" => "YF00", "Ronald Reagan Centennial Commission" => "YG00", "U.S. Court of Appeals for Veterans Claims" => "ZD00", "Office of Compliance" => "ZG00", "Medicare Payment Advisory Commission" => "ZL00", "Commission on Security and Cooperation in Europe" => "ZO00", "U.S. Commission on International Religious Freedom" => "ZP00", "United States-China Economic and Security Review Commission" => "ZS00", "Dwight D. Eisenhower Memorial Commission" => "ZU00", "Commission on the People's Republic of China" => "ZV00", "Abraham Lincoln Bicentennial Commission" => "ZX00", "NASA - Agency Wide" => "NN00", "Headquarters, NASA" => "NN10", "Ames Research Center" => "NN21", "John Glenn Research Center at Lewis Field" => "NN22", "Langley Research Center" => "NN23", "Dryden Flight Research Center" => "NN24", "Goddard Space Flight Center" => "NN51", "George C. Marshall Space Flight Center" => "NN62", "John C. Stennis Space Center" => "NN64", "Lyndon B. Johnson Space Center" => "NN72", "Space Station Program Office" => "NN73", "John F. Kennedy Space Center" => "NN76", "U.S. Navy - Agency Wide" => "NV00", "Immediate Office of the Secretary of the Navy" => "NV08", "Navy Staff Offices" => "NV09", "Navy Field Offices" => "NV10", "Immediate Office of the Chief of Naval Operations" => "NV11", "Secretary of the Navy/Assistant for Administration (DON/AA)" => "NV12", "Office of Naval Research" => "NV14", "Naval Intelligence Command" => "NV15", "Naval Medical Command" => "NV18", "Naval Air Systems Command" => "NV19", "Bureau of Naval Personnel" => "NV22", "Naval Supply Systems Command" => "NV23", "Naval Sea Systems Command" => "NV24", "Naval Facilities Engineering Command" => "NV25", "U.S. Marine Corps" => "NV27", "Strategic Systems Programs Office" => "NV30", "Military Sealift Command" => "NV33", "Space and Naval Warfare Systems Command" => "NV39", "Navy Systems Management Activity" => "NV41", "Commander, Navy Installations" => "NV52", "U.S. Atlantic Fleet, Commander in Chief" => "NV60", "U.S. Naval Forces, Europe" => "NV61", "Chief of Naval Education and Training" => "NV62", "Naval Meteorology and Oceanography Command" => "NV65", "Naval Security Group Command" => "NV69", "U.S. Pacific Fleet, Commander in Chief" => "NV70", "Naval Reserve Force" => "NV72", "Naval Special Warfare Command" => "NV74", "Naval Education and Training Command" => "NV76", "U.S. Special Operations Command (Navy)" => "NVZS", "Administrative Conference of the United States" => "AA00", "American Battle Monuments Commission" => "AB00", "U.S. Institute Of Peace" => "AI00", "U.S. Agency for International Development" => "AM00", "African Development Foundation" => "AN00", "Appalachian Regional Commission" => "AP00", "Federal Labor Relations Authority" => "AU00", "Arctic Research Commission" => "AW00", "Merit Systems Protection Board" => "BD00", "Defense Nuclear Facilities Safety Board" => "BF00", "Pension Benefit Guaranty Corporation" => "BG00", "Commission for the Preservation of America's Heritage Abroad" => "BH00", "Illinois and Michigan Canal National Heritage Corridor Commission" => "BJ00", "James Madison Memorial Fellowship Foundation" => "BK00", "Architectural and Transportation Barriers Compliance Board" => "BT00", "Nuclear Waste Technical Review Board" => "BW00", "Christopher Columbus Fellowship Foundation" => "BZ00", "Commission on Civil Rights" => "CC00", "Commission of Fine Arts" => "CF00", "Central Intelligence Agency" => "CI00", "Commodity Futures Trading Commission" => "CT00", "National Credit Union Administration" => "CU00", "National Commission on Libraries and Information Science" => "CX00", "Delta Regional Authority" => "DA00", "Public Interest Declassification Board" => "DB00", "Office of the Federal Coordinator for Alaska Natural Gas Transportation Projects" => "DF00", "Denali Commission" => "DQ00", "Export-Import Bank of the United States" => "EB00", "Equal Employment Opportunity Commission" => "EE00", "Morris K. Udall Scholarship and Excellence in National Environmental Policy Foundation" => "EO00", "Environmental Protection Agency" => "EP00", "Commission on Executive, Legislative, and Judicial Salaries" => "ES00", "Trade and Development Agency" => "EW00", "Federal Communications Commission" => "FC00", "Federal Deposit Insurance Corporation" => "FD00", "Federal Financial Institutions Examination Council" => "FI00", "Chemical Safety and Hazard Investigation Board" => "FJ00", "Farm Credit System Insurance Corporation" => "FK00", "Farm Credit Administration" => "FL00", "Federal Mediation and Conciliation Service" => "FM00", "Federal Reserve System--Board Of Governors" => "FRBG", "Consumer Financial Protection Bureau" => "FRFT", "Federal Trade Commission" => "FT00", "Office of Special Counsel" => "FW00", "Overseas Private Investment Corporation" => "GB00", "Barry Goldwater Scholarship and Excellence in Education Foundation" => "GE00", "Office of Government Ethics" => "GG00", "Presidio Trust" => "GJ00", "Centennial of Flight Commission" => "GK00", "Valles Caldera Trust" => "GM00", "White House Commission on the National Moment of Remembrance" => "GN00", "Vietnam Education Foundation" => "GO00", "Election Assistance Commission" => "GQ00", "International Boundary and Water Commission: United States and Mexico" => "GW00", "International Boundary Commission: United States and Canada" => "GX00", "International Joint Commission: United States and Canada" => "GY00", "Committee for Purchase from People Who Are Blind or Severely Disabled" => "HB00", "U.S. Holocaust Memorial Museum" => "HD00", "Federal Housing Finance Agency" => "HFHA", "Office of the Inspector General for the Federal Housing Finance Agency" => "HFHI", "Advisory Council on Historic Preservation" => "HP00", "Harry S. Truman Scholarship Foundation" => "HT00", "U.S. Interagency Council on Homelessness" => "HW00", "Broadcasting Board of Governors" => "IB00", "Inter-American Foundation" => "IF00", "Council of the Inspectors General on Integrity and Efficiency" => "IG00", "Corporation for National and Community Service" => "KS00", "Federal Election Commission" => "LF00", "Marine Mammal Commission" => "MA00", "Federal Maritime Commission" => "MC00", "Millennium Challenge Corporation" => "MI00", "National Science Foundation" => "NF00", "National Council on Disability" => "NK00", "National Labor Relations Board" => "NL00", "National Mediation Board" => "NM00", "National Capital Planning Commission" => "NP00", "National Archives and Records Administration" => "NQ00", "Nuclear Regulatory Commission" => "NU00", "Office of the Director of National Intelligence" => "OI00", "Office of Personnel Management" => "OM00", "Occupational Safety and Health Review Commission" => "OS00", "Office of the Vice President" => "OV00", "Public International Organization" => "PI00", "Postal Regulatory Commission" => "PJ00", "U.S. Postal Service" => "PO00", "Office of the Inspector General, USPS" => "PO01", "Peace Corps" => "PU00", "Office of Navajo and Hopi Indian Relocation" => "RE00", "Federal Retirement Thrift Investment Board" => "RF00", "Armed Forces Retirement Home" => "RH00", "Railroad Retirement Board" => "RR00", "Federal Mine Safety and Health Review Commission" => "RS00", "Recovery Act Accountability and Transparency Board" => "RZ00", "Small Business Administration" => "SB00", "Securities and Exchange Commission" => "SE00", "Consumer Product Safety Commission" => "SK00", "National Gallery of Art" => "SM01", "Woodrow Wilson International Center for Scholars" => "SM02", "Smithsonian Institution " => "SM03", "John F. Kennedy Center for the Performing Arts" => "SM04", "Selective Service System" => "SS00", "Social Security Administration" => "SZ00", "National Transportation Safety Board" => "TB00", "U.S. International Trade Commission" => "TC00", "Tennessee Valley Authority" => "TV00", "Japan-United States Friendship Commission" => "UJ00", "Utah Reclamation Mitigation and Conservation Commission" => "UT00", "Privacy and Civil Liberties Oversight Board" => "VD00", "District of Columbia Courts" => "XDCC", "Agency System Test" => "XVAT", "Multi-agency" => "XX00", "Commission on the Prevention of Weapons of Mass Destruction Proliferation and Terrorism" => "YE00", "Department of State - Agency Wide" => "ST00", "Metropolitan Technical Support Center" => "ST14", "Northern Regional Personnel Center" => "ST27", "Materiel Acquisition Support Center" => "ST32", "Eastern Regional Personnel Center" => "ST46", "Department of Transportation - Agency Wide" => "TD00", "Office of the Secretary of Transportation" => "TD01", "Federal Aviation Administration" => "TD03", "Federal Highway Administration" => "TD04", "Federal Railroad Administration" => "TD05", "Saint Lawrence Seaway Development Corporation" => "TD06", "Federal Transit Administration" => "TD09", "National Highway Traffic Safety Administration" => "TD10", "Research and Innovative Technology Administration" => "TD11", "Maritime Administration" => "TD13", "Surface Transportation Board" => "TD15", "Pipeline and Hazardous Materials Safety Administration" => "TD16", "Federal Motor Carrier Safety Administration" => "TD17", "Transportation Administrative Service Center" => "TD18", "Department of Treasury - Agency Wide" => "TR00", "Office of Thrift Supervision" => "TR35", "Office of the Special Inspector General for the Troubled Asset Relief Program (SIGTARP)" => "TR36", "Alcohol and Tobacco Tax and Trade Bureau" => "TR40", "Treasury, Departmental Offices" => "TR91", "Internal Revenue Service" => "TR93", "Bureau of the Fiscal Service (FMS)" => "TRAA", "Bureau of the Fiscal Service (BPD)" => "TRAB", "U.S. Mint" => "TRAD", "Treasury, Financial Crimes Enforcement Network" => "TRAF", "Bureau of Engraving and Printing" => "TRAI", "Office of the Comptroller of the Currency" => "TRAJ", "Office of the Inspector General for Tax Administration" => "TRTG", "Department of Veterans Affairs - Agency Wide" => "VA00", "Board of Veterans Appeals" => "VAAD", "General Counsel" => "VAAE", "Veterans Affairs, Inspector General" => "VAAF", "Immediate Office of the Assistant Secretary for Human Resources and Administration" => "VABA", "Assistant Secretary for Human Resources Management" => "VABC", "Assistant Secretary for Diversity and Inclusion" => "VABD", "Deputy Assistant Secretary for Administration" => "VABE", "Deputy Assistant Secretary for Office of Resolution Management" => "VABF", "Deputy Assistant Secretary for Corporate Senior Executive Management" => "VABG", "Deputy Assistant Secretary for Labor Management Relations" => "VABH", "Dean for VA Learning University" => "VABI", "Veteran Employment Services Office" => "VABJ", "Immediate Office of the Assistant Secretary for Management" => "VADA", "Deputy Assistant Secretary for Budget" => "VADC", "Deputy Assistant Secretary for Finance" => "VADD", "Deputy Assistant Secretary for Acquisition and Materiel Management" => "VADG", "Immediate Office of the Assistant Secretary for Information and Technology" => "VAEA", "Deputy Assistant Secretary for Information and Technology" => "VAEB", "Immediate Office of the Assistant Secretary for Operations, Security, and Preparedness" => "VAGA", "Deputy Assistant Secretary for Security and Law Enforcement" => "VAGB", "Deputy Assistant Secretary for Emergency Management" => "VAGC", "Immediate Office of the Assistant Secretary for Policy and Planning" => "VAHA", "Deputy Assistant Secretary for Program and Data Analysis" => "VAHB", "Deputy Assistant Secretary for Planning and Evaluation" => "VAHC", "National Center for Veteran Analysis and Statistics" => "VAHD", "Deputy Assistant Secretary for Security Preparedness" => "VAHE", "Office of the Assistant Secretary for Public and Intergovernmental Affairs" => "VAJA", "Deputy Assistant Secretary for Intergovernmental Affairs" => "VAJB", "Deputy Assistant Secretary for Public Affairs" => "VAJC", "Immediate Office of the Assistant Secretary for Congressional and Legislative Affairs" => "VAKA", "Deputy Assistant Secretary for Congressional Affairs" => "VAKB", "Deputy Assistant Secretary for Legislative Affairs" => "VAKC", "Veterans Benefits Administration" => "VALA", "Veterans Affairs, National Cemetery Administration" => "VAPA", "Veterans Affairs, Veterans Health Administration" => "VATA", "Amtrak - Office of Inspector General" => "XAMG", "Public Defender Service for the District of Columbia" => "XPDS"}

  def up
    Agency.send(:remove_method, :generate_agency_queries)
    Agency.send(:define_method, :generate_agency_queries) { true }
    keys = CODES.keys
    Agency.all.each do |agency|
      agency.update_attribute(:name, agency.name.squish)
      agency.agency_queries.create(:phrase => "the #{agency.abbreviation}") if agency.abbreviation.present?
    end

    Agency.all.each do |agency|
      code = CODES[agency.name] || CODES[keys.detect { |key| key =~ /#{agency.name}/i }]
      agency.update_attribute(:organization_code, code) if code.present?
    end

  end

  def down
    Agency.send(:remove_method, :generate_agency_queries)
    Agency.send(:define_method, :generate_agency_queries) { true }
    Agency.all.each { |agency| agency.update_attribute(:organization_code, nil) }
  end
end