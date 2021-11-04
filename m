Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BDE54453BD
	for <lists+linux-edac@lfdr.de>; Thu,  4 Nov 2021 14:21:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231243AbhKDNYE (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 4 Nov 2021 09:24:04 -0400
Received: from mail-mw2nam12on2044.outbound.protection.outlook.com ([40.107.244.44]:1953
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231136AbhKDNYD (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 4 Nov 2021 09:24:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hl78S0koArJ8qIaUHR5PB+QXwPu2cIZMeKqYohmmk0QixbaVuKMUY5POxm4xrmJ3+VNGSJRxtKjydaSUzSaqSfhmOw2vrmKzG65wm6wLGgVBFPN8X/ENB0WHRnIOihtSYN14IIQtJmsdJYhyZPMSobsClxAwLUIC70E9h8W1BgN1cNoII6Pxcb6PpOWzh6CjqcudUCwFFBKxYR6e85L8Kbb1qLSOHqAuXbId1sclIvrt+MvNVL/jk6RsQyNgqLYus6ospA+Mrg7fXa4Q1IkTjzsC16F+quSXoTSinpOeHpcxm32G3ONAR+uskm6qV8O2MgeG79MSkYoMNgM9VAjvUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+NfCQIKiGFmZqG0ncDx9uOu2uNPFtmFmVYqfLGGdslw=;
 b=YkvWXvqUYYtkOHUx4wBeXsNiyhMFtnf1TBi6YST3U9Hi+gza8dmJxhIfkfR0LPpvJH7VsiP3N3nSytP7ibHrKovx9txZcmr9pPVMC7UVGzclArNmgZJ/XdDfFWIP2a3BRmnIT1s5cTSvEqcmm1J7yJocTdTRYBuTmnveQcykRA9j26BWXEcdlAs2EoNAq03jSIip7/U0BsLc1bXiMDhGxqx1wnRBM78bNHLWHCTrZkGRHYnqqarO2hpdOAopHTvR+U47onli7pnc9IG9Df8v8y6F3R6IOQZyTj7p5xuCm5tqLfrlxWkj8gtvggBs94+qgGAelV6axSxcJpQoS2QjZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+NfCQIKiGFmZqG0ncDx9uOu2uNPFtmFmVYqfLGGdslw=;
 b=ybaKKW3HLwraPHJKqY3bcHFs2+kPuFuymX7QjjYSvaqTxTBDLZZ0ui2swHZUz79DkRxzC9wujXCEF5C3hFFtBzddB/aTcRqAoS3y8Fzc5CM4L+r1djlcnxj2mCcZEYmhhCcBMyvRqozrjb1+PyO/2w62aIKzFCjNYoSXgkxF5tw=
Authentication-Results: alien8.de; dkim=none (message not signed)
 header.d=none;alien8.de; dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5286.namprd12.prod.outlook.com (2603:10b6:208:31d::6)
 by BL1PR12MB5320.namprd12.prod.outlook.com (2603:10b6:208:314::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.14; Thu, 4 Nov
 2021 13:21:24 +0000
Received: from BL1PR12MB5286.namprd12.prod.outlook.com
 ([fe80::c1e:36ae:bada:e396]) by BL1PR12MB5286.namprd12.prod.outlook.com
 ([fe80::c1e:36ae:bada:e396%6]) with mapi id 15.20.4649.020; Thu, 4 Nov 2021
 13:21:23 +0000
Message-ID: <b7f3639a-e46c-25e8-270b-04860074fd3c@amd.com>
Date:   Thu, 4 Nov 2021 18:48:29 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v6 1/5] x86/amd_nb: Add support for northbridges on
 Aldebaran
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-edac@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, mingo@redhat.com, mchehab@kernel.org,
        yazen.ghannam@amd.com, Muralidhara M K <muralimk@amd.com>
References: <20211028130106.15701-1-nchatrad@amd.com>
 <20211028130106.15701-2-nchatrad@amd.com> <YYF9ei59G/OUyZqR@zn.tnic>
From:   "Chatradhi, Naveen Krishna" <nchatrad@amd.com>
In-Reply-To: <YYF9ei59G/OUyZqR@zn.tnic>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0039.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:22::14) To BL1PR12MB5286.namprd12.prod.outlook.com
 (2603:10b6:208:31d::6)
MIME-Version: 1.0
Received: from [10.252.84.184] (165.204.159.242) by PN2PR01CA0039.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:22::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.10 via Frontend Transport; Thu, 4 Nov 2021 13:21:18 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: add401d9-ec56-4d22-c283-08d99f95ff35
X-MS-TrafficTypeDiagnostic: BL1PR12MB5320:
X-Microsoft-Antispam-PRVS: <BL1PR12MB5320450D8DD9EF3FCD143E9CE88D9@BL1PR12MB5320.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Fp726JUQN1oCTQun43Guz0T5ZdrOdbWZsoRTGJifj/ydOi0PG5MgTaxKq8ShsNJcCsD6xghJFYNDpMWriRT3iJd7edXLCi8un1d3TmG1psAS2DwBbuCoxbjgKDSKA1bxrh+eAFW5Ct0+HeWrr27s+NOQV70p4cT/azmsy8yOsBQORXmPGsjurA6+pmXYjP9Eg7fanF0aresu6GOrgIA/lAPN2Szq/bLYFx00x4jrOmm/A+YAK3bmuqL/zOO7Fa/wD5a3WB4mtUsF0VhIduvRF+9SyeYIYLs4pR0M2KM/ONwnZPlUziObxId5RGNwTs7jGtvNyV85Odgga5XAgi3S0MbyvJNKxdtxLMNLEWUADnsdJMk5bIIWNwbyr+1B8EqpTKsiK18T/s8kIr+Qi0pEfwhk9MqEYrHI5ECdz45AulGpF+pk8lqiswmb4asHdhOWmdG/gj4+qR3yf9HRG602SYi3ljfwWqhmI/GqjZSrGZljRwRAP3iTBntxO//YIYq/Rd+GObdlRem40XB2/XXFLATGgsHQUDSBS7PBsM6VNVxPljgj3IhFpCNyApKVDr7W6n5hT4iVKbOgxtC3pr8WUikkNgdKZd5QDH12effaM/A4P9ccsCDppVNaBuJbiufLIIur33CIvc6F7AtuifHxyKWLv6Xe1XSiqWSMqAd3seqpVx8T0GyVtXKHFeCUb1LTEOnBzREe76Yoo9AwoNwudjMbs6Kfpf3CddnGVdOSr9q3vlKCmvpGtSW9x233EIODNvarODw9j/HUNQLUNsSONTWsnOJWJg5z0+ALZKfpXU1wcHpe2ljtzbPS8MfsdVIc
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5286.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66556008)(186003)(8936002)(8676002)(2616005)(956004)(26005)(16576012)(66946007)(316002)(31686004)(31696002)(66476007)(83380400001)(45080400002)(5660300002)(38100700002)(6486002)(966005)(6666004)(2906002)(6916009)(508600001)(4326008)(53546011)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cWpLVEZrUjAwSWNtcXBDOWQ2RXFsTGp2WUFRWUlxejFkb2NZRFlnaTRReVdv?=
 =?utf-8?B?cTgzWVRoVVBveHJ1dmlGNDRPbm1KdXhKeElwMTVKUlNXUmw4czNYcitQYkFW?=
 =?utf-8?B?MldRd1AzTE0wa0F1cnA4MlQ0ZjBtaFFTUVF2YVI5QmxidHIySDZ0RGFZeVUy?=
 =?utf-8?B?RXRqbTFOQnNBY2hFbDRkMDBRanlROXZmekE2UlhYU0hvUlkxNUVzUEUvaGF3?=
 =?utf-8?B?bExHRzZJWDJ1TXpPaDZLY1hxSjY5ZVhIeWdxWjA1MFF1dDUrc2JpMEpmWGhm?=
 =?utf-8?B?bzlDVmtGOWkxSERUNUNNYTBrQlkva29UelBJUE4vT0JmUzBPV294Zlhxd2dC?=
 =?utf-8?B?Y3FMbUsxTjFwLzZVd3pNMDluRGd0aE0veU84ZUdKODF2d3VvaXhNajQyMnBk?=
 =?utf-8?B?eEhrLys0UENPV0dIamQ3aks4cVdESVJkVDArZ2hXMngrK1hlK1E2M0M2eVRV?=
 =?utf-8?B?TEw3MHRoQlpTejB3VERpeitqRE94Nkl3QU9hLyswK2RXRGFZaVNyMUFuZlha?=
 =?utf-8?B?SzhDYjNhNlV2eFVDRytWa0tqcmJZS1c2dlhDSURqbWp5eDVRR3ZsNTZlVUUv?=
 =?utf-8?B?eU55TGsxMVNKUkpQY3QzakFYZDVBbzJVWVJ0YTVDalhCVVVVZjR4Y1l4dkxX?=
 =?utf-8?B?ZExBcXlwU0syNDFrZGxDQzFNSE41SWEzZ25JZTZ4RXNEblJ5Uk16V1dtemh2?=
 =?utf-8?B?bGVMbGRrMWRnL3hXT0t0SFVsczVwOGJ4T1A1akNScWMvTmNzeUtEWGFlanR5?=
 =?utf-8?B?TmRQUkh4ZEs3WFMvRXJIOVRzd1k4QU5vblVxL2lPdExYTzVyVmlicVcram95?=
 =?utf-8?B?T2FwWloxNWVrenJpL1gyMmo1MXUzZlFDWURPTlhLVHFaWi9obEJCcmlYV0lU?=
 =?utf-8?B?Wk9JSmFXaXNyaXhGV2JPRHZ3OFBmOTd6VElXWjlXU0JPVTZYZzM1STZmSEhJ?=
 =?utf-8?B?RmcyOEtVRE9ET3NGQllycElROWxjQVk2djVGcHgyNzlaMEpIQXZSWXRsSFpw?=
 =?utf-8?B?MWJObDBTdGNpcEhVL2VJakRidTIxMGFkU0Y3NFpYUkpSbmdLd3dQWElacHJ6?=
 =?utf-8?B?Y2Fkd2hjTEdINmx1K2FFR0NrMWQxeVNtdjdRSFF2bk4wUDNEZW1nY3FDYzRj?=
 =?utf-8?B?R3prdThMQ1hJNEtDVTg3WUgwdXV1VU9pYlhTanRiOEZCU1N1aHJMOXM0R040?=
 =?utf-8?B?ZEMyYnZXM0MxQ0Z2T0ZGZHpzODEyTUFmRzZwZFBSMzdpMW51ZFhHckhRazFu?=
 =?utf-8?B?S1ZuQ3UrYmhzNEdUSFNUYXplQU8yN0hsaCttbzFZRjFYd1o1R0RsVmhoYW52?=
 =?utf-8?B?YTRSMW1ldkRneVVRVVgxNk9xcWRTZE9xTlU4U1FsV1RhQnhkZWptMHNRakpk?=
 =?utf-8?B?QjhNQ2ZoNDJPajV6WGM4TElSaEtGNUZrWnpnRzVra0VuS3FNVGxmbUFIYmZM?=
 =?utf-8?B?RlhrSk9MSDBaT0UxREhhZkd6SXBNUE9LU2dtOXNUTzQ1eGIxT3U4WXYxdUU0?=
 =?utf-8?B?dkJEZHFRNlJjaXpsUTNBejdvS3NpeGtJQUcrMXovWitNdUtQS3U1UzZkWGFN?=
 =?utf-8?B?THY1Tk5ocVpRUFduNk1LQmhtUGpKTGtRaGdrWVlpM1BaVDNkcTdIc0xBZHdz?=
 =?utf-8?B?dW5kckNvbkZNZXlyQ0c0ZVNNNDgvUyszVEcyclZacEhEeDQ1OVJzR0hPZHc1?=
 =?utf-8?B?ZWtBcEtVQWFKWWMrcmRXOXNWOEhQYUNwaGFuYndXNmZDbUxGeHBXcC9IclJG?=
 =?utf-8?B?dDJ1S2JTTjdTZ0JyRldaUFVwUEdTam9jam9MWDFlbFBKcWwxZmlmblVHenFR?=
 =?utf-8?B?d3FMWmZicE9MV2xxSDlIWHNaR0V0ejJFNnJ2MlpHWHZyUGVsRWI3QWNyOEN4?=
 =?utf-8?B?NzREYnNpQkNFOFN4STljbTNnSGhEMndscEpweTRMcWFZWDJJeHVTTDJtTSsz?=
 =?utf-8?B?ZUc1K3BQT2p2RkhxZnhjT2Joc05OTmFYSk4vQzZKYmhZWTMxdG40bEhSblFH?=
 =?utf-8?B?akJ0OW5NSFdHVFhRUHNjekJ6b0NaL1dvNmYxaUNxQUlVQ1F5bGlDalYyWGNs?=
 =?utf-8?B?b3d2VXd5TmpsWXphTWVKV25XcUEvaVpXTUFoNE1iU3FESmdlcTN2N0dyRWND?=
 =?utf-8?B?Y0VKOEwzRjlrSnh0c285Uy9NcTZ3eHNVMHdwbnZxdkhXV2tpK2dQUm1jZ0Y0?=
 =?utf-8?Q?OmHjHgms2e9zt/hXaKKNNWk=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: add401d9-ec56-4d22-c283-08d99f95ff35
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5286.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2021 13:21:23.7550
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G+YrYZWpfYUdQmtGYaxhl1WGIsP8MGcdyXacLeDZ//XCu7uSQVRTm6QDI+UC2xjEFBWmy/KunmFwtXxrAZIuCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5320
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hi Boris,

On 11/2/2021 11:33 PM, Borislav Petkov wrote:
> [CAUTION: External Email]
>
> On Thu, Oct 28, 2021 at 06:31:02PM +0530, Naveen Krishna Chatradhi wrote:
>
> Staring at this more...
Thanks for taking the time.
>
>> +/*
>> + * Newer AMD CPUs and GPUs whose data fabrics can be connected via custom xGMI
>> + * links, comes with registers to gather local and remote node type map info.
>> + *
>> + * "Local Node Type" refers to nodes with the same type as that from which the
>> + * register is read, and "Remote Node Type" refers to nodes with a different type.
>> + *
>> + * This function, reads the registers from GPU DF function 1.
>> + * Hence, local nodes are GPU and remote nodes are CPUs.
>> + */
>> +static int amd_get_node_map(void)
> ... so this is a generic function name...
>
>> +{
>> +     struct amd_node_map *nodemap;
>> +     struct pci_dev *pdev;
>> +     u32 tmp;
>> +
>> +     pdev = pci_get_device(PCI_VENDOR_ID_AMD,
>> +                           PCI_DEVICE_ID_AMD_ALDEBARAN_DF_F1, NULL);
> ... but this here is trying to get the Aldebaran PCI device function.
I know, this is confusion. we will try to give a meaning for definition 
here.
>
>   So what happens if in the future, the GPU is a different one and it
> gets RAS functionality and PCI device functions too? You'd probably need
> to add that new GPU support too.
Yes, might happen
>
> And then looking at that patch again, see how this new code is bolted on
> and sure, it all is made to work, but it is strenuous and you have to
> always pay attention to what type of devices you're dealing with.
>
> And the next patch does:
>
>          ... if (bank_type == SMCA_UMC_V2) {
>
>          /* do UMC v2 special stuff here. */
>
> which begs the question: wouldn't this GPU PCI devices enumeration be a
> lot cleaner if it were separate?
>
> I.e., in amd_nb.c you'd have
>
> init_amd_nbs:
>
>          amd_cache_northbridges();
>          amd_cache_gart();
>          amd_cache_gpu_devices();

Agreed. however, a slight modification to the suggestion

Instead of modifying the init_amd_nbs()

How about, defining a new struct

+struct system_topology {
+       const struct pci_device_id *misc_ids;
+       const struct pci_device_id *link_ids;
+       const struct pci_device_id *root_ids;
+       u16 roots_per_misc;
+       u16 misc_count;
+       u16 root_count;
+};

and modifying the amd_cache_northbridges() to

+int amd_cache_northbridges(void)
+{
+        struct system_toplogy topo;
+        int ret;
+
+        if (amd_northbridges.num)
+                return 0;
+
+        ret = amd_cpu_nbs(&topo);
+        printk("==> misc:%d\n", ret);
+
+        if (look_for_remote_nodes()) {
+                ret = amd_gpu_nbs(&topo);
+                printk("==> gpu_misc:%d\n", ret);
+        }
+
+        get_next_northbridges(&topo);

This way, creating appropriate number MCs under EDAC and existing 
exported APIs can remain the same.

Let me know your thoughts on this. I can send an updated version with 
your comments addressed.

>
> and in this last one you do your enumeration. Completely separate data
> structures and all. Adding a new device support would then be trivial.
>
> And then looking at the next patch again, you have:
>
> +               } else if (bank_type == SMCA_UMC_V2) {
> +                       /*
> +                        * SMCA_UMC_V2 exists on GPU nodes, extract the node id
> +                        * from register MCA_IPID[47:44](InstanceIdHi).
> +                        * The InstanceIdHi field represents the instance ID of the GPU.
> +                        * Which needs to be mapped to a value used by Linux,
> +                        * where GPU nodes are simply numerically after the CPU nodes.
> +                        */
> +                       node_id = ((m->ipid >> 44) & 0xF) -
> +                                  amd_gpu_node_start_id() + amd_cpu_node_count();
>
> where instead of exporting those functions and having the caller do the
> calculations, you'd have a function in amd_nb.c which is called
>
>          amd_get_gpu_node_id(unsigned long ipid)
>
> which will use those separate data structures mentioned above and give
> you the node id.
Sure, we can modify this way.
>
> And those GPU node IDs are placed numerically after the CPU nodes so
> your code doesn't need to do anything special - just read out registers
> and cache them.
>
> And you don't need those exports either - it is all nicely encapsulated
> and a single function is used to get the callers what they wanna know.
Got it, thank you.
>
> Hmmm?
>
> --
> Regards/Gruss,
>      Boris.
>
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fpeople.kernel.org%2Ftglx%2Fnotes-about-netiquette&amp;data=04%7C01%7CNaveenKrishna.Chatradhi%40amd.com%7Cdd5b3586178441f4886808d99e2b1ef3%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637714730331703852%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=oXDojOFqVVhxn4P1tgwLycaJgc2rvwo8EoUj3i971Mw%3D&amp;reserved=0
