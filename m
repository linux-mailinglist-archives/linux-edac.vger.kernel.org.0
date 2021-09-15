Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 752C940D02D
	for <lists+linux-edac@lfdr.de>; Thu, 16 Sep 2021 01:29:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233094AbhIOX3y (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 15 Sep 2021 19:29:54 -0400
Received: from mail-bn8nam11on2045.outbound.protection.outlook.com ([40.107.236.45]:4704
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233065AbhIOX3v (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 15 Sep 2021 19:29:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EOsuRA8bbSrM5CB2+gICkyxXBYcB2fJI8i9ur0x/nEafeDs0nSBgWDxx1Yqh3AF587PhVhpK06Zdgr03mdTICh31TOQcrFm0FXfYMOQBotnTF3XvMXlv1UtbdFwxFPbFkk6KCxNUVzgCQI97s9LGwzz+44fdnSsKox84p60j5dUKpr7bVvyIrotC0UyHOcrxjD88hjf+W5e0HLV+Z9Vhkzf3zpexODP1ldDP2kqI9LUPOwHz6bIJbg2nSHzzBPVpkVMKDZTMBncDYdhbQzpa0H6W2PsuoCnHkOFyF/TUDPE3TnQft3v7MzgmrA3jrl1eqsXiLMnsLmz2G08MuBYSbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=UfD/GS0RCKIj4CPfUtQG0jMrco+XpppbQ7THZgimvaE=;
 b=DBMBAh4ngzL1054iD0TOVSqoIpAXpoifnlpIutGj/aywxxvqPFVDclaVU9QmdE3Y6y+bgsafFATXKBMa7aR3T5ro5IQrOr88PdLEWX1VZMPgZG+cZBmdBH5AMBObA0iSR86zycdhH1BzB1nxlyz+MnZfX3RFfm7DB9JjYlhLEkaZ96PqM54phwi2kl4fnzObmxPuHU10WK5zEb8+pd5JLMVvvOp07qJjU1SiA7uTp0W8OV28HqRY/OTaC1wj+fC6TiQFpuJKuuCvj6w/rum4ArDet8VjWEB2QPZ8tRT/Pn/EZcr0eRAR1KI0dtQ2MGckvx+I2t1Sibpg97vjYzV9nA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UfD/GS0RCKIj4CPfUtQG0jMrco+XpppbQ7THZgimvaE=;
 b=ntOJMqF+yIXS2YTZfWlQEf1LF6j+xcNc1YPfTUppM0n0aIkqDJryI64f6AwK+QJKPfTet3qMM3VyMacjQFdyDk/1QlQ80vopb/TXuZdNe8PdYOENaFviCaZjhwOwspDJY6gC1U78CPDdNnjupmg9gRVcGJugaI4bbFBmOL7vLD4=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2685.namprd12.prod.outlook.com (2603:10b6:805:67::33)
 by SA0PR12MB4512.namprd12.prod.outlook.com (2603:10b6:806:71::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Wed, 15 Sep
 2021 23:28:30 +0000
Received: from SN6PR12MB2685.namprd12.prod.outlook.com
 ([fe80::4913:ca1c:92c3:64c]) by SN6PR12MB2685.namprd12.prod.outlook.com
 ([fe80::4913:ca1c:92c3:64c%7]) with mapi id 15.20.4500.019; Wed, 15 Sep 2021
 23:28:30 +0000
From:   Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
To:     x86@kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Tony Luck <tony.luck@intel.com>, "H . Peter Anvin" <hpa@zytor.com>,
        yazen.ghannam@amd.com, Smita.KoralahalliChannabasappa@amd.com
Subject: [PATCH 5/5] x86/mce/mce-inject: Return error code to userspace from mce-inject module
Date:   Wed, 15 Sep 2021 18:27:39 -0500
Message-Id: <20210915232739.6367-6-Smita.KoralahalliChannabasappa@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210915232739.6367-1-Smita.KoralahalliChannabasappa@amd.com>
References: <20210915232739.6367-1-Smita.KoralahalliChannabasappa@amd.com>
Content-Type: text/plain
X-ClientProxiedBy: BN0PR04CA0045.namprd04.prod.outlook.com
 (2603:10b6:408:e8::20) To SN6PR12MB2685.namprd12.prod.outlook.com
 (2603:10b6:805:67::33)
MIME-Version: 1.0
Received: from ethanolx50f7host.amd.com (165.204.184.1) by BN0PR04CA0045.namprd04.prod.outlook.com (2603:10b6:408:e8::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14 via Frontend Transport; Wed, 15 Sep 2021 23:28:29 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 84436643-b4a0-4cdc-9b4a-08d978a086e6
X-MS-TrafficTypeDiagnostic: SA0PR12MB4512:
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR12MB451265B9271EB3B17A0D4CFD90DB9@SA0PR12MB4512.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2043;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jy+DdRQl1jScTYEjfIyEXhN1ls+kiWJ1kulEpbwdkn8D/a/2vv/SbfifnwJs3ld5aqX6+weTeqsrUEPJ8TA2Br+YHjU+c2Jb6dCyCopHaJ3qABUM8edQbFM+FaIQF7r/i7bZeE+fd+FyYFF3EllPCDLYMypurra9SIv/SE4lLhhdR/rWTfOHGjW2ytEn09jKUGGug+DvdnhStsBkyIZT6i6pdDOafxyR+wr4wtYphqOgaFxKwP/Pd8kn2NC9fGFkjPUMJ8BRdhsxgRbf9viFjjjc4SH6oQTiegMY9iSMuK8tGsY92UqhFfh3rVwl+/6j+bgi/oGHXtNObB/xqa+0/45y+M4ysqiyjM+wWXA79otpdErUutsNs9jnDodYLSPD4BnpCCibzS1P5dJxh4Vk0S3ki/EZ4uTd8j2Cw0E8/paOCABAP5IVmvdUqEw8T+ZoAXbYqe02Y7ymhk1xurg/+TQVALz4JpbFWHiICk/YHnkQESj8JBD4HjFF5eMsvmj98QGu1zLwlGM8cTWvuoFs9eHE5K8zRMIQ0AZDdimPPOkrTaBhmCtYsoEyhyyE7by1+LDvYPu2+LU2NegKZ00garjYfzfLvKY+aKM7nxJA6eE7neVevoWn+Hlx3WJWScR0KLmGnug2ksRzuDPdwqAy9NTVQnwN76dR/aQoqMEwyJVJ6Ym7ofbICV+Bbo9tzQMN2MaQ4ORx+2EGeldr4j9znA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2685.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(366004)(396003)(136003)(39860400002)(376002)(86362001)(956004)(2616005)(66946007)(4326008)(66476007)(83380400001)(26005)(478600001)(8676002)(2906002)(186003)(1076003)(7696005)(52116002)(4744005)(36756003)(5660300002)(54906003)(38100700002)(316002)(8936002)(38350700002)(6666004)(6486002)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DdOsrQ/sPozEPdvCxoudWwLim6bzc3VSRSDo25mIo08rh7vxq9kaJ9f6BkVW?=
 =?us-ascii?Q?mXe5OdrJAxRui2OCXCIxOd8P/72xtcQ4NxNDHZ9PmGEUD5/J3eyzjZjI0sL7?=
 =?us-ascii?Q?6ZnMUdygvBAPbEd+D3csPTh3kBCLfdh+IExL8+bQqE4mVvJImItcDTJbg06C?=
 =?us-ascii?Q?hQCN1ZEIkDZf0EawTPETb9tYzgAl0Rc0IJ8oeiw3ghJu0kNTUKx3PT078hcj?=
 =?us-ascii?Q?5xzyzezn4CmIDjlygSjMA5CjoFfyVkTi82OJTv4tjFVFEB+BWFPRb4utDz7g?=
 =?us-ascii?Q?O6988LOB22PzLPVh/W1si21FKjLDlgeyRZyAES/oA/i1s1EcNrcJf+8elO50?=
 =?us-ascii?Q?obcEvKfq4MxEmiAx1dtMiOpoT54m3oGjMocZjSLZY0KFD3xa3DUfq0UVONmK?=
 =?us-ascii?Q?PwMjUUbKC7DPlpyGIh4Q+LP80kj4FMpnqq+LzzJ2Rxff0G8SWzvzHSfG3RuA?=
 =?us-ascii?Q?rLvC9Yo4GACmGPY/ZryKu4fyxNdYcDlWjnrFGC0WAFltHl+oeSXlgoi8RTaS?=
 =?us-ascii?Q?6WoaQTIX6iGR4Curr4OLpzR03/8md6pfyENQAs19PUu5ZMwP/FzmdfJqsRI8?=
 =?us-ascii?Q?SkkDgjF2wQnJcPUWa62wc2IGmdCV/cwQ6dDf/Pk6/MHOdZJs8OBYfdE4AOBx?=
 =?us-ascii?Q?rSQEWhnTKKBhtP6g2EUM1mX7f5ZtO60HW7cwJeAWlETUTtLU4AEDOi2pYaMs?=
 =?us-ascii?Q?O7oPFme04zl6guwuwJ9FJjvsE3NT97WQ919oobnuT1jfYLs5VShP33ohISiF?=
 =?us-ascii?Q?KEQTi+YJbJYZprtzxqlnA+77lS6QqBCD4E9i0VtYQMFKRCseVhPIO8f2znpK?=
 =?us-ascii?Q?2y4ArqaHjXfSarfeg/HT9XmgHN0HnSZzS2KPzyJy4njdovAhdDuaKn4ka+iF?=
 =?us-ascii?Q?bHew1wuju3YbG22anBxrLfKJyu6LGrnf1040bO+Z/RK582hVgMF8ruefHWmu?=
 =?us-ascii?Q?eN2ue/STJyYpIJbmDifIPjc0WrKFu8DscOF8MHu9KTY8TaKieDP1Phba9ANj?=
 =?us-ascii?Q?uH3zDsPjv0SczqA5NwrDccLpfPSQ1ZnlA46d1FBwjZ+9P44i3EqKA25WFrz/?=
 =?us-ascii?Q?TBHAhESCX48SETTkwh7piFtNgytQod7d29KuiW+pJkJHC3tyl7TR9B8EO96b?=
 =?us-ascii?Q?VCbAyE8Z1roExcXAO20dHqcAnMdNHKm2acVsx+PAl2wgSb74HjlryBSam8eG?=
 =?us-ascii?Q?NKvz6iOLmZ7ESA9hLVspw12ULK2rtYjE2wyoHSS4HOwBp2MBGi0aQo6JxrZk?=
 =?us-ascii?Q?04DfvclZS5iz5cDpiRVEDpcvmD9C5mRqvtarW5RrtPEJzTQwW8RUyqIfkwvd?=
 =?us-ascii?Q?MB+MV1aqslwBKJnJkLqKbGbG?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84436643-b4a0-4cdc-9b4a-08d978a086e6
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2021 23:28:30.4595
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zd778/8LpXh7llUhiHKPCfOJZ9Fgo5FTCjSbHTe5ZMt2Ut7JSbIwV/QYinoTJ9LeK8TliitL1Ywx2ZOXbH5vmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4512
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Currently, the mce-inject module fails silently and user must look for
kernel logs to determine if the injection has succeeded.

Save time for the user and return error code from the module if error
injection fails.

Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
---
 arch/x86/kernel/cpu/mce/inject.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/inject.c b/arch/x86/kernel/cpu/mce/inject.c
index c7d1564f244b..0ef9ff921c6a 100644
--- a/arch/x86/kernel/cpu/mce/inject.c
+++ b/arch/x86/kernel/cpu/mce/inject.c
@@ -549,8 +549,10 @@ static void do_inject(void)
 	}
 
 	cpus_read_lock();
-	if (!cpu_online(cpu))
+	if (!cpu_online(cpu)) {
+		mce_err.err = -ENODEV;
 		goto err;
+	}
 
 	toggle_hw_mce_inject(cpu, true);
 
@@ -622,7 +624,7 @@ static int inj_bank_set(void *data, u64 val)
 	/* Reset injection struct */
 	setup_inj_struct(&i_mce);
 
-	return 0;
+	return mce_err.err;
 }
 
 MCE_INJECT_GET(bank);
-- 
2.17.1

