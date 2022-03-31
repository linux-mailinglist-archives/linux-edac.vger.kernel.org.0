Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C8674ED988
	for <lists+linux-edac@lfdr.de>; Thu, 31 Mar 2022 14:20:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235988AbiCaMWA (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 31 Mar 2022 08:22:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235996AbiCaMV6 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 31 Mar 2022 08:21:58 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2089.outbound.protection.outlook.com [40.107.94.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7188580C7
        for <linux-edac@vger.kernel.org>; Thu, 31 Mar 2022 05:20:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oUE6xlOGAZI22xnhWxihz+SeAy7TxZXI36IOlpFgrjaviSjiCH27bKYyuY3N/4LxQ/4YpHlEHHTk16TEuxhyU3SUGzCElGHONaUl5areQ3bQ2n3PMs64FZFY5ydrxn4W3PG2rsg9rzt9OTtpewxBYTKIm9KMDW95KqfCGg3UXUhGp3ojd0pRz4KdEYm5ZhSeJGK6q/k7+19F/e52ZMU+ZYqBiPES4Ty8IuHvjv3dxZa/L6TDeTklePhE+NEQvxTnuI/1H9bPq1MfODMUlQm15tZ5XDqwiG+AfO5fKUsdStiLNk+vBjJ3HvYONvE3XrGIDmg3DFaVcX1cBsxahCCKIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MI8uKaklibSVMgLFdIgpmz2BUzCpGuFEY3B70uO7h4E=;
 b=L+DeDeOsFvgfol1tKdtlJ5ZyykSexvWLmEpyNWZ1Jeonn+Qj5yzH95XZvqdocPYhOwNUBPgbt0aWoYu5wiVqREkhGvKMpFy4jkpyKRGTh46/o/BBimEAe7xet3HRXm1tZJsUC6/STgrCUHDkM7KOxao8v3qBPe6kFovxOVEU4m8ie9HVaDu2cAmf4/utlpJUKvTkKfq2wqOAsRXWFzHft6gBXy5S7KzrLY5BMNxRhzoZFbcJdwQP87JQbObVqKEZiYBTiFgtk5qt2hXhFS5/N3wZoi1/8tySbBp/5nUUybtAWcxn013vLHHDPfYhORGDxIgudMYZZaaPKlNgw3ylrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MI8uKaklibSVMgLFdIgpmz2BUzCpGuFEY3B70uO7h4E=;
 b=GJ76LlBnZ5PuPtjilcwOZTo8WnkKlo/NBuZnmVe86dq2vBi/FUoYuEdmecq2jBj5iT/miriRNwH3wW1D+Q/gk6g4iH5x3DX4MpIXF5cp+hU0G8mUQzF7zFJNRc74WYmNMX3S3L+Fg0sOvweyhEqlggLRg6t0VQG9iTiQN5jskbQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5286.namprd12.prod.outlook.com (2603:10b6:208:31d::6)
 by MWHPR12MB1582.namprd12.prod.outlook.com (2603:10b6:301:10::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.23; Thu, 31 Mar
 2022 12:20:03 +0000
Received: from BL1PR12MB5286.namprd12.prod.outlook.com
 ([fe80::c47b:31f3:4280:8cd]) by BL1PR12MB5286.namprd12.prod.outlook.com
 ([fe80::c47b:31f3:4280:8cd%9]) with mapi id 15.20.5123.024; Thu, 31 Mar 2022
 12:20:03 +0000
Message-ID: <4f7e4f58-41d4-f08b-56ff-e0f83c4bfed3@amd.com>
Date:   Thu, 31 Mar 2022 17:49:49 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [PATCH 06/14] EDAC/amd64: Add get_mc_regs() into pvt->ops
Content-Language: en-US
To:     Yazen Ghannam <yazen.ghannam@amd.com>
Cc:     linux-edac@vger.kernel.org, bp@alien8.de, mingo@redhat.com,
        mchehab@kernel.org, Muralidhara M K <muralimk@amd.com>
References: <20220228161354.54923-1-nchatrad@amd.com>
 <20220228161354.54923-7-nchatrad@amd.com> <YkHdZ1UWh9o016j1@yaz-ubuntu>
From:   "Chatradhi, Naveen Krishna" <nchatrad@amd.com>
In-Reply-To: <YkHdZ1UWh9o016j1@yaz-ubuntu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN1PR0101CA0050.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c00:d::12) To BL1PR12MB5286.namprd12.prod.outlook.com
 (2603:10b6:208:31d::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 20e6505b-de2c-4c79-8782-08da1310c8a2
X-MS-TrafficTypeDiagnostic: MWHPR12MB1582:EE_
X-Microsoft-Antispam-PRVS: <MWHPR12MB158293220C72E9135E7FD11CE8E19@MWHPR12MB1582.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5GdBFqdwMX1SRzWXX2fRf3HfNgwr2I8/F7UYkGyZcIBGPdJR95/6jIp5AZf18B6cT7kpMws07LvDXGG41DB2KjHyNxCDhNLUI5voLmFCn8QWrMb5mB5QuPrLTIiNwF9dBz51S4DiF6HXyM4uiV0uZTQPWYjjlG1T/AHwc0hNMSQnKNIyCkamwyAkbmV5yFaY6koRqwODwN9xQRIYi3ALrGB5GgJnfKIZlmI7XAChC/43smaVZZva6QGbllHz8lrYL4p3XUZ1dUrbs9A9+ymZGUpn4TI/Hvu+YLeWDf+RRof7LsHfBvX+PFStbR9DoVrjNdXCHV0JZz+gk1PHTIEmmsFJnRhtSiEH3pNnW1CcF9iW5l+ABfltSpbo2vKQTAkbFQCEJgGMB0xDGt3Oidhun21ljcCjecq6yNp6sKMqbY2Kl06Cwf1WsR2gYfbB9oHPMoGoEJ0hHiXNZkRxznAIknGbJIwWL+Q+KWJItUxo8VQ+WTyOVo8AgCLisHA3Pj3xjQePLzXzmc0/RVlXSWBmEYW0Aty5/6bjDl4h4JCaQ7Qaaih8Mi8kgXzqdwp+f4ea6vBBOeJIlRfozI+et2OGZdBYvDscwoh72EoR8QNaDvku1WU16PMP/tVaXpywx/j2644Ka6kotj3Zd2iO0yyJH5RrtwOSFe6cryYW1UAWBq1p1juSyDRErYKrT/yHHOuALyFyUsmBmxRp25z/Z2UU4zjoIqAGyMtCiZ1xWB9iPPiiawvFae+k06yhMQ9GGL5m3UcTkTr8w0HH4/MxeCVdAJ1AXdEBkaQjVyu2f1u+VGQ8V+qNyJddmLc6kRBEomOlBTYOYky53ohtgZ+nngDj0Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5286.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(316002)(53546011)(2906002)(6506007)(8936002)(66476007)(8676002)(6862004)(66556008)(4326008)(5660300002)(966005)(6486002)(508600001)(66946007)(31696002)(6666004)(38100700002)(26005)(186003)(36756003)(83380400001)(31686004)(6636002)(37006003)(2616005)(6512007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Rms1ckNobXlxdkl2OGpXL0JUYWRCUmFSMUs3QzI2Q21zdE5kT243U1hxZzFr?=
 =?utf-8?B?MzIyTjNVYzk1dlRKUm85Vmc5N0FuU0NsZUx1RSs2Umxib0xNODlQeUhwaHRC?=
 =?utf-8?B?VjBhZlJTOUxzYVJUZUJGRThtaVUyOFNzY25FeUxQTkMzUEsvUUxKMEJQL01L?=
 =?utf-8?B?dlVCb1JhMldobExsRUwvSy9QY2R2TnpXa1VqY1FzQkZDUmRCMkpmSGFPZDFH?=
 =?utf-8?B?OEZxRWp4dG5DZ2Z5eExvdUxCbldaYTJRVmV4ZzVwcWdlY3d6eGt4YjF2Tzg5?=
 =?utf-8?B?VVk5WDdsUmp4ancwKzE3dWVzcW9DMmdSR0ZxTG1wMU1Nd2JHcnB0U2djQklC?=
 =?utf-8?B?aWVwMDUxckFwU2grZG1vWlV5SE1aUGlzandKaU4wN1piK3FVUjg1NEttZ2R4?=
 =?utf-8?B?MC9NdTh5OThZM251Z1Q0aEJRRU1MNC9USDBrS1RjeWpPM1g4RExIdXQwUE5L?=
 =?utf-8?B?VmV2ZmN5cWsxd1ZHYU9BZEc4VTdvLzhiRWxQVy93cmRnanNRenhJdGZIa2lM?=
 =?utf-8?B?N1hFQ1NzRHpLUGkvcXBFZldUY28xQVFkelFaMjYxbXFLMG44QS91SzRYanU4?=
 =?utf-8?B?VWFUNitKcDh2Rk1EdmpXZWN3bVpNdWtVTW5CVXQycG0zSGdvb3d3WGhFMWpy?=
 =?utf-8?B?bC9sSFQ2c2JIdlBhbTNxTTNINVVkRGdqTnEzeGl4WEJ4WmhIU3p6VUwwRHQr?=
 =?utf-8?B?Z2J4VUVVNzJjaDNDWjNEejJGd1pXK0hOcThkdU5RWFJ3RGN2Sk9QMW1sU1l5?=
 =?utf-8?B?eVBJcWVoaE9VbWpxQ016YVR4am9iSm84d2U4d2M0eXlMNjhZZk5CMDk3WUFk?=
 =?utf-8?B?NjJDRkpTTWNRSWFqaDhvV3lMTVJhQmtXdm1rNVNxYW5YU2RVQWZjbGhEMkIr?=
 =?utf-8?B?RERyd1Izd240MFhMVnY1MEh5bmFhTlVCeExHL2NlTVlicW9QeS82RkNFZmhR?=
 =?utf-8?B?RGVHa0M4VWVZZ3pWNTVjOUtzbVBWU3lvU2VGNWI1Z0RlKzQ1WjdPR1U2UnRn?=
 =?utf-8?B?NCtzOWljU2huTXYwYXdUVE12emQyMThkemIyYjZIS3d4V2lSbUp3UlgxNDF5?=
 =?utf-8?B?elJyS0RQdER0bmI4RDFoNEIwZktYTW0vMVc4bDNpYzhuTTFjcG9OYzluU1RB?=
 =?utf-8?B?SWttVW9DREVDMStZZXBOZlV2Zld0Z1YrRFFFVm9GaGVLNlh0Ymx4VjQxZDgz?=
 =?utf-8?B?cFo0bzh6YmhhRTJlVHl4M3Z6cFhUNjFickdRUzBTRzkzbzFiSkRoV1RYb05C?=
 =?utf-8?B?d3dKckhiVzA1TC9BKzRvakRCcSt1N1c5UkRqSFo0TDA5ZFVSK1dydkVnS2xX?=
 =?utf-8?B?WWwwaWZEdlI5a3VzSzJwWkhkMzJwQWdWN1BEZFRzNGt4Vmx6YTRYck5JUkhY?=
 =?utf-8?B?VnBWSnBHMVFkamZjZXUyWCtuWEZRV2VtWi9qMXFDWmlyN0pOUSszcGVKL2Fz?=
 =?utf-8?B?c2F1TURhUXNXd3pBQy8rOXljWVNOalZzWm8vWENGMWI2aXo4clRkdU5wdy92?=
 =?utf-8?B?dnZqYXJNSjVzNktOcnhtMXd6cXJ6aFV3dk9kcTAyb0ZGaThvLzBhQVV5MFpH?=
 =?utf-8?B?K2U3WnZtbHVxekZHMkY2UWhOdzhYTnFybldORWdacDJlNjE1VHVlUGhkandU?=
 =?utf-8?B?TkRac1dDVzRiNEg4cTQ5d0t2S1ZCSjU5UXcyYitQQmU2Z3pRSFBYbWI1VTNZ?=
 =?utf-8?B?RjcyTTVjdmlLdnljc2dEMitOTno2SHN0emlTc3F4WlhhWTVkY1hRbDNwT2dl?=
 =?utf-8?B?WFNwdUhoNEFad2NRYVRUblV0VXdsVmxFcDJEa3JLcmcwK0hOOUg5L1AvNGhz?=
 =?utf-8?B?T0w4dGNaZHk1anE4TkhJQWI3TzE2azVvQlVwL1NaOHJpT0lraVMwZE90RFJD?=
 =?utf-8?B?Q2RrbkpaQUxBQWU0WUd4ZGdBVnpsVDRQcUtYSjJIT0JuZmdGemdIQnJTQWov?=
 =?utf-8?B?Mm5RN04zVXRlcjduSXYwRkFzam9nTGxDQkJ1NDJlV3VsQjljaFpDZkNkblNY?=
 =?utf-8?B?VVc1TDhmSDBSbFgxVXhqQktlVHlrbHcwQVNIU1NOOW5TKytNMG5HRVorbzY1?=
 =?utf-8?B?TjAzNVNZMzMzamhMVG9xRTZYZThudFFEUWZGV0dxc0lyR1l5UUZPdlFnQUtI?=
 =?utf-8?B?bWdXdTBGVU1Pc2JENzFYT2tzRjNIUEdtVkF4dW93bE9hSFRSdXU3MHNodmJO?=
 =?utf-8?B?U3pQNXFPMmV3N3czNG05RzZYZlRna2dSVGxjckRZTm5LME9PVWFIL2oyNXRW?=
 =?utf-8?B?QTMxVmtJUXRVUG13dWE3OG9WanBqQUc0S2JnMXJYNDVOT0ROM3JRbEkwRE1m?=
 =?utf-8?B?Z3kzSlprVzlEemIyd0xHL2syQnRtZjdrZFRFcE1tSnJNZEFTNGJLdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20e6505b-de2c-4c79-8782-08da1310c8a2
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5286.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2022 12:20:03.8209
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ue1L9onJgA19BugovQ8NJEPmnBP7rDkdGxKlgmL2iyRFEjvDIr1/jqSyWkYOKwDWc3CeM5torPs4XFE6PrAejQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1582
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hi Yazen,

On 3/28/2022 9:38 PM, Yazen Ghannam wrote:
> On Mon, Feb 28, 2022 at 09:43:46PM +0530, Naveen Krishna Chatradhi wrote:
>> From: Muralidhara M K <muralimk@amd.com>
>>
>> Add function pointer for get_mc_regs() in pvt->ops and assign
>> family specific get_mc_regs() definitions appropriately.
>>
> Please include the "why".
Sure
>
>> Signed-off-by: Muralidhara M K <muralimk@amd.com>
>> Signed-off-by: Naveen Krishna Chatradhi <nchatrad@amd.com>
>> ---
>> This patch is created by splitting the 5/12th patch in series
>> [v7 5/12] https://patchwork.kernel.org/project/linux-edac/patch/20220203174942.31630-6-nchatrad@amd.com/
>>
>>   drivers/edac/amd64_edac.c | 77 +++++++++++++++++++++------------------
>>   drivers/edac/amd64_edac.h |  1 +
>>   2 files changed, 43 insertions(+), 35 deletions(-)
>>
>> diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
>> index 69c33eb17e4f..713ffe763e64 100644
>> --- a/drivers/edac/amd64_edac.c
>> +++ b/drivers/edac/amd64_edac.c
>> @@ -3214,6 +3214,27 @@ static void f17_determine_ecc_sym_sz(struct amd64_pvt *pvt)
>>   	}
>>   }
>>   
>> +static void read_top_mem_registers(struct amd64_pvt *pvt)
>> +{
>> +	u64 msr_val;
>> +
>> +	/*
>> +	 * Retrieve TOP_MEM and TOP_MEM2; no masking off of reserved bits since
>> +	 * those are Read-As-Zero.
>> +	 */
>> +	rdmsrl(MSR_K8_TOP_MEM1, pvt->top_mem);
>> +	edac_dbg(0, "  TOP_MEM:  0x%016llx\n", pvt->top_mem);
>> +
>> +	/* Check first whether TOP_MEM2 is enabled: */
>> +	rdmsrl(MSR_AMD64_SYSCFG, msr_val);
>> +	if (msr_val & BIT(21)) {
>> +		rdmsrl(MSR_K8_TOP_MEM2, pvt->top_mem2);
>> +		edac_dbg(0, "  TOP_MEM2: 0x%016llx\n", pvt->top_mem2);
>> +	} else {
>> +		edac_dbg(0, "  TOP_MEM2 disabled\n");
>> +	}
> These two values are not used by any code within this module. They are only
> used in debug print statements and debug sysfs entries. I think this code
> should just be removed. An expert user who wants to know TOM and TOM2 can use
> another method, like msr-tools, rather than recompile a kernel with
> CONFIG_EDAC_DEBUG, etc.
Make sense, do you think some users have developed scripts to parse the 
EDAC debug logs ?
>
>> +}
>> +
>>   /*
>>    * Retrieve the hardware registers of the memory controller.
>>    */
>> @@ -3235,6 +3256,8 @@ static void __read_mc_regs_df(struct amd64_pvt *pvt)
>>   		amd_smn_read(nid, umc_base + UMCCH_ECC_CTRL, &umc->ecc_ctrl);
>>   		amd_smn_read(nid, umc_base + UMCCH_UMC_CAP_HI, &umc->umc_cap_hi);
>>   	}
>> +
>> +	amd64_read_pci_cfg(pvt->F0, DF_DHAR, &pvt->dhar);
> "dhar" is not used by any code for Zen-based systems. I think this line can be
> dropped. Reading "dhar" should still be preserved for legacy systems.
>
> This is also the only use of PCI F0. So all the F0 IDs can be removed too. I
> have a patch for this as part of some general code clean up. Let's include
> that with this set also. I think removing TOM/TOM2 code can be included too.
Sure, we can work on this.
>
>>   }
>>   
>>   /*
>> @@ -3244,30 +3267,8 @@ static void __read_mc_regs_df(struct amd64_pvt *pvt)
>>   static void read_mc_regs(struct amd64_pvt *pvt)
>>   {
>>   	unsigned int range;
>> -	u64 msr_val;
>>   
>> -	/*
>> -	 * Retrieve TOP_MEM and TOP_MEM2; no masking off of reserved bits since
>> -	 * those are Read-As-Zero.
>> -	 */
>> -	rdmsrl(MSR_K8_TOP_MEM1, pvt->top_mem);
>> -	edac_dbg(0, "  TOP_MEM:  0x%016llx\n", pvt->top_mem);
>> -
>> -	/* Check first whether TOP_MEM2 is enabled: */
>> -	rdmsrl(MSR_AMD64_SYSCFG, msr_val);
>> -	if (msr_val & BIT(21)) {
>> -		rdmsrl(MSR_K8_TOP_MEM2, pvt->top_mem2);
>> -		edac_dbg(0, "  TOP_MEM2: 0x%016llx\n", pvt->top_mem2);
>> -	} else {
>> -		edac_dbg(0, "  TOP_MEM2 disabled\n");
>> -	}
>> -
>> -	if (pvt->umc) {
>> -		__read_mc_regs_df(pvt);
>> -		amd64_read_pci_cfg(pvt->F0, DF_DHAR, &pvt->dhar);
>> -
>> -		goto skip;
>> -	}
>> +	read_top_mem_registers(pvt);
>>   
>>   	amd64_read_pci_cfg(pvt->F3, NBCAP, &pvt->nbcap);
>>   
>> @@ -3308,16 +3309,6 @@ static void read_mc_regs(struct amd64_pvt *pvt)
>>   		amd64_read_dct_pci_cfg(pvt, 1, DCLR0, &pvt->dclr1);
>>   		amd64_read_dct_pci_cfg(pvt, 1, DCHR0, &pvt->dchr1);
>>   	}
>> -
>> -skip:
>> -	pvt->ops->prep_chip_selects(pvt);
>> -
>> -	pvt->ops->get_base_mask(pvt);
>> -
>> -	pvt->ops->determine_memory_type(pvt);
>> -	edac_dbg(1, "  DIMM type: %s\n", edac_mem_types[pvt->dram_type]);
>> -
>> -	pvt->ops->determine_ecc_sym_sz(pvt);
>>   }
>>   
>>   /*
>> @@ -3792,6 +3783,7 @@ static int per_family_init(struct amd64_pvt *pvt)
>>   		pvt->ops->prep_chip_selects		= k8_prep_chip_selects;
>>   		pvt->ops->determine_memory_type		= f1x_determine_memory_type;
>>   		pvt->ops->determine_ecc_sym_sz		= f1x_determine_ecc_sym_sz;
>> +		pvt->ops->get_mc_regs			= read_mc_regs;
> The function names should be more consistent: either both get or read.
>
> The read_mc_regs() function is used for systems with DCTs (i.e. legacy). This
> can be included in the name.
sure
>
>>   		break;
>>   
>>   	case 0x10:
>> @@ -3805,6 +3797,7 @@ static int per_family_init(struct amd64_pvt *pvt)
>>   		pvt->ops->prep_chip_selects		= default_prep_chip_selects;
>>   		pvt->ops->determine_memory_type		= f1x_determine_memory_type;
>>   		pvt->ops->determine_ecc_sym_sz		= f1x_determine_ecc_sym_sz;
>> +		pvt->ops->get_mc_regs			= read_mc_regs;
>>   		break;
>>   
>>   	case 0x15:
>> @@ -3834,6 +3827,7 @@ static int per_family_init(struct amd64_pvt *pvt)
>>   		pvt->ops->get_base_mask			= read_dct_base_mask;
>>   		pvt->ops->determine_memory_type		= f1x_determine_memory_type;
>>   		pvt->ops->determine_ecc_sym_sz		= f1x_determine_ecc_sym_sz;
>> +		pvt->ops->get_mc_regs			= read_mc_regs;
>>   		break;
>>   
>>   	case 0x16:
>> @@ -3853,6 +3847,7 @@ static int per_family_init(struct amd64_pvt *pvt)
>>   		pvt->ops->prep_chip_selects		= default_prep_chip_selects;
>>   		pvt->ops->determine_memory_type		= f1x_determine_memory_type;
>>   		pvt->ops->determine_ecc_sym_sz		= f1x_determine_ecc_sym_sz;
>> +		pvt->ops->get_mc_regs			= read_mc_regs;
>>   		break;
>>   
>>   	case 0x17:
>> @@ -3886,6 +3881,7 @@ static int per_family_init(struct amd64_pvt *pvt)
>>   		pvt->ops->prep_chip_selects		= f17_prep_chip_selects;
>>   		pvt->ops->determine_memory_type		= f17_determine_memory_type;
>>   		pvt->ops->determine_ecc_sym_sz		= f17_determine_ecc_sym_sz;
>> +		pvt->ops->get_mc_regs			= __read_mc_regs_df;
> The underscore prefix can be removed, since this is no longer a helper
> function. Also, the "df" suffix can be removed when changing the name.
>
> Maybe something like this:
>
> pvt->ops->read_mc_regs()    <--- This reads memory controller registers.
>
> read_dct_regs()    <--- Used for DRAM Controllers (DCTs).
>
> read_umc_regs()    <--- Used for Unified Memory Controllers (UMCs).
sure
>
>>   
>>   		if (pvt->fam == 0x18) {
>>   			pvt->ctl_name			= "F18h";
>> @@ -3925,6 +3921,7 @@ static int per_family_init(struct amd64_pvt *pvt)
>>   		pvt->ops->prep_chip_selects		= f17_prep_chip_selects;
>>   		pvt->ops->determine_memory_type		= f17_determine_memory_type;
>>   		pvt->ops->determine_ecc_sym_sz		= f17_determine_ecc_sym_sz;
>> +		pvt->ops->get_mc_regs			= __read_mc_regs_df;
>>   		break;
>>   
>>   	default:
>> @@ -3935,7 +3932,8 @@ static int per_family_init(struct amd64_pvt *pvt)
>>   	/* ops required for all the families */
>>   	if (!pvt->ops->early_channel_count || !pvt->ops->dbam_to_cs ||
>>   	    !pvt->ops->get_base_mask || !pvt->ops->prep_chip_selects ||
>> -	    !pvt->ops->determine_memory_type || !pvt->ops->determine_ecc_sym_sz) {
>> +	    !pvt->ops->determine_memory_type || !pvt->ops->determine_ecc_sym_sz ||
>> +	    !pvt->ops->get_mc_regs) {
>>   		edac_dbg(1, "Common helper routines not defined.\n");
>>   		return -EFAULT;
>>   	}
>> @@ -3972,7 +3970,16 @@ static int hw_info_get(struct amd64_pvt *pvt)
>>   	if (ret)
>>   		return ret;
>>   
>> -	read_mc_regs(pvt);
>> +	pvt->ops->get_mc_regs(pvt);
>> +
>> +	pvt->ops->prep_chip_selects(pvt);
>> +
>> +	pvt->ops->get_base_mask(pvt);
>> +
>> +	pvt->ops->determine_memory_type(pvt);
>> +	edac_dbg(1, "  DIMM type: %s\n", edac_mem_types[pvt->dram_type]);
> This line should be included in determine_memory_type(). It should be called
> for each PVT on legacy systems and for each UMC on current systems.

sure

Regards,

Naveenk

>
> Thanks,
> Yazen
