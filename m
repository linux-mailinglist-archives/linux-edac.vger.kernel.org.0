Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A821E57A994
	for <lists+linux-edac@lfdr.de>; Wed, 20 Jul 2022 00:01:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231635AbiGSWBz (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 19 Jul 2022 18:01:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231312AbiGSWBy (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 19 Jul 2022 18:01:54 -0400
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F24895FAE2;
        Tue, 19 Jul 2022 15:01:51 -0700 (PDT)
Received: from pps.filterd (m0134422.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26JLddaZ028927;
        Tue, 19 Jul 2022 22:01:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pps0720;
 bh=b80BmTHDUvxgWBfZpilq92cpE2prsuFHX+9J9zCJOHY=;
 b=CEqsIAL+zqLjfuQKWZMjNeehk2rQ51DvbAIPOu1ixprZYCjul14IckpA6EP+8KhJcN38
 0XXhWh65pv8/2BjjWQUmhjsWr64n9Dw5k0Q5ncNr903X+gRS4+EiFRRn0tfHQHkS7jAb
 3LbR972YUGMGmDfiqim/tEwWdpRbs8V+sf6IAd2PAy8LWiunX0Ii1r8rvO/rjZJ2NJKk
 bTtxaP9jLgw8+VgSdYIkCVuM8vJQ39nJ5+k6EhQN10X8Hwup3S6I2kJ1C0eIBHA62Wp4
 qEgoaGYD6jhUusIbN40KRV9zvJTmY896gBN+mkaUhbRfcYMslq8J7daTC5LkcA9cbSD1 lg== 
Received: from p1lg14880.it.hpe.com (p1lg14880.it.hpe.com [16.230.97.201])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3he4qcr4kf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 19 Jul 2022 22:01:27 +0000
Received: from p1lg14886.dc01.its.hpecorp.net (unknown [10.119.18.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14880.it.hpe.com (Postfix) with ESMTPS id 66179800234;
        Tue, 19 Jul 2022 22:01:26 +0000 (UTC)
Received: from node1.hpecorp.net (unknown [16.231.227.36])
        by p1lg14886.dc01.its.hpecorp.net (Postfix) with ESMTP id 7024E803965;
        Tue, 19 Jul 2022 22:01:24 +0000 (UTC)
From:   Toshi Kani <toshi.kani@hpe.com>
To:     bp@alien8.de, rrichter@marvell.com, mchehab@kernel.org
Cc:     toshi.kani@hpe.com, elliott@hpe.com, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, Borislav Petkov <bp@suse.de>
Subject: [PATCH] EDAC/ghes: Fix buffer overflow in ghes_edac_register()
Date:   Tue, 19 Jul 2022 16:01:24 -0600
Message-Id: <20220719220124.760359-1-toshi.kani@hpe.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: kXjlY3KTYTeeLIQ_X4HvqPMLR42WGhAv
X-Proofpoint-GUID: kXjlY3KTYTeeLIQ_X4HvqPMLR42WGhAv
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-19_08,2022-07-19_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 spamscore=0
 mlxscore=0 malwarescore=0 bulkscore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 clxscore=1011 adultscore=0 suspectscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207190090
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

The following buffer overflow BUG was observed on an HPE system.
ghes_edac_register() called strlen() on an uninitialized label,
which had non-zero values from krealloc_array().
Change dimm_setup_label() to always initialize the label.

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
 drivers/edac/ghes_edac.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/edac/ghes_edac.c b/drivers/edac/ghes_edac.c
index 59b0bedc9c24..3ad3d5fc45e0 100644
--- a/drivers/edac/ghes_edac.c
+++ b/drivers/edac/ghes_edac.c
@@ -106,6 +106,8 @@ static void dimm_setup_label(struct dimm_info *dimm, u16 handle)
 	/* both strings must be non-zero */
 	if (bank && *bank && device && *device)
 		snprintf(dimm->label, sizeof(dimm->label), "%s %s", bank, device);
+	else
+		dimm->label[0] = '\0';
 }
 
 static void assign_dmi_dimm_info(struct dimm_info *dimm, struct memdev_dmi_entry *entry)
