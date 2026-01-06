#!/usr/bin/env python3

from dataclasses import dataclass
import subprocess
import json
import os

@dataclass
class DotfileSpec:
    name: str
    location: str

    @staticmethod
    def from_dict(data: dict) -> DotfileSpec:
        if not isinstance(data, dict):
            raise ValueError("Input must be a dictionary")
        if len(data.keys()) != 2:
            raise ValueError("Dictionary must have exactly two keys: 'name' and 'location'")
        if "name" not in data or "location" not in data:
            raise ValueError("Dictionary must contain 'name' and 'location' keys")
        
        name = data["name"]
        location = data["location"]

        if "{HOME}" in location:
            location = location.format(HOME=os.environ['HOME'])

        return DotfileSpec(name=name, location=location)

    
def get_git_root() -> str:
    """returns the root of the git repository that this script is running in"""
    try:
        return subprocess.check_output(
            ["git", "rev-parse", "--show-toplevel"],
            text=True
        ).strip()
    except subprocess.CalledProcessError as e:
        raise RuntimeError("Error") from e


def read_dotfile_spec(file_path: str) -> list[dict[str, str]]: 
    with open(file_path, 'r') as f:
        contents = json.load(f)
        if not isinstance(contents, list):
            raise ValueError("Dotfile spec must be a list of dictionaries")
        return [DotfileSpec.from_dict(item) for item in contents]


def link_dotfile(dotfile: DotfileSpec):
    