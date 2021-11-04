Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6BB444566A
	for <lists+linux-edac@lfdr.de>; Thu,  4 Nov 2021 16:36:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231189AbhKDPip (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 4 Nov 2021 11:38:45 -0400
Received: from mail-bn8nam11on2088.outbound.protection.outlook.com ([40.107.236.88]:53888
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229770AbhKDPio (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 4 Nov 2021 11:38:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DZv7+B34xPEqZXG/iedOLzbWOUElTZkmB+BpUe7pY3kboQr9fGgjBF/gfj4CJ02aU9tqLyCMtsSU95nkROzhotx3hKFnAnHpHXWkoYlhR3bmU9QnIfB5hufuQlYhT6Id26FdqPsf2/iN4OukyaAWfT/wKJiVz6k4bO4v8gWzTjvqW60AWm1FTZpF4j80MZ+DQa+k69dGw5QHNSomZM03Is8uREFrAw/pFoiROwcPGamOUcW82rgBPmfJGRHDl4nVzRmKkNIJvqLBSqlhUZkFiefMwqWCgC+sSEFgkWGogS07a6kRLUOjlWNSQBa55IkpSpRSL7MVvxSIoirLWNsCgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aOqz7cr+J6ahvKqf3Ti6/fOrKGMbqH1OTs9nkL5Bj4o=;
 b=USKFCk87v2uo1j5/QhMsj6+wRFJqGXYN0cATpGGuKB6r9i+CF9TYgYJNdS7Mw+BFlNtHJ3M7B4tj2jk7X7ecHrlrK90xqJCKGye1DAmHKxbexX8iHj8/9UKvGt0dCUR2SQC+g/dCWWyjpTygUwkNt+Q+4sAZVvAINu9d0cJwKxB8Y9MGuspLbn7S3BLi2UT7QZ/X6B9dd9NiGqsfN7b0LTtSFn+TeLEHuUGurRcpHihIpJp8Eupvy3xLB2s+ojMqF05WGmWOuaNEniHSq81jK+kP95jXRLySW4Rgl9W2mmBk9ljiqluXGl3hBT7A6mwEWM+kuis2FAhXwusQ+Bc0SA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aOqz7cr+J6ahvKqf3Ti6/fOrKGMbqH1OTs9nkL5Bj4o=;
 b=dSG+uIinR2Mpv1NLZ/sBj4W73Mdq0cYBfjF2nG3yd4S/tEjri4YH5sggn8UU7xpIahDsFvXcCbvv1dYhjc4fYBGW3+3/dukKnUsItUJxRpfLGeurEgQyiNnEtHAM+ByepjlkTYDhs2STiYwfhLXNGI2H8k+6XIvJgZrj/BIda6c=
Authentication-Results: alien8.de; dkim=none (message not signed)
 header.d=none;alien8.de; dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5286.namprd12.prod.outlook.com (2603:10b6:208:31d::6)
 by BL0PR12MB5507.namprd12.prod.outlook.com (2603:10b6:208:1c4::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.11; Thu, 4 Nov
 2021 15:36:05 +0000
Received: from BL1PR12MB5286.namprd12.prod.outlook.com
 ([fe80::c1e:36ae:bada:e396]) by BL1PR12MB5286.namprd12.prod.outlook.com
 ([fe80::c1e:36ae:bada:e396%6]) with mapi id 15.20.4649.020; Thu, 4 Nov 2021
 15:36:05 +0000
Message-ID: <b47b168d-283b-390a-5b4d-c5cfecd1bd9d@amd.com>
Date:   Thu, 4 Nov 2021 18:51:04 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
From:   "Chatradhi, Naveen Krishna" <nchatrad@amd.com>
Subject: Re: [PATCH v6 1/5] x86/amd_nb: Add support for northbridges on
 Aldebaran
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-edac@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, mingo@redhat.com, mchehab@kernel.org,
        yazen.ghannam@amd.com, Muralidhara M K <muralimk@amd.com>
References: <20211028130106.15701-1-nchatrad@amd.com>
 <20211028130106.15701-2-nchatrad@amd.com> <YYF9ei59G/OUyZqR@zn.tnic>
Content-Language: en-US
In-Reply-To: <YYF9ei59G/OUyZqR@zn.tnic>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MAXPR0101CA0040.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:d::26) To BL1PR12MB5286.namprd12.prod.outlook.com
 (2603:10b6:208:31d::6)
MIME-Version: 1.0
Received: from [192.168.0.121] (49.207.200.84) by MAXPR0101CA0040.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:d::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.11 via Frontend Transport; Thu, 4 Nov 2021 15:36:02 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 193f2494-ec60-4d7a-66dc-08d99fa8cfff
X-MS-TrafficTypeDiagnostic: BL0PR12MB5507:
X-Microsoft-Antispam-PRVS: <BL0PR12MB5507109FF93535A76BBC3F10E88D9@BL0PR12MB5507.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NnRUaHAySD9cfOtWnkwQ5mgscrV1mlOxpyGIENrBDNXFN/p47n0LQXXO+N/w51wSn5GKaXfiiwIRXsFyWWlyStk8kaQyDJ7B6pvk9zR2jdSr5qUBU9Ub2hNH1Fhe+hbf4NuDd2WBOLB+TuSb//nLx+bpvx8ExQGpyRS7OM/Qo8Uen2KxIjegrOqSUaWKMvYQCBM2VAZsVDFKB5+psB+GhNgro0DTxcfs6Jw8YG2vX3saGWWda1KQuRZEOWrqtAmRbNuR4X0fjjAOV1TyyVw57iVQbS+LsiYJsf3+STEl5hBckXoHtiPcuZdCzrZ7LyIN20bU3jzjwzoZL5MvJ7RuEM/dAQx20OtgV9pAGp5sTw2g0fgo9UQW2y7BaC3llwiYVt1Vwvh6LDPr93HxZ0vJbxWyxlSRBQcx8zhTvl4z7joj5lpFVI358tZUr0Jm3zbqn/4Fzh+4Ijsd16p5cyJj6/zYES0ooJbgJw3/mximW39QSJZuZO9kNwl5YhkxUbWl6OpPgngingI6vFrH3omMcLLYFQU1R8ycxhqO9biUJlYjHhpjPNmjf/iMPhTx9lK4SswRWUlZ4Cxm8g8zCPEABW6+HMXEKJB+SkwhaHsL1vin8geKBwTQf41FaWKBHLFvDe2oVVytaEe0NMBXSJSSAxDdc5PGzkjAxUdrQxSAfvzLo6HI/iyanmNXStB6Z644Rq5PDHMcAJydGthFOLAxY6ti3QaGn55LM4cFf7zmz63DIaoXYaWhjGjC8DISv+MpsmXPznh2jD8zysMOUreKcwGGnsJUcDAKgseNOzFVTFYJGkQRc/aqKfwcRTTxRVrGWAQKRa6nmarnhH+tPhKSzg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5286.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(1006002)(8676002)(316002)(8936002)(966005)(4326008)(45080400002)(66476007)(66556008)(508600001)(66946007)(2616005)(83380400001)(186003)(31696002)(26005)(31686004)(36756003)(6916009)(956004)(16576012)(38100700002)(6486002)(5660300002)(2906002)(55236004)(53546011)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?KzUwMVdGd1owVSs1Z2R6OEUrbDNsbkFFUFkyQ055KzdLRHp0UlNSOW1GZUVo?=
 =?utf-8?B?V2JoZWJVSXBkUjF2NHgvQlpmVW1hVytPdDNBWHRaVXRXN1Vod2lDVXp0RERt?=
 =?utf-8?B?YlZrMFp2WXlUcFI3a0haR0RnWmozbklUeGQzRDNzenNDcTk2c1pTVXF2NFR3?=
 =?utf-8?B?YnMzanVPVHNad2dsU2xFY2xGTnBZejA5ZWJjRzJlN1BHMjAxR3NBaW9XSjNy?=
 =?utf-8?B?Z25xR3Q4YmNwQ1FWRExOblJBcTIybmRTWGg0QnBCTE5rbDJWcVRjcEoyOWJm?=
 =?utf-8?B?RDBZTDlGeXA5OW91L3ZWMUR1SHNVa1hGUE9GaEtNUjAwMGVkOFhXYmF6OFNB?=
 =?utf-8?B?d0xTc0planRRTCs3YWZuaTlFbFJFUU1wb0pEZjB1NlZINjhWemJ0eG1uSDZQ?=
 =?utf-8?B?UVg3Rnh1T3MrZGRVYzVnc3NsZUZuQVlkV1Y0cDU4dEZvV3FrakNaZFV2UFp2?=
 =?utf-8?B?SG1qSUlTbnFSRnJnUGdJNng2c0Q0N3AxbmFGbjFQWWs3R3VWTGk1cURtVEww?=
 =?utf-8?B?S3VrMmtZU0dzM05LcC85cERvQjFJRHpwdzdaUHZmeUVHSVF2TWpCS0FNcUF6?=
 =?utf-8?B?K1V0NGVkSWYyQlRoUGlhVGFHZloxbXNzTmRVK3l5SlpwZWhNYW1KMmF4Zm1F?=
 =?utf-8?B?R3lWdkhTQnRjNWRMZUd5M09VSkd3eW1aeHB6YzU4Z1IzUGttZnVJampBZHhZ?=
 =?utf-8?B?TU8yc1BIZXdLV0dmazBsWHlwNVNOZDhFMXRYbkdDOVpTYURqSUxONEJxZnlD?=
 =?utf-8?B?b3J3ZUpkVzF5dkV6ZXVvU1VtOXZxZkZMZElrT2VWeC9ibnNuT0FWSS9XTk0y?=
 =?utf-8?B?MEEvQU1HYjYxbHFoWm5pWnJBa1dScVRXNjJrV1VyTXBYa1JpTE9BaW4yVDlF?=
 =?utf-8?B?S3IwandBV0QzdkoxYWxoNWZGSFlIb0NBSnJMR1JKTU5lYWlrcHdWNFNNeE1M?=
 =?utf-8?B?UlhiL0hUSEFhQy9YNmpybEtOMjUvZVFxVkRxUWM2TXQ0Y1hsWkZXK1ZUZXZn?=
 =?utf-8?B?c2s0SGwvbGRRRU5DNjlRMW51ZnhESFA4aTEwZTByanBwRWs3R1J0STZTNk1D?=
 =?utf-8?B?VHRLbTErblFzdnM0dnhnOXdrMnBRSk5iRm1WaWNLM21CR01TWCtoYXVxeFNn?=
 =?utf-8?B?NW90WmU2MWY2SjhCbS9wczh2UWh4TUtwY0d1VjVwN01CMHhjU1cxS1RRa1pL?=
 =?utf-8?B?MmI4V08zK0FObVZJaExXbVZJWCtFYlJYVklJMnY1endHTGVzaFBaL1BNYzl2?=
 =?utf-8?B?TnZkNEp3b0RGT1VyWXM5d3VoUzRGY2pDOTAvcmJpTkVUNVc0U1BGOHdabWs5?=
 =?utf-8?B?c0V2eVNQa2dkTFJjSzdnUzdGeEdPampMYmtiNFp6YlN1Zm40M29tZ0o3WTJk?=
 =?utf-8?B?Vjd1TTNyQVdVMTIxOFN3MWZRL3pDb1pCR21ibFVHdGtUVnVMbnBBMGpPV0x6?=
 =?utf-8?B?ZGp5SkhoY3ZUY3VWOUpJVlc3N3hPalhscVBPYS9ybWJKcmQzU08vQ01XUGlw?=
 =?utf-8?B?eU12SUxXUzM4K1VhUC9ScVI4Z0dDNlAwVE9aUExZMXdSMzFLNFBOY3NJdC9z?=
 =?utf-8?B?L0k1MGcxWWYrenVza2lRYmJJU2VVYllhMEc5TDNXcjVSZzBJcHY5czFGTUYv?=
 =?utf-8?B?TEdiWHBzWXFSa1ltQVJpRENKMUFFRDFRVk5NWjZ4bEgrWjltMmx2Wk1SVWdY?=
 =?utf-8?B?SHNkU0RxT3pXcFpHcFR0U1lTUDFyYUFWeVF0Z3NNYWtMeFhVK3E4L2JGV0tV?=
 =?utf-8?B?cExqQ2dPaElXaWhyNnFiRmliN0Vta3NjRVh4Z1BWWEoyemhZbEJRU3ppZHp2?=
 =?utf-8?B?UG9nTEpkcTBoUzN0U1ZENThGeDFGa3dBendiZGk2aWczT05zUlpvcFZkTVJS?=
 =?utf-8?B?WWhzZFBXQlR5WGFCbzhWUFhSRDhVTEw0QS9zZHBnRWFmbXlDZHZJSW1MRlVW?=
 =?utf-8?B?VVM3VGx2V1JYT0k0b1FkMGNwLzA5eE9RK2ZNTllEck5ucFRkdlFkYnVhVVVt?=
 =?utf-8?B?cmtHTDAxc1orVytCZ2R4Y25uUWpjTmg5TzJlVjlnT1Z4NjVvTVU2SFdPamow?=
 =?utf-8?B?UVF1YnExYnNpdlVaVlRCUkVnRTBGRStWTUJLKysyaU5ZNHVZVFRTYzRSc1Ey?=
 =?utf-8?B?QU9oVDdhakdnaVFLdExGOEFtRDVncWNWL1R1Z0h6L1JQVUJNVTFlaDByVmU1?=
 =?utf-8?Q?+0ts7Pmb/wx0J7owRMRvo8A=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 193f2494-ec60-4d7a-66dc-08d99fa8cfff
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5286.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2021 15:36:04.8802
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ja0kW5qMpBcXM0BGaLj9QpTAzAa5rMrY6PvIUROaaO1hCkHIVAh06+UDuQGFxpTcyqmp62IN6p+DmGI1uzM2Eg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB5507
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
>   So what happens if in the future, the GPU is a different one and it
> gets RAS functionality and PCI device functions too? You'd probably need
> to add that new GPU support too.
Yes, might happen
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

Instead of modiying the init_amd_nbs()

How about, modifying the amd_cache_northbridges() to

define a

call amd_prep_cpu_nbs()


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
>
> And those GPU node IDs are placed numerically after the CPU nodes so
> your code doesn't need to do anything special - just read out registers
> and cache them.
>
> And you don't need those exports either - it is all nicely encapsulated
> and a single function is used to get the callers what they wanna know.
>
> Hmmm?
>
> --
> Regards/Gruss,
>      Boris.
>
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fpeople.kernel.org%2Ftglx%2Fnotes-about-netiquette&amp;data=04%7C01%7CNaveenKrishna.Chatradhi%40amd.com%7Cdd5b3586178441f4886808d99e2b1ef3%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637714730331703852%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=oXDojOFqVVhxn4P1tgwLycaJgc2rvwo8EoUj3i971Mw%3D&amp;reserved=0
