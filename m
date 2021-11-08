Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39255449A51
	for <lists+linux-edac@lfdr.de>; Mon,  8 Nov 2021 17:54:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240260AbhKHQ4v (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 8 Nov 2021 11:56:51 -0500
Received: from mail-bn1nam07on2082.outbound.protection.outlook.com ([40.107.212.82]:9982
        "EHLO NAM02-BN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231330AbhKHQ4u (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Mon, 8 Nov 2021 11:56:50 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f+Zd1GYwfDcs3xSg1W6hDKM813QQeIdF/pVTqZ/1glF6wKROefEV2mOxSz36uPc88tSqKjkw1Yb5eJPUw7iRnhHyqc3q2x9VU5grPdOohnSv+elJoXWLPmUG8Ml3mgvTAuKgK2Uvt6p0ospLWr3mvoVeVii0LJmGTQ4AN6dQfcqyiBb21jU8G/h540L8TSVCv1yxniPa7R4LRYauoLNiiDdg3C/YRJeQCdx+bkvZlA8is9pycN9CblK09BjlrtU+b7zIv9AamxNGoqNtxdDd+5Oq3sopFCC1a6DizC4DSggryNieDZ6OV/6RRS0gjJay93DXweT0V+tpTfb54TFH4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GfQ5apR4A25IdSZDbqI3oAn+XfgHfJzXFlz+sIm5nNM=;
 b=fakCJO79hcPrZSm7mEnRyF0uY0dzqDZGvp5X/YDZePaznFMYwK1p6nPc/F7DlIh6a8rRWihxl0PvZnMdEOQLGf67YFJpHf+ts+atAczGGIytFjdAL0yKXQ897br8dYtAYBI6G8jhth59XM5f/FFIoD3KC9N50NXjUxjTVM5l7sBpThXpHZcOg9uGNrPZuLWNS/g8chUJPSArCnWZL68dnXfeDySXwr8E/EqxtaRtnkXtuDHkXpDLSj91BsNuIF3YEEdqaLnk3c8aUvrah6v2+qO/FWQR5Qw6YyD1bAE1FaLmk4GGQkwsyEjEcaWsVPggpRaGfoHUeGzW2JZiW7kZSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GfQ5apR4A25IdSZDbqI3oAn+XfgHfJzXFlz+sIm5nNM=;
 b=F0OYybVaZHEu4lndsIOLPmA/fZPzJBxE0D2Etn1yKz5AfseBPxO/DHx6s/eX4QCXWpY1lW0ogVNHfAAq0wHa9da8aomDzMGrH3Q9m9lCreDX2Of2Wm0plhsUokDjRTlL4tTJ7Ntyi+S9+fkUBTelzHkvNrecqXf1Ze2zWnlahtY=
Authentication-Results: alien8.de; dkim=none (message not signed)
 header.d=none;alien8.de; dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5286.namprd12.prod.outlook.com (2603:10b6:208:31d::6)
 by BL1PR12MB5239.namprd12.prod.outlook.com (2603:10b6:208:315::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.11; Mon, 8 Nov
 2021 16:54:02 +0000
Received: from BL1PR12MB5286.namprd12.prod.outlook.com
 ([fe80::c1e:36ae:bada:e396]) by BL1PR12MB5286.namprd12.prod.outlook.com
 ([fe80::c1e:36ae:bada:e396%7]) with mapi id 15.20.4669.016; Mon, 8 Nov 2021
 16:54:02 +0000
Message-ID: <bcf5e86c-d3f1-0dab-2bed-505b1eb95f17@amd.com>
Date:   Mon, 8 Nov 2021 22:23:49 +0530
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
 <b7f3639a-e46c-25e8-270b-04860074fd3c@amd.com> <YYknXBpOUQtV1aZ8@zn.tnic>
From:   "Chatradhi, Naveen Krishna" <nchatrad@amd.com>
In-Reply-To: <YYknXBpOUQtV1aZ8@zn.tnic>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0161.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:26::16) To BL1PR12MB5286.namprd12.prod.outlook.com
 (2603:10b6:208:31d::6)
MIME-Version: 1.0
Received: from [10.252.84.184] (165.204.159.242) by PN2PR01CA0161.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:26::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.16 via Frontend Transport; Mon, 8 Nov 2021 16:53:58 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 904e820d-f6ae-4958-683a-08d9a2d85dfc
X-MS-TrafficTypeDiagnostic: BL1PR12MB5239:
X-Microsoft-Antispam-PRVS: <BL1PR12MB5239F88D0814273F01DA268CE8919@BL1PR12MB5239.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sYoBKC49bl5rg5pHoeFqzydZZfiZfZ6YIcMEuqayvMuKwCxmqauejLIrhk0wK/x6JYwQ7UtGcSKTqnaqR7WoSJSnzWdVctsp3p8TZVHVt0Gtp1ImZPI/zCpt6JoiAxj2Ig/k8nbxcxLSGuo95CF1OmLixZZKLFFN5EhSw9fkSGK3S5bGbneiML98d5Wai19yhH6u+cEM/jQ2vG8gTEIfwZbL9+McHIU+i/c5WILmq+x8NSMDmDBfx1O6rQAOJGWzXzMVTGBYKo8oq6HtE8rkjM8+CiS2Dfve2Wr6vNNCOFsZGpq5Fb8rxxTbUqz3ykPuZCT0LsLizeyU8rnrbQNX6R+QkqfWVWcTTXiP7wwCdAT/Fkg4gqHATjk0qNdX2wbpCOCevNiqEFXszuDtxAb2a9uy3SNlLIxmorDPRsrk2sYB+AGkFbYnDLwWeuMY79hyz8zWleYweS65l/POlu0/sokpdGePAVoI4wwZYC0sdhlRlQtQDc0i84X3MHu9BWC9XJqWBLA/87C/MgoXoIRCYhZnqzdlKSvGM/FwVDRfVUtwCxTloOPc7r5F5q7yFGO+q5Hqzhw5p/VkFXPZjfWsaVMQU/VpdxiUHTV3mCJ67OR3zMQWxj/HAK/ndYmPiHzj/uFtv7CMuwgJIG43wAu1BKePWeuuVYLUMkvlSGCTFifpPX3O8af1H3t2TCLFb8zCQC5wFTMQUIOQldorubCFzuG2F/byAN3U0KJ4d5wQ7ZJqBT1KRUdng7Vdv2F26XILOa3SYsyqnkodu1UNLbt4WopsB51+5BFA3WdFqFEt0uZq5dzrxldf5qhVdn+SlGdqzNNtcZsdsVWZPac1w0GQ3Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5286.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(956004)(83380400001)(66946007)(36756003)(66556008)(2616005)(6666004)(6486002)(966005)(66476007)(45080400002)(5660300002)(2906002)(508600001)(186003)(31696002)(6916009)(16576012)(53546011)(316002)(31686004)(8676002)(38100700002)(8936002)(4326008)(26005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YWU5MGNuN1RXcjNITkMvKzlPVzlKREZvTktmSUtVWnlxMXU4R3QrbCtrNCtM?=
 =?utf-8?B?SDhFTDVQaytrUzZHY01PRWlBaytuME1ySGs3WW1vMmdVUTBMQnZMVzNpeDV1?=
 =?utf-8?B?bHVTOGFzZXMyZmJyL3Y4WmRLNEVKZ25tWmdGclJOb3I3T0FKWHI4L3pYRzlR?=
 =?utf-8?B?SHBWMHN6a3BOelpQaXk2OEhFUU9KVVFTRjd1bGtDNk94cVRHQ3BET0U2WXpU?=
 =?utf-8?B?V0dxZFl6UktxU3puVXVYSWdXa1hIRWltT3RtS3NmNkU2THdVYVdSNzlVRXYw?=
 =?utf-8?B?emRnUWZSVGtIcEQ2SzZhT2JTd2psU05TNzEwazNVR29wWm80YVlJd0JnanlG?=
 =?utf-8?B?YmY2Uzh6WllBM09qcVVvQjY1eExnZC9iRStKWVErcUtCNXRMdkhiSitYcUtK?=
 =?utf-8?B?M2IyWDIzTFlIZkVNREp1eWxRRmY1UUUwcXEwbGZ6WnNXOVpRYXpicVZEM2xP?=
 =?utf-8?B?Nlpvc01DdUxBay9VK1ZNaXRPLzJvZjhQemtvcmFROGx6UTFVbnNtZFZ4SmJa?=
 =?utf-8?B?VGZlUDdWdWtiUEV0dUFhOVpVNC9WWGNLdXNvMi9zZEdweWV4WEN0aW9CaFBy?=
 =?utf-8?B?Z0tYSEM1VnIvK1MzMC9HV085bjE0YnlXTlYxRm5MRHVJQ0NPdGs4UVZEZERv?=
 =?utf-8?B?WGhKRCtSWFFXeDlVOFllalBEWlZIR0JadVhjanBJdmVCWHRra2hoL3lKNHlr?=
 =?utf-8?B?OXhJMkZpVHdtUWtUdmR2cG45QU5PUjJVV3NXM0UrZW14RGsrNU54Q09Rd3g3?=
 =?utf-8?B?SWFsK3ArWkluOTMraUdmQ1ZQS2xGTFZqSG94c0hQMS8yQmhYNFpqcmswVnVs?=
 =?utf-8?B?MDBDbWZPNjd0OUNUQWdpY1lod25DamsrQ2w5R3N1KzRBd01aelo3djdVdnhh?=
 =?utf-8?B?WmJRaVl3akU0OFlycU1Ca3ZHb1B0d1JSbWxlUlhidndMYWNJYkJqUTN1T3BT?=
 =?utf-8?B?RlpTU3JVU1lVaGZ2dUpXbGp3MDdPUGVyMFdjaUdydmZyMTB4MVVNazF4WHVh?=
 =?utf-8?B?ZzVtTUIzWXAyVm4yVTdMeU5CNkEycEdoNTNwQkhrelVSQ1d1YnkxNzdzb0wr?=
 =?utf-8?B?Nks5Nnd2RVU4M3RaN0tzZzIwcjFJZUMyNzhrM3lScnB3ZGhIcGlLR0Jad2VJ?=
 =?utf-8?B?MG93QmJpUWd3SnNzY0tOdlI4VVltVUN2aUpzOU1zcks3Z0NmUWZjVHRHV1k1?=
 =?utf-8?B?YnpmaTJ4Y1ZVWjNhUDhDL00vOWhvK0h4b2w0N0RHUmN0cVE2Skh4cXNnL0lN?=
 =?utf-8?B?cjh2Q0xvWUs5enFDdkJaMkx5R05YM3FxQnY0U1h4eFlPRzZsbUFJbGZ5cDd1?=
 =?utf-8?B?QVBsSm1PVnA4Vm9vMUZ3SE5OZnhFUncrQythNVJmUUxqcmMxWkJqRHhtWE90?=
 =?utf-8?B?LzBkVUxQdTZMMnljVlVheEl6bEpUMFJLa1RpdjlKeFdnOEVqL2QzeGJaaHB1?=
 =?utf-8?B?TWo0VjhtM1VvZGY2NFlPRlJhNm4xOFVhNVVnTTJtbnA1VnlMLzRiajg0RFpw?=
 =?utf-8?B?STVzRWpQYTJWR0dDK3ZvT0QyV0I1RFJFZFk2RGRudEN4ck4yY1dvUDBONEww?=
 =?utf-8?B?V2VWV0hDYTJkdEc4S0k2MU8wV3ZWbDlpTkpMd3ZlV2M2TWhwc04xZ09XeE1F?=
 =?utf-8?B?blNvZTNVQU9LYnp0MDVGc3QxWVRCb0ticU5Td3lmZFh0M25XMWdTVmhrN1hK?=
 =?utf-8?B?Sy8reHBrN04rbSs1TXBZeG4wSEoxQVpNdUtGZ3JXSTNNTXZuNlpTV1RTYmQ4?=
 =?utf-8?B?Um5kNVZBYWxyc1NjcXhEWCswWjBVWG9Lb2N5R0JyUDBYT0JtSWJqUXBzS3l1?=
 =?utf-8?B?YmdWbmtBZkFOMXJEZml2UitSQzNHMWhYTEhyV1JSc1Nhcm10Zk5jb3VDUEgw?=
 =?utf-8?B?Q3hOMWFGM3N0QnFyOGZIV1Zsc0Ruc0JKbzhRbU5QcytaOG92ZWFoZDlhYWVQ?=
 =?utf-8?B?T3NyYy9RcWtSODl0SmNiRG82cmd6aGRHRHBnOGRGOHJGdUZZKzZTdmx1SW5h?=
 =?utf-8?B?N3drK2ZIa2xuQkRpd09na1NFZWwyZGIxRVJDWUxSb3lSc3cxWHRnam1SM2FE?=
 =?utf-8?B?VENhNTJEMFdncCtPYVk2NVNPNGNod1RYbndicTNPTDgvRTl5b1JwMGpDVTlK?=
 =?utf-8?B?dDM2YlUzY25NZDRRbHpXOTFjU2pYb1JwRnJQYzMvbDIvRTRUNlJUcjBFSjkw?=
 =?utf-8?Q?Wx9AQD2AcnHEZpG0OUBf8Nw=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 904e820d-f6ae-4958-683a-08d9a2d85dfc
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5286.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2021 16:54:02.6409
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vp575JV2nsf+krPJ4d1IiTZnkV0PmNujoUEGv4IPEyyD6rnoUSFqblmPqJL4DQX2qfj1m5CyuFpPwbSsYpnpqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5239
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hi Boris,

On 11/8/2021 7:04 PM, Borislav Petkov wrote:
> [CAUTION: External Email]
>
> On Thu, Nov 04, 2021 at 06:48:29PM +0530, Chatradhi, Naveen Krishna wrote:
>> I know, this is confusion. we will try to give a meaning for definition
>> here.
> Well, not that - you will need to keep adding PCI device IDs for the
> future GPUs supporting this stuff.
Creating a pci_device_id list for GPUs will be needed.
>
>> How about, defining a new struct
>>
>> +struct system_topology {
>> +       const struct pci_device_id *misc_ids;
>> +       const struct pci_device_id *link_ids;
>> +       const struct pci_device_id *root_ids;
>> +       u16 roots_per_misc;
>> +       u16 misc_count;
>> +       u16 root_count;
>> +};
> Well, how does having a single struct help make things easier?

Northbridges on CPUs and GPUs can be described using the elements in the 
above structure.

>
> IOW, if you use accessors to get the information you need, it doesn't
> really matter what the underlying organization of the data is. And if
> it helps to keep 'em separate because stuff is simple altogether, then,
> they should be separate.

I thought organizing the data in a structure would simplify the 
initialization of cpus and gpus.

>
> So, before you ask "How about", think of answering the question "Why
> should it be done this way? What are the advantages?"

I will modify the  patch to enumerate gpu northbridge info only if there are

gpu nodes with  pci_device to access the node_map registers.

>
>> This way, creating appropriate number MCs under EDAC and existing exported
>> APIs can remain the same.
> Why does that matter?
>
> Also, have you verified in what order the init_amd_nbs() fs initcall and
> amd64_edac_init() get executed?
>
> I'm going to venture a pretty sure guess that the initcall runs first
> and that amd_cache_northbridges() call in amd64_edac_init() is probably
> not even needed anymore...
Yes, fs_initcall come before module_init (which inturn is device_init 
level 6). We can replace the  amd_cache_northbridges() call in  
amd64_edac_init() with if(amd_nb_num() < 0).
> Thx.
>
> --
> Regards/Gruss,
>      Boris.
>
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fpeople.kernel.org%2Ftglx%2Fnotes-about-netiquette&amp;data=04%7C01%7CNaveenKrishna.Chatradhi%40amd.com%7C45b6d75b206849ab022808d9a2bc7d4f%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637719752712242190%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=WW26EMOnu%2FBazap9njmnQIvY9hVSZxVpNol4uptGcec%3D&amp;reserved=0
