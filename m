Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2591646225D
	for <lists+linux-edac@lfdr.de>; Mon, 29 Nov 2021 21:41:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234858AbhK2Uor (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 29 Nov 2021 15:44:47 -0500
Received: from mail-bn8nam12on2112.outbound.protection.outlook.com ([40.107.237.112]:9312
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231459AbhK2Umq (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Mon, 29 Nov 2021 15:42:46 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l65i8vLorcSd0Pkhtk6fYpEKEqQkpS+LOiaH6oxHWtZ9OxQJzAAOGi8Y2N7p8Ds6jYcoEPRSqQb6dumVd7jvIklP+AWKbF6ESj66n1Vf3aIzXUoBFP9vg4Zr9BpuIWEbp5nES8eQbAsPlzqsxq+V000KpYoX4/ZDYA0v8VQpP4Vspk/HRjWFrG+5nofNnqA8x5BAX53PIYca1IPMWGGJOXOjZNMc45FDRdmEDaG+ylCSXXS7D4lGAKMacvuuh6u3ZBfQRoEbaFJZ0kIG27MIrd5XYyp0Zbxvc04ZxMrABlrWP1sSIFA0TfjItWVyxYX6VyAMTMDKXC2XNMt6IevnSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/uYaXPk1t0FeEp+SNmz53rFx0Ieq5Q4r7pSBIWfkbR4=;
 b=X9oMwJpnyB6uSfOY/UZBDBd+w5/QKZ0tMSVtIuKe/p8UjvchCG0tWjnCOuHuC1mjStq2qcHMx4XM+dyyuToji4ZOl3obflS0j5ozL09z4qtNWu97R28TpSyiYgcEIWwBmDPVd3A2qsQH9+5doV6G+CWDrIRj23DihPrzOW9rKKja/yBeqkmhKsFH2+EiyLWh4xx6Cta0GGLNsiyR6s9e+bQLIh4KxtJIcne7pqlagJUhj6/BFNe5zp2H42OnF2OVTkjKxeiJ/IhXDj7gdfNWddw6LOGhlw4L6pv/Av5YzyW5FDJBvUedaXpv93h9OYOVtT6kr5cMA2DUA3/xN3sRJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/uYaXPk1t0FeEp+SNmz53rFx0Ieq5Q4r7pSBIWfkbR4=;
 b=FI+aPc8TdslG2VYciZvkNC6KuiWIHzdT4WkJNc89gwM9uEKAvh6ubVmR3sgaFuVcZ5tGG3XcG/3pxlkIkogO7elZCkrK8fshRgxHPREAgpJdHYEqohTesEJhDTreD6+hXwO4U4WO2E9/9zpELKQmAVcsmY0nNQvsnM+4NAmRamg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SA0PR01MB6329.prod.exchangelabs.com (2603:10b6:806:ee::12) by
 SN6PR01MB4126.prod.exchangelabs.com (2603:10b6:805:a7::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4734.23; Mon, 29 Nov 2021 20:39:25 +0000
Received: from SA0PR01MB6329.prod.exchangelabs.com
 ([fe80::64f9:8e27:80ce:5410]) by SA0PR01MB6329.prod.exchangelabs.com
 ([fe80::64f9:8e27:80ce:5410%9]) with mapi id 15.20.4734.024; Mon, 29 Nov 2021
 20:39:25 +0000
Date:   Mon, 29 Nov 2021 12:39:23 -0800
From:   Darren Hart <darren@os.amperecomputing.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Tyler Baicar <baicar@os.amperecomputing.com>,
        patches@amperecomputing.com, abdulhamid@os.amperecomputing.com,
        catalin.marinas@arm.com, will@kernel.org, james.morse@arm.com,
        alexandru.elisei@arm.com, suzuki.poulose@arm.com,
        lorenzo.pieralisi@arm.com, guohanjun@huawei.com,
        sudeep.holla@arm.com, rafael@kernel.org, lenb@kernel.org,
        tony.luck@intel.com, bp@alien8.de, mark.rutland@arm.com,
        anshuman.khandual@arm.com, vincenzo.frascino@arm.com,
        tabba@google.com, marcan@marcan.st, keescook@chromium.org,
        jthierry@redhat.com, masahiroy@kernel.org, samitolvanen@google.com,
        john.garry@huawei.com, daniel.lezcano@linaro.org,
        gor@linux.ibm.com, zhangshaokun@hisilicon.com,
        tmricht@linux.ibm.com, dchinner@redhat.com, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kvmarm@lists.cs.columbia.edu, linux-acpi@vger.kernel.org,
        linux-edac@vger.kernel.org, ishii.shuuichir@fujitsu.com,
        Vineeth.Pillai@microsoft.com
Subject: Re: [PATCH 1/2] ACPI/AEST: Initial AEST driver
Message-ID: <YaU6eyGM+bX/bEhG@fedora>
References: <20211124170708.3874-1-baicar@os.amperecomputing.com>
 <20211124170708.3874-2-baicar@os.amperecomputing.com>
 <87czmpcto5.wl-maz@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87czmpcto5.wl-maz@kernel.org>
X-ClientProxiedBy: MWHPR19CA0087.namprd19.prod.outlook.com
 (2603:10b6:320:1f::25) To SA0PR01MB6329.prod.exchangelabs.com
 (2603:10b6:806:ee::12)
MIME-Version: 1.0
Received: from localhost (50.39.132.186) by MWHPR19CA0087.namprd19.prod.outlook.com (2603:10b6:320:1f::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23 via Frontend Transport; Mon, 29 Nov 2021 20:39:25 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 779e5638-7e97-417c-296f-08d9b3785500
X-MS-TrafficTypeDiagnostic: SN6PR01MB4126:
X-Microsoft-Antispam-PRVS: <SN6PR01MB4126DDFF769BE9A5D0BB1FDFF7669@SN6PR01MB4126.prod.exchangelabs.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bG6BmJ6ucW51r8N9S43lbk+sWKgLOivFVwjk4PjlFIlcSh5l+WPxJi0Q8lNvcM0XWNQmSjnGFeHs3EdJCwCnpihkx6Ax3ZvSbvdBexIEvQe/UYoTvkR2S9SoglUsZkKKiOnVuFhriUVxQUI/bABn84hMVlDeoi9GXpeC34NexPCwRHa+3ZP+a6nIKEdrTxQ34Y+E5IopwTAN4abPrr8uLNHDhK8nhfJ7tLD0YHvhYvFPyPipx2v9PBZ2Xr9iKnlHrHU6KP2cdnVypMO/emHzQNfVE3VtpyhE+/84NxTKBuan/KtQOX0rmjPJ406P+FOBWf1+tynwvXRDgvGol9F9fUDGjzVA8QTOsyhOjjcUooBq2kt3w4OlcIqElicdyQbcJtB7supTLu+SBtDdORL6PSjGcnWDx8IF6HvDxM8Hml6ESYrOQlK7RahuvuTPZ0lMBUG1TB9AjQOXno9KbQpbcDFCAcOKVPXUainN323W/O/Se9kWbAIEjkqyD1hbgFnNrzhsDgm+GOTAtT6yk0obouPGIqs81ecCUT3eh45t5cUlmNDY1BYAdHd6t+9clwHKWe3w8Mz8h0GES86/e53eBgf/NHSxFWl2qD3N1jD+KfuvEJP5dOa+0ZTntfA2+tF+SSi7nVWVvswUjB2d+A4DUqxHFQkpbyYOlWCWX4RnbrlO3+Tr66faRkIz54f60S/BY8kbYQjFjQDWY5bbVe5szw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR01MB6329.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(7916004)(4636009)(366004)(66476007)(5660300002)(66556008)(38100700002)(7406005)(38350700002)(33716001)(8936002)(4326008)(316002)(66946007)(83380400001)(86362001)(7416002)(6916009)(6486002)(508600001)(52116002)(956004)(8676002)(26005)(2906002)(6496006)(186003)(9686003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yu0dHnforDTz2GYvRqzc244tS6QmWjXFOJ7NNmrGpi0vZwiMRz2rWAh9NdRU?=
 =?us-ascii?Q?gIBS3m3ZXtgB7XFyG8GBakRh4WNHqlFxcBq91lc9DAWYmqjsKfWHRpE4Xzr8?=
 =?us-ascii?Q?Z7j4Ectovm1blOov0bsWGxJesANVnDXaraAIxK7B4ZBV7Bti0bx4SCQRybYb?=
 =?us-ascii?Q?ipVKomRpS15twsqZwANrZsjUiJesah72c3BecWY4cul4EgcjzCfF6nHiqGBk?=
 =?us-ascii?Q?J5GPs1uAnXm6eTDrEx1+B0XEREYOz1q50Ai6/X0EQ0WoF9Q50QctID8MrQG2?=
 =?us-ascii?Q?m6efB1xoH6KqN1HmOj3RKpddAdVWM7+br0uUVZcCqrfu85Eja5Jflw6rV3bq?=
 =?us-ascii?Q?DXv+qM9SWP9m75ZOIn8NM50eRPcYTDCblCLipopVpyaAwwXuQnI6KHcbi+JV?=
 =?us-ascii?Q?lKKIk9nEpBPAvxWmRQEVo5nnDclusYP2GFzFM/Vbje98XWzl7f1UHwUVpNsU?=
 =?us-ascii?Q?Yu7ZYv3uwyIi5biCgwmA8hckZZGK4y9PAg+mk2A8ZiYTm7mMA7z3VmtplDQW?=
 =?us-ascii?Q?xpHZXCW6/HhQUYDtZ6mcY1ba89UJ2SgzYokEciww/l/fmChTuMzIAcMnD3V3?=
 =?us-ascii?Q?NABevUsF/VSulv1croBKoaXjK31YG0LuGL1ZD/Y1fItdNV1vqK04jgsTNP3c?=
 =?us-ascii?Q?XDpuUg5J3jBxnblkLgUcH1YmVaz9AaVMBm+JbDc+iyY6rf/5ZivjAIxF+pzF?=
 =?us-ascii?Q?na/gClBVqtQYBK5DTW6PT2BMQ2ySgoqaWZd5zssLgoixmrmqY67Kejx2NnMX?=
 =?us-ascii?Q?DLve839pjoEBw5KA+cM1S/6CD0912fo+oM+T7mLWN824C3IPgz1dwsNkYoE3?=
 =?us-ascii?Q?FkHe/719UAp7HuVm90k8dmxdbVlCJNufe5WVzbU4pYdkl6mPfdvdpkR0/OWG?=
 =?us-ascii?Q?GVcVFPmM/YjXIpO2fpTL/JBpKw7TRxqw9/1pCoC7OvNPlYaRQGjbamxDJZN8?=
 =?us-ascii?Q?o3e0xINNBD09m7AP1l5kNM3653if3L9RmsTB/VeOOxjIxon/TGcwkpSeLb9Q?=
 =?us-ascii?Q?d42yNyKUkX9/W/S0O9sXP5VfQPrgFbFYjYx/yWB/HxC4D0u9kZ6U8Udw5Xy3?=
 =?us-ascii?Q?Lvrr2esZRaqeVZzf97b4v7gZfmoE1eSoikwbrn4EbcwWZ5KeV1Q4iJgxc0eb?=
 =?us-ascii?Q?2E/501HND5j1bREVggFRTF59AzcEWNCqqDJhkk4x0zkQdEknVWPvpeOOtPOz?=
 =?us-ascii?Q?9edK1mWDZELLb+opBz4f+K1loRhYTffNVpCuNijs96Ygz+7nO1KQRAR3JZrw?=
 =?us-ascii?Q?UVFft+4tVFRtgFi2dSv2KGJDn2FqR/WSeOBWVnv2+R1oB8vzY2tW35AkRDo8?=
 =?us-ascii?Q?lIeDB/AOpOXxdMY/lrsIWTPqI7+Z8k6fjxFYHCYSpoful0Roiy6lFtvzCjQ/?=
 =?us-ascii?Q?XIAFDYfMteeKTFgEbP6hsGATE8GR7jraiUvnpZgjpUPu2WAUs/9jTPCHlaTO?=
 =?us-ascii?Q?1s4rNnXo0oLHFfCRC4v2uRAjA3NTm36oDaxhWvUP3uI1yNcSTQdW2lKzdEln?=
 =?us-ascii?Q?F3MrWwf8i19MpMqp+yhVghKMwAJkRmoI9cjz8waIACvHsG64a6RAz9cZRd+m?=
 =?us-ascii?Q?jTTqB1mSA626gHLeRUFDDoYRm6IUg6bo5yjMdiEdPCRqAs2pIAlw7dob1kBy?=
 =?us-ascii?Q?axan057O3Ksk2S3rlC8kklNW6OXljIPuRzRxDREaSge4krrMMD8YMSGbn6VR?=
 =?us-ascii?Q?eay2OSunVYb6HtS0oMDxMNUZ95bp+lrWbL+DHdmzw8zJ4nEySj2p5DdkCgLd?=
 =?us-ascii?Q?39o5jXRzXQ=3D=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 779e5638-7e97-417c-296f-08d9b3785500
X-MS-Exchange-CrossTenant-AuthSource: SA0PR01MB6329.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2021 20:39:25.7299
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wN0/s26X7i8TRD+pYyIzzUo2nXbk8iMwpEA2jkFuBDBmwKZLsBVBBwTJREP26XSXQuJCFCgUSBBSgIhQDG75QLS+9nOxCEb1ntGhT/VQKWSiX36xv1gkUIeNob+9Rdvw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR01MB4126
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Wed, Nov 24, 2021 at 06:09:14PM +0000, Marc Zyngier wrote:
> On Wed, 24 Nov 2021 17:07:07 +0000,
> Tyler Baicar <baicar@os.amperecomputing.com> wrote:
> > 
> > Add support for parsing the ARM Error Source Table and basic handling of
> > errors reported through both memory mapped and system register interfaces.
> > 
> > Assume system register interfaces are only registered with private
> > peripheral interrupts (PPIs); otherwise there is no guarantee the
> > core handling the error is the core which took the error and has the
> > syndrome info in its system registers.
> > 
> > Add logging for all detected errors and trigger a kernel panic if there is
> > any uncorrected error present.
> > 
> > Signed-off-by: Tyler Baicar <baicar@os.amperecomputing.com>
> > ---
> >  MAINTAINERS                     |   1 +
> >  arch/arm64/include/asm/ras.h    |  52 ++++
> >  arch/arm64/include/asm/sysreg.h |   2 +
> >  arch/arm64/kernel/Makefile      |   1 +
> >  arch/arm64/kernel/ras.c         | 125 +++++++++
> >  arch/arm64/kvm/sys_regs.c       |   2 +
> >  drivers/acpi/arm64/Kconfig      |   3 +
> >  drivers/acpi/arm64/Makefile     |   1 +
> >  drivers/acpi/arm64/aest.c       | 450 ++++++++++++++++++++++++++++++++
> >  include/linux/acpi_aest.h       |  50 ++++
> >  include/linux/cpuhotplug.h      |   1 +
> >  11 files changed, 688 insertions(+)
> >  create mode 100644 arch/arm64/include/asm/ras.h
> >  create mode 100644 arch/arm64/kernel/ras.c
> >  create mode 100644 drivers/acpi/arm64/aest.c
> >  create mode 100644 include/linux/acpi_aest.h
> > 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 5250298d2817..aa0483726606 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -382,6 +382,7 @@ ACPI FOR ARM64 (ACPI/arm64)
> >  M:	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> >  M:	Hanjun Guo <guohanjun@huawei.com>
> >  M:	Sudeep Holla <sudeep.holla@arm.com>
> > +R:	Tyler Baicar <baicar@os.amperecomputing.com>
> >  L:	linux-acpi@vger.kernel.org
> >  L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
> >  S:	Maintained
> 
> Isn't this a bit premature? This isn't even mentioned in the commit
> message, only in passing in the cover letter.
> 

Hi Marc,

This was something I encouraged Tyler to add during internal review,
both in response to the checkpatch.pl warning about adding new drivers
as well as our interest in reviewing any future changes to the aest
driver. Since refactoring is common, this level made sense to me - but
would it be preferable to add a new entry for just the new driver Tyler
added?

Thanks,

-- 
Darren Hart
Ampere Computing / OS and Kernel
