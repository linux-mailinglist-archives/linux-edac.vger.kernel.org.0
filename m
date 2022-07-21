Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E683957D2F8
	for <lists+linux-edac@lfdr.de>; Thu, 21 Jul 2022 20:05:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229461AbiGUSF1 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 21 Jul 2022 14:05:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbiGUSF1 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 21 Jul 2022 14:05:27 -0400
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F97323BF0;
        Thu, 21 Jul 2022 11:05:26 -0700 (PDT)
Received: from pps.filterd (m0134423.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26LHG1Km010846;
        Thu, 21 Jul 2022 18:05:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pps0720;
 bh=9k/GYTvLGUcDpcJlhpKTL0HkyWVORo3e8disXhHh3Xk=;
 b=OEMxAQQ/O/JwESNZ722njxmhdM75k2EAhhV7+IbnIT9VxtfsH3ih2L5maTeyBL781/RK
 IAruLDSenygxb8STqyz0moxH39ouKxlqxWkfiZWttqxjxT2oX2E3FAoX3f4FQhMCNvDU
 VHndV4Obu9o8swzfO6CPKD89X8OY/UdWT7zDD3mYNwpfJGu2/HVY+HHLLU3wgaoQb0se
 kaZbZNCc/35x2qQixoFKInyn9ad3Orlt4SJ6f4zagkQHuBvryQFDB7jXXFJqhtzv4D+T
 Tqd8/dFZgd99w6gnQmGWZ1ILqaLC4LYB3ut5Y9oY+Fiw9P9UQE5kliHPn81ZbfHRmrbI 0A== 
Received: from p1lg14881.it.hpe.com (p1lg14881.it.hpe.com [16.230.97.202])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3hfaab8qd2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 21 Jul 2022 18:05:06 +0000
Received: from p1lg14886.dc01.its.hpecorp.net (unknown [10.119.18.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14881.it.hpe.com (Postfix) with ESMTPS id E69A88020A4;
        Thu, 21 Jul 2022 18:05:04 +0000 (UTC)
Received: from node1.hpecorp.net (unknown [16.231.227.36])
        by p1lg14886.dc01.its.hpecorp.net (Postfix) with ESMTP id ED6CC801AD9;
        Thu, 21 Jul 2022 18:05:03 +0000 (UTC)
From:   Toshi Kani <toshi.kani@hpe.com>
To:     bp@alien8.de, rrichter@marvell.com, mchehab@kernel.org
Cc:     toshi.kani@hpe.com, elliott@hpe.com, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, Borislav Petkov <bp@suse.de>
Subject: [PATCH v2] EDAC/ghes: Fix buffer overflow in ghes_edac_register()
Date:   Thu, 21 Jul 2022 12:05:03 -0600
Message-Id: <20220721180503.896050-1-toshi.kani@hpe.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: kEfQsczPnkoFRP-dfl_OjeLORelv4SG1
X-Proofpoint-ORIG-GUID: kEfQsczPnkoFRP-dfl_OjeLORelv4SG1
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-21_24,2022-07-21_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=999
 mlxscore=0 lowpriorityscore=0 spamscore=0 clxscore=1015 suspectscore=0
 bulkscore=0 impostorscore=0 phishscore=0 malwarescore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207210073
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

The following buffer overflow BUG was observed on an HPE system.
ghes_edac_register() called strlen() on an uninitialized label,
which had non-zero values from krealloc_array().

In dimm_setup_label(), *device was set but *bank was null, which
left the label uninitialized. *bank is set from SMBIOS type 17
Bank Locator, offset 11h.  This system had this value set to 0x0
(null string).

Change dimm_setup_label() to always initialize the label and use
"NA" in case bank or device is null.

 detected buffer overflow in __fortify_strlen
 ------------[ cut here ]------------
 kernel BUG at lib/string_helpers.c:983!
 invalid opcode: 0000 [#1] PREEMPT SMP NOPTI
 CPU: 1 PID: 1 Comm: swapper/0 Tainted: G          I       5.18.6-200.fc36.x86_64 #1
 Hardware name: HPE ProLiant DL360 Gen10/ProLiant DL360 Gen10, BIOS U32 03/15/2019
 RIP: 0010:fortify_panic+0xf/0x11
 ...
 Call Trace:
  <TASK>
  ghes_edac_register.cold+0x128/0x128
  ghes_probe+0x142/0x3a0
  platform_probe+0x41/0x90
  really_probe+0x19e/0x370
  __driver_probe_device+0xfc/0x170
  driver_probe_device+0x1f/0x90
  __driver_attach+0xbb/0x190
  ? __device_attach_driver+0xe0/0xe0
  bus_for_each_dev+0x5f/0x90
  bus_add_driver+0x159/0x200
  driver_register+0x89/0xd0
  acpi_ghes_init+0x72/0xc3
  acpi_init+0x441/0x493
  ? acpi_sleep_proc_init+0x24/0x24
  do_one_initcall+0x41/0x200

Fixes: b9cae27728d1f ("EDAC/ghes: Scan the system once on driver init")
Tested-by: Robert Elliott <elliott@hpe.com>
Signed-off-by: Toshi Kani <toshi.kani@hpe.com>
Cc: Robert Richter <rrichter@marvell.com>
Cc: Borislav Petkov <bp@suse.de>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
---
 drivers/edac/ghes_edac.c |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/edac/ghes_edac.c b/drivers/edac/ghes_edac.c
index 59b0bedc9c24..8256065b1801 100644
--- a/drivers/edac/ghes_edac.c
+++ b/drivers/edac/ghes_edac.c
@@ -100,12 +100,13 @@ static struct dimm_info *find_dimm_by_handle(struct mem_ctl_info *mci, u16 handl
 static void dimm_setup_label(struct dimm_info *dimm, u16 handle)
 {
 	const char *bank = NULL, *device = NULL;
+	const char *na = "NA";
 
 	dmi_memdev_name(handle, &bank, &device);
 
-	/* both strings must be non-zero */
-	if (bank && *bank && device && *device)
-		snprintf(dimm->label, sizeof(dimm->label), "%s %s", bank, device);
+	snprintf(dimm->label, sizeof(dimm->label), "%s %s",
+			(bank && *bank) ? bank : na,
+			(device && *device) ? device : na);
 }
 
 static void assign_dmi_dimm_info(struct dimm_info *dimm, struct memdev_dmi_entry *entry)
