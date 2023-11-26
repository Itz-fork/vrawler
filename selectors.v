module main

import regex
import net.html


pub fn element_from_selectors(html_str string, selectors string) []&html.Tag{
	parsed_doc := html.parse(html_str)
	list_of_el := selectors.replace(" >", "").split(" ")
	println(list_of_el)
	mut res := []&html.Tag{}
	// Return first element if select only contains 1 element (Ex: "div")
	if list_of_el.len <= 1 {
		res = parsed_doc.get_tags(name: list_of_el[0])
	}
	// Iter through elements to find the element that selector points to
	mut re_nth := regex.regex_opt(r".+\:nth-child\(\d\)") or { panic(err) }
	for i, el in list_of_el {
		// nth child stuff
		if re_nth.matches_string(el) {
			// Split the string to ['div', 'nth-child(1)']
			spl_e := el.split(":")
			mut re_dig := regex.regex_opt(r"\d") or { panic(err) }
			st, en := re_dig.find(spl_e[1])
			// No matches?
			if st < 0 {
				continue
			}
			// Update first element with corresponding element
			chl_in := spl_e[1][st..en].i8() - 1
			if res.len == 0 {
				// Push n th found child tag to res list
				res << parsed_doc.get_tags(name: spl_e[0])[chl_in]
			} else {
				res[0] = res[0].get_tags(spl_e[0])[chl_in]
			}
		} else {
			if i+1 == list_of_el.len {
				res = res[0].get_tags(el)
			}
			else if res.len == 0 {
				// Push first found child tag to res list
				res << parsed_doc.get_tags(name: el)[0]
			} else {
				res[0] = res[0].get_tags(el)[0]
			}
		}
	}
	return res
}