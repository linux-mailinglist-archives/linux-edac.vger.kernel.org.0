Return-Path: <linux-edac+bounces-5719-lists+linux-edac=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-edac@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0HvkOAnJj2mZTgEAu9opvQ
	(envelope-from <linux-edac+bounces-5719-lists+linux-edac=lfdr.de@vger.kernel.org>)
	for <lists+linux-edac@lfdr.de>; Sat, 14 Feb 2026 01:59:53 +0100
X-Original-To: lists+linux-edac@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D7EC13A3A2
	for <lists+linux-edac@lfdr.de>; Sat, 14 Feb 2026 01:59:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3D0FC307F0A5
	for <lists+linux-edac@lfdr.de>; Sat, 14 Feb 2026 00:58:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D46821E087;
	Sat, 14 Feb 2026 00:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d2Br8zPD"
X-Original-To: linux-edac@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 290F71E1C11;
	Sat, 14 Feb 2026 00:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771030720; cv=none; b=BOkcrr4z9PVxtXyoU6x5F/YekcFpscuQGpRLMMngrluPVDQFFy6WSq4Hfw+mS4vIFoJ8jeLYBHiCUbjK7Bo5z4ZWGjccMN/J9f2udgc3coGkda+O+6euMfbkLRCRyeWMhkwUwts9Q4CPh0qxCE1yLLakh2DrhygwTbTDxVSWPoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771030720; c=relaxed/simple;
	bh=lw/MWmDXCokKVTEYvkD+CT9aaE5yW6806FAANXJoHFg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O1NlJFI/MV58wef4URsjLhkOPHl0PucAhXA9WEmM8tft9PIRBzIfIcbYau193N5gk2OGp+ONHqR9zxMBLFdN/SmeCCGYY0c4uWb6Efo45PzVHj3/tB82zB62XLdc3wSJOzl21tqsUMnBaYjTOYh8kAZGt1i69T38rCpbfazwaKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d2Br8zPD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35D59C19423;
	Sat, 14 Feb 2026 00:58:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771030720;
	bh=lw/MWmDXCokKVTEYvkD+CT9aaE5yW6806FAANXJoHFg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=d2Br8zPDPuN9YfsaCFZBXpw/zqsjROhR1UdRDiQg7h/cVUVQaz2RjDZ7njLkx12Qa
	 RVS9/Ntt+Vn9g/g1IkuRYijKR+gaH/J3ZWTKIpbnpm27LacqF7Dyp3IJII3ue5WBq0
	 V7aWG0BgQNhzE8J7i0WqRvWBn4rrSFArBmCSNRgjv1oGta2QkHmfQmtjrHcxNGrtZW
	 8cYiVAwGl08pLtRR/dWbWB3ym9+CxMJw9Tv5DJfKxz1RNykopztICyKZ6mHtdX7gTi
	 zxS1DyfqG7CsidEkJ1iFT5jw1ulc6WDiuDYAG5/xyTIfvXCgMLbYNw860SFVasFIdk
	 WE/poqgqqYesA==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Lili Li <lili.li@intel.com>,
	Tony Luck <tony.luck@intel.com>,
	Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	bp@alien8.de,
	linux-edac@vger.kernel.org
Subject: [PATCH AUTOSEL 6.19-6.18] EDAC/igen6: Add more Intel Panther Lake-H SoCs support
Date: Fri, 13 Feb 2026 19:58:13 -0500
Message-ID: <20260214005825.3665084-7-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260214005825.3665084-1-sashal@kernel.org>
References: <20260214005825.3665084-1-sashal@kernel.org>
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
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-5719-lists,linux-edac=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,linux-edac@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-edac];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,msgid.link:url]
X-Rspamd-Queue-Id: 8D7EC13A3A2
X-Rspamd-Action: no action

From: Lili Li <lili.li@intel.com>

[ Upstream commit 4c36e6106997b6ad8f4a279b4bdbca3ed6f53c6c ]

Add more Intel Panther Lake-H SoC compute die IDs for EDAC support.

Signed-off-by: Lili Li <lili.li@intel.com>
Signed-off-by: Tony Luck <tony.luck@intel.com>
Reviewed-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Link: https://patch.msgid.link/20251124131537.3633983-1-qiuxu.zhuo@intel.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

Now I have a comprehensive picture. Let me summarize my analysis.

## Detailed Analysis

### 1. Commit Message Analysis

The commit subject is "EDAC/igen6: Add more Intel Panther Lake-H SoCs
support" and the body says "Add more Intel Panther Lake-H SoC compute
die IDs for EDAC support." This is purely a **new device ID addition**
to an existing driver. The commit is authored by Intel employees (Lili
Li, Qiuxu Zhuo) who maintain this specific EDAC driver, and reviewed by
the same team.

### 2. Code Change Analysis

The diff is straightforward and mechanical:

**Part 1 - Macro definitions** (lines ~280-290): Adds 10 new `#define`
constants:
- `DID_PTL_H_SKU4` through `DID_PTL_H_SKU13` with PCI device IDs
  `0xb003`, `0xb004`, `0xb005`, `0xb008`, `0xb011`, `0xb014`, `0xb015`,
  `0xb028`, `0xb029`, `0xb02a`

**Part 2 - PCI device table** (lines ~675-695): Adds 10 new
`PCI_VDEVICE` entries, all pointing to the existing `mtl_p_cfg`
configuration structure — the same configuration used by the 3 initial
PTL-H SKUs.

This is a textbook **PCI device ID addition**. No new logic, no new
config structures, no new functions. Every new entry uses the identical
`mtl_p_cfg` configuration as the existing PTL-H SKUs.

### 3. Classification

This falls squarely into the **"New Device IDs" exception** for stable
trees:
- The driver (`igen6_edac`) already exists in stable trees
- The PTL-H configuration (`mtl_p_cfg`) and initial PTL-H support
  already exist (since v6.13)
- Only new PCI IDs are being added — enabling additional hardware
  variants of the same SoC family

### 4. Scope and Risk Assessment

- **Lines changed**: ~20 (10 `#define`s + 10 PCI table entries)
- **Files touched**: 1 (`drivers/edac/igen6_edac.c`)
- **Risk**: Extremely low. The PCI device table is a static array of ID-
  to-config mappings. The new entries only match hardware with those
  specific PCI IDs. If the hardware isn't present, the entries are
  completely inert. Zero risk to existing functionality.
- **Complexity**: Trivial — pure data addition with no logic changes.

### 5. Dependency Check

This commit has one critical dependency:
- **Initial PTL-H support commit** (`0be9f1af39022`): "EDAC/igen6: Add
  Intel Panther Lake-H SoCs support" — landed in **v6.13**. This commit
  defined `DID_PTL_H_SKU1`-`SKU3` and the usage of `mtl_p_cfg` for
  PTL-H.

Therefore:
- **v6.1 LTS, v6.6 LTS, v6.12 stable**: The prerequisite commit is NOT
  present. Backporting here would require first backporting the initial
  PTL-H support.
- **v6.13+ stable** (v6.13.y, v6.14.y, etc.): The prerequisite IS
  present, so this patch can apply cleanly.

### 6. User Impact

EDAC (Error Detection And Correction) is critical infrastructure for
detecting and reporting memory errors. Without these device IDs, users
with Intel Panther Lake-H SoCs with these specific compute die IDs will
get **no EDAC/ECC error reporting** — meaning memory errors could go
undetected, leading to potential silent data corruption on affected
hardware. This is exactly the kind of hardware enablement that stable
users (particularly enterprise/embedded users) need.

### 7. Stability Indicators

- Reviewed by Intel's EDAC team member (Qiuxu Zhuo)
- Signed off by the RAS maintainer (Tony Luck)
- Same pattern as dozens of prior device ID additions to this driver,
  all of which have been successfully backported to stable trees (Arrow
  Lake, Meteor Lake-P/PS, Raptor Lake-P, Alder Lake-N, etc.)

### 8. Verdict

This is a classic, textbook device ID addition:
- Purely mechanical addition of PCI device IDs
- Uses existing infrastructure (no new code paths)
- Enables EDAC support on additional Panther Lake-H hardware variants
- Extremely low risk — inert on systems without matching hardware
- The only concern is dependency on initial PTL-H support (v6.13+), but
  this is manageable

The commit matches the stable kernel rules for device ID additions
perfectly. It's small, contained, obviously correct, and enables real
hardware support for real users.

**YES**

 drivers/edac/igen6_edac.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/edac/igen6_edac.c b/drivers/edac/igen6_edac.c
index 553c31a2d9226..839b6dd3629e9 100644
--- a/drivers/edac/igen6_edac.c
+++ b/drivers/edac/igen6_edac.c
@@ -274,6 +274,16 @@ static struct work_struct ecclog_work;
 #define DID_PTL_H_SKU1	0xb000
 #define DID_PTL_H_SKU2	0xb001
 #define DID_PTL_H_SKU3	0xb002
+#define DID_PTL_H_SKU4	0xb003
+#define DID_PTL_H_SKU5	0xb004
+#define DID_PTL_H_SKU6	0xb005
+#define DID_PTL_H_SKU7	0xb008
+#define DID_PTL_H_SKU8	0xb011
+#define DID_PTL_H_SKU9	0xb014
+#define DID_PTL_H_SKU10	0xb015
+#define DID_PTL_H_SKU11	0xb028
+#define DID_PTL_H_SKU12	0xb029
+#define DID_PTL_H_SKU13	0xb02a
 
 /* Compute die IDs for Wildcat Lake with IBECC */
 #define DID_WCL_SKU1	0xfd00
@@ -636,6 +646,16 @@ static struct pci_device_id igen6_pci_tbl[] = {
 	{ PCI_VDEVICE(INTEL, DID_PTL_H_SKU1), (kernel_ulong_t)&mtl_p_cfg },
 	{ PCI_VDEVICE(INTEL, DID_PTL_H_SKU2), (kernel_ulong_t)&mtl_p_cfg },
 	{ PCI_VDEVICE(INTEL, DID_PTL_H_SKU3), (kernel_ulong_t)&mtl_p_cfg },
+	{ PCI_VDEVICE(INTEL, DID_PTL_H_SKU4), (kernel_ulong_t)&mtl_p_cfg },
+	{ PCI_VDEVICE(INTEL, DID_PTL_H_SKU5), (kernel_ulong_t)&mtl_p_cfg },
+	{ PCI_VDEVICE(INTEL, DID_PTL_H_SKU6), (kernel_ulong_t)&mtl_p_cfg },
+	{ PCI_VDEVICE(INTEL, DID_PTL_H_SKU7), (kernel_ulong_t)&mtl_p_cfg },
+	{ PCI_VDEVICE(INTEL, DID_PTL_H_SKU8), (kernel_ulong_t)&mtl_p_cfg },
+	{ PCI_VDEVICE(INTEL, DID_PTL_H_SKU9), (kernel_ulong_t)&mtl_p_cfg },
+	{ PCI_VDEVICE(INTEL, DID_PTL_H_SKU10), (kernel_ulong_t)&mtl_p_cfg },
+	{ PCI_VDEVICE(INTEL, DID_PTL_H_SKU11), (kernel_ulong_t)&mtl_p_cfg },
+	{ PCI_VDEVICE(INTEL, DID_PTL_H_SKU12), (kernel_ulong_t)&mtl_p_cfg },
+	{ PCI_VDEVICE(INTEL, DID_PTL_H_SKU13), (kernel_ulong_t)&mtl_p_cfg },
 	{ PCI_VDEVICE(INTEL, DID_WCL_SKU1), (kernel_ulong_t)&wcl_cfg },
 	{ },
 };
-- 
2.51.0


