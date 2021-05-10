Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6176D37821A
	for <lists+linux-edac@lfdr.de>; Mon, 10 May 2021 12:31:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232060AbhEJKc2 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 10 May 2021 06:32:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:60688 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231648AbhEJKab (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Mon, 10 May 2021 06:30:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9377861613;
        Mon, 10 May 2021 10:27:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620642443;
        bh=XHzj5aSxorO5uU/1ApNHopp9jumH8yovnm0BxDgFln0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Pz/ChaWCMw+w1lZO83ALpU24JGfp2mpIpBCJioBWpa7nWam3Vs3EisfZAoMBlx7Bo
         wucWA6VXTj32O/EHszcM4r/iBt4jwtRtF4NH5ytUo2K3OKF+Yba9TLioPSubOx1ZYL
         nCaQb4JHeTDUkoBDv5vENRs4Ha0EWW3+I7COOWVhNVeT6CfKJAbvcT8Bj806RoolF5
         SkAAaiETWD9JirctAEvUSBg6j0lHZc8JeEwd3GS301rCWOLI8BoRhuiY3mh+L/SxKK
         aDrls1VlS0dZuUnJp1Fpd+l3Cgy7Y8mp4r7OT7xX4S2aAOau7tHbYd4UHHY5xHlQoF
         VdqMP+2Q6DnYA==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1lg38C-000UOi-Ji; Mon, 10 May 2021 12:27:20 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>,
        "Jonathan Corbet" <corbet@lwn.net>, Arnd Bergmann <arnd@arndb.de>,
        Borislav Petkov <bp@alien8.de>,
        David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        James Morse <james.morse@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Richter <rric@kernel.org>,
        Thorsten Leemhuis <linux@leemhuis.info>,
        Tony Luck <tony.luck@intel.com>, keyrings@vger.kernel.org,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 06/53] docs: admin-guide: avoid using UTF-8 chars
Date:   Mon, 10 May 2021 12:26:18 +0200
Message-Id: <4b372b47487992fa0b4036b4bfbb6c879f497786.1620641727.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1620641727.git.mchehab+huawei@kernel.org>
References: <cover.1620641727.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

While UTF-8 characters can be used at the Linux documentation,
the best is to use them only when ASCII doesn't offer a good replacement.
So, replace the occurences of the following UTF-8 characters:

	- U+00a0 (' '): NO-BREAK SPACE
	- U+2013 ('–'): EN DASH
	- U+2014 ('—'): EM DASH

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/admin-guide/index.rst           |  2 +-
 Documentation/admin-guide/module-signing.rst  |  4 +-
 Documentation/admin-guide/ras.rst             | 94 +++++++++----------
 .../admin-guide/reporting-issues.rst          | 12 +--
 4 files changed, 56 insertions(+), 56 deletions(-)

diff --git a/Documentation/admin-guide/index.rst b/Documentation/admin-guide/index.rst
index dc00afcabb95..b1692643718d 100644
--- a/Documentation/admin-guide/index.rst
+++ b/Documentation/admin-guide/index.rst
@@ -3,7 +3,7 @@ The Linux kernel user's and administrator's guide
 
 The following is a collection of user-oriented documents that have been
 added to the kernel over time.  There is, as yet, little overall order or
-organization here — this material was not written to be a single, coherent
+organization here - this material was not written to be a single, coherent
 document!  With luck things will improve quickly over time.
 
 This initial section contains overall information, including the README
diff --git a/Documentation/admin-guide/module-signing.rst b/Documentation/admin-guide/module-signing.rst
index 7d7c7c8a545c..bd1d2fef78e8 100644
--- a/Documentation/admin-guide/module-signing.rst
+++ b/Documentation/admin-guide/module-signing.rst
@@ -100,8 +100,8 @@ This has a number of options available:
      ``certs/signing_key.pem`` will disable the autogeneration of signing keys
      and allow the kernel modules to be signed with a key of your choosing.
      The string provided should identify a file containing both a private key
-     and its corresponding X.509 certificate in PEM form, or — on systems where
-     the OpenSSL ENGINE_pkcs11 is functional — a PKCS#11 URI as defined by
+     and its corresponding X.509 certificate in PEM form, or - on systems where
+     the OpenSSL ENGINE_pkcs11 is functional - a PKCS#11 URI as defined by
      RFC7512. In the latter case, the PKCS#11 URI should reference both a
      certificate and a private key.
 
diff --git a/Documentation/admin-guide/ras.rst b/Documentation/admin-guide/ras.rst
index 7b481b2a368e..00445adf8708 100644
--- a/Documentation/admin-guide/ras.rst
+++ b/Documentation/admin-guide/ras.rst
@@ -40,10 +40,10 @@ it causes data loss or system downtime.
 
 Among the monitoring measures, the most usual ones include:
 
-* CPU – detect errors at instruction execution and at L1/L2/L3 caches;
-* Memory – add error correction logic (ECC) to detect and correct errors;
-* I/O – add CRC checksums for transferred data;
-* Storage – RAID, journal file systems, checksums,
+* CPU - detect errors at instruction execution and at L1/L2/L3 caches;
+* Memory - add error correction logic (ECC) to detect and correct errors;
+* I/O - add CRC checksums for transferred data;
+* Storage - RAID, journal file systems, checksums,
   Self-Monitoring, Analysis and Reporting Technology (SMART).
 
 By monitoring the number of occurrences of error detections, it is possible
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
index 18d8e25ba9df..f691930e13c0 100644
--- a/Documentation/admin-guide/reporting-issues.rst
+++ b/Documentation/admin-guide/reporting-issues.rst
@@ -824,7 +824,7 @@ and look a little lower at the table. At its top you'll see a line starting with
 mainline, which most of the time will point to a pre-release with a version
 number like '5.8-rc2'. If that's the case, you'll want to use this mainline
 kernel for testing, as that where all fixes have to be applied first. Do not let
-that 'rc' scare you, these 'development kernels' are pretty reliable — and you
+that 'rc' scare you, these 'development kernels' are pretty reliable - and you
 made a backup, as you were instructed above, didn't you?
 
 In about two out of every nine to ten weeks, mainline might point you to a
@@ -866,7 +866,7 @@ How to obtain a fresh Linux kernel
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 **Using a pre-compiled kernel**: This is often the quickest, easiest, and safest
-way for testing — especially is you are unfamiliar with the Linux kernel. The
+way for testing - especially is you are unfamiliar with the Linux kernel. The
 problem: most of those shipped by distributors or add-on repositories are build
 from modified Linux sources. They are thus not vanilla and therefore often
 unsuitable for testing and issue reporting: the changes might cause the issue
@@ -1248,7 +1248,7 @@ paragraph makes the severeness obvious.
 
 In case you performed a successful bisection, use the title of the change that
 introduced the regression as the second part of your subject. Make the report
-also mention the commit id of the culprit. In case of an unsuccessful bisection,
+also mention the commit id of the culprit. In case of an unsuccessful bisection,
 make your report mention the latest tested version that's working fine (say 5.7)
 and the oldest where the issue occurs (say 5.8-rc1).
 
@@ -1345,7 +1345,7 @@ about it to a chatroom or forum you normally hang out.
 
 **Be patient**: If you are really lucky you might get a reply to your report
 within a few hours. But most of the time it will take longer, as maintainers
-are scattered around the globe and thus might be in a different time zone – one
+are scattered around the globe and thus might be in a different time zone - one
 where they already enjoy their night away from keyboard.
 
 In general, kernel developers will take one to five business days to respond to
@@ -1388,7 +1388,7 @@ Here are your duties in case you got replies to your report:
 
 **Check who you deal with**: Most of the time it will be the maintainer or a
 developer of the particular code area that will respond to your report. But as
-issues are normally reported in public it could be anyone that's replying —
+issues are normally reported in public it could be anyone that's replying -
 including people that want to help, but in the end might guide you totally off
 track with their questions or requests. That rarely happens, but it's one of
 many reasons why it's wise to quickly run an internet search to see who you're
@@ -1716,7 +1716,7 @@ Maybe their test hardware broke, got replaced by something more fancy, or is so
 old that it's something you don't find much outside of computer museums
 anymore. Sometimes developer stops caring for their code and Linux at all, as
 something different in their life became way more important. In some cases
-nobody is willing to take over the job as maintainer – and nobody can be forced
+nobody is willing to take over the job as maintainer - and nobody can be forced
 to, as contributing to the Linux kernel is done on a voluntary basis. Abandoned
 drivers nevertheless remain in the kernel: they are still useful for people and
 removing would be a regression.
-- 
2.30.2

