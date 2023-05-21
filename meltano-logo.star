#
load("render.star", "render")
load("http.star", "http")
load("cache.star", "cache")

IMAGE_URL = "https://meltano.com/assets/logo/02/Meltano%20icon%20white.png"

def image_data(url):
    cached = cache.get(url)
    if cached:
        return cached

    response = http.get(url)

    if response.status_code != 200:
        fail("Image not found", url)

    data = response.body()
    cache.set(url, data)

    return data

def main(config):
    return render.Root(
        child=render.Box(
            child=render.Row(
                expanded=True,
                cross_align="center",
                children=[
                    render.Padding(
                        pad=(0,0,2,0),
                        child=render.Image(src=image_data(IMAGE_URL), height=20)
                    ),
                    render.Text("Meltano", font="6x13")
                ]
            )
        )
    )
