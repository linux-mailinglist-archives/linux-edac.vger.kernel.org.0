Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9BE5409BBD
	for <lists+linux-edac@lfdr.de>; Mon, 13 Sep 2021 20:07:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346358AbhIMSI5 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 13 Sep 2021 14:08:57 -0400
Received: from mail-bn8nam11on2055.outbound.protection.outlook.com ([40.107.236.55]:2465
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235056AbhIMSI4 (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Mon, 13 Sep 2021 14:08:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EnsXlfOl9s7kGinmHRp0ip2rutkC2aopF3HlTe0aSD7Ji3cVuPMSHHNe8lUmzvYz7IS8q67KIdlDNfLFEPYNh2Ng/6LKU+WuS4dxCFpF+0kAAytMbETTaskz7Bs9j0iAMa7q7bL6rg19RitNU6OUCfZNrKzKgYSlQOUgmkM2sRAe8F3gQ29MwSRAacBA0yjQz2lZhkD8ONdll5bFd150bfjW1cLf6DGJIn4Vl0zIJ//nE5erayWBG6qSAayXzrlO5CKJ8kuaNsUkThpoW5egNzjROjREOEJLoQcjRcvoESVn793ilYGiP/VGyL/Y1LDC165hiBeWSolrevr1xpdkVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=QYUyJz7ApaW9xmvPiDsrAb8TTN2Q/EU3aNzRhlSY2C4=;
 b=N3J0PqO1aqJrK/wuMVqhwcBBVYdVPqdZINAm2nqk3ZElks8CViYfbbZNkmz8spAQwFRfvgwX3WJ5gd+zjJv+uJa1IOMcvQWMnxyuXdLAzIenbbsCfJW8GXhsJsHZhu0BS4WqnXTpyFZLPXnMQkIys0c5NtMRzymYoSfIo220Pey4xwu8JvhRWvu/G0ONgMuC5DFu5AH2mX96L40YMxTyvPMRM2duIsVv6gAt3bbf5seUkSwcRbML4KuS9pd0+IRvpkvmA1C+Rx8tXivjI6Ojcp3eiOR++PQjpBynF2NV9uTXHxHxESDCOP7gPQYvHAQItR/6bdYD0nHooXR68AhZxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QYUyJz7ApaW9xmvPiDsrAb8TTN2Q/EU3aNzRhlSY2C4=;
 b=eulDLAFQlS2GmpYzEvQw+NjwNO+sIleolzfWc7g2X6cwuObxNmAyo3MevueL+nAbeMvxD1VHDUdC5DDpTdWOy5mTmbv0fRy//CiP+bPmI6NGNrlzF+VlqFL35NkDN4yubzY2iDoGeHF9LK11jCZ9j88R/2Xyut5Etq4lfWlvEVg=
Authentication-Results: alien8.de; dkim=none (message not signed)
 header.d=none;alien8.de; dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by BN8PR12MB2980.namprd12.prod.outlook.com (2603:10b6:408:62::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.16; Mon, 13 Sep
 2021 18:07:38 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::fd41:979d:a3e1:d958]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::fd41:979d:a3e1:d958%4]) with mapi id 15.20.4500.018; Mon, 13 Sep 2021
 18:07:38 +0000
Date:   Mon, 13 Sep 2021 18:07:30 +0000
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Naveen Krishna Chatradhi <nchatrad@amd.com>,
        linux-edac@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, mchehab@kernel.org,
        Muralidhara M K <muralimk@amd.com>
Subject: Re: [PATCH v3 1/3] x86/amd_nb: Add support for northbridges on
 Aldebaran
Message-ID: <YT+TYrOZpe1IEv28@yaz-ubuntu>
References: <20210806074350.114614-4-nchatrad@amd.com>
 <20210823185437.94417-1-nchatrad@amd.com>
 <20210823185437.94417-2-nchatrad@amd.com>
 <YSYeo6S2OSZbBpb4@zn.tnic>
 <YS/Dsc2gWGGCWnbs@yaz-ubuntu>
 <YTEKMHqjY/IUBfgl@zn.tnic>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YTEKMHqjY/IUBfgl@zn.tnic>
X-ClientProxiedBy: BN0PR03CA0047.namprd03.prod.outlook.com
 (2603:10b6:408:e7::22) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
MIME-Version: 1.0
Received: from yaz-ubuntu (165.204.25.250) by BN0PR03CA0047.namprd03.prod.outlook.com (2603:10b6:408:e7::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14 via Frontend Transport; Mon, 13 Sep 2021 18:07:37 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 88e316f5-70b7-4c67-bd98-08d976e15f26
X-MS-TrafficTypeDiagnostic: BN8PR12MB2980:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN8PR12MB2980F5926FAA54CAB7ACC8EAF8D99@BN8PR12MB2980.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yPdcry0vQVtBiT1lG518yydSqQBXOKPiqHXUW8raCyB1qHfqb9X3xo5JcQznPhp9qcqqRaWF9HRjjj+pnk/FfzV9efELa2N2aT0Ry5raZYTGtrDMbM8FELyN9Fmx9NJx11Mwm3XIb/re+t2sUHjDim/hhV6CpN90OVoGtT72kfmNzNIqiGOOrHTxQAIK3FifWwFWMtNTvccvBGsA3gOHIdaiHniRvra3aAJ3sJGe01CtJZKlEnm+ZQv5cjKpnfKF+eRI5Zxen2Tf+NicDKxLu6XE9DJLI4lh4sGeImtTML5QkPLCW90lUS8IjmwVB4Z4pYI5bAVzIkXCqkDc2VNY5Q77ehtORKW66hzZyXn1ngErJYQWuUY97iLqD2gjCTZdv/0M+33iYzPlqyOi65le76gUdt/rXj/fMxjovHU992fjbvLa8AWqnvn2fcdCqHt7FFJVvn1YINAkvuFm6x/LYdmitSx2nnSwoZo3G9Fop/TVQV6fzVuDGSjn0w12cL7xC9zZRY2U+kAWtNRrat5qSeRcXBY1T2Ix+152YYbAE0VbWdbbeyXRCcAzYKn7sRiZWOYOocUT0oqQjku7J8VZdPKpHou8ABsUYTDoBKCyQo3RVa3J6EkZr0jom8YB9B9ciJPvA/dqQ99u5oBir0gtX2DGTMrtZ1OHQQz/AHE/H1QqBc4YF+1MkTL3mtq15SAB
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(366004)(136003)(346002)(396003)(376002)(2906002)(38100700002)(4326008)(66946007)(6916009)(54906003)(66556008)(956004)(66476007)(186003)(8936002)(8676002)(44832011)(6496006)(478600001)(6666004)(5660300002)(55016002)(9686003)(86362001)(33716001)(316002)(26005)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?oDVwiK8eQRl2nsVJR2KWMw8Zn2GxBMA0IBz0nb1CIZ0ws/HZv9ePT7+HZ8DR?=
 =?us-ascii?Q?NFgOqXOkt2dZ+/vSr9Vd5vmp2S5JUsggKsJcYoMA7tLfjpBX1yJu1j4QAgs/?=
 =?us-ascii?Q?xP4q8x8RweDVd2ONANtwszvX4MxByrO4huBMsJ0aBHctbpu25m26nUzTtaV0?=
 =?us-ascii?Q?xcgohIYoULafJ7ywwuFLAYfzAXJHNAfxOU6ZXByUV/fIDgN0poeZEPcsDLbu?=
 =?us-ascii?Q?f2GM85lmIxKs+1kY6Nb5WB/GiAas0RbRrJs036p1EDS83+8Y6J2zGD5tabCr?=
 =?us-ascii?Q?lZx1ofdDSCCS2jvHGuHIo93hZ1B8n2jDTHIdA3CZZ6V5jD+Dxm6pJdspjkCL?=
 =?us-ascii?Q?vTSvcJ10GarvTV7cxLJHMtrE7DSptOOydjOA+YcyK+eRxS02M1/gnWBZgH/x?=
 =?us-ascii?Q?O7OCI4HlPqIQL1f5chYx4cYAQQm/X7KWvQMD/yPsYqWTUV4KyIMYDJ3PRIWB?=
 =?us-ascii?Q?yMOgTkq+wCsTj/BRWMwvIy6/HFeSesL4fQi/8AxjO2YrI35iJ1e4r35pLUBS?=
 =?us-ascii?Q?lY3KOFdErtuw1X7UiQJLnBFmeQLSCsjm6w1Ifdn+dB72rP5/uWmg6Valpe33?=
 =?us-ascii?Q?SqvlAq1seWufkZwzkJSJhsRs0/Jb1Z0B9PPrsGLVnz9IyMvVoKplxQboCJL6?=
 =?us-ascii?Q?X0WGV/fCmIbi0ACnd9wGSZAtrawaR9sWfk4ZR2yo2e6FMRxjUC+ozyJYuFK1?=
 =?us-ascii?Q?5WnNRfNOU0WEyGY54WU3umiz1HUBJ39KEmOpXU1JkhaxISVYTrhxt4ojwY4a?=
 =?us-ascii?Q?a5CyBEoJyC77i/Dz8QYIC2lTns62jMBcEj/OMYmlZ9PiCoA8A+rvnHE4md4P?=
 =?us-ascii?Q?1mtm62ZRgQ25WAl94GA0OZxAHypPlJh6SJvVg+AeDgW/WQpgca4SlYaq2aGj?=
 =?us-ascii?Q?kiRSUGW3BWON17cWvGnWJckOyeFjqS8FWfl2GFGcjsqBjqq/99XJBbsHK/UE?=
 =?us-ascii?Q?46GLmkq4rhCH6L6uEvn4wbgAjMD/NhU+TXsEfvN2kiB4gzhui62qB7syqJ8A?=
 =?us-ascii?Q?J5VRW80lbFEqyR7zPNAIkXF8QDIHrueX9TYYMOZ5kWCNmPq6NMFrTV/6pvwu?=
 =?us-ascii?Q?vxawADYDpdjyZJ9cmN8TPOpNYgrMygVRcZ4OiY2CFth1V7sHp9udPwaHEeGE?=
 =?us-ascii?Q?FBRccHwIDiE1EWPVH+iz4N/r6N27HI3metUgosfSECy5YJ4LMLjdkUv+vAQ9?=
 =?us-ascii?Q?UPaIf/djmYdUPjGkZZDZFU3KbqEwTUZwBMH39ryhgyHoIYGqhJQ1+ZyOPbpv?=
 =?us-ascii?Q?JWLZBTouB7LNQ/+FqgRu0HXx1hbPjHB9VDDyz1L2I04EqBChXPJ/HjGJ6ZQk?=
 =?us-ascii?Q?fgTFyInnCGVFormI8XVjMWcY?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88e316f5-70b7-4c67-bd98-08d976e15f26
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2021 18:07:38.7548
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wUYMZX/a23X6j7tK5edqi5nK+vJw90J1b0A+6BA7JY0BjvgH6RcsQSNKznr7bTJPNd32re/6r/ZZQRxO4EOhGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB2980
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Thu, Sep 02, 2021 at 07:30:24PM +0200, Borislav Petkov wrote:
> On Wed, Sep 01, 2021 at 06:17:21PM +0000, Yazen Ghannam wrote:
> > These devices aren't officially GPUs, since they don't have graphics/video
> > capabilities. Can we come up with a new term for this class of devices? Maybe
> > accelerators or something?
> > 
> > In any case, GPU is still used throughout documentation and code, so it's fair
> > to just stick with "gpu".
> 
> Hmm, yeah, everybody is talking about special-purpose processing units
> now, i.e., accelerators or whatever they call them. I guess this is the
> new fancy thing since sliced bread.
> 
> Well, what are those PCI IDs going to represent? Devices which have RAS
> capabilities on them?
> 
> We have this nomenclature called "uncore" in the perf subsystem for
> counters which are not part of the CPU core or whatever. But there we
> use that term on AMD already so that might cause confusion.
> 
> But I guess the type of those devices doesn't matter for amd_nb.c,
> right?
> 
> All that thing cares for is having an array of northbridges, each with
> the respective PCI devices and that's it. So for amd_nb.c I think that
> differentiation doesn't matter... but keep reading...
> 
> > We use the Node ID to index into the amd_northbridge.nb array, e.g. in
> > node_to_amd_nb().
> > 
> > We can get the Node ID of a GPU node when processing an MCA error as in Patch
> > 2 of this set. The hardware is going to give us a value of 8 or more.
> > 
> > So, for example, if we set up the "nb" array like this for 1 CPU and 2 GPUs:
> > [ID:Type] : [0: CPU], [8: GPU], [9: GPU]
> >  
> > Then I think we'll need some more processing at runtime to map, for example,
> > an error from GPU Node 9 to NB array Index 2, etc.
> > 
> > Or we can manage this at init time like this:
> > [0: CPU], [1: NULL], [2: NULL], [3: NULL], [4: NULL], [5: NULL], [6: NULL],
> > [7, NULL], [8: GPU], [9: GPU]
> > 
> > And at runtime, the code which does Node ID to NB entry just works. This
> > applies to node_to_amd_nb(), places where we loop over amd_nb_num(), etc.
> > 
> > What do you think?
> 
> Ok, looking at patch 2, it does:
> 
> 	node_id = ((m->ipid >> 44) & 0xF);
> 
> So how ugly would it become if you do here:
> 
> 	node_id = ((m->ipid >> 44) & 0xF);
> 	node_id -= accel_id_offset;
> 
> where that accel_id_offset is the thing you've read out from one of the
> Data Fabric registers before?
> 
> This way, the gap between CPU IDs and accel IDs is gone and in the
> software view, there is none.
> 
> Or are we reading other hardware registers which are aware of that gap
> and we would have to remove it again to get the proper index? And if so,
> and if it becomes real ugly, maybe we will have to bite the bullet and
> do the gap in the array but that would be yucky...
> 
> Hmmm.
>

I really like this idea. I've gone over the current and future code a few
times to make sure things are okay. As far as I can tell, this idea should
work most of the time, since the "node_id" value is mostly used to look up the
right devices in the nb array. But there is one case so far where the "real"
hardware node_id is needed during address translation. This case is in the new
code in review for Data Fabric v3.5, and it only applies to the GPU devices.

What do you think about having a couple of helper functions to go between the
hardware and Linux index IDs? Most cases will use "hardware -> Linux index",
and when needed there can be a "Linux index -> hardware".

I think we still need some piece of info to indicate a device is a GPU based
on its node_id. The AMD NB code doesn't need to know, but the address
translation code does. The AMD NB enumeration can be mostly generic. I think
it may be enough to save an "id offset" value and also a "first special index"
value. Then we can go back and forth between the appropriate values without
having to allocate a bunch of unused memory or hardcoding certain values.

Thanks for the idea!

-Yazen
