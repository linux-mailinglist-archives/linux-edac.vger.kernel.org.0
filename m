Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8D2E3FE247
	for <lists+linux-edac@lfdr.de>; Wed,  1 Sep 2021 20:17:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344384AbhIASS3 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 1 Sep 2021 14:18:29 -0400
Received: from mail-dm6nam11on2082.outbound.protection.outlook.com ([40.107.223.82]:43872
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230063AbhIASS3 (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 1 Sep 2021 14:18:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=InyzQ2xL2l/+hZcrsAvw+BNavTq/V3fFESDHUtMeoDIYpjq1XZtG/EOsL38hYvU9qDJu64HhPYNxdY230LsWgInaTsTKSiPC5xOBJmj+lYV+iCAeg2LAH4seRO27AaipcHxnxy8qvs/nfKdf18w1l42B6yuBJ1ZuOigIhZPWTkAqMl35oyZEO7OyjpyFpeYT8e7HFy1klKa2cs6BUm2iAuayhY4ZhUqAIBsKascaf/+yUiUQIZPpHZfPzNG9plElLhEQLQ+bTqH2k/xVi9QNzsIqAz0Bfq5V7gUplVSKi/0TzmkJCnL7lJ3svEbob0BsEbHfV16yB6VkI9AvtNAzFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pByIuFVCs0ancoZARuutkQoNNTSHqHiFn8E2ji6kDtE=;
 b=VhE9JVscEfJcRu3fztgWnKBF0fsTcA6DY9r4nyTJXzypNbV1yx+02WQmdLD6X8YsrHYnOEKTeWuiqEp+1WkFFUnIpzQyWZHfXL3TXwOFPW7l3vUt27g3pRivVLGkflnji83H5BzjR0nGNy261izyrKW1B7zr8rUQAQU0Xc1sZi+CmtQm+zKWNlIvOyik2K2HY4LTJ2zDrVr7F8L4uZFiFgAznuKTBatj7jryRb/X49kboWRr1R3Bi3N8HF8GQj/UGXiGuikQH5DUL8eZOtBiQ6M2o47z/6yCvMICoSGhJIGryn+lWYZUC2yhgwFNOSrVVVKBnioHxXevChaSuWvwYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pByIuFVCs0ancoZARuutkQoNNTSHqHiFn8E2ji6kDtE=;
 b=KnFTkezZAL7Y9icnDrivMwA3Rdr1ebGsAZb5ydEuBkquQDVNVAjBKzpCSBJO84ILM4ClwGF/R8vbNvXBlDpQGsWajH0v6gn07yGrki7jOjPJM7VjXhejR9toslm2zS7GH8OynITvbUkDZIrkrwnio9p5qID6kJZjJ1aialirhOc=
Authentication-Results: alien8.de; dkim=none (message not signed)
 header.d=none;alien8.de; dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by BN8PR12MB2883.namprd12.prod.outlook.com (2603:10b6:408:98::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.20; Wed, 1 Sep
 2021 18:17:29 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::dd2d:805d:50ad:33c5]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::dd2d:805d:50ad:33c5%7]) with mapi id 15.20.4457.025; Wed, 1 Sep 2021
 18:17:29 +0000
Date:   Wed, 1 Sep 2021 18:17:21 +0000
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Naveen Krishna Chatradhi <nchatrad@amd.com>,
        linux-edac@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, mchehab@kernel.org,
        Muralidhara M K <muralimk@amd.com>
Subject: Re: [PATCH v3 1/3] x86/amd_nb: Add support for northbridges on
 Aldebaran
Message-ID: <YS/Dsc2gWGGCWnbs@yaz-ubuntu>
References: <20210806074350.114614-4-nchatrad@amd.com>
 <20210823185437.94417-1-nchatrad@amd.com>
 <20210823185437.94417-2-nchatrad@amd.com>
 <YSYeo6S2OSZbBpb4@zn.tnic>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YSYeo6S2OSZbBpb4@zn.tnic>
X-ClientProxiedBy: BN0PR04CA0123.namprd04.prod.outlook.com
 (2603:10b6:408:ed::8) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from yaz-ubuntu (165.204.25.250) by BN0PR04CA0123.namprd04.prod.outlook.com (2603:10b6:408:ed::8) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.17 via Frontend Transport; Wed, 1 Sep 2021 18:17:28 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 797f6a91-1aba-42c1-94e7-08d96d74c204
X-MS-TrafficTypeDiagnostic: BN8PR12MB2883:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN8PR12MB2883F5EBEF7C44027D00D0C4F8CD9@BN8PR12MB2883.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BMM59g/jhY52nmGOZsxWQuVEelAXBBPUPGF6CxI2KB6syWQe+Io7/D2XHHiX0+np2zPitwyg6kDNQ8APrGIUEp5SoVQ+6wsFNdI0YBL9ae2+MzzxutBsEJPYXg2Rhj5XXD7Wj/6CJvG8NCLogpGShrGDz6PLL+a5mRNKNNcBn1Ggm/WimCCPYRHtGVlXnpwaSQpGUUDAfbcuNal2oPDTr1cIm29DCFAoPBuVNpKakFEvn7McAki+ZAOLbmAXqitlFcPvxMWWXYyJiawsKChDhSoP70VBflIPTMeI2cJzZPzLhvMp4EoOmQx9bSxGNltCzLg3k39LiZuyV0EJcnnRyGXp1vLJHiQFuNbg3uo+5ZB4hEEqU3bLrjtHk8UnWcHnUU2MhawfBIt86A698L+X1KbJiX3mrb62Id0zDId++zKE2IDtJtwpTZV7v4QNRFK5qF3Zlh7WvGjt0Quh33QRsd+lh8LLtVNpklfKR0nT70ucmewmF2TbdxmrE5FzOL5WZzJs0lH1jXL0t9kqvZGD+hpjB76W0oT9fXsH5eiasc/WodGMatN8hUn3C2HssGvkBx6EEpf53nPOSPs4iwG6uVrNpGp1v36ehRjlsGXDshyUU4NEuF40J774eRlO8LepA57FlJpocmsNOWKC4ZS4pQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(346002)(396003)(376002)(136003)(39860400002)(38100700002)(478600001)(66556008)(8936002)(5660300002)(66946007)(66476007)(6916009)(316002)(9686003)(186003)(54906003)(44832011)(6666004)(4326008)(956004)(83380400001)(86362001)(8676002)(33716001)(6496006)(2906002)(55016002)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?eqgEEmRRkTLr2aPU1LIGT6ffqust4PFUQM6gv8v5powuyhr6XCdRRj3QkhEE?=
 =?us-ascii?Q?PVRu3Q3nj/9KmuR8MQ63eAnftLWbsdlUEl9gYSd8qJ3wdrestRS5LBpjRotF?=
 =?us-ascii?Q?ALeqLGtrBCjdngxC7TRHubPz+gFLeBA5V6RjuCi04mtJ7ycBdfm+y9tGC9PT?=
 =?us-ascii?Q?qIETZEpp8e9RP31r+vvo74HWt8dQ2zutMwZlstml1dliNT+DyTiCf11bVZ3X?=
 =?us-ascii?Q?+Pt+znUjwL8Wa+bZmPYo/asCZ20qYTj4J+ULRmrcDJ8SrLSCKkPSx9qEqBB7?=
 =?us-ascii?Q?8AmPrmErZ8gB8dRR0efhxQaR+JlhFOcX80fEFYMbm6qBfvqqA7jFudrKh5Ph?=
 =?us-ascii?Q?Vb7+1c45wzqgztn8AiA2X1cst2CYMolt+zQAxlNwy0D+so5yXMrWuTlT3XOX?=
 =?us-ascii?Q?nOdWqBiJeGd2UBzdkNevoOIFuuNi5kUMpHpmz/LiS0Eb6xs438phg1/co4xB?=
 =?us-ascii?Q?+RiZHjpNjnaixeKez4EwxfFOZIrHn9tt1B/bjAWeUcDxG+Em7r/6z9tg2HS6?=
 =?us-ascii?Q?ons5T9RacneKnpXFFoauKCjaYQfPVca7yi0VkrIVIOeFF+oNh/IgYx5iGyxT?=
 =?us-ascii?Q?pCyv36OP/eb/qOWffG7lbJhZiyi0734X6RHZz+HsNXR/YoInaZwQp58uIQJu?=
 =?us-ascii?Q?ApN3MzJBslh6ZJkw7A7Sya6yLqlwnI1BupmrYAJxs+ClhALFfMrYS66NaUw1?=
 =?us-ascii?Q?/Pne29svxGP3x3ytE64DjNFnBua4WdDYDMLu/2GT9cuoTp/ManPzGsaAGw7o?=
 =?us-ascii?Q?cUKZ3Mj+HTyyAexLFmwwYCsmoHoyQ8Y3k3v6EWs/as9CPyDHyQyjEBS5MNdz?=
 =?us-ascii?Q?7PyLNFfpMW5zIzUdcGjVT8T9yzPFW/SHB9GBivcch3CTsIt8tn6DHiotXD/0?=
 =?us-ascii?Q?xT/r0FgggloERvvQzSHrePIdkf1xnlo8tA4e/guea7J7suR/bV0Oat3+Iy88?=
 =?us-ascii?Q?Re6G0FBUnzBdF597m5iN8FpYCaKSAvJLNQBSQssvoq52XpaABhGHLrJKJB8T?=
 =?us-ascii?Q?Sn+67OkiNGhyTCaR6c9nOFmmY5HoULOoR3cbtvDZW1g82ZtpBt1BKbfbM3VZ?=
 =?us-ascii?Q?MHG+OtCenA7HClFWyqh1BAEDsEWvr79GdjA1/VDhr5cREk2lUzjhSgMuuKD9?=
 =?us-ascii?Q?IXPm1dUOqflWyy4kWRhrE/arkwJvhK+IR+KOAr1APdyAVP+TrVbutw4VI8ZF?=
 =?us-ascii?Q?aj6GLxPo1rt3h82oxRTNbe7lgM29S9FfZ/JLbUa+aVV4hX2u5iL0s/Pic8xS?=
 =?us-ascii?Q?TMhLVsm3hnQl7cNfNNxbNSEq0A8OmPa1bQf/KqCj0fDKxESN6Sz/OV+hOUBk?=
 =?us-ascii?Q?25b44SVRR3bpxzyGGlMfSrg+?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 797f6a91-1aba-42c1-94e7-08d96d74c204
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2021 18:17:28.9978
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oSDTDwpJWYhljdzhGQI3jOZTCAqpWWY4xdQhwtjx+CzL3H7PxZd0TWuQwKTm1cSJooXmV6hmIESFW78oLL4prg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB2883
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Wed, Aug 25, 2021 at 12:42:43PM +0200, Borislav Petkov wrote:
> On Tue, Aug 24, 2021 at 12:24:35AM +0530, Naveen Krishna Chatradhi wrote:
...
> > 
> > The GPU nodes are enumerated in sequential order based on the
> > PCI hierarchy, and the first GPU node is assumed to have an "AMD Node
> > ID" value of 8 (the second GPU node has 9, etc.).
> 
> What does that mean? The GPU nodes are simply numerically after the CPU
> nodes or how am I to understand this nomenclature?
>

Yes, the GPU nodes will be numerically after the CPU nodes. However, there
will be a gap in the "Node ID" values. For example, if there is one CPU node
and two GPU nodes, then the "Node ID" values will look like this:

CPU Node0 -> System Node ID 0
GPU Node0 -> System Node ID 8
GPU Node1 -> System Node ID 9
 
...
> > + * of 8 (the second GPU node has 9, etc.).
> > + */
> > +#define NONCPU_NODE_INDEX	8
> 
> Why is this assumed? Can it instead be read from the hardware somewhere?
> Or there simply won't be more than 8 CPU nodes anyway? Not at least in
> the near future?
>

Yes, the intention is to leave a big enough gap for at least the forseeable
future.
 
> I'd prefer stuff to be read out directly from the hardware so that when
> the hardware changes, the code just works instead of doing assumptions
> which get invalidated later.
>

So after going through the latest documentation and asking the one of our
hardware folks, it looks like we have an option to read this value from one of
the Data Fabric registers. Hopefully, whatever solution we settle on will
stick for a while. The Data Fabric registers are not architectural, and
registers and fields have changed between model groups.
 
...
> > +static const struct pci_device_id amd_noncpu_root_ids[] = {
> 
> Why is that "noncpu" thing everywhere? Is this thing going to be
> anything else besides a GPU?
> 
> If not, you can simply call it
> 
> 	amd_gpu_root_ids
> 
> to mean *exactly* what they are. PCI IDs on the GPU.
>

These devices aren't officially GPUs, since they don't have graphics/video
capabilities. Can we come up with a new term for this class of devices? Maybe
accelerators or something?

In any case, GPU is still used throughout documentation and code, so it's fair
to just stick with "gpu".
 
...
> >  
> > -	nb = kcalloc(misc_count, sizeof(struct amd_northbridge), GFP_KERNEL);
> > +	if (misc_count_noncpu) {
> > +		/*
> > +		 * The first non-CPU Node ID starts at 8 even if there are fewer
> > +		 * than 8 CPU nodes. To maintain the AMD Node ID to Linux amd_nb
> > +		 * indexing scheme, allocate the number of GPU nodes plus 8.
> > +		 * Some allocated amd_northbridge structures will go unused when
> > +		 * the number of CPU nodes is less than 8, but this tradeoff is to
> > +		 * keep things relatively simple.
> 
> Why simple?
> 
> What's wrong with having
> 
> [node IDs][GPU node IDs]
> 
> i.e., the usual nodes come first and the GPU ones after it.
> 
> You enumerate everything properly here so you can control what goes
> where. Which means, you don't need this NONCPU_NODE_INDEX non-sense at
> all.
> 
> Hmmm?
>

We use the Node ID to index into the amd_northbridge.nb array, e.g. in
node_to_amd_nb().

We can get the Node ID of a GPU node when processing an MCA error as in Patch
2 of this set. The hardware is going to give us a value of 8 or more.

So, for example, if we set up the "nb" array like this for 1 CPU and 2 GPUs:
[ID:Type] : [0: CPU], [8: GPU], [9: GPU]
 
Then I think we'll need some more processing at runtime to map, for example,
an error from GPU Node 9 to NB array Index 2, etc.

Or we can manage this at init time like this:
[0: CPU], [1: NULL], [2: NULL], [3: NULL], [4: NULL], [5: NULL], [6: NULL],
[7, NULL], [8: GPU], [9: GPU]

And at runtime, the code which does Node ID to NB entry just works. This
applies to node_to_amd_nb(), places where we loop over amd_nb_num(), etc.

What do you think?

Thanks,
Yazen
