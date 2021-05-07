Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 062D5376A6F
	for <lists+linux-edac@lfdr.de>; Fri,  7 May 2021 21:04:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229711AbhEGTE4 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 7 May 2021 15:04:56 -0400
Received: from mail-eopbgr770081.outbound.protection.outlook.com ([40.107.77.81]:44439
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229727AbhEGTEm (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Fri, 7 May 2021 15:04:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KTwhho/lWwac3LNK8/M+bl44xGiRXW3J6WUoK6dhJBxBvqnCXgoAeT7W8Tt33rwPQzR95fLTev6Fa5cvEW140XisGmIcVk/pHNZLC5dFUZSAe0sifDnCleEcB3vWAA4j54RHh6O49j6puE4KN+LaEz8NP3vs13FPjimgL9++HwTf0GfYQp6R7mjzWdcUx4wMq6cMkDVvwJ8/2pcXyMWuvuaAaYKsBDIZVZ7ZPp2CYFH289XGuDAaHk8yhY2E7kG2b4CJJvqWLvf8SFkNtQ2bQ9URuE8FecyTCRqY6uIabO8weqNgCTCj6HXpSq4Ax0xPjhPIhanI8uXqfXeBbyJA1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bpNrWwNk470htSu/eF7fYwRRLHNbVIaJfvMJFIkEZcA=;
 b=HF5mL7EqqAs5UVGJhojUR6QW9bLqXOgjyJXHg/kdH9U9vZAvfX4qpu8GpFwLJi2teaJAXeYYilVgw7cxbKV10ljXL8XRbiQxD7x+gv/ljgOi06EAaH0COYkPg9tJ++v7QoPh7uKHQr3jBeGMj/aobp4Z+CDqB8nhFjHbPs6VlWnBOFO2gkWzxB9mLjfXbXQSPBeMCDlFLHWNzyfogEc+gTMv03CktdChycadO5CyToyPe2A4KrJsPIJhlB95E/s71sr6u0dtzN5kFjwArQnUyCvzl3vBa1arjpCowW9r+cCtiHJ0qmLfse0mWi76SP5CYznYJojKgOQgbz+awIFZYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bpNrWwNk470htSu/eF7fYwRRLHNbVIaJfvMJFIkEZcA=;
 b=3bPk5PbGhETwJx1pkqcrjzQT4sEfcjGjMTp/ySHzB3LolxAPtynGqIhH/70H3aO/Vt4EZy3dMlFFcpxVLMKW8X5OszTZ3Etg9MY+hxBAFss8bb+Lj6xUfWS1S443MvRWSdrKNFUnaU+h3OOi2QT/RvAiPR2sIxr3VGaj9yvghCc=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by BN6PR12MB1620.namprd12.prod.outlook.com (2603:10b6:405:10::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.26; Fri, 7 May
 2021 19:02:18 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::418b:8ea0:dc4b:d211]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::418b:8ea0:dc4b:d211%6]) with mapi id 15.20.4108.029; Fri, 7 May 2021
 19:02:18 +0000
From:   Yazen Ghannam <Yazen.Ghannam@amd.com>
To:     linux-edac@vger.kernel.org
Cc:     Yazen Ghannam <Yazen.Ghannam@amd.com>,
        linux-kernel@vger.kernel.org, tony.luck@intel.com, x86@kernel.org,
        Smita.KoralahalliChannabasappa@amd.com
Subject: [PATCH 24/25] x86/MCE/AMD: Match hash function to reference code
Date:   Fri,  7 May 2021 15:01:39 -0400
Message-Id: <20210507190140.18854-25-Yazen.Ghannam@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210507190140.18854-1-Yazen.Ghannam@amd.com>
References: <20210507190140.18854-1-Yazen.Ghannam@amd.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [165.204.25.250]
X-ClientProxiedBy: BN6PR21CA0010.namprd21.prod.outlook.com
 (2603:10b6:404:8e::20) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from aus-x-yghannam.amd.com (165.204.25.250) by BN6PR21CA0010.namprd21.prod.outlook.com (2603:10b6:404:8e::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.3 via Frontend Transport; Fri, 7 May 2021 19:02:17 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e0aa19fb-7eba-4add-1f59-08d9118aa29a
X-MS-TrafficTypeDiagnostic: BN6PR12MB1620:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN6PR12MB1620F1B704A4CEE410B43C09F8579@BN6PR12MB1620.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ugDA3sqoENKJRmIs3XIGOfK6NfyxHmKvrRk2cBL0viVhEibZOUM02+QGJKsEItUS2F2k/SFBRpVldrwpvfmrps7zcxWzND/I54Tf0zvooSls6ppOqpYCGbbyYtColt/J/Za9reg9m/aqsMOeiWvyQyXKS2/O1eeXdR/XSDZqi3yvJZfqm+owX77TMIpkpvUEn8PEp5DEv09Q6LpS+S2EJU7o9gTMZOzE2Id17R7Q/lOCqDcRq+luZVCaOGeJArc7fn5vOLighL25hN3uBFTO2J3BIRjGUnDr5sZSOVEigLpEpM+aAfjXmwY+85eyq7UiXls/7Ejq15FVuPnKpqlkcd+GIH/QhpzHGKqshLnIh8PziidXp6mV2IyG/7febNZOnD731Iz3OfwWBlZga9C2aH3iYAaxEJpxej6A5fmRnMZ7MARirFAb5A+bRKxd0GL9wWNsZ8FU4mE/KSrYhVQkWYnb3gnycf0+nW612p31iaYkf29pAmxxu2L41N4pAj/hKqqe07dif48WRkgRoIIAz1UBPlRTn7hj/rNUmns9PPL7GADisIStOtiQyeP4rjvf3x+86ztNPBELPugMK13gREMKdPEPYKD0/BZg9FauJ8uuvI3p6c84J0j2IuB9eqIFn6vtx4WuNQNSfnMB6y/dg+r50FBX52yaGSrX/bAYm/s=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(376002)(136003)(366004)(39860400002)(346002)(4326008)(6666004)(38350700002)(38100700002)(66556008)(2906002)(26005)(6486002)(66476007)(1076003)(16526019)(86362001)(6916009)(66946007)(2616005)(956004)(186003)(5660300002)(36756003)(478600001)(316002)(52116002)(7696005)(8676002)(83380400001)(4744005)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?y/ZZpnyG1GL6uJx1pFj0EhFmJES27sVUrQKsjipb14yZZto0cXTH8NP4Vees?=
 =?us-ascii?Q?oBW8OMJzCDNc/W1GDsWTFBGMMjZY2YvdJ38+9UwlGLYwxjJkbmWRPEfGiWT4?=
 =?us-ascii?Q?pq3W01CTM1yRRdL7l9s7n9K2SNbQC1m5/ssmFiRNO1Pj2hiGWq8KxrT4HflT?=
 =?us-ascii?Q?CHJmwABuAE2rmGAIKu6qvGiD+aKbqf5sMBd75ogAnGgVm6bMrWCvP9PcaWha?=
 =?us-ascii?Q?ArDkYO1hJOIQRRTprAa8NZXAYrAJzKaSYVJ2VovKDvfMYYcRDBa7mc7oYtiN?=
 =?us-ascii?Q?0/kF9njEsHx0bbSUHXhEq2atK3nvjha3iFLuICkRqjhh3rSvDkvtYwuWjEUf?=
 =?us-ascii?Q?8AC7xQn2yg2liyOMvtrgbf1f4XRYyhu1HesrtB/8ns6asgcMu41xur+lIthw?=
 =?us-ascii?Q?wOb3KFo7LRTTZJcFw6hAsuGo2O9z1U+UYhzd2pdjW0IyYGAPrp6Qgu0OEQW3?=
 =?us-ascii?Q?h4asPtkQWWxkI5URyg18v7cPSXV6c1O5FPp6aHJDiwz5rE4emBt7836VN9YO?=
 =?us-ascii?Q?EDbFEeRUE6jWawlQ1v83EvbvPjms0Sdp/oCBhn7MFUFC0uCsH6veCKu2XLnB?=
 =?us-ascii?Q?Dzqbdulsn3/abzy7/3xYXlnVgG5OsNlxmuIIqXPtGbYhpD5T8klRpRM8cUyy?=
 =?us-ascii?Q?h4CXZkdAQRJyWYHAwMz/k5viC3SATgw+1KoxqXgqnEfiGcbH9kqNcjroGGQ5?=
 =?us-ascii?Q?MM592EAj4h3e0h0w07Srxym2lYDlDBVKNaWPd8d1aRe9bpUbH6Sn7pIiMfqc?=
 =?us-ascii?Q?N/8nZu/h49rPIAs74lvchh9+ArpEKIkhfsCzA3wp1vpdlSbrAhn385DK/7+0?=
 =?us-ascii?Q?R4Tq3/eplDQR5JzgagPP7R0MNlwvwTyuPl9tOu1Md2gqk4IqwY6skQJ1N8PY?=
 =?us-ascii?Q?1NjIBq1LIHRa+pJG2Vhgrqjl4vPlYoEnRBNiO8TJLY9KGRxbCtLmLdueP3on?=
 =?us-ascii?Q?afm4rpOHJ6cJL80uOALbc6yGhEigeIkhLGfC6XI+kDYAa6TOgWeqqIrBnY//?=
 =?us-ascii?Q?ieWKpuEDcYdScR8ZE8gz98NJXSec4EE3pjchaI5LnTLyoNhFq4ynZTaxGh04?=
 =?us-ascii?Q?OGwmtts1+iYj/1Z+z7qoPphToJP/kJUtTmDHEQecmO2LpiC5PU8N6g+D1prK?=
 =?us-ascii?Q?TP6c/DmHJCo6R7T5ut23wJgqGybaOPfO8rLqP8/dbpHh5uuPNxzWZLThIDm+?=
 =?us-ascii?Q?Egeh+uTnTEs6MvFzVQYWQWqWg4VvGUv7tv1xg5/I4pp0LiJfKLq7GozwKX2j?=
 =?us-ascii?Q?x+2upJy35j16tQj6LbHGQPMuRLov4fd0/bVHYnNmlYWe7NH8JBZvyYOuTW8Q?=
 =?us-ascii?Q?2TQ3lXR1HwX3n7D/X4aJq4UU?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0aa19fb-7eba-4add-1f59-08d9118aa29a
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2021 19:02:18.2843
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wuSOt4eMBQBY+X3JWiEDygVJLRzhzbg3+/Kwk5PHAJbOBVensN+tU5KPA7Re/70SqaniqzePg1rUkxUdlVJOhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1620
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Yazen Ghannam <yazen.ghannam@amd.com>

The reference code for DF2 hashing was changed to XOR the interleave
address bit rather than the CS ID. Match that here.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
 arch/x86/kernel/cpu/mce/amd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index 3340f8326681..b3bfdc42dcaa 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -1037,7 +1037,7 @@ static int dehash_addr_df2(struct addr_ctx *ctx)
 			(ctx->ret_addr >> 18) ^
 			(ctx->ret_addr >> 21) ^
 			(ctx->ret_addr >> 30) ^
-			ctx->cs_id;
+			(ctx->ret_addr >> ctx->intlv_addr_bit);
 
 	hashed_bit &= BIT(0);
 
-- 
2.25.1

