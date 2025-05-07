# Θ(n): The algorithm runs in linear time with respect to the length of the input strings

import re

def parse_polynomial(poly_str):
    # Clean the string
    poly_str = poly_str.replace(" ", "")
    
    if poly_str[0] != '-':
        poly_str = '+' + poly_str

    terms = re.findall(r'[\+\-][^+\-]+', poly_str)

    parsed_terms = {}

    for term in terms:
        coef = 0
        exp = 0

        if 'x' in term:
            if '**' in term:
                coef_part, exp_part = term.split('x**')
                exp = int(exp_part)
            else:
                coef_part = term.split('x')[0]
                exp = 1

            if coef_part in ['+', '-']:
                coef_part += '1'
            coef = int(coef_part)
        else:
            coef = int(term)
            exp = 0

        parsed_terms[exp] = parsed_terms.get(exp, 0) + coef

    return parsed_terms

def add_polynomials(poly1_str, poly2_str):
    poly1 = parse_polynomial(poly1_str)
    poly2 = parse_polynomial(poly2_str)

    result_poly = {}

    for exp in set(poly1) | set(poly2):
        result_poly[exp] = poly1.get(exp, 0) + poly2.get(exp, 0)

    return result_poly

def format_polynomial(poly_dict):
    terms = []
    for exp in sorted(poly_dict.keys(), reverse=True):
        coef = poly_dict[exp]
        if coef == 0:
            continue
        sign = '+' if coef > 0 else '-'
        coef_str = str(abs(coef)) if abs(coef) != 1 or exp == 0 else ''
        if exp == 0:
            terms.append(f"{sign}{coef_str}")
        elif exp == 1:
            terms.append(f"{sign}{coef_str}x")
        else:
            terms.append(f"{sign}{coef_str}x**{exp}")
    formatted = ''.join(terms)
    return formatted.lstrip('+')  

# TEST CASES
test_cases = [
    ("x**3 + 5x**2 -3x + 3", "4x**5 - 2x**2 + 1"),
    ("-x**3 + 4x - 2", "3x**3 - 4x + 2"),
    ("2x**7 + x**2 - 5", "-2x**7 + 3x + 5"),
    ("x**2 - x + 1", "-x**2 + x - 1"),
    ("3x**4 + 2x**3 + x**2 + x + 1", "4x**3 + 2x + 9"),
    ("-5x**6 + 3x**2 - x + 4", "5x**6 - 3x**2 + x - 4"),
]

for i, (p1, p2) in enumerate(test_cases, 1):
    print(f"Test Case {i}:")
    print(f"  ({p1}) + ({p2})")
    result = add_polynomials(p1, p2)
    print(f"  = {format_polynomial(result)}\n")
