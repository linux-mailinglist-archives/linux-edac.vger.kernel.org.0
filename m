Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE40142F059
	for <lists+linux-edac@lfdr.de>; Fri, 15 Oct 2021 14:18:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238714AbhJOMUx (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 15 Oct 2021 08:20:53 -0400
Received: from mail-dm6nam11on2079.outbound.protection.outlook.com ([40.107.223.79]:51905
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238683AbhJOMUw (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Fri, 15 Oct 2021 08:20:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n3a75IEoUoUBoAP7N3KW5joF5iALx8buqSbbcaSuLizaq3qAqgtcolIDeYFUZXptFMRNcQpSA8Grc30LhQ8+GJX2Ix33+5j+MGICAmS8FgHF9lf1N6XE1LsO2cdQ1RHaQWKQ3JcC58faP6ffHTMKnFEjLrrRPRhyNkcqYdgj31UPRKg7hzGnQvLf/BScKK4maH4+wcKgHI5PDdLzbY8efAbEno1uGL/srxn6DGBttMZk0ZfJPaHbNfeL6+8jaFkgFKh0TRv1X7d602WCVKPA9MoTII60uO4hKxlwCraO1TNKG38Qmo0pH5ICY8woukjgTPQ+u80xpFC6hsxFFGqLNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wcq7lqsVqNsr+h0kAVHuG5awWH+V1IQxkHe2jWUvPvo=;
 b=TxJEPrFYZfvmfKgAzxZi2upx2wX6K3OIbfKbcH5Kzp3RYOC8FRH0mYZVLGRFK8RrHm+amhT8MRmFE6ncfIzi0e9+tK640vgzPYl4w2h3qDRwXN/kn2yqBkR7r8BScx4hIlKVEtQSfog04eHtA7n8Yln0mkLvL57J/Iu2n2lYyuLqsw6BxWowOnVswy9kwM+l2DnyKnW8wR2KJGlP0VDtGbB3ikHInjekZkF9bK+Wm9lcOwZkUQC6yrV6glOGOGEebItdym6z61EkjYlI62NND28U26/qPQpKA7OFOheQWDe4Nt7f1+t2ZrB+GtWJje4enrM9gFE6iCE33o7Tx52muw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wcq7lqsVqNsr+h0kAVHuG5awWH+V1IQxkHe2jWUvPvo=;
 b=eWljHjh+NknfmjwaxW7fcTAz0evv82lJVXuXSp84GaB3YsLMvjrJy1gG2NTfMMG2jYQqBW7lGeNDta8Ubs+8TaOg06fAu3Yw1DE/7aZV6Zs6Ddu+B8NTdBpIOUCJAd5GUXmgdshFG/ZCOcCcrnAUbkEQl2TBm0wJZ86bM7fd0RQ=
Authentication-Results: alien8.de; dkim=none (message not signed)
 header.d=none;alien8.de; dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5286.namprd12.prod.outlook.com (2603:10b6:208:31d::6)
 by BL1PR12MB5160.namprd12.prod.outlook.com (2603:10b6:208:311::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16; Fri, 15 Oct
 2021 12:18:44 +0000
Received: from BL1PR12MB5286.namprd12.prod.outlook.com
 ([fe80::8c60:1040:31ba:22f0]) by BL1PR12MB5286.namprd12.prod.outlook.com
 ([fe80::8c60:1040:31ba:22f0%9]) with mapi id 15.20.4608.017; Fri, 15 Oct 2021
 12:18:44 +0000
Message-ID: <9f78573d-c969-da1d-8a7d-4abd7d8a75f2@amd.com>
Date:   Fri, 15 Oct 2021 17:48:32 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v4 0/4] x86/edac/amd64: Add support for noncpu nodes
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-edac@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, mingo@redhat.com, mchehab@kernel.org,
        yazen.ghannam@amd.com
References: <20210823185437.94417-1-nchatrad@amd.com>
 <20211014185400.10451-1-nchatrad@amd.com> <YWiKpw5MwtAiwNyB@zn.tnic>
From:   "Chatradhi, Naveen Krishna" <nchatrad@amd.com>
In-Reply-To: <YWiKpw5MwtAiwNyB@zn.tnic>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA1PR0101CA0055.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:20::17) To BL1PR12MB5286.namprd12.prod.outlook.com
 (2603:10b6:208:31d::6)
MIME-Version: 1.0
Received: from [192.168.0.121] (49.207.215.6) by MA1PR0101CA0055.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:20::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16 via Frontend Transport; Fri, 15 Oct 2021 12:18:41 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 772b1bad-2d7c-4225-c4dd-08d98fd5ee18
X-MS-TrafficTypeDiagnostic: BL1PR12MB5160:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL1PR12MB516084B9D698DCB5D107CBDBE8B99@BL1PR12MB5160.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aoEuuokojKYyTeEcUmfnQ57tHzvQTQtoUJrsgrrgHNvogZr9faqA9VEJL0lE7sexxm2hH/NZ0vWepu1XG+N9AB7stUfUfSP1LvgoEBtjQI6+ntWu/dft2ZnykJSAXeg/W60NcejBwErHGMSYV8NSolkQcchXZhCA3tC5seFr5k/hFAJ6JVGjeXjB9EKZDpGTAIUe4BDOBPualCx58WWzrAWc8XnrEfkW0baD6p9A1PrFA0JCsEYkCyw32U3csFCNCUVAqCfNfUHmmpoHeRYUG3lx8yqkZ8yNrkyygelrG5mzPOgsF9KO7emUGSYGs4WdpKKs3pHZ8glHAHAp0oE3O1n6hnIjrZtdxMnrneh2f78zsfVkojveZ35GLiaStaCthkZuQ+NXFuVniINCJxcuAbwLVZ70IXEL5NO/CFlPkM4bdhnVuP3MG5D3ALatyzE8CTmvBNXxZsAyxkdAbyRNMV/5vj5BXec74ArvPh9yAuyWYWNXF36eFBr5xDKZV8tp/Nb8lDzgsFiTEzvU+6fe+6Gpx9U+KB5ECeTWBrhEGVrtW59BYQVA1KYcZ0ZTTSi+IxkNhOB+AlsGYWmS9SwoXx17L5B7lNNKTb1La1xGe0HyCntX+RkZMltiQ0pVB8j5jxpusZ+ryFuOGnqMiIInDgrFqUq3Rtorj1FFfVoF1KOiHpPk0b5DvyMMY6rofHFK751onLKtEKCcagNbzzVYKjanj/g4T/mlb8Fl4OoWIWil2usqQUNNlSWPVEgrltedbpJuRGy4GjqsWOhhX1oJYy3pNZCDegcw5afbyNtBHNCLOvaXI8Dt21jCOHyJ+5lzbtrjRWg4AjwQhV41p4vaX06l1j0V+/+tV5BPwnDvri5JsaMoCW1sdmNespOeWfTV
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5286.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(966005)(55236004)(66946007)(6666004)(1006002)(186003)(2616005)(6916009)(956004)(31686004)(8936002)(8676002)(66556008)(6486002)(66476007)(5660300002)(26005)(53546011)(31696002)(36756003)(16576012)(508600001)(83380400001)(38100700002)(4326008)(2906002)(316002)(45080400002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZGVXZ0NxNWhoWWFEK01qcU1sMkJ4c1BhNXJQOE45dkxwVjhKclROOHlBUjVq?=
 =?utf-8?B?bjNXSFhGV25od3ZrK3NmWVVlZzJEOWN1V3dReHZBcmRtOFY2KzJNOXBhRzk2?=
 =?utf-8?B?Z3JJUGRBNHpUZ0E4dHoxa0o0K3RSaDMwaC9ScVpxNUZ1Z1NuTmg1T1g0bWdM?=
 =?utf-8?B?WHhZT0xvbVJtdUZBUjYyNkxJL1hoM0VDY3lyY0pFU2J6RjNJTnkwT1VwNXE1?=
 =?utf-8?B?U281amdYT2xPb3h4c2YyNHF0WXd5NThHTXpPc05jMm9tMm05K0UyZm16S2I3?=
 =?utf-8?B?ais5dHdsTXVOUjJva0xtZndtWVRCK1ZYbGZ1NzR4RG4zRSs5SjY5cUpUZGNp?=
 =?utf-8?B?a1laaXBqbm54aVYrVk10TU9DNEF0Mk1Qc2k5c3BGTWUrR3JsRy9LTWwydmdZ?=
 =?utf-8?B?TTdLUEFWbWNTYlFlZG1DN2pEQU1qRko2Mnd5SS9zYzJYOU90eithMkhZamVR?=
 =?utf-8?B?QkpMeTc3d3A3YUZYSVlkTnh2MFNYRlVoTFhqUWdvdTNlZFc4VjlnS0VxZG1L?=
 =?utf-8?B?SmprcE5GQk5NMktHMnEyam1tOTk1cFhzNnJwcFJTYWI4OTJCWWdwbUlES1Iv?=
 =?utf-8?B?d0s5b3FyTXk3d29rczBQWUs1cG93Y3Z3MWx3d1hxN1dnWGR2emZOYTFqenp4?=
 =?utf-8?B?OVh4QlpVNitpQkh0N3dKQ3hMN1hCdlNiTmc3NW12ZGZDZEtKSlRjMVRTVUht?=
 =?utf-8?B?TGNZcW5QaG92VE94ZmFFeHBLcUZEaW0wdmZ1aEUzSllPWTVEeXpXNTFGOVVw?=
 =?utf-8?B?Tjl3Y1IwbjduY3E0TG9SbC83WHdUSVRvaXcxM2kxOGIwYzhaS2JuWGx3Mng3?=
 =?utf-8?B?Mm1XektDS3ZyYlJiUlNTY0dIczh1N3U5WFdQSFlua3JGdXY2OFJCMzdpVjlQ?=
 =?utf-8?B?ZDNNR2MxRW4ycSt0Nk1zOURnc01pUlVBY0RORFZkRy8rS1o1YnpUeExGWlpM?=
 =?utf-8?B?NGVVcVRaZEl2Rk9TVnlQR0dDYzU0bTlZcjczVG0yMVVvMWpVWm1KeWM5ZXg0?=
 =?utf-8?B?S240SmNRQWl3R2E5SmQ4SEtEVTlvNm4vUENITXZsOEJnUUhBbnBGNFlkVFcv?=
 =?utf-8?B?V3JWZ1cweC94RGpVZTc5NW9nVU1oaWtYcGNMbEEzYmdlWC9XbjJiNE1JUGJT?=
 =?utf-8?B?Kzd2d3RSL3g4V3pTWjh5TVk0d0MySkpYR0RlL2JSQnA3d285U3pnbGljUkR2?=
 =?utf-8?B?ZmJETWo0VFpUcjNMd0w2eVFJSVlnVkdKS1NpRHpBMHo1c3FDcVVLOFE4U2Q4?=
 =?utf-8?B?RnNCMUJZY1pzengzZUsrSEVsRlg1cGVvazVobzlMbm9PN3c2dWo0QXVTWFYz?=
 =?utf-8?B?OXU5Z2VPWVFJcXc0RERKUG5icmVWRy90YnBrNHpJRWxpeWI0UnlXcHhSOTY5?=
 =?utf-8?B?S2tqMFp0clBtQlJJWStOUDh4SEJ1aE5TNmF2czNvd3VkQnR4WGlmVGJGRXhV?=
 =?utf-8?B?b2s0dmhWc01PZ3Z4VjFUUFdOSSs1UTNjWUNhNG1JUzVCdDJuZ05oL0ZZSjJx?=
 =?utf-8?B?a1JkQVBMSGpDL3d6M0hVcDFIbEE2MWN2WW9RT1k2YmpQcFF3ZW1xSjRpTHRa?=
 =?utf-8?B?OGprWGpyb1oyODB4RW9pTEs4ZS9uRU5SOGVVb2pGTFFWbDc5bWlkQWlCcVc3?=
 =?utf-8?B?ZmRpQllJWFppMDNpcGtZMWZySzIrd1BGc0V0blJDMVJiTXZMb0xqaEQ0dnNP?=
 =?utf-8?B?NWZJbjBJQjExbittWWhuZGE5ejZtYlB1YStoTTJVZ1YreU9ZR0NQVmEzQjkw?=
 =?utf-8?Q?RGo9mFpSdIJ/82ykkB7fKlW5AfebbnZEax0qJFm?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 772b1bad-2d7c-4225-c4dd-08d98fd5ee18
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5286.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2021 12:18:43.8577
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TpxvHPkKAcXmv4sXn8H1GibWQb+fV0PFwG+PeJOfejIbFLGyqFVY01OI+RVEr8POrEYEikC/DoQUtnNfehZrBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5160
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hi Boris,

On 10/15/2021 1:23 AM, Borislav Petkov wrote:
> [CAUTION: External Email]
>
> On Fri, Oct 15, 2021 at 12:23:56AM +0530, Naveen Krishna Chatradhi wrote:
>> On newer heterogeneous systems with AMD CPUs the data fabrics of GPUs
>> can be connected directly via custom links.
>>
>> This patchset does the following
>> 1. amd_nb.c:
>>     a. Add support for northbridges on Aldebaran GPU nodes
>>     b. export AMD node map details to be used by edac and mce modules
>>
>> 2. mce_amd module:
>>     a. Identify the node ID where the error occurred and map the node id
>>        to linux enumerated node id.
>>
>> 2. Modifies the amd64_edac module
>>     a. Add new family op routines
>>     b. Enumerate UMCs and HBMs on the GPU nodes
>>
>> This patchset is rebased on top of
>> "
>> commit 07416cadfdfa38283b840e700427ae3782c76f6b
>> Author: Yazen Ghannam <yazen.ghannam@amd.com>
>> Date:   Tue Oct 5 15:44:19 2021 +0000
>>
>>      EDAC/amd64: Handle three rank interleaving mode
>> "
>>
>> Muralidhara M K (2):
>>    x86/amd_nb: Add support for northbridges on Aldebaran
>>    EDAC/amd64: Extend family ops functions
>>
>> Naveen Krishna Chatradhi (2):
>>    EDAC/mce_amd: Extract node id from MCA_IPID
>>    EDAC/amd64: Enumerate memory on Aldebaran GPU nodes
>>
>>   arch/x86/include/asm/amd_nb.h |   9 +
>>   arch/x86/kernel/amd_nb.c      | 131 +++++++--
>>   drivers/edac/amd64_edac.c     | 517 +++++++++++++++++++++++++---------
>>   drivers/edac/amd64_edac.h     |  33 +++
>>   drivers/edac/mce_amd.c        |  24 +-
>>   include/linux/pci_ids.h       |   1 +
>>   6 files changed, 564 insertions(+), 151 deletions(-)
> So which v4 should I be looking at - this one or
I've noticed the v4 tag missing on the 3rd and 4th patch in the series. 
i tried to abort but the git send-email went through.
>
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.kernel.org%2Fr%2F20211014185058.9587-1-nchatrad%40amd.com&amp;data=04%7C01%7CNaveenKrishna.Chatradhi%40amd.com%7C74d7878274cb4849f2b008d98f4c42c6%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637698379996982690%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=g1%2Bw29J4X%2FbdsugpYICDKMzM4Qd2nvsS1dV8zgR150w%3D&amp;reserved=0
Could you please review the latest one (above link) or should i push 
them as v5, to avoid the confusion.
>
> ?
>
> Btw, you don't have to do --in-reply-to and keep all patchsets in a
> single thread - just send the new revision as a separate thread.
Sure, will do that. thank you.
>
> Thx.
>
> --
> Regards/Gruss,
>      Boris.
>
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fpeople.kernel.org%2Ftglx%2Fnotes-about-netiquette&amp;data=04%7C01%7CNaveenKrishna.Chatradhi%40amd.com%7C74d7878274cb4849f2b008d98f4c42c6%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637698379996982690%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=RNIqyNMrAXLLIzfDB06wXSrmRXH7C596oHAnGIQM1e0%3D&amp;reserved=0
