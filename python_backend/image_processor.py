from PIL import Image


def convert_png_to_pixel_svg(image_path, output_path):
    """
    Converts a PNG image to a pixel-perfect SVG file.

    Each non-transparent pixel is converted into a 1x1 <rect> element.
    Pixels that are pure black (#000000) or pure white (#FFFFFF) are also
    treated as transparent.

    Args:
        image_path (str): The path to the input PNG file.
        output_path (str): The path where the output SVG file will be saved.
    """
    try:
        img = Image.open(image_path)
        # Ensure the image is in RGBA format to handle transparency
        img = img.convert("RGBA")
    except FileNotFoundError:
        print(f"Erro: O arquivo de imagem não foi encontrado em '{image_path}'")
        return

    width, height = img.size
    pixels = img.load()

    svg_elements = []

    # Start the SVG file content
    svg_header = f'<svg xmlns="http://www.w3.org/2000/svg" width="{width}" height="{height}" viewBox="0 0 {width} {height}" shape-rendering="crispEdges">'
    svg_elements.append(svg_header)

    for y in range(height):
        for x in range(width):
            r, g, b, a = pixels[x, y]

            # Rule 1: Skip fully transparent pixels (from original alpha channel)
            if a == 0:
                continue

            # Rule 2: Skip pure black pixels
            if r == 0 and g == 0 and b == 0:
                continue

            # Rule 3: Skip pure white pixels
            if r == 255 and g == 255 and b == 255:
                continue

            # If we reach here, the pixel is visible and should be drawn
            hex_color = f'#{r:02x}{g:02x}{b:02x}'

            # Calculate opacity from the alpha channel
            opacity = a / 255.0

            # Create the <rect> element for the pixel
            # Optimization: if opacity is 1.0, no need to specify fill-opacity
            if opacity == 1.0:
                svg_elements.append(f'<rect x="{x}" y="{y}" width="1" height="1" fill="{hex_color}" />')
            else:
                # Use fill-opacity for partially transparent pixels
                svg_elements.append(
                    f'<rect x="{x}" y="{y}" width="1" height="1" fill="{hex_color}" fill-opacity="{opacity:.4f}" />')

    # Close the SVG tag
    svg_elements.append('</svg>')

    # Join all parts into a single string
    full_svg_code = "".join(svg_elements)

    # Write the SVG code to the output file
    try:
        with open(output_path, 'w') as f:
            f.write(full_svg_code)
        print(f"Missão cumprida. O arquivo SVG foi gerado com sucesso em: '{output_path}'")

        # Print a summary and snippet of the generated code
        num_elements = len(svg_elements) - 2  # Subtract header and footer
        num_lines = full_svg_code.count('>')  # A rough estimate of lines
        print(f"O SVG contém {num_elements} elementos <rect> e tem aproximadamente {num_lines} linhas de código.")

        print("\n--- INÍCIO DO CÓDIGO SVG GERADO (AMOSTRA) ---")
        # Show the header and the first few rects
        print("".join(svg_elements[:10]) + "...")
        print("\n--- FIM DO CÓDIGO SVG GERADO (AMOSTRA) ---")
        # Show the last few rects and the footer
        print("..." + "".join(svg_elements[-10:]))

    except IOError:
        print(f"Erro: Não foi possível escrever o arquivo em '{output_path}'")


# --- EXECUTION ---
input_image_file = 'input_file_0.png'
output_svg_file = 'vytruve.svg'
convert_png_to_pixel_svg(input_image_file, output_svg_file)