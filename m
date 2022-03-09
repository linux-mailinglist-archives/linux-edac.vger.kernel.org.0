Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BACE4D3C8B
	for <lists+linux-edac@lfdr.de>; Wed,  9 Mar 2022 23:03:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232791AbiCIWEm (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 9 Mar 2022 17:04:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231388AbiCIWEl (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 9 Mar 2022 17:04:41 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2056.outbound.protection.outlook.com [40.107.94.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18D66D4449;
        Wed,  9 Mar 2022 14:03:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VghOx4Ov9iHTWEHWp6RCFopgSrEqAcGGpZTAjzG6hlPzAsrSUHsdRW/PxBAgpML9SiCAiN2ggIHbyN3WBbbQFM79ABY/6r5rIgm1/kojGMVmXW0d9OcfP9gGK1gRcmDxtz1bWP/wMUOCS3+z9N1yWBvCVMnbyk9TBFwLx+I9aBGS7yl60vp1BSMKlGe9QSJ3S90nftNjidmMrmWaSOGOhVqgfl5YI/iutuiLDxTRhqm9cHF22MIvy1VOq8sTC3kE0zBXsIQ9USaEUxC7NUa71/Lpy3UsDfxiKjE5nmNFZgsGfmCHK4OIhY8+K1Mc7k8TWlApJteiGEb0NM3O6hF18Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2ftGWYe5ZIvcmy+BupylncaQTC/PQYefGi1R1n7Qs+Y=;
 b=gDsyJoIHk5sdKAsihSK+l+QfWa5lEIum7By6HWnR8cYGsUCntAKxFz0Fkh9EdsfDbR/uZjyLeZ1eLZ7AbgbMxDdWiziu5L2atR1hkHK8vBLlOxzg0Dzs+kC6xCF5/EPN87uLuPnOiUbiWAf5WCOU/RJRomkO5405tmVmrLNWilfel1v+u8uaaG/yFyyxBkWRVkVuTIIM0AOAIeDdbSj8n9Su/0ksCDzHQQhavFRBO8aYU+/4x/GdjsXVByXX01SK8U4+L6FuU0TodNhbmAE7VSIz/khRood5DKvaNU6TI86bWwMam6B/ee13O4ABX+Uj/E3Ulsw1z1wiKxBqysuAaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2ftGWYe5ZIvcmy+BupylncaQTC/PQYefGi1R1n7Qs+Y=;
 b=nzI0Jo+bTPM9hH3WDelC7x6TRZRhM0F7Coh5P4MkSLJ57xPaxjpzao3NuCEkF7uZFEwsGhefzLEdH0yR2aQbHfX/wVrV6F4Oj7wAN+1qRCLjxJ2VmfFW8caa+3ZJIzUBFx29jTB/0mhwLmfqMYdn2/ZezeLLe0a+iQ6/oZW3zrA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by CH2PR12MB5020.namprd12.prod.outlook.com (2603:10b6:610:65::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.17; Wed, 9 Mar
 2022 22:03:36 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::ad74:927:9e6:d2cd]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::ad74:927:9e6:d2cd%2]) with mapi id 15.20.5038.029; Wed, 9 Mar 2022
 22:03:36 +0000
Date:   Wed, 9 Mar 2022 22:03:26 +0000
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        mchehab@kernel.org, tony.luck@intel.com, james.morse@arm.com,
        rric@kernel.org, Smita.KoralahalliChannabasappa@amd.com
Subject: Re: [PATCH v4 08/24] EDAC/amd64: Define function to check DRAM limit
 address
Message-ID: <YikkLnnQX3CJoi37@yaz-ubuntu>
References: <20220127204115.384161-1-yazen.ghannam@amd.com>
 <20220127204115.384161-9-yazen.ghannam@amd.com>
 <YgopjwgItEHPfFtF@zn.tnic>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YgopjwgItEHPfFtF@zn.tnic>
X-ClientProxiedBy: CH2PR03CA0024.namprd03.prod.outlook.com
 (2603:10b6:610:59::34) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e5cffd86-a296-43ed-5292-08da0218a89a
X-MS-TrafficTypeDiagnostic: CH2PR12MB5020:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB5020C8187E98877BED53385CF80A9@CH2PR12MB5020.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: u+Cn+juoO355Q4THuhvkCKnGgRgexUv6fvd4pTJ6rPs8OChUR90Kn81n/oxMSoXvYnEEN4td0wtvPXCQXh9vr+77tlRhj3t98EYdI9Bsqg2CucOdKgCB8pMKfjgdsLtlTXLlIywKrGCYsNeBpD1XeBJR1cr72VKtPVZU51sMbHbQtCD+Pe34pQC9tVCN13Hl9DF+tTv5r6EkHA/MdWN6EdpuQcAMRP/z/+SFxMdiBYQUdz9yi/VCk+SHkFswgapojQ/ZlTrYgPN66wVO5Ryc5wRZQDNkKoeAKXwbYiPZ2AmIHscCWHumFpeHWxARMr6R2KH4u/mHkT1kYSOEHLIjPxgfJMa9VQQQQ+VkSFtMGwZaIE23gTGnz3Q1bnk0O/T7RELYvfQQL2ZGjejOT+Z8zBtRYJGIWZhvda9G6b/tJwnHlZ7HBYXe0fcmHnPFR2dfPESr6DvazBRjwg9yydnFO5H1TC2VOExZANdiR+lNCFQAjVV0knyEj3rLvSuPOXpf32tuk6FKadu2Sc5dO/OOEe9tCsellwJ8xvyOpZaWRm8keyYiVUk1EMjaqMDtgs/1VMN3nCkveHaPekw70q3LJuiVC69nnZWU3sY5sTNHJ3yPMtJNQimgqoV1VXOwTVoudfF855UhbfGtVrEszV9olg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(4636009)(366004)(44832011)(508600001)(8936002)(4744005)(66556008)(9686003)(6666004)(6512007)(6506007)(6486002)(86362001)(38100700002)(2906002)(4326008)(8676002)(6916009)(83380400001)(316002)(26005)(186003)(33716001)(66946007)(66476007)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FAEIL11VuDpu+CjJ1lrBeZVlVH5zVv1qmOcq7zOJ1yXCS0pH4aVLWAMrqJtA?=
 =?us-ascii?Q?EXU161lfwj/jto/hgWQnn2rCBy+gX1I47H4VhF+f0uSSVaIxYlmFtcxTrd1j?=
 =?us-ascii?Q?yasklR9eqWkZf92N5k7ugz0EkZc7T5NdQ07hdmPBY47tfzg3f/X18//2IF1o?=
 =?us-ascii?Q?Ao/zNigYCAunYbMIo11to7Ps/KJcdXaiqrVKpGhA3uhQ2Npa3+s333kjZSrY?=
 =?us-ascii?Q?6I962tNDSf9ZtOGhauHF0rUCYLUFr5i9Jrh2X6woMUde32NfAL23p51eJaOx?=
 =?us-ascii?Q?od9ATNp2BYHAz9tvm2cCTtow0FIyaptZsRWxKiKTeCyhNM7CnaRUqS9kczwA?=
 =?us-ascii?Q?kStlaki1F6awvKg8U3sKPHCVemTAehxFOkgaNrGMx2kg6xwzrbRTe3yzrx7f?=
 =?us-ascii?Q?lNa0VKx6clMVOOEUVrpyClNxLw4XIni9xowdtASerJaD3EI+Aj0kcW874f+U?=
 =?us-ascii?Q?O7CchZDOzel+vG4um1OK7lyatGLfp6DvIfhEm4AdIcMRgDRNERjaEeKvXlkQ?=
 =?us-ascii?Q?gD7vFBMcUETVt380Xgshh6a/DvZ1DxSf61HPAZzJunTuhGnKYE2vDeYCqXhf?=
 =?us-ascii?Q?HZtSmTZSEH20leJg/CcT4h7xoVlUWA0BSDAtKNzxYkfIZ97DazX+E9m2+237?=
 =?us-ascii?Q?xpLjRgL+TetrA8ZUsZX8Qq5Hw1VqUf5J15Y5283oUsUWPrBZtw1Bfg9GW6MK?=
 =?us-ascii?Q?4MByCQO2K8Kj+bAwp9RQDjiTf23lcDcwavDrV5jsOL8vXp1T5KeqJ+Mq8pwl?=
 =?us-ascii?Q?47UF1q6P1YpSeX+sqao4kuMgaGv3AA5qXGiYTw+p0ceQSMElR8sSXcp34QER?=
 =?us-ascii?Q?up9HDbzIJSYVonM3Bpt9tmlETnbe66LMFGgCAWZUXFvFv1h+gLK4pu+XccDT?=
 =?us-ascii?Q?8VnszJ4HHTdeED8e6f9pavEHYI/jmFuDf+6BWfq7vMhk623tEaqn5UpQdIkG?=
 =?us-ascii?Q?3WQvQhFiamdbDVbazXHFP7lt+itB4Y5cJ1SuyBacNxfB/DW+owg8VKaWWYM1?=
 =?us-ascii?Q?kppKchYXAM6jGr8ts65NfclLmPvD7JIu1ys2EEMA+F8TfM7vMaAwH2m+pp9j?=
 =?us-ascii?Q?PX1LuxjSXcZJUD/HnYr6I3vo+cxDgJqwmS1aK7zV4cjZBjYvcv0kYq5gCiMp?=
 =?us-ascii?Q?2lHq/jpgL81EUx5wnKitlzWEShW2jR57DS3RUHLvottKgaDY1kwHm/kSqsRy?=
 =?us-ascii?Q?1TOZqce95P2rEw4QmrPc3BLfVPTwutekf7Kmu4OQtNV6xwzaYbXZpF/Aw40a?=
 =?us-ascii?Q?AYjNtgKZBFeZdS09lobenJ/jZdd2EP8gZI/fsYdSB2ppbeKBhImoA0mI6U0O?=
 =?us-ascii?Q?zMUx/rjF+bOmoj3dNuj+gmIwKw0Tg/QRbyKZqV5evWZ+wwxDMTm2GUmNroRJ?=
 =?us-ascii?Q?Q7Jze14redHm6Z3t/DPcrwpyQFnhW7VVfaD6wm7tP8lPT3y4NaZd0PJkT0Gk?=
 =?us-ascii?Q?J1gF0n4PxOCZ69J3QlP+FYW61IjaMkS5NWS5uUbB7oH7uUJ2r9otT4Sye3yr?=
 =?us-ascii?Q?QrYfb7OfQHZfNzIroh9YI+5R91kn5DZ8m3C0T2UdpTBr7STo7LrgakVrESwz?=
 =?us-ascii?Q?PUIkiW1ir6iiz9BFfe289MTqnSY+bHvQIFWGRkyPiqC3zf+fFRLl5OSmaXoD?=
 =?us-ascii?Q?+gg5u4anOQSbg5CYdmJ/Piw=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5cffd86-a296-43ed-5292-08da0218a89a
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2022 22:03:35.9377
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XuM9X9LOeiUERJeveEuTkJrxgBrjSMp5ddHDvOP/Yp4/f/BcsdPXkEN4wkYlLTtdHbWw0/1F6ghZzGEr+xi+qw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB5020
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Mon, Feb 14, 2022 at 11:06:07AM +0100, Borislav Petkov wrote:
> On Thu, Jan 27, 2022 at 08:40:59PM +0000, Yazen Ghannam wrote:
> > Move the DRAM limit check into a separate helper function.
> 
> You're still writing the "what" in commit messages - pls make a note to
> write about "why" you're doing a change instead.
> 
> Because I don't see why you're doing this. Because
> umc_normaddr_to_sysaddr() is supposed to call helper functions only?
> 
> Now if you had the "why" I wouldn't be wondering...
> 
> :)
>

Yes, you're right. I'll update this.

Yes, the goal is to break up the translation procedure into discrete
high-level steps.

Thanks,
Yazen
