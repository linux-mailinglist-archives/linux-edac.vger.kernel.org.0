Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BA3F115A8B9
	for <lists+linux-edac@lfdr.de>; Wed, 12 Feb 2020 13:05:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728049AbgBLMEq (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 12 Feb 2020 07:04:46 -0500
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:37916 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728092AbgBLMEp (ORCPT
        <rfc822;linux-edac@vger.kernel.org>);
        Wed, 12 Feb 2020 07:04:45 -0500
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01CC0WuL008149;
        Wed, 12 Feb 2020 04:04:23 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=pfpt0818;
 bh=Qq2H3AB4e14/RebfiF7Vy1u8BhrrKY416MyJRIw1wwM=;
 b=sKaPBMJo6esSwc9JhDWdOYlKLj3dWrwf/3g2J84STrLbIa7udOmVUqhgiyWivGWm1XSG
 U0+3jEKFKGsUdp7eBMiTBAJZDEhQlulwH+A8FciHRKaBaeOeTSoL08d1vlVyJPJTG/1q
 YnIo+QRy2Zw2qQoVxGqQ577lSI9e6EU5T/gPlXypIHi+e6pJSM6albjnexQNqkO3aWEj
 79CNJE7987V+Vq9QxI86dtJ7oF4etakKWQhVq7CNo2on5Ct5jDOcgXMcCdavn52kg5li
 q91qEvKPDpUjfQVW4VYRe5oEnr+747M8unkEYVfNsK6FEGIppPowSn2kTGR4273XnXPv 4w== 
Received: from sc-exch03.marvell.com ([199.233.58.183])
        by mx0b-0016f401.pphosted.com with ESMTP id 2y1wcsqyw8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 12 Feb 2020 04:04:22 -0800
Received: from SC-EXCH01.marvell.com (10.93.176.81) by SC-EXCH03.marvell.com
 (10.93.176.83) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 12 Feb
 2020 04:04:20 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.102)
 by SC-EXCH01.marvell.com (10.93.176.81) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Wed, 12 Feb 2020 04:04:20 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f7FJgtzwnGX4yVU4hDFTl9sDUYGKXLHSGLbPQ96O4v00+d6lzQlZR/YgfhZcN61yRZhgKGN6x/0Qfba84ad39CGSZcP/jbr+ykvZrd2/48s9GM1TcetHNLdkvKLeFWzns/100gHTQSiUeB+oWIOwz62WeAQh8qI0dSRYB5Cd+HfE+HGUhta3QCBOOGfaSxw/5xxhUnePTRrqOY7MBSqYJNqPidqt0viWHdXp3pVJ2Di3yRIivez2vviSS9oy/Xc3Z2LOFlFyICf+2p3VusH5eflMYprWiOYSOYLfS1SuYa+1+co6oKGIgerW87gm6ucwFtCNRzX9yxFWDiiaxaZG6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qq2H3AB4e14/RebfiF7Vy1u8BhrrKY416MyJRIw1wwM=;
 b=aDKNKaZ+kgsbDdUzGrqX1sYa+FFgtyZu5TgCJv2jSipF+8TNsz6lejpAqSIEJBo9+jm0yRoFht2YCX+b7osEJvrmRxE25f7EPLLMRPEO+vQQqjLj4OrR1qI9lMXfAu9Y6rZPQjecpn5xIDyFGPKPsU3xwFEMKlYftWhhXVrFcUZtC00svqhP2pER9CDmGl3YH9WxGW2yvjZrmV2GrmPRXq+hXfscLgwzMDTbDDOsAfJg61HWoC5CUAPJneAiLkCNlueZtsE4ExA5FKDKWgggqNRkotvQCjrl+c0pZBYCfu6lZnOsmDjNf1uvEdbZb+W2X1lFJodVOohQ0noa/t8gZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qq2H3AB4e14/RebfiF7Vy1u8BhrrKY416MyJRIw1wwM=;
 b=LNyzlbAB7D4Y1OO3qkwE2nB6OplILRm87aKGRPS+2PKQZGA6IQAPnIviJ05KycmA7xz0iGJbRaZ5oens8OW+gGv8bVYkRsr+q7w4ucXowzZGR3M1a66Vz69M4x7GX7Gf+GwgYfaydVabRo7Fp8h3k8+C/yUPvzVLU9+AnXomlC0=
Received: from MN2PR18MB3408.namprd18.prod.outlook.com (10.255.237.10) by
 MN2PR18MB3512.namprd18.prod.outlook.com (20.180.247.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.27; Wed, 12 Feb 2020 12:04:19 +0000
Received: from MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::b96d:5663:6402:82ea]) by MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::b96d:5663:6402:82ea%7]) with mapi id 15.20.2707.030; Wed, 12 Feb 2020
 12:04:19 +0000
From:   Robert Richter <rrichter@marvell.com>
To:     Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>
CC:     James Morse <james.morse@arm.com>,
        Aristeu Rozanski <aris@redhat.com>,
        Robert Richter <rrichter@marvell.com>,
        <linux-edac@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH v3 2/4] EDAC/mc: Fix use-after-free and memleaks during device removal
Date:   Wed, 12 Feb 2020 13:03:38 +0100
Message-ID: <20200212120340.4764-3-rrichter@marvell.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200212120340.4764-1-rrichter@marvell.com>
References: <20200212120340.4764-1-rrichter@marvell.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HE1PR05CA0226.eurprd05.prod.outlook.com
 (2603:10a6:3:fa::26) To MN2PR18MB3408.namprd18.prod.outlook.com
 (2603:10b6:208:165::10)
MIME-Version: 1.0
Received: from rric.localdomain (31.208.96.227) by HE1PR05CA0226.eurprd05.prod.outlook.com (2603:10a6:3:fa::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2729.22 via Frontend Transport; Wed, 12 Feb 2020 12:04:17 +0000
X-Mailer: git-send-email 2.20.1
X-Originating-IP: [31.208.96.227]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d331fab5-6ca2-432a-7960-08d7afb3b093
X-MS-TrafficTypeDiagnostic: MN2PR18MB3512:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR18MB3512F75BD47570C76B5E992ED91B0@MN2PR18MB3512.namprd18.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:632;
X-Forefront-PRVS: 0311124FA9
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(136003)(376002)(39860400002)(346002)(396003)(189003)(199004)(8676002)(66476007)(66556008)(36756003)(66946007)(1076003)(6506007)(81156014)(53546011)(81166006)(6666004)(186003)(2906002)(478600001)(52116002)(8936002)(16526019)(5660300002)(26005)(6512007)(4326008)(6486002)(110136005)(54906003)(86362001)(316002)(2616005)(956004);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB3512;H:MN2PR18MB3408.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /ZXEmFuhnJ93870+dfYA/IwRv9c6WeC1vESUWErjSteMgnSQVO8mQwC7e0JbkbALeVB3L54raBI2HaVtyUa5uyv0URNESVWNmAFrJ4Jb7HXNDUqFROYc4tBOrQWfVKSmED7r7RkEaZufJGT/qfTD4Vf/9fDVfK6aMWf3+Thbf5ifQ1+xof/VgGwDS0pC4AOa1fTvrNbRMHzCRkZbfT1lORhhu4XhRLfpMTqgc/paqYh1W3o247pm8eQ0l0SYpV30cXu0Zl1exejo/P+HFN4Q/hbd/OnwW94iqsG1K5Doay4A+yxw70bjXKPBR2ReQ5YAtof2wfRqNO1O3Gd9G5Xw0596PYlx1rE6c+DWShVeN59ZAz2Eue7aTZWgo8AKSmsmaVukPEOnu/pCRQ4J2P65ohdzUrnxOK6Z//2/a7n0yfJr7qt81PUeipRCOFv89jkT
X-MS-Exchange-AntiSpam-MessageData: 7OM1pXJBqEaF8n+fpCe5mNTnlyOT5GCJ2xrj9hjs5DysrPkocVLjZML974ul4T5Ve6igLTWhWZePRYnp6Jaaf8JLOlEskLMzq50SxDtCeqazw5kTTZzrEjWTivRC25ipSnLgJvb3lUz6CitIHppNRw==
X-MS-Exchange-CrossTenant-Network-Message-Id: d331fab5-6ca2-432a-7960-08d7afb3b093
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2020 12:04:19.5374
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ybKwpSuEwY3faordwgt5Z6CfhBr5d4PMhc62YlJ4hK7Hmn80fHtspL5Suibz/DOC8z/p8pIdTrrpU9ov2rWjHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB3512
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-12_06:2020-02-11,2020-02-12 signatures=0
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

A test kernel with the options set below revealed several issues when
removing a mci device:

 DEBUG_TEST_DRIVER_REMOVE
 KASAN
 DEBUG_KMEMLEAK

Issues seen:

1) Use-after-free:

On 27.11.19 17:07:33, John Garry wrote:
> [   22.104498] BUG: KASAN: use-after-free in
> edac_remove_sysfs_mci_device+0x148/0x180

The use-after-free is caused by the mci_for_each_dimm() iterator that
is called in edac_remove_sysfs_mci_device(). The iterator was
introduced with commit c498afaf7df8 ("EDAC: Introduce an
mci_for_each_dimm() iterator"). The iterator loop calls function
device_unregister(&dimm->dev), which removes the sysfs entry of the
device, but also frees the dimm struct in dimm_attr_release(). When
incrementing the loop in mci_for_each_dimm(), the dimm struct is
accessed again, but it is already freed.

The fix is to free all the mci device's subsequent dimm and csrow
objects at a later point in _edac_mc_free() when the mci device is
freed. This keeps the data structures intact and the mci device can be
fully used until its removal. The change allows the save usage of
mci_for_each_dimm() to release dimm devices from sysfs.

2) Memory leaks:

Following memory leaks have been detected:

 # grep edac /sys/kernel/debug/kmemleak | sort | uniq -c
       1     [<000000003c0f58f9>] edac_mc_alloc+0x3bc/0x9d0      # mci->csrows
      16     [<00000000bb932dc0>] edac_mc_alloc+0x49c/0x9d0      # csr->channels
      16     [<00000000e2734dba>] edac_mc_alloc+0x518/0x9d0      # csr->channels[chn]
       1     [<00000000eb040168>] edac_mc_alloc+0x5c8/0x9d0      # mci->dimms
      34     [<00000000ef737c29>] ghes_edac_register+0x1c8/0x3f8 # see edac_mc_alloc()

All leaks are from memory created by edac_mc_alloc().

Note: The test above shows that edac_mc_alloc() was called here from
ghes_edac_register(), thus both functions show up in the stack dump,
but the driver causing the leaks is edac_mc. The comments with the
data structures involved were made manually by analyzing the objdump.

The data structures listed above and created by edac_mc_alloc() are
not properly removed during device removal, which is done in
edac_mc_free(). There are two paths implemented to remove the device
depending on device registration, _edac_mc_free() is called if the
device is not registered and edac_unregister_sysfs() otherwise. The
implemenations differ. For the sysfs case the mci device removal lacks
the removal of subsequent data structures (csrows, channels, dimms).
This causes the memory leaks (see mci_attr_release()).

Fixing this as follows:

Unify code and use the _edac_mc_free() code path to free the mci
struct and subsequent memory allocations. An effect of this is that no
data is freed in edac_mc_sysfs.c (except the "mc" sysfs root node).

The patch has been tested with the above kernel options, no issues
seen any longer.

To backport this patch to 5.4+ kernels, the previous revert patch
needs to be applied too or squashed with this patch to avoid
conflicts.

Reported-by: John Garry <john.garry@huawei.com>
Fixes: c498afaf7df8 ("EDAC: Introduce an mci_for_each_dimm() iterator")
Fixes: faa2ad09c01c ("edac_mc: edac_mc_free() cannot assume mem_ctl_info is registered in sysfs.")
Fixes: 7a623c039075 ("edac: rewrite the sysfs code to use struct device")
Signed-off-by: Robert Richter <rrichter@marvell.com>
---
 drivers/edac/edac_mc.c       | 12 +++---------
 drivers/edac/edac_mc_sysfs.c | 15 +++------------
 2 files changed, 6 insertions(+), 21 deletions(-)

diff --git a/drivers/edac/edac_mc.c b/drivers/edac/edac_mc.c
index 7243b88f81d8..69e0d90460e6 100644
--- a/drivers/edac/edac_mc.c
+++ b/drivers/edac/edac_mc.c
@@ -505,16 +505,10 @@ void edac_mc_free(struct mem_ctl_info *mci)
 {
 	edac_dbg(1, "\n");
 
-	/* If we're not yet registered with sysfs free only what was allocated
-	 * in edac_mc_alloc().
-	 */
-	if (!device_is_registered(&mci->dev)) {
-		_edac_mc_free(mci);
-		return;
-	}
+	if (device_is_registered(&mci->dev))
+		edac_unregister_sysfs(mci);
 
-	/* the mci instance is freed here, when the sysfs object is dropped */
-	edac_unregister_sysfs(mci);
+	_edac_mc_free(mci);
 }
 EXPORT_SYMBOL_GPL(edac_mc_free);
 
diff --git a/drivers/edac/edac_mc_sysfs.c b/drivers/edac/edac_mc_sysfs.c
index ba0937140fe4..1c9c6a7b9f66 100644
--- a/drivers/edac/edac_mc_sysfs.c
+++ b/drivers/edac/edac_mc_sysfs.c
@@ -276,10 +276,7 @@ static const struct attribute_group *csrow_attr_groups[] = {
 
 static void csrow_attr_release(struct device *dev)
 {
-	struct csrow_info *csrow = container_of(dev, struct csrow_info, dev);
-
-	edac_dbg(1, "Releasing csrow device %s\n", dev_name(dev));
-	kfree(csrow);
+	/* release device with _edac_mc_free() */
 }
 
 static const struct device_type csrow_attr_type = {
@@ -608,10 +605,7 @@ static const struct attribute_group *dimm_attr_groups[] = {
 
 static void dimm_attr_release(struct device *dev)
 {
-	struct dimm_info *dimm = container_of(dev, struct dimm_info, dev);
-
-	edac_dbg(1, "Releasing dimm device %s\n", dev_name(dev));
-	kfree(dimm);
+	/* release device with _edac_mc_free() */
 }
 
 static const struct device_type dimm_attr_type = {
@@ -893,10 +887,7 @@ static const struct attribute_group *mci_attr_groups[] = {
 
 static void mci_attr_release(struct device *dev)
 {
-	struct mem_ctl_info *mci = container_of(dev, struct mem_ctl_info, dev);
-
-	edac_dbg(1, "Releasing csrow device %s\n", dev_name(dev));
-	kfree(mci);
+	/* release device with _edac_mc_free() */
 }
 
 static const struct device_type mci_attr_type = {
-- 
2.20.1

