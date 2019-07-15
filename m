Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B4D5D68F5F
	for <lists+linux-edac@lfdr.de>; Mon, 15 Jul 2019 16:14:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389255AbfGOOOB (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 15 Jul 2019 10:14:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:55014 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388738AbfGOOOA (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Mon, 15 Jul 2019 10:14:00 -0400
Received: from sasha-vm.mshome.net (unknown [73.61.17.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2673F206B8;
        Mon, 15 Jul 2019 14:13:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563200039;
        bh=03xaZEiGP2CVhguAPuV+RHpYcfkROW1/kBhp7W7yaCk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AP3UjTrNqhg7vsKIPX6MAkNlZOFHlMag5Dh49NjLjraNMgs11BfedQCt/xUGDkla9
         ph/oNCtekIPdJxN0k7RlnnXJINvg1biP1cfOsbASBRClrWUljiWvN5Vsj+tlF+P4M7
         Yn//El/fF/1y9xsck/CEgr5lllvNC0pCY0ipUrhQ=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Eiichi Tsukata <devel@etsukata.com>,
        James Morse <james.morse@arm.com>,
        Tony Luck <tony.luck@intel.com>,
        Sasha Levin <sashal@kernel.org>, linux-edac@vger.kernel.org
Subject: [PATCH AUTOSEL 5.1 166/219] EDAC: Fix global-out-of-bounds write when setting edac_mc_poll_msec
Date:   Mon, 15 Jul 2019 10:02:47 -0400
Message-Id: <20190715140341.6443-166-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190715140341.6443-1-sashal@kernel.org>
References: <20190715140341.6443-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Eiichi Tsukata <devel@etsukata.com>

[ Upstream commit d8655e7630dafa88bc37f101640e39c736399771 ]

Commit 9da21b1509d8 ("EDAC: Poll timeout cannot be zero, p2") assumes
edac_mc_poll_msec to be unsigned long, but the type of the variable still
remained as int. Setting edac_mc_poll_msec can trigger out-of-bounds
write.

Reproducer:

  # echo 1001 > /sys/module/edac_core/parameters/edac_mc_poll_msec

KASAN report:

  BUG: KASAN: global-out-of-bounds in edac_set_poll_msec+0x140/0x150
  Write of size 8 at addr ffffffffb91b2d00 by task bash/1996

  CPU: 1 PID: 1996 Comm: bash Not tainted 5.2.0-rc6+ #23
  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-2.fc30 04/01/2014
  Call Trace:
   dump_stack+0xca/0x13e
   print_address_description.cold+0x5/0x246
   __kasan_report.cold+0x75/0x9a
   ? edac_set_poll_msec+0x140/0x150
   kasan_report+0xe/0x20
   edac_set_poll_msec+0x140/0x150
   ? dimmdev_location_show+0x30/0x30
   ? vfs_lock_file+0xe0/0xe0
   ? _raw_spin_lock+0x87/0xe0
   param_attr_store+0x1b5/0x310
   ? param_array_set+0x4f0/0x4f0
   module_attr_store+0x58/0x80
   ? module_attr_show+0x80/0x80
   sysfs_kf_write+0x13d/0x1a0
   kernfs_fop_write+0x2bc/0x460
   ? sysfs_kf_bin_read+0x270/0x270
   ? kernfs_notify+0x1f0/0x1f0
   __vfs_write+0x81/0x100
   vfs_write+0x1e1/0x560
   ksys_write+0x126/0x250
   ? __ia32_sys_read+0xb0/0xb0
   ? do_syscall_64+0x1f/0x390
   do_syscall_64+0xc1/0x390
   entry_SYSCALL_64_after_hwframe+0x49/0xbe
  RIP: 0033:0x7fa7caa5e970
  Code: 73 01 c3 48 8b 0d 28 d5 2b 00 f7 d8 64 89 01 48 83 c8 ff c3 66 0f 1f 44 00 00 83 3d 99 2d 2c 00 00 75 10 b8 01 00 00 00 04
  RSP: 002b:00007fff6acfdfe8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
  RAX: ffffffffffffffda RBX: 0000000000000005 RCX: 00007fa7caa5e970
  RDX: 0000000000000005 RSI: 0000000000e95c08 RDI: 0000000000000001
  RBP: 0000000000e95c08 R08: 00007fa7cad1e760 R09: 00007fa7cb36a700
  R10: 0000000000000073 R11: 0000000000000246 R12: 0000000000000005
  R13: 0000000000000001 R14: 00007fa7cad1d600 R15: 0000000000000005

  The buggy address belongs to the variable:
   edac_mc_poll_msec+0x0/0x40

  Memory state around the buggy address:
   ffffffffb91b2c00: 00 00 00 00 fa fa fa fa 00 00 00 00 fa fa fa fa
   ffffffffb91b2c80: 00 00 00 00 fa fa fa fa 00 00 00 00 fa fa fa fa
  >ffffffffb91b2d00: 04 fa fa fa fa fa fa fa 04 fa fa fa fa fa fa fa
                     ^
   ffffffffb91b2d80: 04 fa fa fa fa fa fa fa 00 00 00 00 00 00 00 00
   ffffffffb91b2e00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

Fix it by changing the type of edac_mc_poll_msec to unsigned int.
The reason why this patch adopts unsigned int rather than unsigned long
is msecs_to_jiffies() assumes arg to be unsigned int. We can avoid
integer conversion bugs and unsigned int will be large enough for
edac_mc_poll_msec.

Reviewed-by: James Morse <james.morse@arm.com>
Fixes: 9da21b1509d8 ("EDAC: Poll timeout cannot be zero, p2")
Signed-off-by: Eiichi Tsukata <devel@etsukata.com>
Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/edac/edac_mc_sysfs.c | 16 ++++++++--------
 drivers/edac/edac_module.h   |  2 +-
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/edac/edac_mc_sysfs.c b/drivers/edac/edac_mc_sysfs.c
index 7c01e1cc030c..4386ea4b9b5a 100644
--- a/drivers/edac/edac_mc_sysfs.c
+++ b/drivers/edac/edac_mc_sysfs.c
@@ -26,7 +26,7 @@
 static int edac_mc_log_ue = 1;
 static int edac_mc_log_ce = 1;
 static int edac_mc_panic_on_ue;
-static int edac_mc_poll_msec = 1000;
+static unsigned int edac_mc_poll_msec = 1000;
 
 /* Getter functions for above */
 int edac_mc_get_log_ue(void)
@@ -45,30 +45,30 @@ int edac_mc_get_panic_on_ue(void)
 }
 
 /* this is temporary */
-int edac_mc_get_poll_msec(void)
+unsigned int edac_mc_get_poll_msec(void)
 {
 	return edac_mc_poll_msec;
 }
 
 static int edac_set_poll_msec(const char *val, const struct kernel_param *kp)
 {
-	unsigned long l;
+	unsigned int i;
 	int ret;
 
 	if (!val)
 		return -EINVAL;
 
-	ret = kstrtoul(val, 0, &l);
+	ret = kstrtouint(val, 0, &i);
 	if (ret)
 		return ret;
 
-	if (l < 1000)
+	if (i < 1000)
 		return -EINVAL;
 
-	*((unsigned long *)kp->arg) = l;
+	*((unsigned int *)kp->arg) = i;
 
 	/* notify edac_mc engine to reset the poll period */
-	edac_mc_reset_delay_period(l);
+	edac_mc_reset_delay_period(i);
 
 	return 0;
 }
@@ -82,7 +82,7 @@ MODULE_PARM_DESC(edac_mc_log_ue,
 module_param(edac_mc_log_ce, int, 0644);
 MODULE_PARM_DESC(edac_mc_log_ce,
 		 "Log correctable error to console: 0=off 1=on");
-module_param_call(edac_mc_poll_msec, edac_set_poll_msec, param_get_int,
+module_param_call(edac_mc_poll_msec, edac_set_poll_msec, param_get_uint,
 		  &edac_mc_poll_msec, 0644);
 MODULE_PARM_DESC(edac_mc_poll_msec, "Polling period in milliseconds");
 
diff --git a/drivers/edac/edac_module.h b/drivers/edac/edac_module.h
index dd7d0b509aa3..75528f07abd5 100644
--- a/drivers/edac/edac_module.h
+++ b/drivers/edac/edac_module.h
@@ -36,7 +36,7 @@ extern int edac_mc_get_log_ue(void);
 extern int edac_mc_get_log_ce(void);
 extern int edac_mc_get_panic_on_ue(void);
 extern int edac_get_poll_msec(void);
-extern int edac_mc_get_poll_msec(void);
+extern unsigned int edac_mc_get_poll_msec(void);
 
 unsigned edac_dimm_info_location(struct dimm_info *dimm, char *buf,
 				 unsigned len);
-- 
2.20.1

