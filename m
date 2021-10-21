Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B9A343682C
	for <lists+linux-edac@lfdr.de>; Thu, 21 Oct 2021 18:41:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232063AbhJUQnk (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 21 Oct 2021 12:43:40 -0400
Received: from mail-bn8nam12on2082.outbound.protection.outlook.com ([40.107.237.82]:55009
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232146AbhJUQnX (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 21 Oct 2021 12:43:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mk6Lxr9Cq5D0xMZ3AzVqtexX1pTVrSOtM8T+xH40iHjSMGjHv8OkEjhj6XGMRkT9jG5NaHGTSYk5bgQlu8GLbw55A9jnYbEU7TMo4dWMZIPgELowboVSsbvCLMkdxjdSDsNy7xCAopN56IIgv36KT/j0YY3VjqJmPbZ1vSWgQNvZCEFAIgkDLiC6+vRwoCSo8pUh1J65uFtxSp+7jvsOXYuAk8e7aiGuUIq0zXrK5CMezp0wHnVkuQLVGhvEqAMfOi09K8ekOocEtxUyvCW4MAa5no3g5brlK0xk3zFYbvR9B1Q7IbrSefv0gOHH+oy2o3kAgZyumbtm3i8oOE5I4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t4gR1ZK5JLkQTFECrpXtDkpuTZt2o0oX4IkmtWMoE3w=;
 b=RfkKxR/wQic5uljUyd0XW9gLv7stZOg/tLCWMKN2/MjEf81bMxu9DPWQ8Hi6uivL3n0SOVhmI0E215Nx7q+U3co+9+4vy6gCNo/83m1WXE8Tp+VsLfOdmCORNbqfZPG8STS+4laLBdwzWVl8c5pZNBF8uJgbVSBoBqgQqB2Q5Bsa+PWjqJ0/YFCtL4AYRc+Da3gkUTyp2PoCM7AaK2hXHpsK+DXblvazTdzT36nS/FC/fLA4+aqr4nl35S+8yNJK/c9S7Hn0bJn/7S3j7RZY/+NiL+ZO6ILGwC2+o5Jy6KbDoy3NSjK3b8Ly+G9FxOcEdPs81PebGUxRPCCju585Cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t4gR1ZK5JLkQTFECrpXtDkpuTZt2o0oX4IkmtWMoE3w=;
 b=JSUqJOmpkiphSD9urDnvVoQGRzhdNoHQOCj/jioEHFiEcb2X6W0rOGt6eEfh++XZ4xquckXiyBgrQsmRNA8XRWXU5vx/G3IEudVqjUiNmLUTzXE4ZDYNuXP5r3kwZSoUb77K6rtI8Ds8thcEWpNMPZYzq7hEgmYSN1megZ6ViTs=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by BN7PR12MB2595.namprd12.prod.outlook.com (2603:10b6:408:30::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.18; Thu, 21 Oct
 2021 16:40:59 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::d075:22bc:12ee:e73e]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::d075:22bc:12ee:e73e%7]) with mapi id 15.20.4608.018; Thu, 21 Oct 2021
 16:40:59 +0000
Date:   Thu, 21 Oct 2021 16:40:51 +0000
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     Naveen Krishna Chatradhi <nchatrad@amd.com>
Cc:     linux-edac@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, bp@alien8.de, mingo@redhat.com,
        mchehab@kernel.org, Muralidhara M K <muralimk@amd.com>
Subject: Re: [PATCH v4 4/4] EDAC/amd64: Enumerate memory on Aldebaran GPU
 nodes
Message-ID: <YXGYEz8MmPybnoI0@yaz-ubuntu>
References: <20210823185437.94417-1-nchatrad@amd.com>
 <20211014185400.10451-1-nchatrad@amd.com>
 <20211014185400.10451-5-nchatrad@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211014185400.10451-5-nchatrad@amd.com>
X-ClientProxiedBy: BL1PR13CA0438.namprd13.prod.outlook.com
 (2603:10b6:208:2c3::23) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
MIME-Version: 1.0
Received: from yaz-ubuntu (165.204.25.250) by BL1PR13CA0438.namprd13.prod.outlook.com (2603:10b6:208:2c3::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.10 via Frontend Transport; Thu, 21 Oct 2021 16:40:58 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ef0ab217-798c-4843-629f-08d994b18fec
X-MS-TrafficTypeDiagnostic: BN7PR12MB2595:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN7PR12MB2595A1A6D00F6A26836F3AEDF8BF9@BN7PR12MB2595.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: u2ZDxn6GCMFnHyyYuNAqWT3f/rApSj+xWBAoxWuE22oc+T5pGPN1sLYpDMNoTIAxkZImssOlHZZJDf5UN9YLBCFQ0qCtTfkNA4IzaUBHVvSONS6SZ6WNp3xDYFDEDEyoOuQspHb/VXD/5VpwcSv+QdqCLfIXfkJbU/9t+udUkZo7E4lWYMei0aspF0+aLwFb6G5S1r4hwWGgMYxod/HlvFpWNfhNW7A/foH8TfEuddIolC9AY+EYumHYSfZbNVwf4TXyM83S38hf8MF6HKvnYYsYhxLD8iqTZFtfHolAAf/R7IClodUmTslrcLw9oeTiNefFRel1SEeucCTalPBinrYM/O2M3TSsqEbdocCCTR67QZvS/PretDAalFfIUT6Drb550BKfjSVb6pAaU5pZKhnwQ8UGOy7eZI7ph/LFV6QfbzCL4OTm7O2BILv23BsyZSmQ7KzAQQJuTuGeKoYoZAtP1NZbO7lGvQW83b49l9HtdcR9OxCXQm+aZJDoFC+AqNbHOJjZz9O4HPDJkuFyZW0Ews1eaRn0rfW87JAOyCGdZg9v6bv9HUMd1wd5wSr+A5PM0SdX0z/Ao67l356OlgVv4kRQJcZ90TcEtBUE0wdesykP4QdlutSY+raAlBGDgAEf6x1yErSIaWd6cpgUaw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(5660300002)(66946007)(6636002)(86362001)(2906002)(33716001)(9686003)(55016002)(6666004)(6496006)(8676002)(38100700002)(956004)(186003)(6862004)(508600001)(4326008)(316002)(26005)(66556008)(8936002)(44832011)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bFQlEe6tPaRck8OrM2VxWzSsqPYjwOO7SGB/VRkQxdbzOPLJPn2LOwmz1lTc?=
 =?us-ascii?Q?2JH4y6kR+gcP8/1uQor177jvwOWzSjiLmWYpQIeXPHqVdhVU62yWm+iK1ntx?=
 =?us-ascii?Q?sfmOfIzX7Bw1s6OA/0w6AE7ufkL98znK7M2DM+lcVSll2zU9BBGSsZExLXcA?=
 =?us-ascii?Q?N/Z1inGVHv5MpY8jyx8XSa0LnuGyr7v8jwxmJyszaiO0lN8jeBCtdal/3lUa?=
 =?us-ascii?Q?BpCbP1Fey9s1LKDxBgV4T9zctNNQs86w++aZ1dfo1+1AOCPr82/npNJFMmGv?=
 =?us-ascii?Q?2S5ZcHpeXvvwXzUt5tDvPvYwtl1JVTmhI4j4fOiQmS1Q0WMwd18yKv1OzUl1?=
 =?us-ascii?Q?uOgjyzqMajazUZEZqT/yMWtqrdLSx1/MpXa5odT+tWTIs4N6pDqjlA6r5oIZ?=
 =?us-ascii?Q?kvp/+tZbmg7MwNbVixjbDe1JkcxD3MqWMybdx9uf5S/aGxTStKd7Rp/E2ZWW?=
 =?us-ascii?Q?vTFmSTpDyzcv2wax7/KO/lYrKbd7JANpIjg48dS/FAjKSp0vFJtBxCLKHuQ1?=
 =?us-ascii?Q?2vCuD8/SC0fANcOZpdwkRVVaKj00qjGk+8yh5DOGEtl3oUc/Ej+NOwwec+C1?=
 =?us-ascii?Q?pfkBcInWlbsMnO62hOKvEogozw1m9m8Tp5WnWkGMsCaoRlQVsOj2ZOgv5bJm?=
 =?us-ascii?Q?zcpDi56XVPlZtrtj44olkXZeohjWzL7F6hm68E/oY1oINKx2TARUq4XOl+km?=
 =?us-ascii?Q?Y3OZyMB87sh+NGz2BPVUPE0MHlVNLj71ei7ekTxf72jOQ5z7vnvC+0tZ7TSK?=
 =?us-ascii?Q?uhatW5QV7th0PGOaS9pdyPqVsZqD7wSRnIn0mGO6DmVLROPd94nTPNNqu6B3?=
 =?us-ascii?Q?G7YTnQ9JiUllssCK4oIAH1b/0iWTHgDHdCmJe1DDiiBI1xw2C9h9MluA+qQf?=
 =?us-ascii?Q?j92pXnULCjjdOFDhiLJ19r2VWezoAZmd/+9fGpUrJdo5n/PngbM62Gf0bFqL?=
 =?us-ascii?Q?29NZCzQt6aGT3HWg8g3F/pcMLGyWvNGfHVENaP4D7FfQO6+YDB58Km3P98OU?=
 =?us-ascii?Q?SoSlLT6zy+b8PZsKrmUDXVZgwwNqsrIPobPr8LNKfDncIj5dluLhCUlxR27Q?=
 =?us-ascii?Q?JTXK8W+4T1JZ7HBAzQXHOAfCuUqnVhYmIsFPjcSVKHgzWq2umeoid9IK/cdx?=
 =?us-ascii?Q?Qq7ClgfZrd8sAHY7ipOFAoGuNvJxjKKkD06WGcTKpwQl2X+o/UF2qpMsTM6+?=
 =?us-ascii?Q?vVCeSYdbaE3aei4x+1D8HNFfdQWuaOZc2nmsuV/Yi1Tn9pe7Nxuid2lMkz+B?=
 =?us-ascii?Q?dHgfw7QTcfdfO0B8ff4R2FtS1Jl1Pd67iIxWzplA4pQ3PKvtRsJY/XvB/Fcv?=
 =?us-ascii?Q?vhvcVbu+09enrOU6NLxW4ckc?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef0ab217-798c-4843-629f-08d994b18fec
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2021 16:40:59.7080
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yghannam@amd.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2595
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Fri, Oct 15, 2021 at 12:24:00AM +0530, Naveen Krishna Chatradhi wrote:
...
> @@ -3726,6 +3935,17 @@ static struct amd64_family_type *per_family_init(struct amd64_pvt *pvt)
>  			pvt->ops = &family_types[F17_M70H_CPUS].ops;
>  			fam_type->ctl_name = "F19h_M20h";
>  			break;
> +		} else if (pvt->model >= 0x30 && pvt->model <= 0x3f) {
> +			if (pvt->mc_node_id >= amd_cpu_node_count()) {
> +				fam_type = &family_types[ALDEBARAN_GPUS];

The fam_type needs to become part of amd64_pvt.

Otherwise, what happens here is the module loads on a CPU node and sets a CPU
family type. Then a GPU node is probed and the family type is overwritten
with a GPU family type.

> +				pvt->ops = &family_types[ALDEBARAN_GPUS].ops;
> +				pvt->is_gpu = true;
> +			} else {
> +				fam_type = &family_types[F19_CPUS];
> +				pvt->ops = &family_types[F19_CPUS].ops;
> +				fam_type->ctl_name = "F19h_M30h";
> +			}
> +			break;
>  		}
>  		fam_type	= &family_types[F19_CPUS];
>  		pvt->ops	= &family_types[F19_CPUS].ops;
> @@ -3808,9 +4028,10 @@ static int init_one_instance(struct amd64_pvt *pvt)

Thanks,
Yazen
