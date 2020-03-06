Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B60DF17C17D
	for <lists+linux-edac@lfdr.de>; Fri,  6 Mar 2020 16:14:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727065AbgCFPOT (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 6 Mar 2020 10:14:19 -0500
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:21966 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727307AbgCFPON (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 6 Mar 2020 10:14:13 -0500
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 026F6mNs002765;
        Fri, 6 Mar 2020 07:14:01 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=pfpt0818;
 bh=9/boXRJsaGqBzf4vvZ2R1cpx9BE+bEHgcqbQTLi4S5A=;
 b=X5pRit43f0lnz8AA06y7SRqtfKOS/JIcaHD7emLrEuAT99iOWU7im8vHt6JTl1D3bXJ3
 qkZVa1pYzPUUg8ziuKKS8An4A8WRPGfGml09rP9lflZAgkP8mQF9FN6ImEoIL8I7iQKw
 gIfxPummx8HbLIZ2hoc18zeo1mvkaj4RotQURge+AZ2nW6RjIv9Uh++vPt27rZBFsbwx
 ZN26sB2G5CyU+f0vWDkOO3Xh40iUl8gZ3oxfnsXHNBvTRhpEtRJueCD9UVwcU94JZMXm
 j9YT+jyaMZd+c1mUgdcFI0GSkbpNzDD+3ZmW1RJV9wzaU23YrraqeO3tsdzZC3FyaxXP OA== 
Received: from sc-exch01.marvell.com ([199.233.58.181])
        by mx0a-0016f401.pphosted.com with ESMTP id 2yjnjhb2du-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 06 Mar 2020 07:14:01 -0800
Received: from SC-EXCH03.marvell.com (10.93.176.83) by SC-EXCH01.marvell.com
 (10.93.176.81) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 6 Mar
 2020 07:14:00 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by SC-EXCH03.marvell.com (10.93.176.83) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Fri, 6 Mar 2020 07:14:00 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V4dBdSrrW/zbaam+GpkmB3crEmFKfsgRNIlUylirKe8NmCYmWFOdkF4Dx9kOHboetMIZ9fsIAGNtDHK1YDpxOMSMBoXDp5KrksaOff1cM4PvSVyacpZJHbxhCr17VrN2pV6X2QBwj4hzGRzyNifcdzXsIG7pfdHUoDbEzYp1a27Qxc+xJpVPDqdKbf7fSpoMd0lSPxbr6PzrKVkGxAXvtMEes+Di7FXDQPZUpRJMUJGCP8G09JY4+iM9whehf5xQ15QvKBJ8MVrSEUnUQv/Q/ry7RvGqaMLOuOXR3x6CWD5jd9ZixQZjSZfqC9rJT7g1fYF4P3mSreIMmj7fgL6XMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9/boXRJsaGqBzf4vvZ2R1cpx9BE+bEHgcqbQTLi4S5A=;
 b=l6JAhMGdHgWJg7lfzqwhe7cxq6IXlDwVx2QBCXY0A4UrVj2rCmTqhwbN2SRiudqmbQGACdbwyOhMnZNcaiHjfIbqmXbc6D2bf3KHsgr+SC/kJgFDt7/IONKG/huQphkR3ZENqlwqAGuaX/6uelqBOAwDpfzVixa6SmHUzxYDchKKGomEH17mLtEsGTfKdx9rzE4qQ6waJtTvuHRLu36Qcl9nVj/4JpkfzApHgOyF3XWj3I8Krpybp8XQKqqbAQbLX8qfWic/bhB38tTWUXfYQxCEhiUmp+5uNHOd7DaIrlKXO/huhJPZHbXQ0GboimohqGGs9w5YYU/sVtSPELMrWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9/boXRJsaGqBzf4vvZ2R1cpx9BE+bEHgcqbQTLi4S5A=;
 b=qQT8H+lSDJ/2rk738UsEpMK4XBE6Wy4ALxmk1i+qPqzh5KnJQ1FrOsrqT0q1iULKNm5lWs3kut/LRsR5uipVBq9a/KQGtPSACaJ3jMQv8V7uRMwr3oKJojCbJ9KuUUJvV/+4XM95EE1YO0PxlE94WIxHAZrhQbD43Q7KEDxuL40=
Received: from MN2PR18MB3408.namprd18.prod.outlook.com (2603:10b6:208:165::10)
 by MN2PR18MB2400.namprd18.prod.outlook.com (2603:10b6:208:ab::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.14; Fri, 6 Mar
 2020 15:13:59 +0000
Received: from MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::30c4:52fe:fdf8:faff]) by MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::30c4:52fe:fdf8:faff%7]) with mapi id 15.20.2793.013; Fri, 6 Mar 2020
 15:13:59 +0000
From:   Robert Richter <rrichter@marvell.com>
To:     Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>
CC:     James Morse <james.morse@arm.com>,
        Aristeu Rozanski <aris@redhat.com>,
        Robert Richter <rrichter@marvell.com>,
        <linux-edac@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 10/11] EDAC/ghes: Create an own device for each mci
Date:   Fri,  6 Mar 2020 16:13:17 +0100
Message-ID: <20200306151318.17422-11-rrichter@marvell.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200306151318.17422-1-rrichter@marvell.com>
References: <20200306151318.17422-1-rrichter@marvell.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HE1PR0102CA0059.eurprd01.prod.exchangelabs.com
 (2603:10a6:7:7d::36) To MN2PR18MB3408.namprd18.prod.outlook.com
 (2603:10b6:208:165::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from rric.localdomain (31.208.96.227) by HE1PR0102CA0059.eurprd01.prod.exchangelabs.com (2603:10a6:7:7d::36) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.15 via Frontend Transport; Fri, 6 Mar 2020 15:13:57 +0000
X-Mailer: git-send-email 2.20.1
X-Originating-IP: [31.208.96.227]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b625be2d-2f08-4dd7-bbb3-08d7c1e0fed2
X-MS-TrafficTypeDiagnostic: MN2PR18MB2400:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR18MB24008D09DE91BCB03E0FBAEFD9E30@MN2PR18MB2400.namprd18.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2000;
X-Forefront-PRVS: 0334223192
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(346002)(39850400004)(396003)(366004)(136003)(199004)(189003)(81156014)(81166006)(5660300002)(8676002)(6666004)(54906003)(26005)(956004)(2616005)(4326008)(16526019)(316002)(110136005)(186003)(2906002)(8936002)(86362001)(6512007)(36756003)(478600001)(6486002)(1076003)(66556008)(52116002)(66946007)(66476007)(6506007);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB2400;H:MN2PR18MB3408.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K7sx/83Cxf7CoGwjd93LcNbgKh52A7B08t8MXiDrIoXTUx0sC+q0RqeTfrKy59fmEajmBxV7FR6FFQcw3i5bs0rb0RP6pgCq7z7c/6+6cTE2VwhPpCy0PA9PaTwuikL0tmjwXgWwphA6tSp6fR4W7oKfet+TOEIR5kTyDXVBy2vP8M3qy/oM/tsHDLHJnJgvC/DNi0yWXA+x3DYpuJWo9rizkC4fKiAV4HxSj+7RU2TK+LL6SRi93A0KEwK9RsRnVQZrBUm0ucdcExe19jT6JA20+p6MouJl3mlE73NDidmF2NblNfp7JawHKQmZIPZ1z2K8LF3YY0r8skRQvcbcjNBoLuGJfqUxLv7F+wB5nnKvylJG3MAXF+7GnoEJHxn72Mv3CSLJQHhVaBvf4BJaohzwvujOnN/MCvsNWCA2DQMGy8DjrG6K3/+EUKMmUjW3
X-MS-Exchange-AntiSpam-MessageData: g/5K07bQKrmUVGhQIoim16i6W3W2HuWJJCQu2x3S3+cXP/+VUSO/iSMkWlsjiJnqjz5pKuiCLEQ9UQAhiBqK6r2Q/N/C22KrZbYyu/g7ozjANMnTQUn6hA6cxUfG+IaaBZIrmUzb4WpQvRlOlkq3DA==
X-MS-Exchange-CrossTenant-Network-Message-Id: b625be2d-2f08-4dd7-bbb3-08d7c1e0fed2
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2020 15:13:59.0801
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IKSRLhSU9vGIw3Byq5d+N9UuhoySu83kUbF2wmHv6NoBS1IlMd36RGbO+Bv0UMIAOm1HriqEPI934eADnCChEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB2400
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-03-06_04:2020-03-06,2020-03-06 signatures=0
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Each edac mc must have a unique device for identification (see
add_mc_to_global_list()). This 1:1 mapping between parent device and
mci is a limitation for supporting multiple instances created by the
ghes driver. Solve this by creating an own device in between of the
ghes parent and the mci struct, this allows a 1:n mapping between
both.

Implement this using a platform device as this is the least possible
effort to create and free a device. It shows up nicely in sysfs:

 # find /sys/ -name ghes_mc*
 /sys/devices/platform/GHES.0/ghes_mc.1
 /sys/devices/platform/GHES.0/ghes_mc.0
 /sys/bus/platform/devices/ghes_mc.1
 /sys/bus/platform/devices/ghes_mc.0

Signed-off-by: Robert Richter <rrichter@marvell.com>
---
 drivers/edac/ghes_edac.c | 26 +++++++++++++++++++++++---
 1 file changed, 23 insertions(+), 3 deletions(-)

diff --git a/drivers/edac/ghes_edac.c b/drivers/edac/ghes_edac.c
index cd61b8ae49f6..64220397296e 100644
--- a/drivers/edac/ghes_edac.c
+++ b/drivers/edac/ghes_edac.c
@@ -539,6 +539,8 @@ static struct acpi_platform_list plat_list[] = {
 static struct mem_ctl_info *ghes_mc_create(struct device *dev, int mc_idx,
 					int num_dimm)
 {
+	struct platform_device_info pdevinfo;
+	struct platform_device *pdev;
 	struct edac_mc_layer layers[1];
 	struct mem_ctl_info *mci;
 	struct ghes_mci *pvt;
@@ -547,13 +549,23 @@ static struct mem_ctl_info *ghes_mc_create(struct device *dev, int mc_idx,
 	layers[0].size = num_dimm;
 	layers[0].is_virt_csrow = true;
 
+	pdevinfo	= (struct platform_device_info){
+		.parent	= dev,
+		.name	= "ghes_mc",
+		.id	= mc_idx,
+	};
+
+	pdev = platform_device_register_full(&pdevinfo);
+	if (IS_ERR(pdev))
+		goto fail;
+
 	mci = edac_mc_alloc(mc_idx, ARRAY_SIZE(layers), layers, sizeof(*pvt));
 	if (!mci)
-		return NULL;
+		goto fail;
 
 	pvt = mci->pvt_info;
 
-	mci->pdev = dev;
+	mci->pdev = &pdev->dev;
 	mci->mtype_cap = MEM_FLAG_EMPTY;
 	mci->edac_ctl_cap = EDAC_FLAG_NONE;
 	mci->edac_cap = EDAC_FLAG_NONE;
@@ -562,6 +574,11 @@ static struct mem_ctl_info *ghes_mc_create(struct device *dev, int mc_idx,
 	mci->dev_name = "ghes";
 
 	return mci;
+
+fail:
+	platform_device_unregister(pdev);
+
+	return NULL;
 }
 
 static int ghes_mc_add_or_free(struct mem_ctl_info *mci,
@@ -573,6 +590,7 @@ static int ghes_mc_add_or_free(struct mem_ctl_info *mci,
 	rc = edac_mc_add_mc(mci);
 	if (rc < 0) {
 		ghes_dimm_release(dimms);
+		platform_device_unregister(to_platform_device(mci->pdev));
 		edac_mc_free(mci);
 		return rc;
 	}
@@ -609,8 +627,10 @@ static void ghes_mc_free(void)
 		return;
 
 	mci = edac_mc_del_mc(mci->pdev);
-	if (mci)
+	if (mci) {
+		platform_device_unregister(to_platform_device(mci->pdev));
 		edac_mc_free(mci);
+	}
 }
 
 static int ghes_edac_register_fake(struct device *dev)
-- 
2.20.1

