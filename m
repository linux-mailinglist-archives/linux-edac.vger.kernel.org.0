Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FBE5506293
	for <lists+linux-edac@lfdr.de>; Tue, 19 Apr 2022 05:24:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346478AbiDSD1Y (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 18 Apr 2022 23:27:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232721AbiDSD1Y (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 18 Apr 2022 23:27:24 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2074.outbound.protection.outlook.com [40.107.92.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D307224F25;
        Mon, 18 Apr 2022 20:24:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l3Zh3u6UARbtR0M8wfVUwH9ckguBEPdWVGQ8E5fy7OJn8D6orS91VMIKNu5GNcOWn8PJ/Q92b6xRlEvnAUkb6EHwMCFH5jIu4N6XNrQAVhVq3Y9c33vIRaiBakOYN2Q3C2PFroMaHzqXJEQH3nogKyTG7d0bg0SIysowLx2lgiiUAHHU9hb8ujSJ2kXDzmiHaBBwXuuUwWdxc3HK/MfDfc3ARFCX0hNdpHexe5DEOromdPG2K9YGMIJgcvl0VMKtR0AeofSv6/a/wkG3h1jh2jiPrBGzLKO64GjOpNU1YNqWuH5cXmSIdwOnXKoO4Ma5/NQg1fkpKKWBvbB+X37IXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d1/hEP0dZqZ4C5+oWgu8dus3kcUFk+PHGgf0NUVFT90=;
 b=TUAGPNFn4hgksff6pxAl9F3ALNWUKWgv8ONn0YCljxWoLg3LrrR8IpDsfWgVbyRG9Carrsk/oFMWNu2XIMtm40cCNx4pX8h9NewYvwUvGG8DQdPMNzvqlc2w/PzYQaFh6yB7cn1YJWyEdX5EdJ+lHaV9gP1S6NlRzskvgCAe5HimVjpRLSUoMyt7V8WZHl0ZRSp+Y5KuPoAwfLG4eaN5p4+Y9kEhv03OuT6NOa5Dp93nQUXS5u/ptb50al5NBuRzq1/h2AskNSFLeiEExCeYAE5oNChljvgYdR3/ZW8arHGf/q3d8tdgUcFOYXaJajJKG0cJg7GEWDdjnHABD/JVZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d1/hEP0dZqZ4C5+oWgu8dus3kcUFk+PHGgf0NUVFT90=;
 b=P3xWjcvC7hTN08NYQeudiKIpgekLISyMesNyno7fF3xEEfllgn8KXd8c1N1jMGtpxrcox5vDLgqsSqS7vYzjZLGshCoujFKm0h1EFItYXySgtdJwqDX+SblEgAbZ/wpacoZuHmrYCfaC+i5RHVKKH3lgsn9CUMQ1qzB3uV2h5QE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB2869.namprd12.prod.outlook.com (2603:10b6:a03:132::30)
 by SN6PR12MB2640.namprd12.prod.outlook.com (2603:10b6:805:6c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Tue, 19 Apr
 2022 03:24:38 +0000
Received: from BYAPR12MB2869.namprd12.prod.outlook.com
 ([fe80::482f:9ad2:91d9:ddf4]) by BYAPR12MB2869.namprd12.prod.outlook.com
 ([fe80::482f:9ad2:91d9:ddf4%7]) with mapi id 15.20.5164.025; Tue, 19 Apr 2022
 03:24:38 +0000
Message-ID: <6cda2827-af75-589d-3e43-a287d6683e7a@amd.com>
Date:   Mon, 18 Apr 2022 20:24:35 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v4 1/2] x86/mce: Check for writes ignored in MCA_STATUS
 register
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>
Cc:     x86@kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, Tony Luck <tony.luck@intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>
References: <20220214233640.70510-1-Smita.KoralahalliChannabasappa@amd.com>
 <20220214233640.70510-2-Smita.KoralahalliChannabasappa@amd.com>
 <Yk267A1MKOo2AlXQ@zn.tnic>
From:   Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
In-Reply-To: <Yk267A1MKOo2AlXQ@zn.tnic>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0214.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::9) To BYAPR12MB2869.namprd12.prod.outlook.com
 (2603:10b6:a03:132::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b48ca954-9b17-43df-2f6b-08da21b42265
X-MS-TrafficTypeDiagnostic: SN6PR12MB2640:EE_
X-Microsoft-Antispam-PRVS: <SN6PR12MB2640605CFB5E22918AC1140890F29@SN6PR12MB2640.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BZy6Zz+JRsLzrYH0MlcxDl0eXVgAU6hqoyKxbrlLEdRvmzd2PS8BQ5lWyQETbMrbQPw9UH3StuIAdyGlx+3Mb83NlDEPckQPb/eUw8PhODGic0zREXyN3Cps2K3BG1FI3zlJ5ZmvpfMQxvpPce7FijINZmgzJ9/bJcqFL+O0V3TDsHQWZs3aZOWi7BIWwpeQmzwb/5wPnskwJn9HfLIZH/lFvwKwymN+ptEQ+apvCz+bj/TV/oZ1ezjdpOWTg9PN4eVTiQiSjjeZItSZTicQkNFC8z4RoBkFjRNoMKnXDG6tpSCFbQt5RUb1l+6iRvcHfwd5mcNKRhBVzNLVtivPv48LPuUzdqzzidqaWoySMU67UAqYBh5cXkJf39Lam44xPatUnjd9LdEQFJOPbXgVxMEZtb/jkA67nIlKAXyGpPB85tAoujWdmmLLOcQcw1DKB7ZCP1I6hC24cOqraD5/Srz4Ju0tM0C2FE75wHNpwg3sTZaSEdVG5TVGnCGbEncP0OJgecC4xRNhXx2+9n8CwQS34p4XVcRckKTYS+aAr0qRxZCzIbJOkgLW7YzwZ+x31YALzmNZvad7fIf3xY8339iqm0/wjecvv/M1VztrRagg8YImf28o1QvjBs4o/aH4ulOQSPCba3ru4Px14blX02Qu0nRJSqjPOmteXzmjR7Q6zFEze/WLXX/6YqQAqCgV8lYR6SjDr8E4vmC/7oqL1h4gYECw5Wln4CFphAtg9t/YK6p5/Vp6DEAFMcke6ncyisW+B3l7Y73/8gO8s1O8kg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(31686004)(38100700002)(54906003)(2616005)(31696002)(66476007)(66556008)(4326008)(66946007)(186003)(8676002)(316002)(26005)(6916009)(36756003)(6486002)(508600001)(6666004)(6506007)(6512007)(86362001)(8936002)(83380400001)(2906002)(5660300002)(53546011)(21314003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YTBlaWQyVlhsVjBRYlJnRmhsalRtU2xTT04yRG4yOTkzTVFtSUlpSCtsUEZj?=
 =?utf-8?B?QmZMZkRXcU5qQjRIS1BqMDZYUTVOMTdPWVZJRHFPV0NRcnRobHJIalJwNStU?=
 =?utf-8?B?cVRoSEpBYzIrZUNva1MxcFdBV0MyaThmVkdKWURZbUMyTDhzOUFXMzBpVU1O?=
 =?utf-8?B?TkJyNkd0MTBwMmlpbmErOUNQZnRyWnFqVVp5VnpjcEZlSUdZbWliRG5GZHU0?=
 =?utf-8?B?Tm00RzR3R29RdmkxR0h5WnFBOHEyY1BtUFZibXlJam80RjF4cEZjNUh1SDBs?=
 =?utf-8?B?N3NuQ1VFblZSRlh2dmtxcDJzelFZeTNLRktuSEY2WGlmbnk3eU1uNHZGc3Nl?=
 =?utf-8?B?MTZsVFMvd3JnYnZzVTZ1YXdXRGZrZmVZejRMdkcrcUdYS0x0Q0hVUml1dHRs?=
 =?utf-8?B?WkJmRlFjdHJIdERGaUpIS1h1RUYvSVFTQzVMczFNU1hNMDlia01tQ2dRUWJ3?=
 =?utf-8?B?TTYzL0FiM0xKRkVvL09iZHh4UEV5Q21pNy92MmhKeHFuVmk4bnVHZGg4Q0FG?=
 =?utf-8?B?R0Z3Q1IvUTdxalJuQ29uTHZTNkFsb1ZVZ2t6Vy9XQ1NLM2J2b2lIVy96WWU3?=
 =?utf-8?B?Z2NaMXZrRHJhUkU3ZmJxMEVnZC9wWHh3UHJBTXdLRTdiTHdaMmRmUjVUamRl?=
 =?utf-8?B?MC9GOU9zSnc0Q0wwRW5INVJQRmV5Mjgva0xqQmJJMmlXbEYrSDByUk4rSlJx?=
 =?utf-8?B?Q2VoeEhlMFVLQ243VE82Zy9qWGJOZll0NlFSd0RGUGs2cXkvdlk0SU1pVFpt?=
 =?utf-8?B?RDI5ckJEMUR2U0h1c1hjRjlSVUFaSHdLTFg5RVJRRFFaVXk3YkU5a1diYlFz?=
 =?utf-8?B?ME1GUWthbzByMXhtZkNtRTcxVjJDMXgwSkdmK1ZUbnZoRDF3cWQ4M1ZtZHE2?=
 =?utf-8?B?NTdsMGJHTVJCVU40OFpYWk1vMXRyR2lyaXpHMndBeGF0dFdPV2JBVVNpL1F0?=
 =?utf-8?B?YkZaNmJDeFp0T3VpTzVwaVJIeDNkR3VQaE5PQ3JMUytBbkRMZWs4QmlQb3Vy?=
 =?utf-8?B?cXdhQnNNTGlpUXFwYXJySGxTaHVRaGQ3Mm5YVHhZbUVyb0ZNNllOdm94U29x?=
 =?utf-8?B?M2JMTkY3MWtyQmd1YVd6eEJlUTBkRVRId2JOcDAwMGdGR1p6SlYvRUZhMUIy?=
 =?utf-8?B?dEZmZlBKdEtjMmtDajFRbUUvYUpSOUZIWHlJS2RXSVFhQlhLbWw1U3l0MWNL?=
 =?utf-8?B?NW50U1BTTDYvY1Q1NHJkUGJlQW5YeVFDeUNVODFIOURvd2hUb2svaVpYSXdm?=
 =?utf-8?B?U2owekx2cGtPWTJRTUxHNll5UDc3RGFOcVF0eFZ2ZlA1dVNra3p3YVozSVh3?=
 =?utf-8?B?bE5sU1ZzR2wyTTlXUzJ4cDN5NTBSN2wxVkV6UVlnelkweFlRVDZOZ2pJSmow?=
 =?utf-8?B?aURqL0NPa3QraEhBc29VRkcvVDlpYkw4R3lyMHdTbWNodUJDZHgzM0RDMlE1?=
 =?utf-8?B?bFBZUlI4Y3hXQnczTk16SHZHcG9hUksvL0VlbFZoZVZ5SStjd2M2bTdxNnBG?=
 =?utf-8?B?T3NOcGJVbTI5WDZkaXF3Z2NBSUg3UVJEWDYwVDVkaHRvY3NScmZXVTFLcDRW?=
 =?utf-8?B?RmYrNXFxNnZXbVVVNGtaaGhvRmNjRU1hWEU5eXdmUHlteCtMZ0FoTGtMSzVu?=
 =?utf-8?B?UmN6U280VjRldXFIMnJBYmdyVDNKWHVucnZ6MzUvU3ZBSzBMRXhwZEliSTM1?=
 =?utf-8?B?Nklta3RLUldSQWxUZng5blB2VHU3Y01uTjBjR0lJMnRPeHB4U0pvcmdqaThE?=
 =?utf-8?B?RHNnK21pRit2T2lINW55ZzZWeDRheHNvYnExNTRKNSs0OE9URXZ1VFpwc2JF?=
 =?utf-8?B?enQ0aGhFNnlpWG1zR2FETHpwa09OV1h6NjFxYytFR3VnUEV4TERBK1g2eFVP?=
 =?utf-8?B?Q1JuZ3pFSk8xcGp0OUJTMG1NZ1owaUZhZUJCM2ZHaGtSNnJpdzdLSFR1Y2Nr?=
 =?utf-8?B?YVh4cUNmcVNlOVZodDFVamJqYnpWRkRUT0VvY2xiUTdCWjFMR0ttZHRsejM0?=
 =?utf-8?B?YUdwVWl0VE1SMUVzMWZvY1M1QXNHTXRSczE2Rlk2aUxVdDhEUWs3RTJudlgy?=
 =?utf-8?B?WHREVFVYa1FFQjBGU2QxNHNxL1VEUUM4NmtNK3F5RGRwb0RMY3h0VDIyaGhj?=
 =?utf-8?B?SmNiMk41S0ZhcUxEMHF6di9CZHlvMHVxa3B4WWl6TXdYT3B2SmlHU1A4bE02?=
 =?utf-8?B?NUo2VjMzSzJCNWpzampjYTNJVVdFTEY4SWNBcGxVc0VGa0tWSVFxZndJMldG?=
 =?utf-8?B?aEhnNklqQUlHaXBZRWx1VVpIS3FON2tNMHhPVDNndDh1VjFaNFdyditZSnVH?=
 =?utf-8?B?NXJQSFh1V2lzcVBkWWg2R3ZXS2hmYmlDV1pZMmRUWjN1VSs5L0VSZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b48ca954-9b17-43df-2f6b-08da21b42265
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2022 03:24:38.3264
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8C3dvQoQ3S3hOM9dNjWXwceFXFV+eZq9EU3ONu27KGS7mkZmotut81Qi+VwnOKSq/+95xY8WrajGgP/hI1m9fQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2640
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On 4/6/2022 9:08 AM, Borislav Petkov wrote:
> On Mon, Feb 14, 2022 at 05:36:39PM -0600, Smita Koralahalli wrote:
>> diff --git a/arch/x86/kernel/cpu/mce/inject.c b/arch/x86/kernel/cpu/mce/inject.c
>> index 5fbd7ffb3233..43ba63b7dc73 100644
>> --- a/arch/x86/kernel/cpu/mce/inject.c
>> +++ b/arch/x86/kernel/cpu/mce/inject.c
>> @@ -470,11 +470,36 @@ static void toggle_nb_mca_mst_cpu(u16 nid)
>>   		       __func__, PCI_FUNC(F3->devfn), NBCFG);
>>   }
>>   
>> +struct mce_err_handler {
>> +	struct mce *mce;
>> +	int err;
>> +};
> Well, we already have a struct mce i_mce which serves as a sort-of
> global container for injection data which gets dumped into the hardware
> upon injection time.
>
> Now you're adding another struct which contains additional info and are
> adding a pointer to that i_mce.
>
> But this is not a clean design - when you do stuff like that you need to
> unify all those global-info-containing structs and make the code dealing
> with them straight-forward . I.e., if you don't look at the big picture
> of a design, it soon grows into an unwieldy mess which some poor sod
> would need to clean up afterwards and that poor sod is in most cases the
> maintainer.
>
> So I went and did that ontop of your patch, this is one possible way to
> do it but it.
>
> Here it is, a combined diff ontop of tip:ras/core. Please split it into
> patches: first patch converts to the new descriptor and then a second
> one adds the MCA_STATUS checking bits.
>
> There are a couple of other changes in there, if they're not clear, feel
> free to ask.
>
> Thx.
>
> ---
> diff --git a/arch/x86/kernel/cpu/mce/inject.c b/arch/x86/kernel/cpu/mce/inject.c
> index 43ba63b7dc73..0fd1eea2f754 100644
> --- a/arch/x86/kernel/cpu/mce/inject.c
> +++ b/arch/x86/kernel/cpu/mce/inject.c
> @@ -33,10 +33,14 @@
>   
>   #include "internal.h"
>   
> -/*
> - * Collect all the MCi_XXX settings
> - */
> -static struct mce i_mce;
> +static bool hw_injection_possible = true;
> +
> +/* Collect all the MCi_XXX settings */
> +static struct inject_desc {
> +	struct mce m;
> +	int err;
> +} inj_desc;
> +
>   static struct dentry *dfs_inj;
>   
>   #define MAX_FLAG_OPT_SIZE	4
> @@ -110,9 +114,11 @@ static int inj_ipid_set(void *data, u64 val)
>   
>   DEFINE_SIMPLE_ATTRIBUTE(ipid_fops, inj_ipid_get, inj_ipid_set, "%llx\n");
>   
> -static void setup_inj_struct(struct mce *m)
> +static void setup_inj_struct(void)
>   {
> -	memset(m, 0, sizeof(struct mce));
> +	struct mce *m = &inj_desc.m;
> +
> +	memset(&inj_desc, 0, sizeof(struct inject_desc));
>   
>   	m->cpuvendor = boot_cpu_data.x86_vendor;
>   	m->time	     = ktime_get_real_seconds();
> @@ -470,84 +476,78 @@ static void toggle_nb_mca_mst_cpu(u16 nid)
>   		       __func__, PCI_FUNC(F3->devfn), NBCFG);
>   }
>   
> -struct mce_err_handler {
> -	struct mce *mce;
> -	int err;
> -};
> -
> -static struct mce_err_handler mce_err;
> -
> -static bool prepare_mca_status(struct mce *m)
> +static bool prepare_mca_status(void)
>   {
> -	u32 status_reg = mca_msr_reg(m->bank, MCA_STATUS);
> -	u64 status_val = m->status;
> +	u32 status_reg = mca_msr_reg(inj_desc.m.bank, MCA_STATUS);
> +	u64 status_val = inj_desc.m.status;
>   
>   	wrmsrl(status_reg, status_val);
>   	rdmsrl(status_reg, status_val);
>   
> -	return status_val;
> +	return status_val == inj_desc.m.status;
>   }
>   
> -static void prepare_msrs(void *info)
> +static void prepare_msrs(void *unused)
>   {
> -	struct mce_err_handler *i_mce_err = ((struct mce_err_handler *)info);
> -	struct mce m = *i_mce_err->mce;
> -	u8 b = m.bank;
> +	struct mce *m = &inj_desc.m;
> +	u8 b = inj_desc.m.bank;
>   
> -	if (!prepare_mca_status(&m)) {
> +	if (!prepare_mca_status()) {
>   		pr_err("Platform does not allow error injection, try using APEI EINJ instead.\n");
> -		i_mce_err->err = -EINVAL;
> +		inj_desc.err = -EINVAL;
> +		hw_injection_possible = false;
>   		return;
>   	}
>   
> -	wrmsrl(MSR_IA32_MCG_STATUS, m.mcgstatus);
> +	wrmsrl(MSR_IA32_MCG_STATUS, m->mcgstatus);
>   
>   	if (boot_cpu_has(X86_FEATURE_SMCA)) {
> -		if (m.inject_flags == DFR_INT_INJ) {
> -			wrmsrl(MSR_AMD64_SMCA_MCx_DESTAT(b), m.status);
> -			wrmsrl(MSR_AMD64_SMCA_MCx_DEADDR(b), m.addr);
> +		if (m->inject_flags == DFR_INT_INJ) {
> +			wrmsrl(MSR_AMD64_SMCA_MCx_DESTAT(b), m->status);
> +			wrmsrl(MSR_AMD64_SMCA_MCx_DEADDR(b), m->addr);
>   		} else {
> -			wrmsrl(MSR_AMD64_SMCA_MCx_STATUS(b), m.status);
> -			wrmsrl(MSR_AMD64_SMCA_MCx_ADDR(b), m.addr);
> +			wrmsrl(MSR_AMD64_SMCA_MCx_STATUS(b), m->status);
> +			wrmsrl(MSR_AMD64_SMCA_MCx_ADDR(b), m->addr);
>   		}
>   
> -		wrmsrl(MSR_AMD64_SMCA_MCx_MISC(b), m.misc);
> -		wrmsrl(MSR_AMD64_SMCA_MCx_SYND(b), m.synd);
> +		wrmsrl(MSR_AMD64_SMCA_MCx_MISC(b), m->misc);
> +		wrmsrl(MSR_AMD64_SMCA_MCx_SYND(b), m->synd);
>   	} else {
> -		wrmsrl(MSR_IA32_MCx_STATUS(b), m.status);
> -		wrmsrl(MSR_IA32_MCx_ADDR(b), m.addr);
> -		wrmsrl(MSR_IA32_MCx_MISC(b), m.misc);
> +		wrmsrl(MSR_IA32_MCx_STATUS(b), m->status);
> +		wrmsrl(MSR_IA32_MCx_ADDR(b), m->addr);
> +		wrmsrl(MSR_IA32_MCx_MISC(b), m->misc);
>   	}
>   }
>   
> -static void do_inject(void)
> +static int do_inject(void)
>   {
> +	struct mce *m = &inj_desc.m;
> +	unsigned int cpu = m->extcpu;
>   	u64 mcg_status = 0;
> -	unsigned int cpu = i_mce.extcpu;
> -	u8 b = i_mce.bank;
> +	u8 b = m->bank;
>   
> -	mce_err.mce = &i_mce;
> -	mce_err.err = 0;
> +	m->tsc = rdtsc_ordered();
>   
> -	i_mce.tsc = rdtsc_ordered();
> +	m->status |= MCI_STATUS_VAL;
>   
> -	i_mce.status |= MCI_STATUS_VAL;
> +	if (m->misc)
> +		m->status |= MCI_STATUS_MISCV;
>   
> -	if (i_mce.misc)
> -		i_mce.status |= MCI_STATUS_MISCV;
> -
> -	if (i_mce.synd)
> -		i_mce.status |= MCI_STATUS_SYNDV;
> +	if (m->synd)
> +		m->status |= MCI_STATUS_SYNDV;
>   
>   	if (inj_type == SW_INJ) {
> -		mce_log(&i_mce);
> -		return;
> +		mce_log(m);
> +		return 0;
>   	}
>   
> +	if (!hw_injection_possible)
> +		return -EINVAL;

Why are we checking this here? This flag (hw_injection_possible)
is set to false inside prepare_msrs() called from 
smp_call_function_single().
Should this check be done after the call to smp_call_function_single()?
Also, we already have inj_desc.err which returns error code to userspace
when WRIG in status registers. Why is this flag needed?

Thanks,
Smita

> +
>   	/* prep MCE global settings for the injection */
>   	mcg_status = MCG_STATUS_MCIP | MCG_STATUS_EIPV;
>   
> -	if (!(i_mce.status & MCI_STATUS_PCC))
> +	if (!(m->status & MCI_STATUS_PCC))
>   		mcg_status |= MCG_STATUS_RIPV;
>   
>   	/*
> @@ -556,8 +556,8 @@ static void do_inject(void)
>   	 * - MCx_STATUS[UC] cleared: deferred errors are _not_ UC
>   	 */
>   	if (inj_type == DFR_INT_INJ) {
> -		i_mce.status |= MCI_STATUS_DEFERRED;
> -		i_mce.status &= ~MCI_STATUS_UC;
> +		m->status |= MCI_STATUS_DEFERRED;
> +		m->status &= ~MCI_STATUS_UC;
>   	}
>   
>   	/*
> @@ -578,13 +578,13 @@ static void do_inject(void)
>   
>   	toggle_hw_mce_inject(cpu, true);
>   
> -	i_mce.mcgstatus = mcg_status;
> -	i_mce.inject_flags = inj_type;
> -	smp_call_function_single(cpu, prepare_msrs, &mce_err, 0);
> +	m->mcgstatus = mcg_status;
> +	m->inject_flags = inj_type;
> +	smp_call_function_single(cpu, prepare_msrs, NULL, 0);
>   
>   	toggle_hw_mce_inject(cpu, false);
>   
> -	if (mce_err.err)
> +	if (inj_desc.err)
>   		goto err;
>   
>   	switch (inj_type) {
> @@ -601,6 +601,7 @@ static void do_inject(void)
>   err:
>   	cpus_read_unlock();
>   
> +	return inj_desc.err;
>   }
>   
>   /*
> @@ -611,6 +612,7 @@ static int inj_bank_set(void *data, u64 val)
>   {
>   	struct mce *m = (struct mce *)data;
>   	u8 n_banks;
> +	int err;
>   	u64 cap;
>   
>   	/* Get bank count on target CPU so we can handle non-uniform values. */
> @@ -650,12 +652,12 @@ static int inj_bank_set(void *data, u64 val)
>   	}
>   
>   inject:
> -	do_inject();
> +	err = do_inject();
>   
>   	/* Reset injection struct */
> -	setup_inj_struct(&i_mce);
> +	setup_inj_struct();
>   
> -	return mce_err.err;
> +	return err;
>   }
>   
>   MCE_INJECT_GET(bank);
> @@ -745,7 +747,7 @@ static void __init debugfs_init(void)
>   
>   	for (i = 0; i < ARRAY_SIZE(dfs_fls); i++)
>   		debugfs_create_file(dfs_fls[i].name, dfs_fls[i].perm, dfs_inj,
> -				    &i_mce, dfs_fls[i].fops);
> +				    &inj_desc.m, dfs_fls[i].fops);
>   }
>   
>   static int __init inject_init(void)
> @@ -758,7 +760,7 @@ static int __init inject_init(void)
>   	register_nmi_handler(NMI_LOCAL, mce_raise_notify, 0, "mce_notify");
>   	mce_register_injector_chain(&inject_nb);
>   
> -	setup_inj_struct(&i_mce);
> +	setup_inj_struct();
>   
>   	pr_info("Machine check injector initialized\n");
>   
> diff --git a/arch/x86/kernel/cpu/mce/internal.h b/arch/x86/kernel/cpu/mce/internal.h
> index 4ae0e603f7fa..7e03f5b7f6bd 100644
> --- a/arch/x86/kernel/cpu/mce/internal.h
> +++ b/arch/x86/kernel/cpu/mce/internal.h
> @@ -211,7 +211,7 @@ noinstr u64 mce_rdmsrl(u32 msr);
>   
>   static __always_inline u32 mca_msr_reg(int bank, enum mca_msr reg)
>   {
> -	if (mce_flags.smca) {
> +	if (cpu_feature_enabled(X86_FEATURE_SMCA)) {
>   		switch (reg) {
>   		case MCA_CTL:	 return MSR_AMD64_SMCA_MCx_CTL(bank);
>   		case MCA_ADDR:	 return MSR_AMD64_SMCA_MCx_ADDR(bank);
>

