Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C185C485687
	for <lists+linux-edac@lfdr.de>; Wed,  5 Jan 2022 17:12:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241846AbiAEQMU (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 5 Jan 2022 11:12:20 -0500
Received: from mail-dm6nam10on2088.outbound.protection.outlook.com ([40.107.93.88]:12512
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S241849AbiAEQMO (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 5 Jan 2022 11:12:14 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZoBcMobTAOr4+2iPE1LBgefiurKbKzjpmtcF4oQr8OvxGqcB/qXpovp+LQE9wkFMpm4/YH61vmwOyweni56S0u8oFTd+sYbawREDujUXn8OVFEyVifPbOzHslcKaTEjhBtWKrYVTGotBZvVpuVmNut84zlhrKCntwO1vwa8GTaf+IHw92LctJ++b3CoOyWoqq5FY1mMTuNsgjmxJWrNmy5re7lpltroLaz1TJrpYRM3BEMf6H+9gLecDA5puJ1hU/He5l+CHn3ExhfAE8RqNPtqxHsjafHS3fKKeWFa+oiGaiaMZzLAwVSSvJd29FGIiiLMUPQlgXQl+nbsUcDDlcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iyj7MfLwPTXicMFqsVw6+xaAUFp0iMzzi4xDT10jE/4=;
 b=QX/Njnh2NJ47zlVVoZ9Dp2rpbT9lZuuDZJRg0e8juD+CthvkWJLvJ4U7jb6MB20jm4ukhDBkWR6LvyGR7zE1QNF2L+lIuUDOoYy2KXp8FR21rTi12vUWLTiDOMMjvIrNG8raJQk3plqr1PDg+iy91qYT/HaBDR8XEpbWJjzeqJwMIx8/BLdGzf5EySn7BB7F5ZanFkZ8eN7fDcP4zwI7nlPtRB8q/IrSa3iXrTQh0gd2B1u5b+7BTE5uPdKnxOvXnT51lsmlgcPtfdp6wrmBQkbEzA8J9oCWt3urOaDqCKDp3iKlQj/V6axnoMw/iRODlL1DdyM8b/Tx0FbGyA2vrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iyj7MfLwPTXicMFqsVw6+xaAUFp0iMzzi4xDT10jE/4=;
 b=SgoAfTwZeon250GPA7Y3UDMd0x8MK+5DFr4kIeKX41VgCBCC5t3h6zHytXvNMMOAh8eIoMtTxtD9sQerfP5I6sMYj60j2zXQjAnJOTjwAV4T3Fv5vBLQ5HhDi83BLaOnDztzaLNK0zscdUDK3EuPnPQV7AVYTmcuFcrI6Umpm68=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by BN6PR12MB1746.namprd12.prod.outlook.com (2603:10b6:404:104::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.7; Wed, 5 Jan
 2022 16:12:13 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::a192:7073:258c:28b3]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::a192:7073:258c:28b3%6]) with mapi id 15.20.4867.009; Wed, 5 Jan 2022
 16:12:13 +0000
Date:   Wed, 5 Jan 2022 16:12:08 +0000
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        mchehab@kernel.org, tony.luck@intel.com, james.morse@arm.com,
        rric@kernel.org, Smita.KoralahalliChannabasappa@amd.com,
        william.roche@oracle.com
Subject: Re: [PATCH v2 1/2] EDAC/amd64: Check register values from all UMCs
Message-ID: <YdXDWIuuoY4D5cfO@yaz-ubuntu>
References: <20211215155309.2711917-1-yazen.ghannam@amd.com>
 <20211215155309.2711917-2-yazen.ghannam@amd.com>
 <YbotciKVDsH1Fl1H@zn.tnic>
 <YbtkcppejpW8gHqY@yaz-ubuntu>
 <Yc2ZzMT+Mg5xCvjI@zn.tnic>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yc2ZzMT+Mg5xCvjI@zn.tnic>
X-ClientProxiedBy: CH2PR18CA0005.namprd18.prod.outlook.com
 (2603:10b6:610:4f::15) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2f5e2be3-e294-40ad-78f0-08d9d066223f
X-MS-TrafficTypeDiagnostic: BN6PR12MB1746:EE_
X-Microsoft-Antispam-PRVS: <BN6PR12MB1746B384B787812A6CE2DF71F84B9@BN6PR12MB1746.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IlV8S9U07MUyo5IRebrvZSHKia9Tuu/cocRJpynY9qXK3lPgLHh0lSPcNxEJxqlJT1FYWvsixSdgQBMHW/G25eqotw9NJ7GzrhrQ52hCDAumHFzDgwDPbT3w0D4b3NKRNHWvZkKZZBdnODB9qEE5c9vUKhyQNnV1c7D7CtrzvCNERFS0RcZ+8Mfw4zWaA39ErH35RQwzhTMzfiq/owSNUQhCQ0REBTAeEKR8WJaBmxofi2FkFdV8vTSZIlda1m7xU584y+RC6XCUE7zuQO6ukHAaNEqBbYwLFNEe5m0Xe4kUKWfZhB+u9u2rBgao9w4eTmN6tj4MLbbI+RFdMOzOcSsyr8Yco3guSsL87BSmgc6rTKpbQdyi1FbqvyUnKRt85gEwVLfASZKGeJj2On2qjvPym8KnC9ZHJ7EcSk0OlTCyDWpUvIbbF6PITnXaBrg/wAwBlMfxH4WkTpGZrWNHQtrFzWnUB5e6iLzGZ21PeuAniJP/of2dirILtMTeCOaNGoKs/mdxFAPI3Z0C8IFy52C54guIaO5UezcBqpMQCwd6ngCvD7L55vQcYU1UELvwS5F0ql+VHbuu6oDhidD72GITwkUhh5c7z+iJb1hCaSp4dIX5vVW5GaH0w5R5aYPxX+WHOJs6L8WAFmo371UY+lapey6nyKnuJ/IvZVn3qm1pmlI/DttaVv75we0suCB1Gr9jT/3HZ1fhGSauXCGhnhTw476Ueblu4GxIEij29pY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(4636009)(366004)(8936002)(9686003)(6512007)(966005)(83380400001)(508600001)(6506007)(38100700002)(5660300002)(6666004)(44832011)(316002)(66556008)(66946007)(66476007)(4326008)(86362001)(26005)(186003)(33716001)(6916009)(2906002)(8676002)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9JbAvBVnsZ6jKAu1CgqS8uU5AiHm8B39Ji1vzrZz/TVaUSTuMClaPBO1Lblr?=
 =?us-ascii?Q?XeLC188oAngcKezzXsEF8yYZx7qrYGKXsScIg8jK0nQW/M7qJxAPS946wfDL?=
 =?us-ascii?Q?cj6fLInEI/4Aeb0dPzJRBjTZbp2Atjd2Gnq2gQYoZIy8h4w9HPM9NzEn3zSQ?=
 =?us-ascii?Q?pIh6wRWpk3FqLp0yChhoMbroJZtjY6dK2r7XOxnBKzDCrXRP4OqV28OsMt+i?=
 =?us-ascii?Q?5vyqVFzIpfJPLa+TvK+WdKmwegHCxBFKsQ1Vk+jKTlW9AQ8MfRIeJP6tdNY/?=
 =?us-ascii?Q?yiF1+gcJG+RLX5Tvf14/HIEiWQCixwK/IH+rBRwBR2A4NomGlTmylqq841rn?=
 =?us-ascii?Q?7l1frtCLa4IhkorAqDE8CTkHeSVhqgwCtyIxDReuRYKGtah5muWVRl6dQ8tM?=
 =?us-ascii?Q?xbqwSJKZpUrQfeQp+OsySvaLIyWO/u7IQzZQOlLUZLDTqKOlnPqmP805aqSf?=
 =?us-ascii?Q?W9EC3Ua2dTzYDTyW4Rb8nRBmXYNK5yzqY+1UKBLZeqWrj2ZGt7Z+YAp1KmWp?=
 =?us-ascii?Q?qU0utOps5ZgpKsIlR4FMv5eSZKgTMhVHd8tccSSErxpXDqS19EeLR7XN3kkw?=
 =?us-ascii?Q?oljr1D33Ia8lcQzzz+LQVKe0ymtN6tHkIOG+uD1WhZ1YOZJqyHzQadePuvVu?=
 =?us-ascii?Q?GO1dczz/PfmWxRzy4CPKdgZum18gsZ+chnJJRCYnVkur/fpOmSYZ/X4yiFUE?=
 =?us-ascii?Q?RT7I1Yh3o+omBahspM5tD08ISZ3Qv9+7BhpYqP8M5OwnNr+Ys3rUAxZNzHK2?=
 =?us-ascii?Q?t/cpX0DbHZF1uLiRFfXFlHJYZBpQ5ABn4xdM42VcS0D6XjcXSujHEOWKgDht?=
 =?us-ascii?Q?MnTrEjm5hccD9gJ+iPd1eRTocrwBrGrjA10X6F6zKjyY9FuS6gnn0uRQA2ax?=
 =?us-ascii?Q?7SKEfepeFXU2IhD5spAuR36/9bCT4F1L5wYmauo5xyn0zR8mHouxgN0ElYx8?=
 =?us-ascii?Q?WdmFoodXwWNh55KExhMaOYLtrQkhL464Oyli+xgRl7sjezZzCpfkoYUzYacf?=
 =?us-ascii?Q?UcPN6O0T2hhvkZ8w9t7jnuwoOu2scdvC9V4Hye3OI+Oke/TWFBHCT/7Jp8cL?=
 =?us-ascii?Q?MZlshFEUZWV2vC1Z9NpLuj20j9I6iRXottz/bZh2VvyqL1/uKHw7C8HZaXCZ?=
 =?us-ascii?Q?QyiqbuiPvxY7Jt2cfPjwxxObKNxZOsk54SIVYoL7C8kSssDeMPPQfWXrgYc1?=
 =?us-ascii?Q?YGQh59BCPegxMsmKtQCpjdvEKKcpyVOm2jxSf4DMMRiWQfc29gnEqKZ92YvS?=
 =?us-ascii?Q?upgygJBfkJMlEIi3EyPwE/RikxRvB1OurTHxsr0JH7Bmqg+Bb+/ajmK9Em/7?=
 =?us-ascii?Q?pvrAspKCxWOrsfDevCF5Tcr8Kcv976cgR8ZF1MPB8N2YtzS8uPCawPBIWW+T?=
 =?us-ascii?Q?1fnyJ/iqmMBG3knd23C9KzERjGecWZgqJO0MGsj1NHgPz/9J3X1ViHhbvFqd?=
 =?us-ascii?Q?d7k2Lxudw2XKeUu0n9HbStZ4pgRkLb44D8QyTn4TMkXdhOGWQPTfwlf2ppTM?=
 =?us-ascii?Q?2Kacb520syegJmCICp/76blaYjBZEIaV4mkTs+AUgr7rOTfBh7O/bbLYh+Fn?=
 =?us-ascii?Q?5h9jEbsNsE/v/KF2b+CeUUEYl0lcN9LdWdJHp0y/tG/y9kcbRCjykOf+AJBT?=
 =?us-ascii?Q?pGPzIckYLb8/ykny1VyJ6IQ=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f5e2be3-e294-40ad-78f0-08d9d066223f
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2022 16:12:13.1181
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3KqUzvjUBpjUzFre1QL7lKCI7JeH1x4hw0rqXOG+Nz8kpQvccA24YLzAqmepyzzu8BqQOzQfztzliRO2r7t92A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1746
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Thu, Dec 30, 2021 at 12:36:44PM +0100, Borislav Petkov wrote:
> On Thu, Dec 16, 2021 at 04:08:18PM +0000, Yazen Ghannam wrote:
> > No, that's a good question. And actually the assumption is incorrect. It is
> > allowed to have different DIMM types in a system though all DIMMs on a single
> > UMC must match.
> 
> Oh fun, really?!
> 
> So a single system can have DDR4 *and* DDR5 on the same board?!
>

Well, I don't know about that specifically. There are some restrictions, but
you could have UDIMMs and RDIMMs of the same generation, at least.
 
> So then that
> 
> 	pvt->dram_type
> 
> is insufficient to store the DIMM type for a pvt. If you have multiple
> UMCs on a pvt and all have different type DIMMs, then you need the
> relevant DIMM type when you dump it in sysfs...
> 
> Which then means, you need ->dram_type to be per UMC...
> 
> And also, I'm assuming the hw already enforces that DIMMs on a single
> UMC must match - it simply won't boot if they don't so you don't have to
> enforce that, at least.
> 
> > Do you recommend a follow up patch or should this one be reworked?
> 
> This one is insufficient, I'm afraid.
> 
> One way to address this is, you could use pvt->umc at the places where
> dram_type is used and assign directly to the dimm->mtype thing. But then
> you'd need a way to map each struct dimm_info *dimm to the UMC so that
> you can determine the correct DIMM type.
> 

I did send a patch that did something like this.
https://lkml.kernel.org/r/20211228200615.412999-2-yazen.ghannam@amd.com

Though this got a build warning report, so I need to follow up on that.

> Which would make pvt->dram_type redundant and can be removed.
>

I kept this so as to not break legacy systems. But I'll look at it again. I
think you may be right.

Thanks,
Yazen 
