import os
import hashlib


class Dolos:
    def __init__(self, source_folder, output_file, k=5, window_size=10):
        self.source_folder = source_folder
        self.output_file = output_file
        self.k = k
        self.window_size = window_size
        self.index = {}
        self.output_set = set()

    def tokenize_file(self, file_path):
        # Get tokens from a file
        with open(file_path, "r") as file:
            return [token.strip() for token in file.read().split()]

    def fingerprint_file(self, file_path):
        # Tokenize the file content
        tokens = self.tokenize_file(file_path)
        fingerprints = set()

        # Generate k-grams and hash them
        for i in range(len(tokens) - self.k + 1):
            kgram = tuple(tokens[i : i + self.k])
            # Using SHA-256 hash for simplicity
            hash_value = hashlib.sha256(str(kgram).encode()).hexdigest()[:8]
            fingerprints.add(hash_value)

        return fingerprints

    def index_file(self, file_path):
        # Generate and store fingerprints in the index
        fingerprints = self.fingerprint_file(file_path)

        for fingerprint in fingerprints:
            if fingerprint in self.index:
                self.index[fingerprint].append((file_path, fingerprints))
            else:
                self.index[fingerprint] = [(file_path, fingerprints)]

    def process_folder(self):
        # Process all files in the specified folder
        files = os.listdir(self.source_folder)

        for file in files:
            file_path = os.path.join(self.source_folder, file)
            if os.path.isfile(file_path):
                self.index_file(file_path)

    def report_duplicates(self):
        with open(self.output_file, "w") as output:
            for fingerprint, occurrences in self.index.items():
                if len(occurrences) > 1:
                    for i in range(len(occurrences)):
                        for j in range(i + 1, len(occurrences)):
                            file1, fingerprints1 = occurrences[i]
                            file2, fingerprints2 = occurrences[j]

                            common_fingerprints = set(fingerprints1).intersection(
                                fingerprints2
                            )
                            similarity = len(common_fingerprints) / (
                                len(fingerprints1)
                                + len(fingerprints2)
                                - len(common_fingerprints)
                            )
                            total_overlap = len(common_fingerprints)

                            if similarity < 0.3 or total_overlap < 10:
                                continue

                            if (file1, file2) in self.output_set or (
                                file2,
                                file1,
                            ) in self.output_set:
                                continue

                            self.output_set.add((file1, file2))

                            output.write(f"  - Files: {file1} and {file2}\n")
                            output.write(f"    Similarity: {similarity:.2%}\n")
                            output.write(f"    Total Overlap: {total_overlap}\n")
                            output.write("\n")


def main():
    source_folder = "compiled"
    output_file = "output.txt"  # Specify the desired output file
    dolos = Dolos(source_folder, output_file, k=5, window_size=10)
    dolos.process_folder()
    dolos.report_duplicates()


if __name__ == "__main__":
    main()
