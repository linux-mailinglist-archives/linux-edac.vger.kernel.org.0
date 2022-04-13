Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4FE44FFEFD
	for <lists+linux-edac@lfdr.de>; Wed, 13 Apr 2022 21:16:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236188AbiDMTTB (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 13 Apr 2022 15:19:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235895AbiDMTTB (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 13 Apr 2022 15:19:01 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2045.outbound.protection.outlook.com [40.107.237.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 852E8624E;
        Wed, 13 Apr 2022 12:16:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BOhrvdO2IiWVFOJdGdlEszvf1xsvxm3BoUUZosAguBmLQs9Emdx2TQ9R2kNlCrUCKprkgmI/zZFGz6s3//3t+rxxqvbx2sJF9Iec1qEklDwpA+863/CutbCxYAJwpetbrS76YXfUjEQ+3LC6y9lBVAUr4xrM746tFA3YOX6pwf8OUvTyqcKYBZVaMfMxazf+Z3OSbUqWijIwfl/AMPo4+xSXKvtv7vN/QlCjV9SZVRtN7Y4Wf/MD/HcfTk+X+pkNeubTHV4NZNLXk3l44SnQfO1czJhwt9Uu18eywTno662SASNzYqkjuml8HKdebsBAGgGyFS/y5gZsFuhGlbQsJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tTeYED6zC/OgMh3m50PKl5d0TAVQRKK1pOjNMZLDveQ=;
 b=f6eWuyuGkv0Tf1DgtOsnj4to+HUIB2FPKHDW2IofSWKBPIedBCa9CZrugKPpS7VLO6GzsGMmmHSbElC02idFOEUC6lgU8M5WiGknx9POiRrvblQfRH9E7tsBgicEPaD3pA4Z7xqX01n2xQ7HNOGn2OtDNoN5TNX8MeUSR/P4V0J42SeqnU8UFGhng+yzJskMJgcZHeB2XoYPD926TZuwVJPLe6or/uBuWaBgQRa8vdDsCWm+pQq2CcXumcU7KVeAZ5h3A3yapBfmLe1EvwgM6X+UgPPbW4f29TFxD5d9Cxt8D+KpyRCgHHcRn9oczismCfVwlE3ibgdHCN1r14hicg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tTeYED6zC/OgMh3m50PKl5d0TAVQRKK1pOjNMZLDveQ=;
 b=4+BCuL7WA34CgS/5oJPEczhB1dJQVaAf30vOeFf2mIHADH9TCpX+bQpyEwEuC/qluviktgZGP7zRzrvfWsvrPKQhXqW8BEuGrEiRw79xZ6snfc6ovkfQzeBzRIH/op8AjT3BR/BFv5WT24dFPOMBBEn/dmHq/sDwpl0MmTp/Cqo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB2869.namprd12.prod.outlook.com (2603:10b6:a03:132::30)
 by BYAPR12MB3432.namprd12.prod.outlook.com (2603:10b6:a03:ac::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Wed, 13 Apr
 2022 19:16:29 +0000
Received: from BYAPR12MB2869.namprd12.prod.outlook.com
 ([fe80::482f:9ad2:91d9:ddf4]) by BYAPR12MB2869.namprd12.prod.outlook.com
 ([fe80::482f:9ad2:91d9:ddf4%7]) with mapi id 15.20.5144.029; Wed, 13 Apr 2022
 19:16:29 +0000
Message-ID: <2c4c2359-f662-cd5d-e9ab-da5c71ca7dc9@amd.com>
Date:   Wed, 13 Apr 2022 12:16:26 -0700
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
X-ClientProxiedBy: SJ0PR05CA0003.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::8) To BYAPR12MB2869.namprd12.prod.outlook.com
 (2603:10b6:a03:132::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 864133b1-eaa2-4ec5-012e-08da1d821c79
X-MS-TrafficTypeDiagnostic: BYAPR12MB3432:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB3432F2C64E4933F27029956D90EC9@BYAPR12MB3432.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KMRysLtco7TUld4JGn3jHVGM8pkPJnydgCxzT0SZfepVOvjuMBiQeoRu9ZvB9dD0XTtvEl2IYOShyEvW5uCb0fern0KzutF6M67609RikkKPL1JeVPypxHbfuMq+PXGe+jEGyk3FANMGVOZbIXnpEW2nSKA+odlWs3Z1Q0INzIhOaOi2pSGfsVSrsDOO7okttkQj/fK/+cv55MgxpID/cYj1CHZg60DRDQPrVc9qlZ8t0iRsAFM5B4ygv7A1LAh+maiqlu97+p2b2MqF28Taiq0qk1Qt6i448WLyDOwomnYSLsIGVWSLqaLUwBvnp9glvyBC8OcVxzi8UnVtcBs0nA9V08xyvjCplNPZYli7GxWvZfllT470Wmv8R8wLkHJfGomZ5a0FC3oACVrlNMuODrdTETLRSYqb/H14m1KYBlbf5hfxS/Twa3c+RRlv0rUFw1UmikUa4cs4ben0UV2VtKECzR7/BkRkI8tiPKwREOcv7DRysoJzbFvPNCZ6HvwNxBpRG2yU3TwehUGXGW8jDqCFXvl9404PQNrAwJGiWq0b27laFvpdZNFDRqopXZDOVuLiZjcDcUO6en9MdH5lzsUbrbJaPEL31DIre/fgqfmB3yDGKrKEa9eva1KpgS1t7ZEG9jlv4KadyC+EJd30Rik4DrGwUkco4VDuAI70ey+JyCdzqHHEfdfpxJngjUSsH/Yl81tmwm0L/+/PyPRxc/jMzqgmxEmFgb78FlQz4Gga0S/iACtQ6Q13bCbOLKpgz8TX53QQHItOQLWFdo+rRw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(8936002)(38100700002)(316002)(2616005)(86362001)(4326008)(6506007)(53546011)(6512007)(83380400001)(6666004)(2906002)(31696002)(5660300002)(6486002)(8676002)(66476007)(66556008)(66946007)(6916009)(186003)(54906003)(508600001)(31686004)(36756003)(21314003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U2VBUzk2dnh1cEd5amxFTCtHa0o1YlowVy92eUpFcGRBS1o0Vmw2V2tETjVa?=
 =?utf-8?B?NEZ5ZlZabldsdUxLQWlhYmttbW0waXArTVdkZlZQNTVlbWxWMTlic09lMVYv?=
 =?utf-8?B?QVFmbVFQVnRLT2tZVTRKY0RzNmhyYmFNcnlvOVcvSjdWNlliVi9HcEd3UmlN?=
 =?utf-8?B?UCszV2VSRGkxUWpkcy9GV0dDVEVPNE90QVBtb0N6anhEV1VZNUZCOGxQdXZC?=
 =?utf-8?B?eDdPL05uUDVGZ3NCd2FlMjVwV2s3OFIwUUNLZnFyK2RWbWR0Y2hHaVI0VGFj?=
 =?utf-8?B?UXlhY0VDRDlPZGdwUDJRd2VaUjVsbmZmWjlsODBwYVlmRWFwaENqR1NqL1ov?=
 =?utf-8?B?bnFvYkxDUTN6RHhVbld0Rk5abllaU0g3Y3FRQWRlVUNHWjdpWURXMDUvQjFp?=
 =?utf-8?B?SEU0cE5BMWV5TVc2d2tZZW11UDY1RGU1ZHJtS015NHRVWDkyY01TaklYVjY4?=
 =?utf-8?B?bjZmb3JuZWxRSWw2MkVwdW9FN3N5aVdnaERFL1RMT2xDdGFYR2ZHUUpMb1VI?=
 =?utf-8?B?RG45REVsNGtHV1Z0N1p6Z0tRaER5YjloV2xabVZtSE1VRXB4LzRvdGlrY1Nl?=
 =?utf-8?B?bk8yMDhicjRxUlhNdjIxdG5BeGVJdHVnMkRDS1FVbU9BbUpRSy9qWkNZZDFJ?=
 =?utf-8?B?ZHZ3eGFVK29xSGFXdmx3cGR2MXRXWDFBdlE4dndNcjE0bDVpcDkrMnlWTFlE?=
 =?utf-8?B?eEJPK2gwVnBvWnkyQ2U5VXpWLzBSbVNEK3k4ckhpUk8rdU5SV1hTN3ZFeWRM?=
 =?utf-8?B?bk1DUWRNY3AzSVAzY3hURmswclN5amo4MjAzdXlNMlZscFJkeUVPeTNvV05h?=
 =?utf-8?B?YytCMnVkMTA5TU10RGNiV1B6M2dzQyt2dVZZTXpybXFYUGRFcDdqN2s2YVpm?=
 =?utf-8?B?R2pEbjdzQk9ZN3IyQmRHWHJjb1FZYVFpTlJqdnRrcTBtaUx4UDJ5dkxyNDdp?=
 =?utf-8?B?ZFVBNDE3UWdIN1dyWEk5bGdlcXorWFlQV2JwRWpveUZkakRLS2VxcytNV2Fs?=
 =?utf-8?B?V3JXTEp0TG5BVmFsTTZwN1VnZC9GLzgzSjVUTFF3ejZiY09PV1A4ZHQzelhx?=
 =?utf-8?B?NXRyd2hhUW1jMTB4ZUNtRmNHb015YTcwaTZYODYrTTRiOGYwSGtKNjlteDVI?=
 =?utf-8?B?KzIxdTQrR0JaRHk4L1BvZHlaQ2RlZ282NU15dlRBdWZ4THV2ZmFIcEJtc3dq?=
 =?utf-8?B?SFJTdkRucHFoVWhYSUJTK21xNDAycnpJWnZDbXh2Y2J3MG8vT3F6bUJPZmxn?=
 =?utf-8?B?d29WZXpRakxLejlxZStDL3RSWlIvaUozTm5zOTB3a3dYWXFoTDZ0RU01U3Np?=
 =?utf-8?B?VCs0bDd5ZUZCd3JBeThLYlFZYlpPQ2ZhQTVCalJOTk0wMWl5M3gxenhtL2dJ?=
 =?utf-8?B?SFQrMVlDRmxqbmEzYXFmbEJ5UXV0YkhkbUpYdnl5Z0NuRjBFbk5HNTBlMXV1?=
 =?utf-8?B?dEQyYmpCZ1FFM28xVzNPczJTUzRRd1pQNTRHNkVpU1VHb1lXZFdmZzBWcnBT?=
 =?utf-8?B?bmhIQ3BvL09hZ1dVdXdPekh0UkpTcDZ5bDRRQ2orK252Z05YaGs4eFBjanNY?=
 =?utf-8?B?T013RWtRbXB1MXNKR1U0UVpPekdsWUdsamQ4NWlCMFhjYWNzbytsdVNPREJP?=
 =?utf-8?B?TllJUDFlQWJiTjNTNDhnMXhtZm02RWhCY2JvZVh2ZnZlNFJzdWZHRWRBeGZn?=
 =?utf-8?B?enIxdXNXb002ZEFPVDJIckdIN051ZnFyNzIxaVNrbE1rN1V0Unlobjh1Nld1?=
 =?utf-8?B?YjNYR0ZWdTljR2dSTExvQmd2Vlk5Znh5cERtcWJVWURraU43SlZYS1ZWNkZ2?=
 =?utf-8?B?V05SaWxNSlU5RUlrcjNvandjbXN0MXlMTmE3ZkZxQ2FoU3JIc0ViV3J4Y3lW?=
 =?utf-8?B?Y3NyaDZzSTBrWU82T2NxV0RDdWlWSWVuS0pUd0REcjdIS0xjYnExTVBvdk1C?=
 =?utf-8?B?YkhsRjBuM3prdUNwZlNsTDF1RnRqZjhDOWpNNlNEVmNDbVZGQmZQN0h4Y1RH?=
 =?utf-8?B?Kyt2Sms1NUZKQWJFKzVaQnJFSkNHUUNpNklyeEo4cTA5NytvaDU2SnFSVU5R?=
 =?utf-8?B?NXhvU3NxejNrUEZxY2svSS92cEVPeFVUaWt2aFpkclNrK2tWeUtUZWZQQXVt?=
 =?utf-8?B?RnFwUlBpZ1NkZTZaVkZmYTgzb0wzM1hoai9SLyt1a1AwRFVzcjlMTDgzaDll?=
 =?utf-8?B?K2lMYkZ3dWZIemFLT3BZU2FHV2k4cEhmQzI4VTBySC9UMWx2eXhTZGRuYWU5?=
 =?utf-8?B?Y2NGQmZORTM4d3hGT01icUNNSVBjb2tUenNqcUNxSUJmZTQyYXBTY3VmYzYr?=
 =?utf-8?B?NWthemFKYnM1VmlJbXcramNUaG9POGNxUzdsL0lPYjhVK2EzQ2xaWDhiQTBK?=
 =?utf-8?Q?rriGoj6xPcPCdazPat+QqeVtNHu2Skcc7SsKOM1INhPhe?=
X-MS-Exchange-AntiSpam-MessageData-1: RgJx5nVElW6+gw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 864133b1-eaa2-4ec5-012e-08da1d821c79
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2022 19:16:29.1523
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z5mJCBn/ewlGibyfQPSYasTkBfDkKTFjD7kDDE6Iq1Esc8qXn4jOBzR58Lalv877yNxrSKp9OyYbqzERF1yKSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3432
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
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
Okay, will make changes as mentioned. Thanks.
I understood most of it, just have one doubt below..
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
Should this change be part of this patch series? Also, why mce_flags.smca
check won't work?

Thanks,
Smita
>   		switch (reg) {
>   		case MCA_CTL:	 return MSR_AMD64_SMCA_MCx_CTL(bank);
>   		case MCA_ADDR:	 return MSR_AMD64_SMCA_MCx_ADDR(bank);
>

