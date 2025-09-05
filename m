Return-Path: <linux-edac+bounces-4729-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 325FAB44ED1
	for <lists+linux-edac@lfdr.de>; Fri,  5 Sep 2025 09:14:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C77D617D0C8
	for <lists+linux-edac@lfdr.de>; Fri,  5 Sep 2025 07:14:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2836B2D46D9;
	Fri,  5 Sep 2025 07:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nrSD0tXw"
X-Original-To: linux-edac@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEF862D3A8A;
	Fri,  5 Sep 2025 07:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757056464; cv=none; b=SAWbZI5FGae6lR1uKf+EBOPavdWq1sO1EeQ5poc8H9B/1BWyCRoW3xgBIgJNYqxCWEfzHAK/l/DjmNInqhcslysa/Cjp8SUPKNzREw+aqk9vG3aAtjQiKn5putlwm7rVbDw7qFHfhG2O3uvUTrKpXaGJcOuBrvYtwchM4RPMvkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757056464; c=relaxed/simple;
	bh=i36iL+KR7T7uZpLSbsJEopmHE0PSVOySVwlmjmxdzKo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=C9tudciOaC8XAioZvPvQk2cDfvF+gdgimm2FRHbpMVhRyqxPHbxQrwux4lyBFRwZD3bdjwU7FSLBRm9asoFAHR0hJPcBBZBbgqNKJSXObOKTsZy3VbmDYg2FBae3sSnBPMM1dOUo6lOk3QuXRhRGXoYX5U+XRj33Pq5ItIC1cyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nrSD0tXw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86B3CC4CEF1;
	Fri,  5 Sep 2025 07:14:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757056463;
	bh=i36iL+KR7T7uZpLSbsJEopmHE0PSVOySVwlmjmxdzKo=;
	h=Date:From:To:Cc:Subject:From;
	b=nrSD0tXwtr2Yh1WmtvrkbYVD6OdnGHNJRibQrTfQxvkXrwV4OIkdLex+XPX02JlCY
	 gP7eLtKIOzQKP+CN813MJczPTT/3jYXu29IuQR/3DtTcfJPSlj97VKxG+HsayT9q+3
	 UZpgBRDuZ8bdk2qniqyF0vHOz5myfV+7xo2Uu1Nc5ngWsv/f/5pZ7l6n66JSAJwuRM
	 02Fpwu5KAFVCsqz9Mt+d2595brCMvo0mqRST59KdV2qxBBZGzgQ38Ki3Ci7T69072E
	 0adZr8zFdJtgZdLfLJudW/dRMDvfsgvOFhYeSh9YX+auBadcmWcdXTvTXBj++iH/UC
	 nGVXlkAtg4PFg==
Date: Fri, 5 Sep 2025 09:14:17 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>
Cc: EDAC Mailing List <linux-edac@vger.kernel.org>, Linux Kernel Mailing
 List <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] v4: Split sphinx call logic from docs Makefile
Message-ID: <20250905091417.13181d6f@foz.lan>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Jon,

As patch 04/19 do some changes on non-English documents, perhaps the best
is for you to pick the series as a pull request. The content here
is identical to:

	https://lore.kernel.org/linux-doc/cover.1756969623.git.mchehab+huawei@kernel.org/

so, I'll just repeat the description below.

-

This series does a major cleanup at docs Makefile by moving the
actual doc build logic to a helper script (scripts/sphinx-build-wrapper).

Such script was written in a way that it can be called either
directly or via a makefile. When running via makefile, it will
use GNU jobserver to ensure that, when sphinx-build is
called, the number of jobs will match at most what it is
specified by the "-j" parameter.

The first 3 patches do a cleanup at scripts/jobserver-exec
and moves the actual code to a library. Such library is used
by both the jobserver-exec command line and by sphinx-build-wrappper.

The change also gets rid of parallel-wrapper.sh, whose
functions are now part of the wrapper code.

I opted to pick patches from:
   https://lore.kernel.org/linux-doc/cover.1756916565.git.mchehab+huawei@kernel.org/T/#t

re-ordering them to make more sense.

The last patch breaks doc build when Python3 < 3.7, as requested,
or when sphinx-pre-install suggests to install an updated Sphinx
version. Matteu suggested adding a PYTHON env to allow overriding it,
but this won't would work with sphinx-pre-install, which is meant to
be executed with older python versions, but still requires to run
python from the suggested package to check if package install
succeded. Currently, sphinx-pre-install recomments to install a newer
Python on 3 distribution types:

    - 3.11 on openSuse Leap;
    - 3.9 on RHEL8 and RHEL8-based distros;
    - 3.13 on openSUSE Thumbleweed.

Patch 19 breaks sphinx-pre-install for those, and adding PYTHON
env won't properly fix it. ATM, I can't think on a good non-hacky
solution, as the only way I can think is to let sphinx-pre-install
(and sphinx-build-wrapper) execute python3.x instead of python3.

---

v4:
- updated references for sphinx-pre-install after its rename;
- added some extra patches to add more options to python_version,
  allowing it to bail out and suggest alternatives;
- added a patch at the end to explicitly break doc builds when
  python3 points to python3.6 or older.

v3:
- rebased on the top of docs-next;
- added two patches to build man files that were on a separate
  patch series.

v2:

- there's no generic exception handler anymore;
- it moves sphinx-pre-install to tools/docs;
- the logic which ensures a minimal Python version got moved
  to a library, which is now used by both pre-install and wrapper;
- The first wrapper (05/13) doesn't contain comments (except for
  shebang and SPDX). The goal is to help showing the size increase
  when moving from Makefile to Python. Some file increase is
  unavoidable, as Makefile is more compact: no includes, multple
  statements per line, no argparse, etc;
- The second patch adds docstrings and comments. It has almost
  the same size of the code itself;
- I moved the venv logic to a third wrapper patch;
- I fixed an issue at the paraller build logic;
- There are no generic except blocks anymore.

Please pull from:

	git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-docs.git docs/v6.17-2

For:

{ADD CONTENT HERE}

Regards,
Mauro

---

The following changes since commit 7e5a0fe4e8ae2eb341f8ebbee2b24231a58fc28b:

  doc: filesystems: proc: remove stale information from intro (2025-09-03 16:04:43 -0600)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-docs.git tags/docs/v6.17-2

for you to fetch changes up to 04de72da80bbb19e38e2b416de56a9cb179f25e9:

  tools/docs: sphinx-* break documentation bulds on openSUSE (2025-09-04 21:07:43 +0200)

----------------------------------------------------------------
[GIT PULL for v6.17-rc5] docs fixes

----------------------------------------------------------------
Mauro Carvalho Chehab (19):
      scripts/jobserver-exec: move the code to a class
      scripts/jobserver-exec: move its class to the lib directory
      scripts/jobserver-exec: add a help message
      scripts: sphinx-pre-install: move it to tools/docs
      tools/docs: python_version: move version check from sphinx-pre-install
      tools/docs: python_version: drop a debug print
      tools/docs: python_version: allow check for alternatives and bail out
      tools/docs: sphinx-build-wrapper: add a wrapper for sphinx-build
      tools/docs: sphinx-build-wrapper: add comments and blank lines
      tools/docs: sphinx-build-wrapper: add support to run inside venv
      docs: parallel-wrapper.sh: remove script
      docs: Makefile: document latex/PDF PAPER= parameter
      tools/docs: sphinx-build-wrapper: add an argument for LaTeX interactive mode
      tools/docs,scripts: sphinx-*: prevent sphinx-build crashes
      tools/docs: sphinx-build-wrapper: allow building PDF files in parallel
      docs: add support to build manpages from kerneldoc output
      tools: kernel-doc: add a see also section at man pages
      scripts: kdoc_parser.py: warn about Python version only once
      tools/docs: sphinx-* break documentation bulds on openSUSE

 Documentation/Makefile                             | 136 +---
 Documentation/doc-guide/kernel-doc.rst             |  29 +-
 Documentation/doc-guide/sphinx.rst                 |   4 +-
 Documentation/sphinx/kerneldoc-preamble.sty        |   2 +-
 Documentation/sphinx/parallel-wrapper.sh           |  33 -
 .../translations/it_IT/doc-guide/sphinx.rst        |   4 +-
 .../translations/zh_CN/doc-guide/sphinx.rst        |   4 +-
 Documentation/translations/zh_CN/how-to.rst        |   2 +-
 MAINTAINERS                                        |   3 +-
 Makefile                                           |   2 +-
 scripts/jobserver-exec                             |  88 +--
 scripts/lib/jobserver.py                           | 149 +++++
 scripts/lib/kdoc/kdoc_files.py                     |   5 +-
 scripts/lib/kdoc/kdoc_output.py                    |  84 ++-
 scripts/lib/kdoc/kdoc_parser.py                    |   7 +-
 scripts/split-man.pl                               |  28 -
 tools/docs/lib/python_version.py                   | 178 +++++
 tools/docs/sphinx-build-wrapper                    | 739 +++++++++++++++++++++
 {scripts => tools/docs}/sphinx-pre-install         | 135 +---
 19 files changed, 1265 insertions(+), 367 deletions(-)
 delete mode 100644 Documentation/sphinx/parallel-wrapper.sh
 create mode 100755 scripts/lib/jobserver.py
 delete mode 100755 scripts/split-man.pl
 create mode 100644 tools/docs/lib/python_version.py
 create mode 100755 tools/docs/sphinx-build-wrapper
 rename {scripts => tools/docs}/sphinx-pre-install (93%)

