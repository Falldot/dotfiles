return {
	cmd = {"node", script_path, "--stdio"},
    filetypes = {"vue"},
    root_dir = util.root_pattern("package.json", ".git/");
    init_options = {
		typescript = {
			serverPath = tslib_path
		},
		languageFeatures = {
			references =  true,
			definition = true,
			typeDefinition = true,
			callHierarchy = true,
			hover = true,
			rename = true,
			renameFileRefactoring = true,
			signatureHelp = true,
			codeAction = true,
			completion = {
				defaultTagNameCase = 'both',
				defaultAttrNameCase = 'kebabCase',
				getDocumentNameCasesRequest = false,
				getDocumentSelectionRequest = false,
			},
			schemaRequestService = true,
			documentHighlight = true,
			documentLink = true,
			codeLens = { showReferencesNotification = true },
			semanticTokens = true,
			diagnostics = true,
		},
		documentFeatures = {
			selectionRange = false,
			foldingRange = false,
			linkedEditingRange = true,
			documentSymbol = true,
			documentColor = true,
			documentFormatting = {
				defaultPrintWidth = 100,
				getDocumentPrintWidthRequest = true,
			},
		},
	},
    settings = {
		['volar-api'] = {
			trace = {
				server = "off"
			}
		},
		['volar-document'] = {
			trace = {
				server = "off"
			}
		},
		['volar-html'] = {
			trace = {
				server = "off"
			}
		},
		volar = {
			codeLens = {
				references = true,
				pugTools = true,
				scriptSetupTools = true,
			},
			tagNameCase = 'both',
			attrNameCase = 'kebab',
			formatting = {
				printWidth = 100
			},
			autoCompleteRefs = true,
			preferredTagNameCase = 'auto',
			preferredAttrNameCase = 'auto-kebab',
		}
	}
}