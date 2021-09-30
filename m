Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C21941D696
	for <lists+linux-edac@lfdr.de>; Thu, 30 Sep 2021 11:45:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349523AbhI3Jqo (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 30 Sep 2021 05:46:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:46514 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1349504AbhI3Jqo (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 30 Sep 2021 05:46:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8FB4861528;
        Thu, 30 Sep 2021 09:45:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632995101;
        bh=YEbjO2PVjYe4aLR6UTcioxMYW4qUoWftUtALRs+AOmA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hNJI2e9Oj5eL8k+VwX7deiWVQ1GfGFlpZ9TETSqTZPdXViAurzkqRU88G/MUYrhCH
         xJeOf24kjY8n0fwh/xQ0FcuR/PSXiHh/F9FnxHhnE+nfNloIszFRGERge0XpNmFqDC
         bZLCSDKzcBL2YWIKgJ+VZjapFmicmbqtCARbci97JK2Wmi+m1ZTn/qcghNlRLvNCAr
         eS08pCP1GOsKpp7AtUXU+nWhhal0IhT/NK3nJ2OQ365gOAb6VJ7Jjk1CG3HTX1ROZm
         XDCKKuH6FxR0DbnOhRLZGFwptIAtYGLWOJWPGa5XUzgdZhhW9WGU/sGet+OYoZNZ2i
         q1OLZoknw/UuQ==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1mVscd-002ATG-O9; Thu, 30 Sep 2021 11:44:59 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Jonathan Corbet" <corbet@lwn.net>, Borislav Petkov <bp@alien8.de>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tony Luck <tony.luck@intel.com>, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Andi Kleen <ak@linux.intel.com>
Subject: [PATCH v2 4/7] ABI: sysfs-mce: add a new ABI file
Date:   Thu, 30 Sep 2021 11:44:51 +0200
Message-Id: <801a26985e32589eb78ba4b728d3e19fdea18f04.1632994837.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1632994837.git.mchehab+huawei@kernel.org>
References: <cover.1632994837.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Reduce the gap of missing ABIs for Intel servers with MCE
by adding a new ABI file.

The contents of this file comes from:
	Documentation/x86/x86_64/machinecheck.rst

Cc: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---

See [PATCH v2 0/7] at: https://lore.kernel.org/all/cover.1632994837.git.mchehab+huawei@kernel.org/

 Documentation/ABI/testing/sysfs-mce       | 107 ++++++++++++++++++++++
 Documentation/x86/x86_64/machinecheck.rst |  56 +----------
 MAINTAINERS                               |   2 +
 3 files changed, 111 insertions(+), 54 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-mce

diff --git a/Documentation/ABI/testing/sysfs-mce b/Documentation/ABI/testing/sysfs-mce
new file mode 100644
index 000000000000..686fbfa02cdc
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-mce
@@ -0,0 +1,107 @@
+What:		/sys/devices/system/machinecheck/machinecheckX/
+Contact:	Andi Kleen <ak@linux.intel.com>
+Date:		Feb, 2007
+Description:
+		(X = CPU number)
+
+		Machine checks report internal hardware error conditions
+		detected by the CPU. Uncorrected errors typically cause a
+		machine check (often with panic), corrected ones cause a
+		machine check log entry.
+
+		For more details about the x86 machine check architecture
+		see the Intel and AMD architecture manuals from their
+		developer websites.
+
+		For more details about the architecture
+		see http://one.firstfloor.org/~andi/mce.pdf
+
+		Each CPU has its own directory.
+
+What:		/sys/devices/system/machinecheck/machinecheckX/bank<Y>
+Contact:	Andi Kleen <ak@linux.intel.com>
+Date:		Feb, 2007
+Description:
+		(Y bank number)
+
+		64bit Hex bitmask enabling/disabling specific subevents for
+		bank Y.
+
+		When a bit in the bitmask is zero then the respective
+		subevent will not be reported.
+
+		By default all events are enabled.
+
+		Note that BIOS maintain another mask to disable specific events
+		per bank.  This is not visible here
+
+What:		/sys/devices/system/machinecheck/machinecheckX/check_interval
+Contact:	Andi Kleen <ak@linux.intel.com>
+Date:		Feb, 2007
+Description:
+		The entries appear for each CPU, but they are truly shared
+		between all CPUs.
+
+		How often to poll for corrected machine check errors, in
+		seconds (Note output is hexadecimal). Default 5 minutes.
+		When the poller finds MCEs it triggers an exponential speedup
+		(poll more often) on the polling interval.  When the poller
+		stops finding MCEs, it triggers an exponential backoff
+		(poll less often) on the polling interval. The check_interval
+		variable is both the initial and maximum polling interval.
+		0 means no polling for corrected machine check errors
+		(but some corrected errors might be still reported
+		in other ways)
+
+What:		/sys/devices/system/machinecheck/machinecheckX/tolerant
+Contact:	Andi Kleen <ak@linux.intel.com>
+Date:		Feb, 2007
+Description:
+		The entries appear for each CPU, but they are truly shared
+		between all CPUs.
+
+		Tolerance level. When a machine check exception occurs for a
+		non corrected machine check the kernel can take different
+		actions.
+
+		Since machine check exceptions can happen any time it is
+		sometimes risky for the kernel to kill a process because it
+		defies normal kernel locking rules. The tolerance level
+		configures how hard the kernel tries to recover even at some
+		risk of	deadlock. Higher tolerant values trade potentially
+		better uptime with the risk of a crash or even corruption
+		(for tolerant >= 3).
+
+		==  ===========================================================
+		 0  always panic on uncorrected errors, log corrected errors
+		 1  panic or SIGBUS on uncorrected errors, log corrected errors
+		 2  SIGBUS or log uncorrected errors, log corrected errors
+		 3  never panic or SIGBUS, log all errors (for testing only)
+		==  ===========================================================
+
+		Default: 1
+
+		Note this only makes a difference if the CPU allows recovery
+		from a machine check exception. Current x86 CPUs generally
+		do not.
+
+What:		/sys/devices/system/machinecheck/machinecheckX/trigger
+Contact:	Andi Kleen <ak@linux.intel.com>
+Date:		Feb, 2007
+Description:
+		The entries appear for each CPU, but they are truly shared
+		between all CPUs.
+
+		Program to run when a machine check event is detected.
+		This is an alternative to running mcelog regularly from cron
+		and allows to detect events faster.
+
+What:		/sys/devices/system/machinecheck/machinecheckX/monarch_timeout
+Contact:	Andi Kleen <ak@linux.intel.com>
+Date:		Feb, 2007
+Description:
+		How long to wait for the other CPUs to machine check too on a
+		exception. 0 to disable waiting for other CPUs.
+
+		Unit: us
+
diff --git a/Documentation/x86/x86_64/machinecheck.rst b/Documentation/x86/x86_64/machinecheck.rst
index b402e04bee60..cea12ee97200 100644
--- a/Documentation/x86/x86_64/machinecheck.rst
+++ b/Documentation/x86/x86_64/machinecheck.rst
@@ -21,60 +21,8 @@ from /dev/mcelog. Normally mcelog should be run regularly from a cronjob.
 Each CPU has a directory in /sys/devices/system/machinecheck/machinecheckN
 (N = CPU number).
 
-The directory contains some configurable entries:
-
-bankNctl
-	(N bank number)
-
-	64bit Hex bitmask enabling/disabling specific subevents for bank N
-	When a bit in the bitmask is zero then the respective
-	subevent will not be reported.
-	By default all events are enabled.
-	Note that BIOS maintain another mask to disable specific events
-	per bank.  This is not visible here
-
-The following entries appear for each CPU, but they are truly shared
-between all CPUs.
-
-check_interval
-	How often to poll for corrected machine check errors, in seconds
-	(Note output is hexadecimal). Default 5 minutes.  When the poller
-	finds MCEs it triggers an exponential speedup (poll more often) on
-	the polling interval.  When the poller stops finding MCEs, it
-	triggers an exponential backoff (poll less often) on the polling
-	interval. The check_interval variable is both the initial and
-	maximum polling interval. 0 means no polling for corrected machine
-	check errors (but some corrected errors might be still reported
-	in other ways)
-
-tolerant
-	Tolerance level. When a machine check exception occurs for a non
-	corrected machine check the kernel can take different actions.
-	Since machine check exceptions can happen any time it is sometimes
-	risky for the kernel to kill a process because it defies
-	normal kernel locking rules. The tolerance level configures
-	how hard the kernel tries to recover even at some risk of
-	deadlock.  Higher tolerant values trade potentially better uptime
-	with the risk of a crash or even corruption (for tolerant >= 3).
-
-	0: always panic on uncorrected errors, log corrected errors
-	1: panic or SIGBUS on uncorrected errors, log corrected errors
-	2: SIGBUS or log uncorrected errors, log corrected errors
-	3: never panic or SIGBUS, log all errors (for testing only)
-
-	Default: 1
-
-	Note this only makes a difference if the CPU allows recovery
-	from a machine check exception. Current x86 CPUs generally do not.
-
-trigger
-	Program to run when a machine check event is detected.
-	This is an alternative to running mcelog regularly from cron
-	and allows to detect events faster.
-monarch_timeout
-	How long to wait for the other CPUs to machine check too on a
-	exception. 0 to disable waiting for other CPUs.
-	Unit: us
+The directory contains some configurable entries. See
+Documentation/ABI/testing/sysfs-mce for more details.
 
 TBD document entries for AMD threshold interrupt configuration
 
diff --git a/MAINTAINERS b/MAINTAINERS
index e9fd362ef4d6..360311ea0b43 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20457,6 +20457,8 @@ M:	Tony Luck <tony.luck@intel.com>
 M:	Borislav Petkov <bp@alien8.de>
 L:	linux-edac@vger.kernel.org
 S:	Maintained
+F:	Documentation/ABI/testing/sysfs-mce
+F:	Documentation/x86/x86_64/machinecheck.rst
 F:	arch/x86/kernel/cpu/mce/*
 
 X86 MICROCODE UPDATE SUPPORT
-- 
2.31.1

