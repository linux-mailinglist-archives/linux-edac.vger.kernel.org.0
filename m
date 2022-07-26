Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E16CC5817C8
	for <lists+linux-edac@lfdr.de>; Tue, 26 Jul 2022 18:46:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229747AbiGZQqx (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 26 Jul 2022 12:46:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbiGZQqw (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 26 Jul 2022 12:46:52 -0400
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A24D1148;
        Tue, 26 Jul 2022 09:46:49 -0700 (PDT)
Received: from pps.filterd (m0148664.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26QEW9gL003111;
        Tue, 26 Jul 2022 16:46:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pps0720;
 bh=uS1MGlPUgaNKgZxxo7vKiN1NvWRyGLcRebrPWn5jCHE=;
 b=iPXImH60lC0C0x89taIkoWrbBfIX64QjBXStw5YlQ9iWnbbnThCEJLmehQs9dVw5UqTd
 MbSaODC/KF0Pl8g+bAAEcqy/+P76oghuaq9RH+24I6CJUCeNkQfHggOHev0OPwaeYOI0
 EGMABiIVWSHHQP/Ynu+alAW04xFANdgO7rUE8bAAWkq9zJvrownbahxqDRnR3rfjSZi8
 aaNy5U13z299YTmxr2E8Rzg3p4peij81z87l/KzCHhD0JmI2rQufhL7cRSgDH65ZRrKu
 FSlBFpqIgNCJQiZ2RdiUcYl4EbOB5Bpg0KufXnqSzJ8waWUEMJOqaFxFdG5WjAxBGTBt qQ== 
Received: from p1lg14878.it.hpe.com (p1lg14878.it.hpe.com [16.230.97.204])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3hjew9ufv6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 Jul 2022 16:46:35 +0000
Received: from p1lg14885.dc01.its.hpecorp.net (unknown [10.119.18.236])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14878.it.hpe.com (Postfix) with ESMTPS id EB714D2CA;
        Tue, 26 Jul 2022 16:46:29 +0000 (UTC)
Received: from node1.hpecorp.net (unknown [16.231.227.36])
        by p1lg14885.dc01.its.hpecorp.net (Postfix) with ESMTP id 0E27A8041D3;
        Tue, 26 Jul 2022 16:46:28 +0000 (UTC)
From:   Toshi Kani <toshi.kani@hpe.com>
To:     bp@alien8.de, rric@kernel.org, mchehab@kernel.org
Cc:     toshi.kani@hpe.com, elliott@hpe.com, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3] EDAC/ghes: Set the DIMM label unconditionally
Date:   Tue, 26 Jul 2022 10:46:28 -0600
Message-Id: <20220726164628.1756924-1-toshi.kani@hpe.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: aupQqHlnyKAZUQCBZy1PbXMj4kEUfmSY
X-Proofpoint-GUID: aupQqHlnyKAZUQCBZy1PbXMj4kEUfmSY
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-26_05,2022-07-26_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 malwarescore=0 impostorscore=0 mlxlogscore=999
 phishscore=0 adultscore=0 lowpriorityscore=0 mlxscore=0 suspectscore=0
 bulkscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207260065
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

  detected buffer overflow in __fortify_strlen
   ------------[ cut here ]------------
   kernel BUG at lib/string_helpers.c:983!
   invalid opcode: 0000 [#1] PREEMPT SMP NOPTI
   CPU: 1 PID: 1 Comm: swapper/0 Tainted: G          I       5.18.6-200.fc36.x86_64 #1
   Hardware name: HPE ProLiant DL360 Gen10/ProLiant DL360 Gen10, BIOS U32 03/15/2019
   RIP: 0010:fortify_panic
   ...
   Call Trace:
    <TASK>
    ghes_edac_register.cold
    ghes_probe
    platform_probe
    really_probe
    __driver_probe_device
    driver_probe_device
    __driver_attach
    ? __device_attach_driver
    bus_for_each_dev
    bus_add_driver
    driver_register
    acpi_ghes_init
    acpi_init
    ? acpi_sleep_proc_init
    do_one_initcall

dimm_setup_label() only initializes the label when both bank and
device are set.  This HPE BIOS only sets device since bank locator
is unnecessary to locate a DIMM.

  Handle 0x0020, DMI type 17, 84 bytes
  Memory Device
          Array Handle: 0x0013
          Error Information Handle: Not Provided
          Total Width: 72 bits
          Data Width: 64 bits
          Size: 32 GB
          Form Factor: DIMM
          Set: None
          Locator: PROC 1 DIMM 1        <=== device
          Bank Locator: Not Specified   <=== bank

Change dimm_setup_label() to always initialize the label to fix the
issue.  It sets to a null string in case BIOS does not provide both
bank and device so that ghes_edac_register() keeps the default label
from edac_mc_alloc_dimms().

Fixes: b9cae27728d1f ("EDAC/ghes: Scan the system once on driver init")
Signed-off-by: Toshi Kani <toshi.kani@hpe.com>
Co-developed-by: Robert Richter <rric@kernel.org>
Tested-by: Robert Elliott <elliott@hpe.com>
---
 drivers/edac/ghes_edac.c |   12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/edac/ghes_edac.c b/drivers/edac/ghes_edac.c
index 59b0bedc9c24..c229ed0ce678 100644
--- a/drivers/edac/ghes_edac.c
+++ b/drivers/edac/ghes_edac.c
@@ -103,9 +103,15 @@ static void dimm_setup_label(struct dimm_info *dimm, u16 handle)
 
 	dmi_memdev_name(handle, &bank, &device);
 
-	/* both strings must be non-zero */
-	if (bank && *bank && device && *device)
-		snprintf(dimm->label, sizeof(dimm->label), "%s %s", bank, device);
+	/* 
+	 * Set a null string when both bank and device are zero.
+	 * This keeps ghes_edac_register() preserving the default
+	 * label from edac_mc_alloc_dimms().
+	 */
+	snprintf(dimm->label, sizeof(dimm->label), "%s%s%s",
+			(bank && *bank) ? bank : "",
+			(bank && *bank && device && *device) ? " " : "",
+			(device && *device) ? device : "");
 }
 
 static void assign_dmi_dimm_info(struct dimm_info *dimm, struct memdev_dmi_entry *entry)
