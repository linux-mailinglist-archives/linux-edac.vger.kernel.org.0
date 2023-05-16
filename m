Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 436777043F8
	for <lists+linux-edac@lfdr.de>; Tue, 16 May 2023 05:32:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229524AbjEPDcf (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 15 May 2023 23:32:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjEPDce (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 15 May 2023 23:32:34 -0400
Received: from smtp-relay-canonical-0.canonical.com (smtp-relay-canonical-0.canonical.com [185.125.188.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 553CC1732;
        Mon, 15 May 2023 20:32:30 -0700 (PDT)
Received: from localhost.localdomain (unknown [10.101.196.174])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 1608F41202;
        Tue, 16 May 2023 03:32:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1684207946;
        bh=92q1PLUKc0SfASvf/P3OXVFQ0dTuTKcCi5d/Xu7OF+4=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=pC5sjxArJ3TluBRly9STHhWHkxbjaH2d64KQL7gj0qEj08FgwvrvgQz0z5x/N0c15
         9o5eHTsMkf4xt4pSqW9i/FaRcHGTySOS8zSVvE2uRJC5uAuaA1KFingu2n4LwKQY7n
         EPq8/FsDFv1w3f53gVErcQfRTkpFpRUG4Hs74g5W78gVlyCaxJq+n36ktQ8/LKoVAH
         5DgJBqTdDJb3GXPx2PtrXCn1xea/cJVxmlmc+/lNOvRJWgwPVhdNnp/K7HLwt4eVR5
         QIhV4ken2dpeKbOSEIK1xyK8do+d4GR0acfCZulltgX6QVfv5rSg5C3hKisbuo6NDj
         2TC8oJrj2kq+w==
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     tony.luck@intel.com
Cc:     acelan.kao@canonical.com,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        James Morse <james.morse@arm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Richter <rric@kernel.org>, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] EDAC/Intel: Fix shift-out-of-bounds when DIMM/NVDIMM is absent
Date:   Tue, 16 May 2023 11:31:33 +0800
Message-Id: <20230516033133.340936-1-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

The following splat can be found on many systems equipped with EDAC:
[   13.875276] UBSAN: shift-out-of-bounds in drivers/edac/skx_common.c:369:16
[   13.875279] shift exponent -66 is negative
[   13.875280] CPU: 11 PID: 519 Comm: systemd-udevd Not tainted 6.4.0-rc1+ #1
[   13.875282] Hardware name: HP HP Z4 G5 Workstation Desktop PC/8962, BIOS U61 Ver. 01.01.15 04/19/2023
[   13.875283] Call Trace:
[   13.875285]  <TASK>
[   13.875287]  dump_stack_lvl+0x48/0x70
[   13.875295]  dump_stack+0x10/0x20
[   13.875297]  __ubsan_handle_shift_out_of_bounds+0x156/0x310
[   13.875302]  ? __kmem_cache_alloc_node+0x196/0x300
[   13.875307]  skx_get_dimm_info.cold+0xac/0x15d [i10nm_edac]
[   13.875312]  i10nm_get_dimm_config+0x240/0x360 [i10nm_edac]
[   13.875316]  ? kasprintf+0x4e/0x80
[   13.875321]  skx_register_mci+0x12b/0x1d0 [i10nm_edac]
[   13.875324]  ? __pfx_i10nm_get_dimm_config+0x10/0x10 [i10nm_edac]
[   13.875329]  i10nm_init+0x89f/0x1d10 [i10nm_edac]
[   13.875333]  ? __pfx_i10nm_init+0x10/0x10 [i10nm_edac]
[   13.875337]  do_one_initcall+0x46/0x240
[   13.875342]  ? kmalloc_trace+0x2a/0xb0
[   13.875346]  do_init_module+0x6a/0x280
[   13.875350]  load_module+0x2419/0x2500
[   13.875353]  ? security_kernel_post_read_file+0x5c/0x80
[   13.875358]  __do_sys_finit_module+0xcc/0x150
[   13.875360]  ? __do_sys_finit_module+0xcc/0x150
[   13.875363]  __x64_sys_finit_module+0x18/0x30
[   13.875365]  do_syscall_64+0x59/0x90
[   13.875368]  ? syscall_exit_to_user_mode+0x2a/0x50
[   13.875371]  ? do_syscall_64+0x69/0x90
[   13.875372]  ? do_syscall_64+0x69/0x90
[   13.875373]  ? do_syscall_64+0x69/0x90
[   13.875374]  ? do_syscall_64+0x69/0x90
[   13.875375]  ? syscall_exit_to_user_mode+0x2a/0x50
[   13.875376]  ? do_syscall_64+0x69/0x90
[   13.875377]  ? do_syscall_64+0x69/0x90
[   13.875378]  ? do_syscall_64+0x69/0x90
[   13.875379]  ? sysvec_call_function+0x4e/0xb0
[   13.875381]  entry_SYSCALL_64_after_hwframe+0x72/0xdc

When a DIMM slot is empty, the read value of mtr can be 0xffffffff,
therefore the wrong "ranks" value creates shift-out-of-bounds error. The
same issue can be found on NVDIMM too.

So only consider DIMM/NVDIMM is present when the value of mtr/mcddrtcfg
is not ~0.

Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 drivers/edac/sb_edac.c    | 2 +-
 drivers/edac/skx_common.h | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/edac/sb_edac.c b/drivers/edac/sb_edac.c
index 0c779a0326b6..bc5155e84514 100644
--- a/drivers/edac/sb_edac.c
+++ b/drivers/edac/sb_edac.c
@@ -211,7 +211,7 @@ static const int mtr_regs[] = {
 static const int knl_mtr_reg = 0xb60;
 
 #define RANK_DISABLE(mtr)		GET_BITFIELD(mtr, 16, 19)
-#define IS_DIMM_PRESENT(mtr)		GET_BITFIELD(mtr, 14, 14)
+#define IS_DIMM_PRESENT(mtr)		((mtr != ~0) && GET_BITFIELD(mtr, 14, 14))
 #define RANK_CNT_BITS(mtr)		GET_BITFIELD(mtr, 12, 13)
 #define RANK_WIDTH_BITS(mtr)		GET_BITFIELD(mtr, 2, 4)
 #define COL_WIDTH_BITS(mtr)		GET_BITFIELD(mtr, 0, 1)
diff --git a/drivers/edac/skx_common.h b/drivers/edac/skx_common.h
index b6d3607dffe2..2f975ffeaac9 100644
--- a/drivers/edac/skx_common.h
+++ b/drivers/edac/skx_common.h
@@ -50,8 +50,8 @@
 #define NUM_CHANNELS	MAX(SKX_NUM_CHANNELS, I10NM_NUM_CHANNELS)
 #define NUM_DIMMS	MAX(SKX_NUM_DIMMS, I10NM_NUM_DIMMS)
 
-#define IS_DIMM_PRESENT(r)		GET_BITFIELD(r, 15, 15)
-#define IS_NVDIMM_PRESENT(r, i)		GET_BITFIELD(r, i, i)
+#define IS_DIMM_PRESENT(r)		((r != ~0) && GET_BITFIELD(r, 15, 15))
+#define IS_NVDIMM_PRESENT(r, i)		((r != ~0) && GET_BITFIELD(r, i, i))
 
 #define MCI_MISC_ECC_MODE(m)	(((m) >> 59) & 15)
 #define MCI_MISC_ECC_DDRT	8	/* read from DDRT */
-- 
2.34.1

