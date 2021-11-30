Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE3CA463C06
	for <lists+linux-edac@lfdr.de>; Tue, 30 Nov 2021 17:41:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244208AbhK3Qou (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 30 Nov 2021 11:44:50 -0500
Received: from mail-bn8nam12on2117.outbound.protection.outlook.com ([40.107.237.117]:10497
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S244194AbhK3Qos (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 30 Nov 2021 11:44:48 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZnJ8rFxi/117hy4RzR9qvLkgj3uDSxbAioZ1QXqXIXTfoZWlnP5kfqVzDbrsAFyOBmyEAYhExyxklMF0VbpLAZ+tm5HM/h8hEN6zb6Cq5CXYiuXt5s7Kj/zsRt1NqwzqxAqIFE3NNzYi++vdJHG1QwlRPlMgh7mWrDWf5BW4cTivDwtvCFqRaxiGE6/LOc/qjr7f4eEzb7tvGnlnBlJj/pVgKL48m4LQPxzXnxWZQgsmgp9DLT77aEu2SCkSubgQvEfAUc7vcL9nrWqTsxQGim7IPvt96ijUVYOehLCuboGdAGkHcywnUaGCaBlYxoolwWUYK/RoNdnEzXD5zCCOFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+yEItGiPWj3aXVyuDumXZFuOZ/qU1MeOdeSVgGDQQ3A=;
 b=aUxqBAgnFejY0xEr0CSMMzo/nNboKvkSGVPtFbwoZem0dKXb7btGb113VMpAyLREIlBbCf8OKIZ6Wsw84kEkmRD18/bc3CuPpLKdfswOcdqHNbaPLxCravF59htWNYhRxnXdYiyQR2EzjcrMD5WKGYwyY2P85RkEba4HGCVH526y/zH4PLV+HBbXEjo0v3n9AtiGMhSil15OG6OT9wWVEIfMsMNzfApMCrHnYvX8iNfWLRzeRsJvj5CSTNXXC484JVQqc0ckahb+Qp/whbKUb+NfHxM+wnZoG+C0LKMWWxIqvhd09M/SLs6MDE9+2pgNxGvZOrkXRY638gpdfvs2ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+yEItGiPWj3aXVyuDumXZFuOZ/qU1MeOdeSVgGDQQ3A=;
 b=JNgES/bEKbCnF4gv+acExYxDWNR6cMMcjIWO0rerrl0lbKNHDSaaXodbP5841E0Gi/JjQwTvhRXvuWdYCLTIaXNS8Kr5kijSctoAjuUigPyHKCokEyWlfEUYkixGD7GRtBOQ11aSNCcKa756S0/nma8APFwc6s04ydS4HHsgiVI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from PH0PR01MB6326.prod.exchangelabs.com (2603:10b6:510:a::8) by
 PH0PR01MB6407.prod.exchangelabs.com (2603:10b6:510:c::14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4755.11; Tue, 30 Nov 2021 16:41:23 +0000
Received: from PH0PR01MB6326.prod.exchangelabs.com
 ([fe80::1051:3c01:3bea:1e21]) by PH0PR01MB6326.prod.exchangelabs.com
 ([fe80::1051:3c01:3bea:1e21%9]) with mapi id 15.20.4755.011; Tue, 30 Nov 2021
 16:41:23 +0000
Date:   Tue, 30 Nov 2021 08:41:19 -0800
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
        masahiroy@kernel.org, samitolvanen@google.com,
        john.garry@huawei.com, daniel.lezcano@linaro.org,
        gor@linux.ibm.com, zhangshaokun@hisilicon.com,
        tmricht@linux.ibm.com, dchinner@redhat.com, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kvmarm@lists.cs.columbia.edu, linux-acpi@vger.kernel.org,
        linux-edac@vger.kernel.org, ishii.shuuichir@fujitsu.com,
        Vineeth.Pillai@microsoft.com
Subject: Re: [PATCH 1/2] ACPI/AEST: Initial AEST driver
Message-ID: <YaZUL+cftvNYgx1j@fedora>
References: <20211124170708.3874-1-baicar@os.amperecomputing.com>
 <20211124170708.3874-2-baicar@os.amperecomputing.com>
 <87czmpcto5.wl-maz@kernel.org>
 <YaU6eyGM+bX/bEhG@fedora>
 <87h7bum0xh.wl-maz@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87h7bum0xh.wl-maz@kernel.org>
X-ClientProxiedBy: MW3PR06CA0021.namprd06.prod.outlook.com
 (2603:10b6:303:2a::26) To PH0PR01MB6326.prod.exchangelabs.com
 (2603:10b6:510:a::8)
MIME-Version: 1.0
Received: from localhost (50.39.132.186) by MW3PR06CA0021.namprd06.prod.outlook.com (2603:10b6:303:2a::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23 via Frontend Transport; Tue, 30 Nov 2021 16:41:21 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e99e2d4c-1ea7-4e9c-261e-08d9b4203de8
X-MS-TrafficTypeDiagnostic: PH0PR01MB6407:
X-Microsoft-Antispam-PRVS: <PH0PR01MB6407727515DEAEFA52263389F7679@PH0PR01MB6407.prod.exchangelabs.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GN+OAET2UlwJgFp8XQ8+yDEa1GHxce6TH2i9wWlUaYWXE8+Y89LRKGOgfTeV7CIdJG0pRj3nqoelG/8j8Bi7dVh4y9cCFffjxUOOyovo97E5x33116Ti60XuAZsiVZTYvz1p0Lsu67mgusRbYY1dudHUOOv+X1v5ql6LVfKJrSxHV2JcZrl8hEyB00BHwWfelprqWmZb4gJP5ODr97SRk3UP3cITbB7ld+O0q4LtiA8KU3ZMGWet9cfAQrxhCwo0bhnSmS4UU4R7XS/cDL+LHxACUooBh0TDvEMdD/p3UjwRkasJIKtFN6uEos1IY/zLDp4O4Mi43BDn5oZRn3aVbG5LNHEbjptm09+Tf0bLcQscskTqHCSySy5MFMiVtOzFNM0sKKOk0iPPM3bT4lKRxpylFJt5onE+T4exXfMGOy0UP4LaE5Lg9nQV/3BpCntFHjCMUC9aA+1PhRvfpC7MkLuhjB43z2JOLz7nE+kCx5uCdpno7p9JZVQznClxuFanMa+/Ooes0yHWYtgpIltEFhHbQlE0qk+4mRXm2LZTmEwqh+IpQiNhBQK/c38t8FBVtC2Vf3l64fXZeX/PBgeRlCJ7Umvz3pyYyUC6FjxVmUL0F/rA/+InI52eQbZxqzbWc/lmrHbPESxKlOoeZnFMLSnBUIvA72rrQI3CR6VkQMdslURmnHcJFCnpCIKaWffX5VX8jfsDAOCSScDBn+FlVWsRa0fEGz4XMiFvz4w49oE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR01MB6326.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(7916004)(4636009)(366004)(6486002)(2906002)(956004)(26005)(83380400001)(66476007)(66556008)(66946007)(186003)(316002)(7406005)(8936002)(8676002)(38350700002)(38100700002)(33716001)(7416002)(6916009)(4326008)(5660300002)(9686003)(6496006)(52116002)(86362001)(508600001)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TJIPU/4iAcxI3FFOdl16XBGCDADJUzHKUymkZCI8wU/XHhYzLDhsP8iIHiCW?=
 =?us-ascii?Q?HJNngmowIDQaErY3Bbk8f1bV3Elv+A9BXBf3qOxhBgWqoYp4OHvPNgRmYTqy?=
 =?us-ascii?Q?ZGGUEkgX9PkkfIRKpmyfJIbmf5No2RWmlVZ9OHz9ladasuvQu318jTPMKFaF?=
 =?us-ascii?Q?Dxu3PSaZ7YcrgK6KkFtxePIih0ewd8yEdHJFnxQ7J6BUotVDoM8DlYK3J4ol?=
 =?us-ascii?Q?PCpgbQ3nrkl2xjV4UisSIdG57iiu8pCIiNYYdLs8RvbS714vuAP1ellD94eN?=
 =?us-ascii?Q?m7HgEPqxXmcW151h/om02erSq6t2cDlWrsNKNZC0SjqK9FHLcCQiZNClEH6G?=
 =?us-ascii?Q?1bnVWgqevWwku75XeK3pDwqqQP1WHFxElSXpCXUIMxYR/yb/YVBflKZ3QXik?=
 =?us-ascii?Q?AL6iiMojHn9MgcLzNH+bGrh2Wt/KM+p8f+7lmiGcB/MFr0d16etVrrMdaKRZ?=
 =?us-ascii?Q?pYBJtBwqDdA0rIWZudIz29//CbJdUZ0/eogLMopJjKkYAm8TPZP48Pp1//RJ?=
 =?us-ascii?Q?2DmnDulxC7B+HxgyG6dxp7n8EoDkuCTSpNAKcxWI7Hpu+7q5dyLS3KXCLxeX?=
 =?us-ascii?Q?nZLvkOrg7pQG89EQSPtd3jL4885EQPmQSETm2o9LxW76Bhx3UutkOr0p+2Vf?=
 =?us-ascii?Q?Nh4cSEWpNG7RXy8lSi8E7LlAQXIINjisyhwQovZHFzXhOHYfyxA72enR1+cJ?=
 =?us-ascii?Q?I0APZ739aiSQE551+3kodspxcHP7V5G5OxtvKdHFvk4CKvBjN9Xh0FsIbYdY?=
 =?us-ascii?Q?WUWY52IHjh8oe3MnL0oqDSVKIeCpIUpZgqSOlet71JENCfBde8seeYXdnP8D?=
 =?us-ascii?Q?Pb5t+FtCqFBAj9Ws7l5jRr4eaE6qcHFGMkEs4OfY0lKZGDXlVS2eOwpI2dwA?=
 =?us-ascii?Q?goflDOQXfLqL7ORQlS5HeCAu+v2FivfZbrPS7NWFyMHjpdNIhaPIxB52FXsq?=
 =?us-ascii?Q?uUi2+Wa5mQPljHyNTzX0K7ZUM9bkLYSMYvVdWOeTZ+6N+VkDKZQ4DtU0Usr4?=
 =?us-ascii?Q?Ucd1vyvc9s7uZx4e+5L+/tHGbFsKNQaxUC3OSdAeLFwsPCGkxETsnJap2uGB?=
 =?us-ascii?Q?VJmr6MoKITZ0MOsOwvHuPkctZxRSny2MrkJZzUiG6H5sJaJxTWJydtryNuxg?=
 =?us-ascii?Q?YJw614hf9fqtW0ZSLlZ5I2hVE6o1UuSd1gVo+ZZCYZ4SPjxsqO27K8tgmhMU?=
 =?us-ascii?Q?BfSXHecw8ohJy+GuaMKSUGEvbs3W9kyO42z6l3s64sxI/XuvahCmHCqRuwQM?=
 =?us-ascii?Q?+EDcVpQbUzo/QthSvQIcH0p3mC1PJsXZPX0KF1gH6cW7hyUOvTx9pUO/lBQi?=
 =?us-ascii?Q?VEaTUd/IiikZ1gkBeuC7e2t0wtyVRVpriEZDaALs4a8XUAgX54wjbUmKQbxw?=
 =?us-ascii?Q?03uDYIkSbOu5l8QR1JJuxYTbAv7M6+OmDPuTTgCoi9DiX/LIsoDxWwgjpjmC?=
 =?us-ascii?Q?RdlJkcu5ICN780RMSaUBH2uN1K82rnMrYD/FO57lCJuxJk19ukAmvhKO4Xyy?=
 =?us-ascii?Q?2Wzz23SNbtl2+MbYmZzoKJ9ZN6nuXr5/uNmeCgMbPBwAUnJoJyaTSc+doIDo?=
 =?us-ascii?Q?KUg3z1mnYD8YrNHIu5rBP6sU2xaBhvg6v25fUyhuOKrAV8ihtyg3JXtAF8ry?=
 =?us-ascii?Q?nCaS4AnY3CAZI8A3TNXbdRDZNwQrb97rwBM8haDiJHtKWvmEHfky49uuedgX?=
 =?us-ascii?Q?cQMw5Qd9gDFZ8ECkZwylRGVop/y1+OhzyiwU7FFnzU+pWKlrA5OSXgMZYE52?=
 =?us-ascii?Q?5hmiG56M1Q=3D=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e99e2d4c-1ea7-4e9c-261e-08d9b4203de8
X-MS-Exchange-CrossTenant-AuthSource: PH0PR01MB6326.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2021 16:41:22.8238
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bceKGQXD3RHaYjLb+FzhEoq7nRDkZBAjs9tsenicdO3SG9ZZn1HmPW65iYEGy6OsD3BpLWZkWrYD3eN9XVRT3fUmMWlx9ydJUjLRHj/kbBJ3DhcCwR2FP+sJvoTspnCs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR01MB6407
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Tue, Nov 30, 2021 at 09:45:46AM +0000, Marc Zyngier wrote:
> Hi Darren,
> 
> On Mon, 29 Nov 2021 20:39:23 +0000,
> Darren Hart <darren@os.amperecomputing.com> wrote:
> > 
> > On Wed, Nov 24, 2021 at 06:09:14PM +0000, Marc Zyngier wrote:
> > > On Wed, 24 Nov 2021 17:07:07 +0000,
> > > >
> > > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > > index 5250298d2817..aa0483726606 100644
> > > > --- a/MAINTAINERS
> > > > +++ b/MAINTAINERS
> > > > @@ -382,6 +382,7 @@ ACPI FOR ARM64 (ACPI/arm64)
> > > >  M:	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > > >  M:	Hanjun Guo <guohanjun@huawei.com>
> > > >  M:	Sudeep Holla <sudeep.holla@arm.com>
> > > > +R:	Tyler Baicar <baicar@os.amperecomputing.com>
> > > >  L:	linux-acpi@vger.kernel.org
> > > >  L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
> > > >  S:	Maintained
> > > 
> > > Isn't this a bit premature? This isn't even mentioned in the commit
> > > message, only in passing in the cover letter.
> > > 
> > 
> > Hi Marc,
> > 
> > This was something I encouraged Tyler to add during internal review,
> > both in response to the checkpatch.pl warning about adding new drivers
> > as well as our interest in reviewing any future changes to the aest
> > driver. Since refactoring is common, this level made sense to me - but
> > would it be preferable to add a new entry for just the new driver Tyler
> > added?
> 
> Adding someone as the co-maintainer/co-reviewer of a whole subsystem
> (ACPI/arm64 in this case) comes, IMO, with a number of pre-requisites:
> has the proposed co-{maintainer,reviewer} contributed and/or reviewed
> a significant number of patches to that subsystem and/or actively
> participated in the public discussions on the design and the
> maintenance of the subsystem, so that their reviewing is authoritative
> enough? I won't be judge of this, but it is definitely something to
> consider.

Hi Marc,

Agreed. I applied similar criteria when considering sub maintainers for
the platform/x86 subsystem while I maintained it.

> I don't think preemptively adding someone to the MAINTAINERS entry to
> indicate an interest in a whole subsystem is the right way to do it.
> One could argue that this is what a mailing list is for! ;-) On the
> other hand, an active participation to the review process is the
> perfect way to engage with fellow developers and to grow a profile. It
> is at this stage that adding oneself as an upstream reviewer makes a
> lot of sense.

Also generally agree. In this specific case, our interest was in the
driver itself, and we had to decide between the whole subsystem or
adding another F: entry in MAINTAINERS for the specific driver. Since
drivers/acpi/arm64 only has 3 .c files in it, adding another entry
seemed premature and overly granular. Certainly a subjective thing and
we have no objection to adding the extra line if that's preferred. This
should have been noted in the commit message.

> Alternatively, adding a MAINTAINERS entry for a specific driver is
> definitely helpful and will certainly result in the listed maintainer
> to be Cc'd on changes affecting it. But I would really like this
> maintainer to actively engage with upstream, rather than simply be on
> the receiving end of a stream of changes.

Agree for subsystems. For individual drivers, I think having the author
as a reviewer is appropriate and should result in more patch reviews,
which moves us in the direction of more community participation which we
all want to see.

Thanks,

-- 
Darren Hart
Ampere Computing / OS and Kernel
