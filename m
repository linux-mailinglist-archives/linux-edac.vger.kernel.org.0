Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D113450839
	for <lists+linux-edac@lfdr.de>; Mon, 15 Nov 2021 16:25:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236406AbhKOP2I (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 15 Nov 2021 10:28:08 -0500
Received: from mail-dm6nam08on2047.outbound.protection.outlook.com ([40.107.102.47]:57728
        "EHLO NAM04-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232424AbhKOP2G (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Mon, 15 Nov 2021 10:28:06 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e1ZPven1vOzQJr2PdPuNyH1iCxyNwiNjdiLMGi2Imcv1Zf3bqZj0185PGZNJbRDshlklmlG1ibegAUMvFyPXcftMLZsM0XSh7YKHdealf14dOWyxG9P3o2Pc9aRtV9bX3GGR3S8thjFGk21VVgvvwR53SUpfTsAeU4bVwG2Cvi8Zi78zkcIRsMEX6b83g/vuAbIKwhaRsT4lo3YxpjgskDeRHDShNPJR9E2090Lpk2kf4t+k2gvrsRVSgC9naNyZeTsc08cDTh8MTHC4yuAk2Dx0Y/8dn5VMbwQpXJHqWJbbgQ/kTy3AL2pHhriw0HK5yZCRmePZHPFQyZSYWSOX1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=78Cw6E3VT+NNApyO0xVuzXdTFoMN3bagVYIbnbN1LIM=;
 b=gpyRkhs7RddTXyzVB+i0AKXktKAscK5pE8X2OZqkL39H2jbCu5lHG+zW2O2AEoEO3Yacd2JErZcnD9UbkVFWyWGMBuabjF9z5npQIO3HJYfpue18quUZU7qav1CxsBsSCPHaVUUM8sd5TOO0ttMAcqNciN+ZWkfvHQuQiLyxjScaqzQqS5I0cyJjbhjetDv+Yw4t7DFzldqTeVpZl5qj7p1rXgwV5uxuqzZS1RYhTx7HnfpGWO1BgQgUjNBPADjT0YtzoShKN2uHz8HBXtgsoDXCc7PjDEbxEs/Y18YuGwHl2K0cqriYmoWEcJLbtRej4vKkBp7jk9J99Mn5qV3dSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=78Cw6E3VT+NNApyO0xVuzXdTFoMN3bagVYIbnbN1LIM=;
 b=N0tE62EWnsIiPygrCd9S8DyGS+resMMvg0oRU53K3iNQqLr9ghIUCr9AllBW7SXpaENEHv8n/5E2QtjCsPIhSD6GfOEdAltPEAFxfkEoN6umRyoEZdYYcfNADwnjCDS/qKCy4s2Jwtolm5LCGCK/y+l1ZjRAtOYy/IUqNO325Ss=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5286.namprd12.prod.outlook.com (2603:10b6:208:31d::6)
 by BL1PR12MB5125.namprd12.prod.outlook.com (2603:10b6:208:309::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.16; Mon, 15 Nov
 2021 15:25:08 +0000
Received: from BL1PR12MB5286.namprd12.prod.outlook.com
 ([fe80::c1e:36ae:bada:e396]) by BL1PR12MB5286.namprd12.prod.outlook.com
 ([fe80::c1e:36ae:bada:e396%6]) with mapi id 15.20.4690.027; Mon, 15 Nov 2021
 15:25:08 +0000
Message-ID: <90642509-81af-51f2-8942-c90432680fa2@amd.com>
Date:   Mon, 15 Nov 2021 20:54:55 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v6 5/5] EDAC/amd64: Enumerate memory on Aldebaran GPU
 nodes
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-edac@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, mingo@redhat.com, mchehab@kernel.org,
        yazen.ghannam@amd.com, Muralidhara M K <muralimk@amd.com>
References: <20211028130106.15701-1-nchatrad@amd.com>
 <20211028130106.15701-6-nchatrad@amd.com> <YY0WrKjnQ20IjrhB@zn.tnic>
From:   "Chatradhi, Naveen Krishna" <nchatrad@amd.com>
In-Reply-To: <YY0WrKjnQ20IjrhB@zn.tnic>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BM1PR01CA0093.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:1::33) To BL1PR12MB5286.namprd12.prod.outlook.com
 (2603:10b6:208:31d::6)
MIME-Version: 1.0
Received: from [10.252.84.184] (165.204.159.242) by BM1PR01CA0093.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00:1::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.26 via Frontend Transport; Mon, 15 Nov 2021 15:25:05 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5fae46be-bda7-4fc8-93a5-08d9a84c1ba3
X-MS-TrafficTypeDiagnostic: BL1PR12MB5125:
X-Microsoft-Antispam-PRVS: <BL1PR12MB5125657F571BB0A2014E08D6E8989@BL1PR12MB5125.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2733;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: csvIDLImH9CLqY/VDLDqfKQeGhJucpLjFxcgQC8navLk/A9oHWQ0pwVIu+KgjM/5EHGKZe/HHaoQ9/E8DZgryj1j2kDPYZb5539jqnsrdUl4S4kqO88yleb4kKHHUD0JJ6P2tJokb0XF16MuYQqEw5/UY1V5gFEnPqk/cixg+6rBTTkvSxqjBCgLVMP3QzoeQHUTDLacDDAKUawBOS6bMpDe7BX3xIVddPQ6Tqgp+sZSqfat3fAQYrzIVka1fUO/EzuFefqBuohwgJHKPx7TYntuqEJ+DCy4UGkozrGYQrLcS46g+2V8i2dr+o3sQ1G2MFXf2DqMh4HX/HH4JzWyK7CvDpFFgaxo5QS+unymr9menosyn9zBhImXY/a3F1SgzSxy4pPKjRKEhkmg4wUU97XOw9xrGmeWDr7sxIzDbnDmY//OI2NWmsF/ALpBy+1jYqsEp6H/NB692yKZFZV0u31RGrWpQ3cQsNjyJry+/kacz7Iu5jBa6un7fYnZsU529T26BPi/z2kA1QJjMJ8uvznqog7YVU2jk43c8jLef++OTpY7jeumPh+PkSkZRjXO6JmRiLbhGAg6ydym19IAbgW/HkIol57mQvSNP81nRikdYWBKXRXzO+E7bURpMkbQ3GArXkUSbfXyAs3fB0Zn8NMN95CGsrhpAtOe7DTIu54oIJMlWTMHk4ujb6f1A+TKZowWyzol/iRJQrvRBIImGVA2k8/IOXexPuQekwLP5KvmLe97aiyx/ubVOXat5zurd/YkMzZvSKQHzPi5UPs8QayHXpyUeJQFgfzeaBvUa9F4Yq4z0lJUhqxsJNU0cDdB8WithPSr8hmv9QVa7MQZeZWgmdYLOL4ZLnXVcowH9lE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5286.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(2906002)(6666004)(38100700002)(31686004)(186003)(966005)(30864003)(316002)(956004)(6916009)(6486002)(26005)(5660300002)(45080400002)(16576012)(4326008)(2616005)(31696002)(36756003)(83380400001)(66476007)(508600001)(66556008)(66946007)(53546011)(8676002)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UXZlQ1pjeWNlRExhQXpkQzY4ZzVWazBvZE5aZGNUOXJIdHNodjRiSlUwdFJy?=
 =?utf-8?B?U1ZQMjNJeWhOQXpRWGFuQS9TNmdaSnhXdjE3bkQ5clRxVndBUmZSeWdUc0dw?=
 =?utf-8?B?YkFCWDZjelN2SG1FUjBCSTcyYkVtNEtoTVBPMGlWN0NkTmY0MDFEQUtzc3E2?=
 =?utf-8?B?cWhmT1hnNDNBVmxqZko2T0JwbmNCRHg0RVhNWmxtYVFyMkduMWlMYW9vNzVx?=
 =?utf-8?B?NUlvbVllS01qRzR3bVFQQllZb2hPNUpLZVpPWENKckxNUHdRY25VYThleklk?=
 =?utf-8?B?WmtUZVM2Q2VSWHJBdHo0YXQ0WnUxdkk3RjlucFpIbHFpODc1MWhrRHVSSWtF?=
 =?utf-8?B?RkpEMUZFbzVxVmx6VTZ6VWtuNFhQOG40cUNjcTZVc2NrVkdEWmswWWtTbHhx?=
 =?utf-8?B?TFQxLzhiOG8rUVlLU0d2M1dBMmdWOWF5b2JpNVNXaHhmMjRxR0xPTm1XNWlJ?=
 =?utf-8?B?K3F6aUh5Ri9YMmNra0plc3JNN0dZRDduaWxEOFVHSEVkaWltNkFmM2F1aTJj?=
 =?utf-8?B?WVZkS2FjaTNOWmRzcVdoRnFMR3dPYkxRTmVuOG9HNmNkSE5FYkc1QlJheEV3?=
 =?utf-8?B?RlgxYjZqNjJDNkpRaGhOWkJ6RjZuTUlkUkoxT3h6ZUg2TkV5VUNWd1F2ZUJ6?=
 =?utf-8?B?YlRFb0F3N093ZkFleHZ0eUZkeFB5REpsU0VZNzBBQ0NzS2dqelIzUWFNdE0v?=
 =?utf-8?B?aDFKSUU1RzFDVFFRaFpnY2w2bTJ1KzRLay9HYU9OZlpVb2pmVUIwSzlXTGt4?=
 =?utf-8?B?SUtOMGlUSFUza2xZcWpsekIvZ29wRUlmdng3UHFXdENvTWpERW1xZzlvMFZs?=
 =?utf-8?B?akZxcEFFZ3pJM2hwdlpGcHo1KzlvZWswUkFXcWdiZWNQRTVMT3VjbWhsem9H?=
 =?utf-8?B?c2JCckJyN1VRWXEvWVdKWEVVSE9zRWtQSnpvK3pKN003SnVvcFRWUnovL2lL?=
 =?utf-8?B?ZHpVckZQLzFILzJhRFVEZTJ3TUc1OVo4a0p0dDRnbWpIaXZzZHhYbXdBNGZS?=
 =?utf-8?B?T2V2MC9IY1FvRFVJdllGbkFmNXpEb0RBVy9MRzFyRklZUjBOOXBiUkUyUFhB?=
 =?utf-8?B?NmliRlhla3ZkbXZRYUl5WjVhOHdpYmFvOGY0a0w4VjNIcE9SVGlEYjhlL2Z1?=
 =?utf-8?B?ZFVvVGVtVGRkdGxUYUhyeWNhbUF4dGpTRENVN3RKMUR6cTN2QUhpcXVLdENT?=
 =?utf-8?B?WkY3dXVhRnVMbEc3Uk13ZnZieHBBVEsyT3A0VnM0QnFTYlFFMnFBRFJ0UjZr?=
 =?utf-8?B?SzhKUytac3kwZEdvR3c3Q2pwdHArdWUyaWpqVTJnM3BKai9KbGZtM1VXYTBu?=
 =?utf-8?B?VnorV2c2TEFYVGR0a2o4R3lKaTNoUGxaY0p2TlhXY0xPdjJrYzVoOHhTZDhV?=
 =?utf-8?B?czZoRWV0bk1tcFkzRE4xRlVVSm1rblE2KzZvMVBBa1NwaVBjalVrRzFIcm5C?=
 =?utf-8?B?NVNYUnVsK2JsdmNxMUN0bVVocUxtM21FaEFwNDhIamJKQ3FzRENSV01ISDd4?=
 =?utf-8?B?UCtmcHhTZHhScUZJeWVpR21YSS91NHQ3WFFUaWl2dllwT25yYnBlWkhmNGRV?=
 =?utf-8?B?WFBkcjlnYnVhQmdpRkRhb04zRmNMeHZFR1c3VlFuRVR4UjNyUnZNUUltVG1R?=
 =?utf-8?B?RHNMMHg4WmlWdGZ3VEduZTNnQ3c5ZWxYYzJSUXI5SjZwVlNiUFVSYXJ3ZVR0?=
 =?utf-8?B?dThOWVlhT1dPUlNBU1JXN3RQVEhjREhSbEY2Rys5VHJra0JMZ2ppMk1HanBC?=
 =?utf-8?B?N0IybUwrSGVOM0JEKzhUbW04c3FrMlNKajhMYm1GRzFPMzUvRWVxb1JWdlUz?=
 =?utf-8?B?WndPQWJyUWJNak5aajMzczRlWTE3TXpmdk1VdVdEK0NKOGU2UUF5b1ZHZmZa?=
 =?utf-8?B?Y1NHVlMzSGxhak13cUVTZzVmV3VJUkNpL1NKUU82RGx1TzZadkVENmFNY0po?=
 =?utf-8?B?dHBUYVpJYzl4cWw4eElUQXhqN0cyM0FDZGJrd3dLblhXREZzRDM0MXo5bkNT?=
 =?utf-8?B?Z2dId3BKSmc1b0Z1SkNPVjVuYVdFU0tDcGJoVjUrUDVidVo0bTZEL3U0Vnlp?=
 =?utf-8?B?cGo1bmkyLzAvZUNKU0d4VlBOY1VLUDJDRzM3a29mRHhKbjZleVlEcXlZMDAy?=
 =?utf-8?B?bUdQNEJndnZMeHdmM1NnTm12SHRrQmI0U2k3RFM5bDZqcHNwSjB4NjhrQnN3?=
 =?utf-8?Q?LmauRftF5yVMNDFOawruiFM=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fae46be-bda7-4fc8-93a5-08d9a84c1ba3
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5286.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2021 15:25:08.7278
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 43WIJwHATr1Z2rbJ/XuaGJYc6lNzMZDj6J7WaN4lWe0ednvHniRkGG5E4ePAOajkj/DJMzPRLw4LsmWWvAqpuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5125
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hi Boris

On 11/11/2021 6:42 PM, Borislav Petkov wrote:
> [CAUTION: External Email]
>
> On Thu, Oct 28, 2021 at 06:31:06PM +0530, Naveen Krishna Chatradhi wrote:
>> On newer heterogeneous systems with AMD CPUs, the data fabrics of the GPUs
>> are connected directly via custom links.
>>
>> One such system, where Aldebaran GPU nodes are connected to the
>> Family 19h, model 30h family of CPU nodes, the Aldebaran GPUs can report
>> memory errors via SMCA banks.
>>
>> Aldebaran GPU support was added to DRM framework
>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Farchives%2Famd-gfx%2F2021-February%2F059694.html&amp;data=04%7C01%7CNaveenKrishna.Chatradhi%40amd.com%7Ca6aa66df219641c880d008d9a514e5bf%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637722331481685552%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=Pnx%2FQxgmXS2MfWzu8lVEs22As3yJSWoAsjOvp%2FFOJYw%3D&amp;reserved=0
>>
>> The GPU nodes comes with HBM2 memory in-built, ECC support is enabled by
>> default and the UMCs on GPU node are different from the UMCs on CPU nodes.
>>
>> GPU specific ops routines are defined to extend the amd64_edac
>> module to enumerate HBM memory leveraging the existing edac and the
>> amd64 specific data structures.
>>
>> Note: The UMC Phys on GPU nodes are enumerated as csrows and the UMC
>> channels connected to HBM banks are enumerated as ranks.
> For all your future commit messages, from
> Documentation/process/submitting-patches.rst:
>
>   "Describe your changes in imperative mood, e.g. "make xyzzy do frotz"
>    instead of "[This patch] makes xyzzy do frotz" or "[I] changed xyzzy
>    to do frotz", as if you are giving orders to the codebase to change
>    its behaviour."
>
> Also, do not talk about what your patch does - that should hopefully be
> visible in the diff itself. Rather, talk about *why* you're doing what
> you're doing.
Sure.
>
>> Cc: Yazen Ghannam <yazen.ghannam@amd.com>
>> Co-developed-by: Muralidhara M K <muralimk@amd.com>
>> Signed-off-by: Muralidhara M K <muralimk@amd.com>
>> Signed-off-by: Naveen Krishna Chatradhi <nchatrad@amd.com>
>> Link: https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flkml.kernel.org%2Fr%2F20210823185437.94417-4-nchatrad%40amd.com&amp;data=04%7C01%7CNaveenKrishna.Chatradhi%40amd.com%7Ca6aa66df219641c880d008d9a514e5bf%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637722331481685552%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=aD3jFWS4RrPrIRF5mFoggBs%2BYqUseU3adJFqlrbD2D8%3D&amp;reserved=0
>> ---
>> Changes since v5:
>> Removed else condition in per_family_init for 19h family
>>
>> Changes since v4:
>>   Split "f17_addr_mask_to_cs_size" instead as did in 3rd patch earlier
>>
>> Changes since v3:
>> 1. Bifurcated the GPU code from v2
>>
>> Changes since v2:
>> 1. Restored line deletions and handled minor comments
>> 2. Modified commit message and some of the function comments
>> 3. variable df_inst_id is introduced instead of umc_num
>>
>> Changes since v1:
>> 1. Modifed the commit message
>> 2. Change the edac_cap
>> 3. kept sizes of both cpu and noncpu together
>> 4. return success if the !F3 condition true and remove unnecessary validation
>>
>>   drivers/edac/amd64_edac.c | 298 +++++++++++++++++++++++++++++++++-----
>>   drivers/edac/amd64_edac.h |  27 ++++
>>   2 files changed, 292 insertions(+), 33 deletions(-)
>>
>> diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
>> index 7953ffe9d547..b404fa5b03ce 100644
>> --- a/drivers/edac/amd64_edac.c
>> +++ b/drivers/edac/amd64_edac.c
>> @@ -1121,6 +1121,20 @@ static void debug_display_dimm_sizes_df(struct amd64_pvt *pvt, u8 ctrl)
>>        }
>>   }
>>
>> +static void debug_display_dimm_sizes_gpu(struct amd64_pvt *pvt, u8 ctrl)
>> +{
>> +     int size, cs = 0, cs_mode;
>> +
>> +     edac_printk(KERN_DEBUG, EDAC_MC, "UMC%d chip selects:\n", ctrl);
>> +
>> +     cs_mode = CS_EVEN_PRIMARY | CS_ODD_PRIMARY;
>> +
>> +     for_each_chip_select(cs, ctrl, pvt) {
>> +             size = pvt->ops->dbam_to_cs(pvt, ctrl, cs_mode, cs);
>> +             amd64_info(EDAC_MC ": %d: %5dMB\n", cs, size);
>> +     }
>> +}
>> +
>>   static void __dump_misc_regs_df(struct amd64_pvt *pvt)
>>   {
>>        struct amd64_umc *umc;
>> @@ -1165,6 +1179,27 @@ static void __dump_misc_regs_df(struct amd64_pvt *pvt)
>>                 pvt->dhar, dhar_base(pvt));
>>   }
>>
>> +static void __dump_misc_regs_gpu(struct amd64_pvt *pvt)
> The function pointer this gets assigned to is called *get*_misc_regs.
> But this function is is doing *dump*.
>
> When I see __dump_misc_regs_gpu() I'd expect this function to be called
> by a higher level dump_misc_regs() as the "__" denotes layering usually.
>
> There is, in fact, dump_misc_regs() but that one calls
> ->get_misc_regs().
>
> So this all needs fixing - right now I see a mess.
>
> Also, there's <function_name>_gpu and gpu_<function_name> with the "gpu"
> being either prefix or suffix. You need to fix the current ones to be
> only prefixes - in a pre-patch - and then add yours as prefixes only too.
Will modify the names to use prefixes
>
> And in talking about pre-patches - this one is doing a bunch of things
> at once and needs splitting. You do the preparatory work like carving
> out common functionality and other refactoring in pre-patches, and then
> you add the new functionality ontop.
Sure, i will split this.
>
> Also, I don't like ->is_gpu one bit, it being sprinkled like that around
> the code. This says that the per-family attrs and ops assignment is
> lacking.
Yes, adding few more ops routines should help get rid of this if conditions.
>
>
>> @@ -2982,7 +3132,17 @@ static void decode_umc_error(int node_id, struct mce *m)
>>
>>        pvt->ops->get_umc_err_info(m, &err);
>>
>> -     if (umc_normaddr_to_sysaddr(m->addr, pvt->mc_node_id, err.channel, &sys_addr)) {
>> +     /*
>> +      * GPU node has #phys[X] which has #channels[Y] each.
>> +      * On GPUs, df_inst_id = [X] * num_ch_per_phy + [Y].
>> +      * On CPUs, "Channel"="UMC Number"="DF Instance ID".
>> +      */
> This comment doesn't look like it is destined for human beings to read
> but maybe to be parsed by programs?

The present system supports the following setup

A GPU node includes four Unified Memory Controllers (UMC). Each UMC 
contains eight UMCCH instances.

Each UMCCH controls one 128-bit HBM2e (2GB) channel. The UMC interfaces 
to the system via the Data Fabric (DF) Coherent Slave.


For a generalized function, i will modify the comment as

"A GPU node has 'X' number of UMC PHYs and 'Y' number of UMCCH instances 
each. This results in 'X*Y' number of

instances in the Data Fabric. Therefore the Data Fabric ID of an 
instance can be found with the following formula:

df_inst_id = 'X' * number of channels per PHY + 'Y'

>
>> +     if (pvt->is_gpu)
>> +             df_inst_id = (err.csrow * pvt->channel_count / mci->nr_csrows) + err.channel;
> I'm not sure we want to log ECCs from the GPUs: what is going to happen
> to them, how does the further error recovery look like?

AMD GPU has support for memory error reporting via the SMCA register 
banks, functionality is similar to the CPU dies.

The customer/end users of this product want to count memory errors and 
they want to do this in the OS using similar

mechanisms as they are used to on the CPU side.

>
> Also, EDAC sysfs structure currently has only DIMMs, below's from my
> box.
>
> I don't see how that structure fits the GPUs so here's the $10^6
> question: why does EDAC need to know about GPUs?

The errors are not specific to GPUs, the errors are originating from 
HBM2e memory chips on the GPU.

As a first step, I'm trying to leverage the existing EDAC interfaces to 
report the HBM errors.

Page retirement and storing the bad pages info on a persistent storage 
can be the next steps.

>
> What is the strategy here?
>
> Your 0th message talks about the "what" but what gets added is not
> important - the "why" is.
Sure, i will update with the why.
>
> $ grep -r . /sys/devices/system/edac/mc/ 2>/dev/null
> /sys/devices/system/edac/mc/power/runtime_active_time:0
> /sys/devices/system/edac/mc/power/runtime_status:unsupported
> /sys/devices/system/edac/mc/power/runtime_suspended_time:0
> /sys/devices/system/edac/mc/power/control:auto
> /sys/devices/system/edac/mc/mc0/ce_count:0
> /sys/devices/system/edac/mc/mc0/rank7/dimm_ue_count:0
> /sys/devices/system/edac/mc/mc0/rank7/dimm_mem_type:Unbuffered-DDR4
> /sys/devices/system/edac/mc/mc0/rank7/power/runtime_active_time:0
> /sys/devices/system/edac/mc/mc0/rank7/power/runtime_status:unsupported
> /sys/devices/system/edac/mc/mc0/rank7/power/runtime_suspended_time:0
> /sys/devices/system/edac/mc/mc0/rank7/power/control:auto
> /sys/devices/system/edac/mc/mc0/rank7/dimm_dev_type:Unknown
> /sys/devices/system/edac/mc/mc0/rank7/size:8192
> /sys/devices/system/edac/mc/mc0/rank7/dimm_ce_count:0
> /sys/devices/system/edac/mc/mc0/rank7/dimm_label:mc#0csrow#3channel#1
> /sys/devices/system/edac/mc/mc0/rank7/dimm_location:csrow 3 channel 1
> /sys/devices/system/edac/mc/mc0/rank7/dimm_edac_mode:SECDED
> /sys/devices/system/edac/mc/mc0/topmem:0x00000000e0000000
> /sys/devices/system/edac/mc/mc0/mc_name:F17h
> /sys/devices/system/edac/mc/mc0/rank5/dimm_ue_count:0
> /sys/devices/system/edac/mc/mc0/rank5/dimm_mem_type:Unbuffered-DDR4
> /sys/devices/system/edac/mc/mc0/rank5/power/runtime_active_time:0
> /sys/devices/system/edac/mc/mc0/rank5/power/runtime_status:unsupported
> /sys/devices/system/edac/mc/mc0/rank5/power/runtime_suspended_time:0
> /sys/devices/system/edac/mc/mc0/rank5/power/control:auto
> /sys/devices/system/edac/mc/mc0/rank5/dimm_dev_type:Unknown
> /sys/devices/system/edac/mc/mc0/rank5/size:8192
> /sys/devices/system/edac/mc/mc0/rank5/dimm_ce_count:0
> /sys/devices/system/edac/mc/mc0/rank5/dimm_label:mc#0csrow#2channel#1
> /sys/devices/system/edac/mc/mc0/rank5/dimm_location:csrow 2 channel 1
> /sys/devices/system/edac/mc/mc0/rank5/dimm_edac_mode:SECDED
> /sys/devices/system/edac/mc/mc0/dram_hole:0 0 0
> /sys/devices/system/edac/mc/mc0/ce_noinfo_count:0
> ...
>
> --
> Regards/Gruss,
>      Boris.

Regards,

Naveen

>
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fpeople.kernel.org%2Ftglx%2Fnotes-about-netiquette&amp;data=04%7C01%7CNaveenKrishna.Chatradhi%40amd.com%7Ca6aa66df219641c880d008d9a514e5bf%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637722331481685552%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=fw%2B%2F8rCVRhhZ0xp8XLUW5rvoDUnfNQzwJleHVoPmDkw%3D&amp;reserved=0
