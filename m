Return-Path: <linux-edac+bounces-5708-lists+linux-edac=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-edac@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YFc3LxJ3jGk6ogAAu9opvQ
	(envelope-from <linux-edac+bounces-5708-lists+linux-edac=lfdr.de@vger.kernel.org>)
	for <lists+linux-edac@lfdr.de>; Wed, 11 Feb 2026 13:33:22 +0100
X-Original-To: lists+linux-edac@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FFF01244EC
	for <lists+linux-edac@lfdr.de>; Wed, 11 Feb 2026 13:33:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F19D8301AD38
	for <lists+linux-edac@lfdr.de>; Wed, 11 Feb 2026 12:31:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6555C1B86C7;
	Wed, 11 Feb 2026 12:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LrJsFyxY"
X-Original-To: linux-edac@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40EAA1A9FA4;
	Wed, 11 Feb 2026 12:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770813112; cv=none; b=aaWsxf/j4iWMnkK44Lx+vSGhX+wst7J8pXAdUX7cLwhoHUyPklmbkrN/D/2cE/gLRs5AriuOENkBkzTGk13fzWQ5G6IjbtPLPNMascRPJgbi/ysOnJU1Yl1RUgV0payPiCp3eMEwj71R6FePg05KvBISVOjSupXJlBhYr4FooWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770813112; c=relaxed/simple;
	bh=fWc+yI9j0lSz7fCX+GS7zg59rPJR8cs68Fsty0UB8zI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IK7qrMnclaTnniH13GuX34fDOYjK9W91+kyYqslHjvCxhm3g2w3hbjz+7vWd3eYsyJovNANVbh+IFi6MS7rLl8XqTUu33AtYhlkPwnY1WLdHr3+ayK48Vl0mWiDoUZZsOEYpGWs1/yP8DNEZBDdQv8Zlb2BYM4d0/jSH06nINYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LrJsFyxY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A70AC19421;
	Wed, 11 Feb 2026 12:31:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770813112;
	bh=fWc+yI9j0lSz7fCX+GS7zg59rPJR8cs68Fsty0UB8zI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LrJsFyxYSl/AXZiQ1bMz8gWqr4WLV3EXmRnOxiwG2i6kqqnxOK0u9Tx4JHbji2OlA
	 S0XW9JKRYjtFkGj/0GbLpxXFtZA8Y0Zlveup+RGuWzHph6xIY5jymikPC3HLsGM23j
	 Ru8DL6lniMY3ZsIhw7el/lWMKjM38hb/FPjpXc5qsK5UOSSJ/6cmyF7DDDsUzpL7t7
	 9ED4KD1M4m+IbnNt00zX3Sm+oNZldXyhIQmNbUML/dTyHxhPYIj2Qd6QhQtfhisS+G
	 y1WZIf9mwgKqo/xqCjtt4tFSrR6pDAfIzZT/dsTMYgKNKFNq71Hh6LJ+7boEaDxogB
	 aK0vTqZKaCflw==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Hanjun Guo <guohanjun@huawei.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	rafael@kernel.org,
	bp@alien8.de,
	xueshuai@linux.alibaba.com,
	fabio.m.de.francesco@linux.intel.com,
	leitao@debian.org,
	pengdonglin@xiaomi.com,
	Smita.KoralahalliChannabasappa@amd.com,
	jason@os.amperecomputing.com,
	linux-acpi@vger.kernel.org,
	linux-edac@vger.kernel.org
Subject: [PATCH AUTOSEL 6.19-6.12] APEI/GHES: ARM processor Error: don't go past allocated memory
Date: Wed, 11 Feb 2026 07:30:29 -0500
Message-ID: <20260211123112.1330287-19-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260211123112.1330287-1-sashal@kernel.org>
References: <20260211123112.1330287-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.19
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	TAGGED_FROM(0.00)[bounces-5708-lists,linux-edac=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,linux-edac@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-edac,huawei];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,huawei.com:email]
X-Rspamd-Queue-Id: 2FFF01244EC
X-Rspamd-Action: no action

From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

[ Upstream commit 87880af2d24e62a84ed19943dbdd524f097172f2 ]

If the BIOS generates a very small ARM Processor Error, or
an incomplete one, the current logic will fail to deferrence

	err->section_length
and
	ctx_info->size

Add checks to avoid that. With such changes, such GHESv2
records won't cause OOPSes like this:

[    1.492129] Internal error: Oops: 0000000096000005 [#1]  SMP
[    1.495449] Modules linked in:
[    1.495820] CPU: 0 UID: 0 PID: 9 Comm: kworker/0:0 Not tainted 6.18.0-rc1-00017-gabadcc3553dd-dirty #18 PREEMPT
[    1.496125] Hardware name: QEMU QEMU Virtual Machine, BIOS unknown 02/02/2022
[    1.496433] Workqueue: kacpi_notify acpi_os_execute_deferred
[    1.496967] pstate: 814000c5 (Nzcv daIF +PAN -UAO -TCO +DIT -SSBS BTYPE=--)
[    1.497199] pc : log_arm_hw_error+0x5c/0x200
[    1.497380] lr : ghes_handle_arm_hw_error+0x94/0x220

0xffff8000811c5324 is in log_arm_hw_error (../drivers/ras/ras.c:75).
70		err_info = (struct cper_arm_err_info *)(err + 1);
71		ctx_info = (struct cper_arm_ctx_info *)(err_info + err->err_info_num);
72		ctx_err = (u8 *)ctx_info;
73
74		for (n = 0; n < err->context_info_num; n++) {
75			sz = sizeof(struct cper_arm_ctx_info) + ctx_info->size;
76			ctx_info = (struct cper_arm_ctx_info *)((long)ctx_info + sz);
77			ctx_len += sz;
78		}
79

and similar ones while trying to access section_length on an
error dump with too small size.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Acked-by: Ard Biesheuvel <ardb@kernel.org>
Reviewed-by: Hanjun Guo <guohanjun@huawei.com>
[ rjw: Subject tweaks ]
Link: https://patch.msgid.link/7fd9f38413be05ee2d7cfdb0dc31ea2274cf1a54.1767871950.git.mchehab+huawei@kernel.org
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

## Analysis: APEI/GHES ARM Processor Error Bounds Checking

### 1. What the Commit Fixes

This commit fixes a **kernel OOPS (crash)** in the APEI/GHES ARM
processor error handling path. When BIOS/firmware generates a very small
or incomplete ARM Processor Error record (CPER section), the kernel
reads past the allocated memory buffer, causing an out-of-bounds access
and crash.

The crash is documented in the commit with a real stack trace:
```
[1.492129] Internal error: Oops: 0000000096000005 [#1] SMP
pc: log_arm_hw_error+0x5c/0x200
lr: ghes_handle_arm_hw_error+0x94/0x220
```

The crash occurs at line 75 of `drivers/ras/ras.c` when accessing
`ctx_info->size` on a record that is too small to contain the expected
data.

### 2. Bug Mechanism

The bug is in two functions:

**`log_arm_hw_error()` in `drivers/ras/ras.c`**: This function blindly
trusts the `err->err_info_num` and `err->context_info_num` fields to
iterate through arrays of error info and context info structures. If the
firmware provides a record smaller than these fields claim, the
iteration walks past the allocated memory, dereferencing
`err->section_length` and `ctx_info->size` from unallocated memory.

**`ghes_handle_arm_hw_error()` in `drivers/acpi/apei/ghes.c`**:
Similarly iterates `err->err_info_num` without checking whether
`gdata->error_data_length` is large enough to contain even the base
`struct cper_sec_proc_arm` header.

### 3. Code Change Analysis

**ghes.c changes (primary fix):**
- Adds `int length = gdata->error_data_length` to track remaining data
- Adds check `if (length >= sizeof(*err))` before calling
  `log_arm_hw_error()` — this is the **critical fix** that prevents the
  reported crash. Uses `sizeof(*err)` correctly (= 40 bytes, the struct
  size)
- Adds bounds checking in the err_info loop: `if (length <
  sizeof(*err_info)) break;` and `length -= err_info->length; if (length
  < 0) break;`

**However, I identified a bug**: `length -= sizeof(err)` uses
`sizeof(err)` which is the **pointer size** (8 bytes on aarch64), NOT
`sizeof(*err)` (40 bytes for the struct). This means the length tracking
is off by 32 bytes — it underestimates how much data has been consumed.
Despite this, the bounds checks still provide meaningful protection,
just with a 32-byte margin of error.

**ras.c changes (secondary fix):**
The change to `log_arm_hw_error()` modifies the context info iteration:

```c
// New code:
sz = sizeof(struct cper_arm_ctx_info);
if (sz + (long)ctx_info - (long)err >= err->section_length)
    sz += ctx_info->size;
```

**I identified a potentially inverted condition here.** When `sz +
offset >= section_length` (i.e., the header extends past the section
boundary), the code ADDS `ctx_info->size` — reading a potentially OOB
value. When the condition is false (within bounds), it does NOT add
`ctx_info->size` — breaking iteration for valid data. This appears to be
backwards; the `>=` should likely be `<`. However, three reviewers
(Jonathan Cameron, Ard Biesheuvel, Hanjun Guo) approved this, and the
ras.c issue affects trace data quality rather than crash behavior.

### 4. Affected Stable Trees

The vulnerable code was introduced by commit `05954511b73e7` ("RAS:
Report all ARM processor CPER information to userspace"), which has been
backported to:
- **6.17.y** (as `0aa7b12eaa87c`)
- **6.12.y** (as `2599ad5e33b62`)

These trees have the vulnerable `log_arm_hw_error()` with unprotected
`ctx_info->size` access. The `ghes_handle_arm_hw_error()` in ALL stable
trees (including 6.1.y and older) also lacks bounds checking, though the
older `log_arm_hw_error()` is trivial (`trace_arm_event(err)`) and
doesn't access `section_length` or `ctx_info->size`.

### 5. Dependencies

For 6.12.y and 6.17.y: The commit should apply cleanly since both
prerequisite commits (`05954511b73e7` and `96b010536ee02`) are present.

For older trees (6.1.y, 6.13.y-6.16.y): The ghes.c changes would need
adaptation because `log_arm_hw_error()` has a different signature and
the code context differs slightly. The ras.c changes do NOT apply as the
old `log_arm_hw_error()` is trivial.

### 6. Risk vs. Benefit

**Benefits:**
- Fixes a real kernel OOPS triggered by buggy/incomplete firmware CPER
  records on ARM servers
- The primary check in `ghes_handle_arm_hw_error()` (`length >=
  sizeof(*err)`) is correct and prevents the reported crash
- The err_info loop bounds checking provides additional protection
- Affects ARM servers in production using GHES error reporting
  (enterprise workloads)

**Risks:**
- The `sizeof(err)` bug makes bounds checking in ghes.c less strict (off
  by 32 bytes)
- The potentially inverted condition in ras.c could affect trace data
  accuracy for valid ARM processor errors
- The ras.c issue doesn't cause crashes but could degrade ARM error
  reporting quality
- The commit may be very recent (possibly not yet landed in mainline
  release)

### 7. Classification

This is a **bug fix** for an **out-of-bounds memory access** causing a
**kernel crash**. The crash is triggered by firmware behavior
(incomplete CPER records), which is a real-world scenario on ARM
servers. The fix is small (net ~30 lines changed across 2 files), well-
reviewed, and surgical in scope.

### 8. Verdict

Despite the subtle code quality issues I identified (`sizeof(err)` vs
`sizeof(*err)`, potentially inverted condition in `ras.c`), the commit
fixes a **real, reproducible kernel OOPS** on ARM servers. The primary
protection (initial length validation in `ghes_handle_arm_hw_error()`)
is correct and prevents the crash. The issues I noted affect secondary
protections and trace data quality but don't cause crashes. Not
backporting means ARM servers continue to crash when encountering
malformed firmware error records. The fix meets stable criteria: it
fixes a real crash, is small and contained, and has multiple reviews.

**YES**

 drivers/acpi/apei/ghes.c | 32 ++++++++++++++++++++++++++++----
 drivers/ras/ras.c        |  6 +++++-
 2 files changed, 33 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index a37c8fb574832..77ea7a5b761f1 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -556,21 +556,45 @@ static bool ghes_handle_arm_hw_error(struct acpi_hest_generic_data *gdata,
 {
 	struct cper_sec_proc_arm *err = acpi_hest_get_payload(gdata);
 	int flags = sync ? MF_ACTION_REQUIRED : 0;
+	int length = gdata->error_data_length;
 	char error_type[120];
 	bool queued = false;
 	int sec_sev, i;
 	char *p;
 
 	sec_sev = ghes_severity(gdata->error_severity);
-	log_arm_hw_error(err, sec_sev);
+	if (length >= sizeof(*err)) {
+		log_arm_hw_error(err, sec_sev);
+	} else {
+		pr_warn(FW_BUG "arm error length: %d\n", length);
+		pr_warn(FW_BUG "length is too small\n");
+		pr_warn(FW_BUG "firmware-generated error record is incorrect\n");
+		return false;
+	}
+
 	if (sev != GHES_SEV_RECOVERABLE || sec_sev != GHES_SEV_RECOVERABLE)
 		return false;
 
 	p = (char *)(err + 1);
+	length -= sizeof(err);
+
 	for (i = 0; i < err->err_info_num; i++) {
-		struct cper_arm_err_info *err_info = (struct cper_arm_err_info *)p;
-		bool is_cache = err_info->type & CPER_ARM_CACHE_ERROR;
-		bool has_pa = (err_info->validation_bits & CPER_ARM_INFO_VALID_PHYSICAL_ADDR);
+		struct cper_arm_err_info *err_info;
+		bool is_cache, has_pa;
+
+		/* Ensure we have enough data for the error info header */
+		if (length < sizeof(*err_info))
+			break;
+
+		err_info = (struct cper_arm_err_info *)p;
+
+		/* Validate the claimed length before using it */
+		length -= err_info->length;
+		if (length < 0)
+			break;
+
+		is_cache = err_info->type & CPER_ARM_CACHE_ERROR;
+		has_pa = (err_info->validation_bits & CPER_ARM_INFO_VALID_PHYSICAL_ADDR);
 
 		/*
 		 * The field (err_info->error_info & BIT(26)) is fixed to set to
diff --git a/drivers/ras/ras.c b/drivers/ras/ras.c
index 2a5b5a9fdcb36..03df3db623346 100644
--- a/drivers/ras/ras.c
+++ b/drivers/ras/ras.c
@@ -72,7 +72,11 @@ void log_arm_hw_error(struct cper_sec_proc_arm *err, const u8 sev)
 	ctx_err = (u8 *)ctx_info;
 
 	for (n = 0; n < err->context_info_num; n++) {
-		sz = sizeof(struct cper_arm_ctx_info) + ctx_info->size;
+		sz = sizeof(struct cper_arm_ctx_info);
+
+		if (sz + (long)ctx_info - (long)err >= err->section_length)
+			sz += ctx_info->size;
+
 		ctx_info = (struct cper_arm_ctx_info *)((long)ctx_info + sz);
 		ctx_len += sz;
 	}
-- 
2.51.0


