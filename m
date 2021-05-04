Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A1C2372F2B
	for <lists+linux-edac@lfdr.de>; Tue,  4 May 2021 19:48:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232039AbhEDRtS (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 4 May 2021 13:49:18 -0400
Received: from mail-dm6nam11on2052.outbound.protection.outlook.com ([40.107.223.52]:41921
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232045AbhEDRtS (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 4 May 2021 13:49:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JhQ+Oj2hqVhYOGAyi3vdYtNOdGgmm8LKqmbTonX651Wfx0/q5oLkUsxlrq9ymbC9398bQJGHtOO0N4XlNGKDHPPBypyJljya9zYol+hSbdiIqWMkGqQkkyU4rH8bTdFF58sdFztsBOHFP7Ex592wpKALbR4NhVjQ3SqSoZZRoOy3L5yxgyateuZZcJxdZTUZ+ITLfCaSQhYYdXEsbA4pdxibigCpPbrq68LQ3cT4yddT4RKeKokbbV8+S/9SNSvw02TcqXKENz01fp/9RHnd/ibej88ReVmsydcP1B2L+NKdG3g5XwPpCsslJfQ0cAbhW5hv7u8tjaoL3VoWq18cGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=96cCY42XheRRAAcNN0LXKhrDouELERIod52zf1VCv1k=;
 b=dFMx0BZKDVvF2KLpGkHJOREjzIqxlcb28X8dmoDLydIOB6sDIbd1zx+afxJu2Pq5mjNoQrHkQPNTTSDsn80pvwY52XMj8Rn97mXfRhHcU0ZgRSRxV0sCgS3MZ1M7w4sCfzzH3433C8OojQig2CfGwBDEYutQ9JyKtxHzIrocc2PJys30zMqpOcLp2ovHchc/2HInLmi4wMp5P7v1MFlWPt2rAJ47npXXsA/6s9VCTresh+QyACJPmLCVtj5GW7XPdEX/VZzdTNlAuSjyREZbUZ6zEQ5n5Vr49r/wPXfnYRqJNiI53FldcslBwrRC3+38P6XxAFIRzMUZTNnGAaPgxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=96cCY42XheRRAAcNN0LXKhrDouELERIod52zf1VCv1k=;
 b=apGatA08OmUg/80OjJiKuLEN9KSpbmofxw/zwHvUlMLqvq7iDJ+Ss+0ftsNjwyuFahyg2Jt9lCiLcQguEDk/i9vD61IpgmgshgAlPwNiUeCiBUfZcM7+vdz/IBuPyj3NjvHRYK3se4oe6foDMsv+Nmdb4ofSAmoBQwYSNxd6pRA=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by BN6PR1201MB0212.namprd12.prod.outlook.com (2603:10b6:405:56::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.42; Tue, 4 May
 2021 17:48:18 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::418b:8ea0:dc4b:d211]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::418b:8ea0:dc4b:d211%6]) with mapi id 15.20.4065.039; Tue, 4 May 2021
 17:48:18 +0000
From:   Yazen Ghannam <Yazen.Ghannam@amd.com>
To:     linux-edac@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, tony.luck@intel.com, x86@kernel.org,
        Smita.KoralahalliChannabasappa@amd.com,
        Yazen Ghannam <yazen.ghannam@amd.com>
Subject: [PATCH 0/2] AMD Zen-based IF Unit Poison Quirk
Date:   Tue,  4 May 2021 17:47:10 +0000
Message-Id: <20210504174712.27675-1-Yazen.Ghannam@amd.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [165.204.184.1]
X-ClientProxiedBy: BN6PR18CA0013.namprd18.prod.outlook.com
 (2603:10b6:404:121::23) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ethanolx80b6host.amd.com (165.204.184.1) by BN6PR18CA0013.namprd18.prod.outlook.com (2603:10b6:404:121::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend Transport; Tue, 4 May 2021 17:48:17 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6d7cb7e3-fc74-4fcf-fd49-08d90f24ccd9
X-MS-TrafficTypeDiagnostic: BN6PR1201MB0212:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN6PR1201MB0212C0CB80D19AFDBB6CE757F85A9@BN6PR1201MB0212.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TKDfGFax5YZXH37ZAMdRf5Vqg7+/V2S8+MoNmr3lO5lBlwHWFPlv5G3Xmc+GXMbKqLagNtptL4lbn/nIE136MN8L34AgfAXwUTB6xLvV3iak3Y3tKl2/KaegtzIYkvHmZ7LOWzEPrCcItTVooZcHRqZ/6cD0lqAI+gFMO/9gR38ODRmXyc3+YbnFitjYVFGOnqNApechvdN3auQNiTw6kCkMZvUt9FWicDNWkF7yk/F6IlkTCX/6afJd/r5d7/Thra8qJxu0sjUZUnlNnI22El14fO1nt1Q/C72TMiFVFgrqtn5+DqNfGHix+NfjVKp/lDf6tmgc/crRuZkz2F6dmR/UaXlIxNFV81IrY3oo5aKS5QpZ6rJUbo0zVvKKp0xDNClWG+5Ian7X7y5hiH2AhGi4mzKhm+8ruRjd3ypzOlVXBue8OKFPSJE6gRqTIJwnd6FGw+9HMfQDEwpE69cb+X4O+Yi2o6itGWYTozkkMp45mx9ra86jiG22e9ywLvZqqEHfkLh4aAfiODJynHJfbUKw1sPMamDCuf8eukFg6QUjPIQDJKDs37IhSB+MVj/T3s2ruNzQlAfXyo6oAuY4/OAKA+6cinJCgHv8ncYhsIrLMuwnqYqHKLnWxWd8sfp4vzlCMnhAzpCkFRbtv7kToA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(346002)(396003)(136003)(376002)(366004)(66476007)(66946007)(8676002)(5660300002)(26005)(2906002)(38100700002)(38350700002)(6916009)(6486002)(478600001)(66556008)(86362001)(4744005)(1076003)(4326008)(186003)(36756003)(8936002)(316002)(956004)(6666004)(16526019)(7696005)(83380400001)(52116002)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?RhgQPiv+d5uWc7Da/jaTZysnuTpB3ocIhTfJtEfxU10I/NZ02YPpmlva1tp6?=
 =?us-ascii?Q?CkXGNdyeymhb5/QNZBlKeDkF/T1y3KG0IsEublA3fE+5Y59PUmjnR0bbmytd?=
 =?us-ascii?Q?nJ4Bsd8fqlnqMcSuP5SpVgmjVGMxrxXL9oCtK8mfLC6ygVMudO3tYiAPsiyu?=
 =?us-ascii?Q?7R3Qd8LqIBTO5P5fMQs8OWYJz8x5YixjmNXgo5FSB2KAQLC2TZpuYGjpdrIX?=
 =?us-ascii?Q?knC6M7w4yasLpOozkNw1ya9uABP+cXY0B7MdslaMQlGSc7dvVVfLJSNqVk5o?=
 =?us-ascii?Q?zuUWmBvhxKtXBVMn04HNcIETMexrUeaJbl4VRKOCdIZa//XkHITKQV4rdtcn?=
 =?us-ascii?Q?FTELDrYyOxEtAHHG4p3IfvXxppQxE9UZv8ec2AMUdHs/s5zAs65YbF4CnUzW?=
 =?us-ascii?Q?I0bZhvjaJRtrlVyiDkwGMbVncOYHO++d3u4DKZEi88gKf8wx4eKSC7l5Sw/A?=
 =?us-ascii?Q?2tJjBneQDqbq0jDobw2/qamprsnSMTuMmvS6JcFleR6iiKosmw0VHiCEkRXO?=
 =?us-ascii?Q?cORcYoliRBz05v236u7HXWOvTYMUKIMFlleBSHif6xFaH631biRoaDf1RfS9?=
 =?us-ascii?Q?gjyq8vwmEgDpdvz22llP4FayzbDIfNxZXKglFdecWffufril5Y/HEFbrAVh/?=
 =?us-ascii?Q?5hlC4Gca3llfzCYWRJv9moEndzdtelDXJO0QJ/VNAFcA0IEOZ+tHnnSmal2J?=
 =?us-ascii?Q?uosvFVM7jTuAtOO45twKq2lnQb6lN6QUksDN1L9C4+PMIif3c3aR/xsuuIkt?=
 =?us-ascii?Q?37a0UV90kj6f84L/GuQ7QtGvXZTi0OMzbOpHRwFF6aUwP1tExuB/t7tE4ugl?=
 =?us-ascii?Q?qVg3M7L1S6YPGK5N0i3/faO9yuyTfGyVI5VW9iyEVMDGR3PYf1FCnIQFlrzP?=
 =?us-ascii?Q?qEwnEiadKcEpv1OrqukvUvzRoqvmskbIIlHcYjrM4uWqYi2tyFAQHlwUzrcY?=
 =?us-ascii?Q?wDzI1ybs+3anyF409G/1vaMarDSj/qthAx3mpISLVY0RE2uDmA/uBxBZ1YWY?=
 =?us-ascii?Q?T00ulKPxNwfkkDxcGZ8PFupTHYoYgb+Pxl6CREuvoy+J+lFild2TjE82buWF?=
 =?us-ascii?Q?3/9yGHaJS3y42masPxYgh8N+o0PwoMGq4l3n05952L8JktpJhe3IP9WlWpoy?=
 =?us-ascii?Q?45eH050Qzdm7XJgVfcAAZczoc7QH/W9Ozs80/WVmYyynpizU0MI7h2DHilgp?=
 =?us-ascii?Q?sBOsHwyz6lFIipOYHxcw+dTh07lVVVJxzu9X9dpHhWyQCl93B3Eb845sPEyL?=
 =?us-ascii?Q?qe6ImXeBoZtc66TpdsHblWWtAxQgjWnZar6Z023qCq/J3E7lvqBzNr3G4NAF?=
 =?us-ascii?Q?/WrICC3M3cp1pt+N9waIE3D5?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d7cb7e3-fc74-4fcf-fd49-08d90f24ccd9
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2021 17:48:18.1702
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V0hd+HEAGljQMkuYG+5VJgyTTKjeedunb5nB+7PTtdiYVniog9XwGpNViedhcUFhK0BUxXVJg/AuGSmwh5Xvkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB0212
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Yazen Ghannam <yazen.ghannam@amd.com>

The Instruction Fetch unit on AMD Zen-based systems has a
microarchitectural quirk in which RIPV is not set on poison consumption
errors. However, the error is guaranteed to be delivered before a
context switch. Therefore, the CS register can be considered valid.

Patch 1 handles this behavior. Patch 2 addresses fallout from the change
in behavior in Patch 1.

Both patches Cc: stable because there have been bug reports that seem to
exhibit this behavior. There are no Fixes tags, because I don't think we
can point to specific commits that introduced this issue.

Thanks,
Yazen

Yazen Ghannam (2):
  x86/MCE: Always save CS register on AMD Zen IF errors
  x86/MCE: Don't call kill_me_now() directly

 arch/x86/kernel/cpu/mce/amd.c      | 17 +++++++++++++++++
 arch/x86/kernel/cpu/mce/core.c     | 12 ++++++++----
 arch/x86/kernel/cpu/mce/internal.h |  2 ++
 3 files changed, 27 insertions(+), 4 deletions(-)

-- 
2.25.1

