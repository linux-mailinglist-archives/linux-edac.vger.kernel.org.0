Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F10711CBC05
	for <lists+linux-edac@lfdr.de>; Sat,  9 May 2020 03:08:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727878AbgEIBI4 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 8 May 2020 21:08:56 -0400
Received: from mga11.intel.com ([192.55.52.93]:32798 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727828AbgEIBIz (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Fri, 8 May 2020 21:08:55 -0400
IronPort-SDR: c/McO39PfwgtVIuMMfPrNEBpkPTS9x19VHmV1RH/OBtVVBZtU/JZ9vvxLWsCX0ye+KT+WXeiJl
 cWymAy/cA1vg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2020 18:08:55 -0700
IronPort-SDR: 5fO0j/coocSAUZR0MhXhNEzz703zECrbnIHL7KW5KWwI+U8a3v7HT3ysVkTde1P0Rmu4Zy6vHd
 ME/AymPQXHIg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,369,1583222400"; 
   d="scan'208";a="285651365"
Received: from qiuxu-lab.sh.intel.com ([10.239.53.133])
  by fmsmga004.fm.intel.com with ESMTP; 08 May 2020 18:08:53 -0700
From:   Qiuxu Zhuo <qiuxu.zhuo@intel.com>
To:     bp@alien8.de
Cc:     tony.luck@intel.com, aris@redhat.com, mchehab@kernel.org,
        linux-edac@vger.kernel.org, Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Subject: [PATCH v1 1/1] EDAC, {skx,i10nm}: Use CPU stepping macro to pass configurations
Date:   Sat,  9 May 2020 09:08:22 +0800
Message-Id: <20200509010822.76331-1-qiuxu.zhuo@intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Use the X86_MATCH_INTEL_FAM6_MODEL_STEPPINGS() macro to pass CPU
stepping specific configurations to {skx,i10nm}_init(), so can delete
the CPU stepping check from 10nm_init().

Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
---
 drivers/edac/i10nm_base.c | 12 +++++-------
 drivers/edac/skx_base.c   |  2 +-
 2 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/edac/i10nm_base.c b/drivers/edac/i10nm_base.c
index a6bc54b02de4..ea8f2127e238 100644
--- a/drivers/edac/i10nm_base.c
+++ b/drivers/edac/i10nm_base.c
@@ -135,9 +135,11 @@ static struct res_config i10nm_cfg1 = {
 };
 
 static const struct x86_cpu_id i10nm_cpuids[] = {
-	X86_MATCH_INTEL_FAM6_MODEL(ATOM_TREMONT_D,	&i10nm_cfg0),
-	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_X,		&i10nm_cfg0),
-	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_D,		&i10nm_cfg1),
+	X86_MATCH_INTEL_FAM6_MODEL_STEPPINGS(ATOM_TREMONT_D,	X86_STEPPINGS(0x0, 0x3), &i10nm_cfg0),
+	X86_MATCH_INTEL_FAM6_MODEL_STEPPINGS(ATOM_TREMONT_D,	X86_STEPPINGS(0x4, 0xf), &i10nm_cfg1),
+	X86_MATCH_INTEL_FAM6_MODEL_STEPPINGS(ICELAKE_X,		X86_STEPPINGS(0x0, 0x3), &i10nm_cfg0),
+	X86_MATCH_INTEL_FAM6_MODEL_STEPPINGS(ICELAKE_X,		X86_STEPPINGS(0x4, 0xf), &i10nm_cfg1),
+	X86_MATCH_INTEL_FAM6_MODEL_STEPPINGS(ICELAKE_D,		X86_STEPPINGS(0x0, 0xf), &i10nm_cfg1),
 	{}
 };
 MODULE_DEVICE_TABLE(x86cpu, i10nm_cpuids);
@@ -264,10 +266,6 @@ static int __init i10nm_init(void)
 
 	cfg = (struct res_config *)id->driver_data;
 
-	/* Newer steppings have different offset for ATOM_TREMONT_D/ICELAKE_X */
-	if (boot_cpu_data.x86_stepping >= 4)
-		cfg->busno_cfg_offset = 0xd0;
-
 	rc = skx_get_hi_lo(0x09a2, off, &tolm, &tohm);
 	if (rc)
 		return rc;
diff --git a/drivers/edac/skx_base.c b/drivers/edac/skx_base.c
index 94c942fd06c1..1ff22136cf72 100644
--- a/drivers/edac/skx_base.c
+++ b/drivers/edac/skx_base.c
@@ -164,7 +164,7 @@ static struct res_config skx_cfg = {
 };
 
 static const struct x86_cpu_id skx_cpuids[] = {
-	X86_MATCH_INTEL_FAM6_MODEL(SKYLAKE_X,	&skx_cfg),
+	X86_MATCH_INTEL_FAM6_MODEL_STEPPINGS(SKYLAKE_X, X86_STEPPINGS(0x0, 0xf), &skx_cfg),
 	{ }
 };
 MODULE_DEVICE_TABLE(x86cpu, skx_cpuids);
-- 
2.17.1

