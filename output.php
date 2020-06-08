#!/usr/bin/php
<?php

$postcode_file = file('data/postcodes.csv');
$postcode_regions = [];
$i = 0;
foreach ($postcode_file as $line) {
	++$i;
	if ($i < 2)
		continue;
	$record = [];
	list ($record['postcode'],$record['region']) = explode(",", $line);
	$record = array_map('trim', $record);
	$postcode_regions[] = $record;
}

$regions = ['Unknown' => []];
$postcodes = [];
foreach ($postcode_regions as $region) {
	if ($region['region'] !== "") {
		if (!isset($regions[$region['region']])) {
			$regions[$region['region']] = [];
		}
		$postcodes[$region['postcode']] = $region['region'];
	} else {
		$postcodes[$region['postcode']] = 'Unknown';
	}
}


$business_file = file('data/records.csv');
$businesses = [];
$i = 0;
foreach ($business_file as $line) {
	++$i;
	if ($i < 2)
		continue;
	$record = ['region' => ''];
	@list ($record['code'], $record['category'], $record['name'],$record['phone'], $record['address'], $record['postcode'], $record['website'], $record['description']) = @explode(";", $line);
	$record = array_map('trim', $record);
	$businesses[] = $record;
}

foreach ($businesses as &$business) 
{
	if (isset($postcodes[$business['postcode']]) && $business['name'] !== "") {
		$region_from_postcode = $postcodes[$business['postcode']];	
	} else {
		$region_from_postcode = "Unknown";
	}
	$business['region'] = $region_from_postcode;
	$regions[$region_from_postcode][] = $business;	
}

$fp = fopen('output/companion-card-nsw.csv', 'w');
fputcsv($fp, ['region','code','category','name','phone','address','postcode','website','description']);
foreach ($businesses as $business) {
	fputcsv($fp, $business);
}
fclose($fp);


$region_names = array_keys($regions);

for ($j = 0; $j < count($regions); ++$j) {
	$reg_name = $region_names[$j];
	if (count($regions[$region_names[$j]]) > 0) {
		file_put_contents('output/'.$reg_name.'.json', json_encode($regions[$region_names[$j]], JSON_PRETTY_PRINT));
	}
}