Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C88A24C43B
	for <lists+linux-edac@lfdr.de>; Thu, 20 Aug 2020 19:10:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726946AbgHTRKy (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 20 Aug 2020 13:10:54 -0400
Received: from mail-dm6nam10on2071.outbound.protection.outlook.com ([40.107.93.71]:31070
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730285AbgHTRGv (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 20 Aug 2020 13:06:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h6bwJVg1lFKwKtCoOoRUkiUHT3dJE3DgEXi1ztP0Zxyn0zn97TxjB2kNw1zi1VTLmV+GwVBAJwEJbhQh8m+JEgRZ59rcGuG5+RbGCprCRxzhlhZrWVI1QUSqTEygLlJjFJfvQx3ka8PA2Ps9Y9kO6tQSb1TK3joF8dzb0eQ97HrIJw1xfRZFTY6wExyNsOn2y6iG/47FQp5GQAYxThVBVWi2QbLPXYBpAOKEoRUh+42ytbEUOrwXqoPNNmLPflJmBSuE3yZeDk6cc3QVlTockpXidcuOD629RBco7yxd4FMWbmuw12up3tdBPr+GPQULqoverR+8XU8of6adE14sVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6CCmaC8O8Z+Z2nkxbusO1E5t+kGU1TfGDjslFBXhPlE=;
 b=HtVxWpF6Ap9SSJjpwCfVTTdC/fdyTqOmul2x1QfAqO5D1bPu/ec8FErOFf3YvF2npiWNmatpCbZj+wNLNC2zTO86d7nMt8UqYSFLR9D8uWhniX5kXdhDN5+VNGox2WdC4KL9fZZ5GgeEtqbIYKAY7yBNre/mxTFd+JeYcQkXFlXT6PPkId9LbNInT+iT3sFfyO3rMZEk0wORuOVW75V6TpKytMx3dk5HsPpyTr/enTWHG67jV5E86XSBgJ6ZuTs4C85yt2hV6WxHEmAknrnU3z1KU1NZDGpsP41F2bWQJ8jIDsYas9/1n71iQFIYwBQCznBYCVahy/J1lvx627gEKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6CCmaC8O8Z+Z2nkxbusO1E5t+kGU1TfGDjslFBXhPlE=;
 b=jXgPzXqxQkkpAIng63f+4AaqFAWke/hGlqgGRugCabJihZNrIRJL/JAhtWn4LYUFfOvL2W2R0iFZc12jax4rpXfUa1XOa19eEqYSm7s4Nq1RaRWYsHPWIBBLZ9Hp+D9g2xr2s3nFA5lavi2UuBqLLwJY+JV5rD+Geg9t51Wukgo=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by BN8PR12MB3602.namprd12.prod.outlook.com (2603:10b6:408:49::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.25; Thu, 20 Aug
 2020 17:06:48 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::1ef:8f33:480b:e2d0]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::1ef:8f33:480b:e2d0%4]) with mapi id 15.20.3283.024; Thu, 20 Aug 2020
 17:06:48 +0000
From:   Yazen Ghannam <Yazen.Ghannam@amd.com>
To:     linux-edac@vger.kernel.org
Cc:     Yazen Ghannam <Yazen.Ghannam@amd.com>,
        linux-kernel@vger.kernel.org, bp@suse.de, tony.luck@intel.com,
        x86@kernel.org, Smita.KoralahalliChannabasappa@amd.com
Subject: [PATCH] x86/mce: Increase maximum number of banks to 64
Date:   Thu, 20 Aug 2020 17:06:24 +0000
Message-Id: <20200820170624.1855825-1-Yazen.Ghannam@amd.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DM6PR11CA0046.namprd11.prod.outlook.com
 (2603:10b6:5:14c::23) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from yaz-ethanolx.amd.com (165.204.78.2) by DM6PR11CA0046.namprd11.prod.outlook.com (2603:10b6:5:14c::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.24 via Frontend Transport; Thu, 20 Aug 2020 17:06:47 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [165.204.78.2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: a94b16ce-2602-44a0-8b59-08d8452b6c6d
X-MS-TrafficTypeDiagnostic: BN8PR12MB3602:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN8PR12MB36022F46857F155B9C0DFDF6F85A0@BN8PR12MB3602.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:800;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 80W2OuujGi44uMTiCz+6Wodb1kY71cqsaPQtLpVyRmF67riUCT6JAPzg5YKP8MTWQwtfPDDUSaCdrKFOoy9n3XxOpKkEj83W5EK3HltL0pY/QI6DsO5SvJhGQnakQVky+OCc6anvojcc5ZGWsco66jhlt7tkO7FfNoP8XBLPypwL6zakZhZ1OFSoPO8nY8zw63QTWdUOaFRZ1qB/vyqLk+toWs+Smm7qGc3iu77FkX5q78XBYycv33JtrwdwhlRmRzM2S6RRwPRu8Nn0AyiK+G/hkd/XN4hVbUsmozhrs3o1QyIv5ueVeOFTJDycC3ZsIAMA35dq/R/ovWUGP8Y4JA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(39860400002)(396003)(366004)(136003)(186003)(8936002)(16526019)(26005)(478600001)(4326008)(6666004)(1076003)(86362001)(5660300002)(6486002)(66946007)(8676002)(66476007)(316002)(956004)(7696005)(15650500001)(36756003)(2906002)(83380400001)(2616005)(52116002)(6916009)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 7DuMsL6+SY3X/K8Fn90yGKJira8TTCbhpopJZGezjXjDTTb0Dd9SigpJRW2Q+9UIFhmutCap0pmR5XZ/lxVqmFXlQnw3Ivoa7H73AxDk4qcLSpLgHgXV8neXAx0VC8YNtN0JyaRBWKgn64nVp10xMYUaDEav+oh0E1o3AAtz1IjdyqLNmEHbP77VZbBt3wBVrbIdvX0JzPxdHa7fHciT03tIJv7P5h1mjP23SNLA+v/uqLn9P9IPiPuNCcWZN061kJmg6Tb8OICDu4IQqeHiH/lhbVakqBTIoFRWxgXDXxEB2q0yuvl+DLMSMA4Cyc6xv280m9FsJfua1d3rKe1SVq2TGXQZeI1RRaEbEoG7lwPLv/yq3L3Pwh3ra9R/NPCXFMrmvu4+vTvPXSAnKkRweZRzsnbgvLOcqh9E0Irayb5YFd3TMGawWR2nEqehCefMeuZh2zmLcnkRqXbPglq3LW4nZ8YIKzV7VfPxAYzNgxgeO8lYG3nvoyETWDgvOkHS5wtA+ixn3nJCJB+VlcTY8AUWAz38wSz7NqYdDY85IRqeFiHXUL3uTg1Sz7hlaVg0J2C+wpmWtvINXpeKM7eeZ4XpyojJTwzdEeDb55HhPqB1uUauI93SanSZ8xf5+OqTc9uX309h89MmzZzpKxfakQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a94b16ce-2602-44a0-8b59-08d8452b6c6d
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2020 17:06:48.0462
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mX2a6M1hrRSLOt7NGx9Trj0XdfOTysYgC6CgYyCpnf9OujIQJyU4hChB2Gsmzo6oXuidpecHlivQpZXlN6/vnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3602
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Akshay Gupta <Akshay.Gupta@amd.com>

...because future AMD systems will support up to 64 MCA banks per CPU.

MAX_NR_BANKS is used to allocate a number of data structures, and it is
used as a ceiling for values read from MCG_CAP[Count]. Therefore, this
change will have no functional effect on existing systems with 32 or
fewer MCA banks per CPU.

Signed-off-by: Akshay Gupta <Akshay.Gupta@amd.com>
[ Adjust commit message and code comment. ]
Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
 arch/x86/include/asm/mce.h | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/mce.h b/arch/x86/include/asm/mce.h
index 6adced6e7dd3..109af5c7f515 100644
--- a/arch/x86/include/asm/mce.h
+++ b/arch/x86/include/asm/mce.h
@@ -200,12 +200,8 @@ void mce_setup(struct mce *m);
 void mce_log(struct mce *m);
 DECLARE_PER_CPU(struct device *, mce_device);
 
-/*
- * Maximum banks number.
- * This is the limit of the current register layout on
- * Intel CPUs.
- */
-#define MAX_NR_BANKS 32
+/* Maximum number of MCA banks per CPU. */
+#define MAX_NR_BANKS 64
 
 #ifdef CONFIG_X86_MCE_INTEL
 void mce_intel_feature_init(struct cpuinfo_x86 *c);
-- 
2.25.1

