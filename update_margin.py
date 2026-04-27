import os


def refactor_file(filepath):
    with open(filepath) as f:
        content = f.read()

    # Replacements
    content = content.replace("Costing", "Margin")
    content = content.replace("costing", "margin")
    content = content.replace("COSTING", "MARGIN")
    content = content.replace("CostingRequest", "MarginRequest")
    content = content.replace("CostingResponse", "MarginResponse")
    content = content.replace("costing_engine", "margin_engine")

    with open(filepath, "w") as f:
        f.write(content)


for root, _, files in os.walk("local_services/margin_engine"):
    for file in files:
        if file.endswith(".py") or file == "alembic.ini":
            refactor_file(os.path.join(root, file))
