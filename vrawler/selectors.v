module vrawler

import regex
import net.html

pub fn element_from_selectors(hdoc string, selectors string) []&html.Tag {
	mut parsed_doc := html.parse(hdoc).get_root()
	list_of_el := selectors.replace(' ', '').split('>')
	mut res := []&html.Tag{}
	mut resval := parsed_doc
	// Iter through elements to find the element that selector points to
	mut re_nth := regex.regex_opt(r'.+\:nth-child\(\d\)') or { panic(err) }
	for i, el in list_of_el {
		if el.starts_with('#') {
			// elements with id
			resval = resval.get_tags_by_attribute_value('id', el.split('#')[1])[0]
		} else if re_nth.matches_string(el) {
			// elements with nth child
			// Split the string to ['div', 'nth-child(1)']
			spl_e := el.split(':')
			mut re_dig := regex.regex_opt(r'\d') or { panic(err) }
			st, en := re_dig.find(spl_e[1])
			// No matches?
			if st < 0 {
				continue
			}
			chl_in := spl_e[1][st..en].i8() - 1
			resval = resval.get_tags(spl_e[0])[chl_in]
		} else {
			// Just elements
			if i + 1 == list_of_el.len {
				return resval.get_tags(el)
			} else {
				resval = resval.get_tags(el)[0]
			}
		}
		if res.len == 0 {
			res << resval
		} else {
			res[0] = resval
		}
	}
	return res
}
