Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EFA737BCF5
	for <lists+linux-edac@lfdr.de>; Wed, 12 May 2021 14:51:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231422AbhELMw4 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 12 May 2021 08:52:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:52158 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231293AbhELMwu (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 12 May 2021 08:52:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 306C1613CF;
        Wed, 12 May 2021 12:51:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620823902;
        bh=Tbm1lU5lr00378ByC1nMvAs2HAItbU4kcrpdqRshg3w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WWcChBZ5QwAuyJyX/8U3XsMMjLRnJYA79eUSinMRZflN+8V/2sCH+vBle37aIDXbm
         yS/DMVV6WVUSRZD/C/AsYrd2BPGTF08QgXZMymi2fy2kKgZeAPI1qQf46+Tn4WI/KJ
         2hkGH8wdJxOcvXQ8Mm376bB9Fs3sKP7EkiCAuf/6D8MQzELQWBLo3SQJYrwYLurJ50
         b5X1rbpfHPcwJoXF+Q/dwV0KxTSU4/52HXl+0osoO1ZLvZkkfKsHQZGvo+EKjuXMFA
         AdimOyisxtcYO5T7qbW+5beinFl0mxHEau8P0hk66bZShg6hND6AuREwykMW+a9nUJ
         rcB5kzPLtdUXA==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1lgoKy-0018gu-4M; Wed, 12 May 2021 14:51:40 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>, Borislav Petkov <bp@alien8.de>,
        James Morse <james.morse@arm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Richter <rric@kernel.org>,
        Thorsten Leemhuis <linux@leemhuis.info>,
        Tony Luck <tony.luck@intel.com>, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 02/40] docs: admin-guide: Use ASCII subset instead of UTF-8 alternate symbols
Date:   Wed, 12 May 2021 14:50:06 +0200
Message-Id: <a0e9db59df5dafa9fbd5f2f3a9d39a9fa2864726.1620823573.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1620823573.git.mchehab+huawei@kernel.org>
References: <cover.1620823573.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

The conversion tools used during DocBook/LaTeX/Markdown->ReST conversion
and some automatic rules which exists on certain text editors like
LibreOffice turned ASCII characters into some UTF-8 alternatives that
are better displayed on html and PDF.

While it is OK to use UTF-8 characters in Linux, it is better to
use the ASCII subset instead of using an UTF-8 equivalent character
as it makes life easier for tools like grep, and are easier to edit
with the some commonly used text/source code editors.

Also, Sphinx already do such conversion automatically outside literal blocks:
   https://docutils.sourceforge.io/docs/user/smartquotes.html

So, replace the occurences of the following UTF-8 characters:

	- U+00a0 (' '): NO-BREAK SPACE

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/admin-guide/ras.rst             | 86 +++++++++----------
 .../admin-guide/reporting-issues.rst          |  2 +-
 2 files changed, 44 insertions(+), 44 deletions(-)

diff --git a/Documentation/admin-guide/ras.rst b/Documentation/admin-guide/ras.rst
index 7b481b2a368e..e1adbd27d1d8 100644
--- a/Documentation/admin-guide/ras.rst
+++ b/Documentation/admin-guide/ras.rst
@@ -443,49 +443,49 @@ A typical EDAC system has the following structure under
 
 	/sys/devices/system/edac/
 	├── mc
-	│   ├── mc0
-	│   │   ├── ce_count
-	│   │   ├── ce_noinfo_count
-	│   │   ├── dimm0
-	│   │   │   ├── dimm_ce_count
-	│   │   │   ├── dimm_dev_type
-	│   │   │   ├── dimm_edac_mode
-	│   │   │   ├── dimm_label
-	│   │   │   ├── dimm_location
-	│   │   │   ├── dimm_mem_type
-	│   │   │   ├── dimm_ue_count
-	│   │   │   ├── size
-	│   │   │   └── uevent
-	│   │   ├── max_location
-	│   │   ├── mc_name
-	│   │   ├── reset_counters
-	│   │   ├── seconds_since_reset
-	│   │   ├── size_mb
-	│   │   ├── ue_count
-	│   │   ├── ue_noinfo_count
-	│   │   └── uevent
-	│   ├── mc1
-	│   │   ├── ce_count
-	│   │   ├── ce_noinfo_count
-	│   │   ├── dimm0
-	│   │   │   ├── dimm_ce_count
-	│   │   │   ├── dimm_dev_type
-	│   │   │   ├── dimm_edac_mode
-	│   │   │   ├── dimm_label
-	│   │   │   ├── dimm_location
-	│   │   │   ├── dimm_mem_type
-	│   │   │   ├── dimm_ue_count
-	│   │   │   ├── size
-	│   │   │   └── uevent
-	│   │   ├── max_location
-	│   │   ├── mc_name
-	│   │   ├── reset_counters
-	│   │   ├── seconds_since_reset
-	│   │   ├── size_mb
-	│   │   ├── ue_count
-	│   │   ├── ue_noinfo_count
-	│   │   └── uevent
-	│   └── uevent
+	│   ├── mc0
+	│   │   ├── ce_count
+	│   │   ├── ce_noinfo_count
+	│   │   ├── dimm0
+	│   │   │   ├── dimm_ce_count
+	│   │   │   ├── dimm_dev_type
+	│   │   │   ├── dimm_edac_mode
+	│   │   │   ├── dimm_label
+	│   │   │   ├── dimm_location
+	│   │   │   ├── dimm_mem_type
+	│   │   │   ├── dimm_ue_count
+	│   │   │   ├── size
+	│   │   │   └── uevent
+	│   │   ├── max_location
+	│   │   ├── mc_name
+	│   │   ├── reset_counters
+	│   │   ├── seconds_since_reset
+	│   │   ├── size_mb
+	│   │   ├── ue_count
+	│   │   ├── ue_noinfo_count
+	│   │   └── uevent
+	│   ├── mc1
+	│   │   ├── ce_count
+	│   │   ├── ce_noinfo_count
+	│   │   ├── dimm0
+	│   │   │   ├── dimm_ce_count
+	│   │   │   ├── dimm_dev_type
+	│   │   │   ├── dimm_edac_mode
+	│   │   │   ├── dimm_label
+	│   │   │   ├── dimm_location
+	│   │   │   ├── dimm_mem_type
+	│   │   │   ├── dimm_ue_count
+	│   │   │   ├── size
+	│   │   │   └── uevent
+	│   │   ├── max_location
+	│   │   ├── mc_name
+	│   │   ├── reset_counters
+	│   │   ├── seconds_since_reset
+	│   │   ├── size_mb
+	│   │   ├── ue_count
+	│   │   ├── ue_noinfo_count
+	│   │   └── uevent
+	│   └── uevent
 	└── uevent
 
 In the ``dimmX`` directories are EDAC control and attribute files for
diff --git a/Documentation/admin-guide/reporting-issues.rst b/Documentation/admin-guide/reporting-issues.rst
index 18d8e25ba9df..d7ac13f789cc 100644
--- a/Documentation/admin-guide/reporting-issues.rst
+++ b/Documentation/admin-guide/reporting-issues.rst
@@ -1248,7 +1248,7 @@ paragraph makes the severeness obvious.
 
 In case you performed a successful bisection, use the title of the change that
 introduced the regression as the second part of your subject. Make the report
-also mention the commit id of the culprit. In case of an unsuccessful bisection,
+also mention the commit id of the culprit. In case of an unsuccessful bisection,
 make your report mention the latest tested version that's working fine (say 5.7)
 and the oldest where the issue occurs (say 5.8-rc1).
 
-- 
2.30.2

