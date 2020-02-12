Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 20C0D15A8B4
	for <lists+linux-edac@lfdr.de>; Wed, 12 Feb 2020 13:05:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727675AbgBLMEf (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 12 Feb 2020 07:04:35 -0500
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:37472 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727535AbgBLMEf (ORCPT
        <rfc822;linux-edac@vger.kernel.org>);
        Wed, 12 Feb 2020 07:04:35 -0500
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01CC0KXV008063;
        Wed, 12 Feb 2020 04:04:21 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=pfpt0818;
 bh=ZmuyD3r3TiH1jVbJvMRegp/SV8TVnvHKsQgDMUG0nuQ=;
 b=sDpM0KUMazBqEtAPkm5rQDqSewU/cfTcvy2qeOykuRvTTadMDbhcKY8wFnOondqLfy+x
 +F38fdBje/bClCD/EMP279wqojXIbxvkTqftqAlIvwIzLqjKmT1VbcBvmRasCTqY+8cG
 4+NufUqVDd5rQUPaCvgvckzMUhK5dwFCaBfi2xw+ygW0ncM6dqSDsZ8pAipT+SXWFP7l
 QtS0ck2PZUo+B6IT845JQnbWilf/Wlt4XiG6L29A4PiDH2wqhS8+mAwdXEhaAIqqL9xE
 V1+wBrlZ5VMSp4NpXb0l6NZCQbZtfpKeUFFlOPvpB3dDRz1bXHkWDSDkpQCNJQzgq45o Bw== 
Received: from sc-exch04.marvell.com ([199.233.58.184])
        by mx0b-0016f401.pphosted.com with ESMTP id 2y1wcsqyw3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 12 Feb 2020 04:04:20 -0800
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by SC-EXCH04.marvell.com
 (10.93.176.84) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 12 Feb
 2020 04:04:18 -0800
Received: from SC-EXCH03.marvell.com (10.93.176.83) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 12 Feb
 2020 04:04:18 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.104)
 by SC-EXCH03.marvell.com (10.93.176.83) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Wed, 12 Feb 2020 04:04:17 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IdmkHTZ6U8YlYYKU+146LhulED1nBIP+YuVGDLn8261VdrWOtS6XVOGPsGG1aPTtMEahKV1Dhm3HYLJ+uFGLiS+iO4ftp5LU6KF0S51WP47UdNsgxkKQjHZQ1ombnyQ73fkp66KK1MKo0Dl8dYCjh8G4JQP5YlZTDI2M1baVSLsBd2uTEsfzJ0twyzjPC3X/R5GTCVIfdUzXANr7UyVZ6MPnoqaMRVOxU+osounIwApqwKPzbBW+FZpD9iB9gLOp+hNT2Qf8mwmGvClwH9XwJ+bnJUhysn/s/79/8iUgW9dYGhsWmZx2yJA+LAUGRycOUwn2sh+DM3e7CqVhWXR+rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZmuyD3r3TiH1jVbJvMRegp/SV8TVnvHKsQgDMUG0nuQ=;
 b=aHqJHaDk3f90ZKbeSFEjfaAH3f+yUgsb7Q2c3SxBa4mveZ3KZi8hgYI4rXhQOpIRA0TcR+54jO0mzEdQlgHLg31ovt/z8ox3BpHjJIrfNLoPGSeyEXzSUArt5Pqlrmtts67f5M7hEy7Fd6Hl36rLhD0za2p6fASJiPNHj/ILpTxkkrJzMHC0295i23prUixAzxAqKgiCWLW5+rPw0GijPHg/mUKH8b7ARAK+e5feGdRW9poXLc+81E2dUwtj0ys5z16+v8FHdz9zSRvm5VFeKkY6a0a0u0odWdn9y02NTxIUdrx1bjbw4rKtUy52koR9Pit9jd231Z2Y1pcJJ25Bww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZmuyD3r3TiH1jVbJvMRegp/SV8TVnvHKsQgDMUG0nuQ=;
 b=SWYMlTvKjaVXzfjtRozQkagP+xncFHdbvdl1iZV46/FadIgT2V2MQeuSlMW/vezIOAZfbnbXjj5DUCLuq/MdJv3lCFKa7w/vLYil5tAJ02DLSRgQUhVCE9jjmH2t2ISA6Mp5t1/U5BlgiYdm7wFmUUQwwWT8wKcouT8WnAHFyMI=
Received: from MN2PR18MB3408.namprd18.prod.outlook.com (10.255.237.10) by
 MN2PR18MB3512.namprd18.prod.outlook.com (20.180.247.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.27; Wed, 12 Feb 2020 12:04:17 +0000
Received: from MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::b96d:5663:6402:82ea]) by MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::b96d:5663:6402:82ea%7]) with mapi id 15.20.2707.030; Wed, 12 Feb 2020
 12:04:17 +0000
From:   Robert Richter <rrichter@marvell.com>
To:     Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>
CC:     James Morse <james.morse@arm.com>,
        Aristeu Rozanski <aris@redhat.com>,
        Robert Richter <rrichter@marvell.com>,
        <linux-edac@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 1/4] Revert parts of "EDAC/mc_sysfs: Make debug messages consistent"
Date:   Wed, 12 Feb 2020 13:03:37 +0100
Message-ID: <20200212120340.4764-2-rrichter@marvell.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200212120340.4764-1-rrichter@marvell.com>
References: <20200212120340.4764-1-rrichter@marvell.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HE1PR05CA0226.eurprd05.prod.outlook.com
 (2603:10a6:3:fa::26) To MN2PR18MB3408.namprd18.prod.outlook.com
 (2603:10b6:208:165::10)
MIME-Version: 1.0
Received: from rric.localdomain (31.208.96.227) by HE1PR05CA0226.eurprd05.prod.outlook.com (2603:10a6:3:fa::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2729.22 via Frontend Transport; Wed, 12 Feb 2020 12:04:15 +0000
X-Mailer: git-send-email 2.20.1
X-Originating-IP: [31.208.96.227]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2c02f96d-83a0-43dc-884a-08d7afb3af41
X-MS-TrafficTypeDiagnostic: MN2PR18MB3512:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR18MB3512E4DB40001977806FC477D91B0@MN2PR18MB3512.namprd18.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:62;
X-Forefront-PRVS: 0311124FA9
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(136003)(376002)(39860400002)(346002)(396003)(189003)(199004)(8676002)(66476007)(66556008)(36756003)(66946007)(1076003)(6506007)(81156014)(81166006)(6666004)(186003)(2906002)(478600001)(52116002)(8936002)(16526019)(5660300002)(26005)(6512007)(4326008)(6486002)(110136005)(54906003)(86362001)(316002)(2616005)(956004);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB3512;H:MN2PR18MB3408.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: V4G38hreeuIIOSVtVOdROFpUhqbf9dyIFlUZVxygDCb/fmIZGO7lXxtP3Z/4GF4brkeCxnx+fsg5bVScHdzZ2NT3Q82VUXOmyT75wqZK+qHJjFkEKGxSLP+Pw6R7AGKg/sIEKtcqdS6CSztvnwusGC3ZgpwbOjFA7ZK/O2AAJNnCoxQX8ykCOvvks8fsLnLOD1rruAWzCEHg7ptu/QNpnFce/PWKrNRPY3eE1m/ygfN3vKVwGXk+uIZ2gJ+xaNYQOtVOoK5MkyBeT8rVuiR38kK0wgnc2FgDpsDTVt/GkjbhxZBZtDdqkGwvvUXM2ezHH9o8SML6iKBBw1uc6P9Hqy1epl2I3XgXmq8z6JPhXugb99t92BVXMQwXgHoPlehwzRtheYsbk0ImkMpNGKaHHa9Yrqw86q1IbxvMgG5zMmNqSXq+G4HcxvAukM3fo3JL
X-MS-Exchange-AntiSpam-MessageData: GxiMat+jR2LSjE2rdQ7nZQI1pv/KajAJecYRSdVIfzH6+ESBuJ6Ah2+THXpXwAzHB+DbW8lCtmBjhQBXF1III6ztpf3xZBzOsxJCStS3dj4ytmF5+C5LBGcsxJqpzGT2xGIsOS+flpUyxrHoK8vgeg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c02f96d-83a0-43dc-884a-08d7afb3af41
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2020 12:04:17.2227
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xFj/Y+giq4PsoH8hMLVghkO+BF3cwa5hXE7SfVEQP96Qad+u03zkBEk7Bf60QcU5GO16GJQUsC3EMvvqllI+0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB3512
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-12_06:2020-02-11,2020-02-12 signatures=0
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

This reverts parts of commit e701f412030ec3783f1c30c7741492693d6213e3.

Revert a couple of changes to ease stable backports of the next fix on
top of this commit. Due to this revert the next patch will apply
without conflicts on 5.3 based or earlier kernels. As the code
introduced by the revert will be removed, the resulting code of the
fix will be the same as without the revert.

Signed-off-by: Robert Richter <rrichter@marvell.com>
---
 drivers/edac/edac_mc_sysfs.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/edac/edac_mc_sysfs.c b/drivers/edac/edac_mc_sysfs.c
index 0367554e7437..ba0937140fe4 100644
--- a/drivers/edac/edac_mc_sysfs.c
+++ b/drivers/edac/edac_mc_sysfs.c
@@ -278,7 +278,7 @@ static void csrow_attr_release(struct device *dev)
 {
 	struct csrow_info *csrow = container_of(dev, struct csrow_info, dev);
 
-	edac_dbg(1, "device %s released\n", dev_name(dev));
+	edac_dbg(1, "Releasing csrow device %s\n", dev_name(dev));
 	kfree(csrow);
 }
 
@@ -610,7 +610,7 @@ static void dimm_attr_release(struct device *dev)
 {
 	struct dimm_info *dimm = container_of(dev, struct dimm_info, dev);
 
-	edac_dbg(1, "device %s released\n", dev_name(dev));
+	edac_dbg(1, "Releasing dimm device %s\n", dev_name(dev));
 	kfree(dimm);
 }
 
@@ -895,7 +895,7 @@ static void mci_attr_release(struct device *dev)
 {
 	struct mem_ctl_info *mci = container_of(dev, struct mem_ctl_info, dev);
 
-	edac_dbg(1, "device %s released\n", dev_name(dev));
+	edac_dbg(1, "Releasing csrow device %s\n", dev_name(dev));
 	kfree(mci);
 }
 
-- 
2.20.1

