Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 193F5251924
	for <lists+linux-edac@lfdr.de>; Tue, 25 Aug 2020 15:04:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726306AbgHYNEZ (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 25 Aug 2020 09:04:25 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2691 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725792AbgHYNEY (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 25 Aug 2020 09:04:24 -0400
Received: from lhreml715-chm.china.huawei.com (unknown [172.18.7.106])
        by Forcepoint Email with ESMTP id A35E7627D4C61468E1FF;
        Tue, 25 Aug 2020 14:04:22 +0100 (IST)
Received: from DESKTOP-6T4S3DQ.china.huawei.com (10.47.87.1) by
 lhreml715-chm.china.huawei.com (10.201.108.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Tue, 25 Aug 2020 14:04:22 +0100
From:   Shiju Jose <shiju.jose@huawei.com>
To:     <linux-edac@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <bp@alien8.de>, <mchehab@kernel.org>, <tony.luck@intel.com>,
        <james.morse@arm.com>, <rrichter@marvell.com>
CC:     <linuxarm@huawei.com>
Subject: [PATCH 1/1] EDAC/ghes: Fix for NULL pointer dereference in ghes_edac_register()
Date:   Tue, 25 Aug 2020 14:01:08 +0100
Message-ID: <20200825130108.2132-1-shiju.jose@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.47.87.1]
X-ClientProxiedBy: lhreml744-chm.china.huawei.com (10.201.108.194) To
 lhreml715-chm.china.huawei.com (10.201.108.66)
X-CFilter-Loop: Reflected
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

After the 'commit b9cae27728d1 ("EDAC/ghes: Scan the system once on driver init")'
applied, following error has occurred in ghes_edac_register() when
CONFIG_DEBUG_TEST_DRIVER_REMOVE is enabled. The null ghes_hw.dimms pointer
in the mci_for_each_dimm() of ghes_edac_register() caused the error.

The error occurs when all the previously initialized ghes instances are
removed and then probe a new ghes instance. In this case, the ghes_refcount
would be 0, ghes_hw.dimms and mci already freed. The ghes_hw.dimms would
be null because ghes_scan_system() would not call enumerate_dimms() again.

Following is the error log:

EDAC MC0: Giving out device to module ghes_edac.c controller ghes_edac: DEV ghes (INTERRUPT)
EDAC MC: Removed device 0 for ghes_edac.c ghes_edac: DEV ghes
Unable to handle kernel NULL pointer dereference at virtual address 0000000000000330
Mem abort info:
  ESR = 0x96000004
  EC = 0x25: DABT (current EL), IL = 32 bits
  SET = 0, FnV = 0
  EA = 0, S1PTW = 0
Data abort info:
  ISV = 0, ISS = 0x00000004
  CM = 0, WnR = 0
[0000000000000330] user address but active_mm is swapper
Internal error: Oops: 96000004 [#1] PREEMPT SMP
Modules linked in:
CPU: 34 PID: 1 Comm: swapper/0 Not tainted 5.9.0-rc1-00085-g06a4ec1d9dc6-dirty #29
Hardware name: Huawei TaiShan 2280 V2/BC82AMDC, BIOS 2280-V2 CS V3.B270.01 05/08/2020
pstate: 60c00009 (nZCv daif +PAN +UAO BTYPE=--)
pc : ghes_edac_register+0x19c/0x340
lr : ghes_edac_register+0x12c/0x340
sp : ffff80001041bad0
x29: ffff80001041bad0 x28: ffffc56e16f210a0
x27: 0000000000000000 x26: ffffc56e175d0000
x25: 0000000000000000 x24: ffff007ef7e2a010
x23: ffff007ef5c3a6ec x22: ffffc56e17606000
x21: ffffc56e17409000 x20: ffff007ef5c3a000
x19: ffffc56e176a7000 x18: 000000000000000e
x17: ffff80001007dfff x16: 0000008000000000
x15: ffff80001007dfff x14: 0000000044011000
x13: 0000000040000000 x12: ffff80001007e000
x11: 00000000ffffffff x10: 00000000ffffffff
x9 : 0000000000000002 x8 : ffff207ef6c502fc
x7 : 0000000000000360 x6 : 0000000000000000
x5 : 00000000fffffffc x4 : ffff007ef5c3a6e0
x3 : 0000000000000020 x2 : ffff207ef6c27c00
x1 : 0000000000000000 x0 : 0000000000000000
Call trace:
 ghes_edac_register+0x19c/0x340
 ghes_probe+0x1f0/0x3dc
 platform_drv_probe+0x4c/0xb0
 really_probe+0x1c4/0x444
 driver_probe_device+0x54/0xb0
 device_driver_attach+0x68/0x70
 __driver_attach+0x94/0xdc
 bus_for_each_dev+0x64/0xc0
 driver_attach+0x20/0x28
 bus_add_driver+0x138/0x1f8
 driver_register+0x60/0x10c
 __platform_driver_register+0x4c/0x54
 ghes_init+0x94/0x110
 do_one_initcall+0x58/0x1ac
 kernel_init_freeable+0x204/0x274
 kernel_init+0x10/0x10c
 ret_from_fork+0x10/0x18
Code: 52800000 52806c07 f9401026 9b271801 (b9433023)
---[ end trace f7c77f8c8dfe4b4a ]---
Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b
SMP: stopping secondary CPUs
Kernel Offset: 0x456e05a60000 from 0xffff800010000000
PHYS_OFFSET: 0xffffc58400000000
CPU features: 0x0040002,22808a18
Memory Limit: none
---[ end Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b ]---

Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
---
 drivers/edac/ghes_edac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/edac/ghes_edac.c b/drivers/edac/ghes_edac.c
index da60c29468a7..7930643c6811 100644
--- a/drivers/edac/ghes_edac.c
+++ b/drivers/edac/ghes_edac.c
@@ -227,7 +227,7 @@ static void ghes_scan_system(void)
 {
 	static bool scanned;
 
-	if (scanned)
+	if (scanned && refcount_read(&ghes_refcount))
 		return;
 
 	dmi_walk(enumerate_dimms, &ghes_hw);
-- 
2.17.1


