Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8460744DA49
	for <lists+linux-edac@lfdr.de>; Thu, 11 Nov 2021 17:23:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233128AbhKKQ0h (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 11 Nov 2021 11:26:37 -0500
Received: from mail-bn8nam08on2052.outbound.protection.outlook.com ([40.107.100.52]:37995
        "EHLO NAM04-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232033AbhKKQ0g (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 11 Nov 2021 11:26:36 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GY+Uk6AGWyN1lABfGW1OnimQy5U1p5QbFjefozvNmVJMMeKX1L6MadfBCy3OlxSr6dNmCdXP/Rqmzc/HXKvwjdRIvuGADkKJVrGQOYc5b5w5hCER+eErzVHpeJXy3l8iva5NbgkPYpUnrmm5Vk/Qrsw3iIKydQiTq6XhKH4exwtPvaf7iZAUOSox4EaZIogfOVoCG832FgIdyoAomqP5nj7tN0OdEfVW5FD+RNJkwBaZiAMRjvffQFBc7RCATVhBap7DHN4LysKaFtzGZEVy5vCRZFnmLvhHNlWV/lHmIy9ulPBiLUGuXgdvD6gemOwjXrL5wktGEvHK/PAcYjOfLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6osQfQksqfF/lpeMpMN9MqV1xIj4PaqEBST/0aRn89I=;
 b=a3hxK5QOZCsgo651IdUq3pT8ZbhhNoOGs8bJMEGSSJNGqw80T2tmYW4cX//2Ko1hXcBg2rb65KFUYOMh/MZBEVfZLkHJxh+it98LjhpJvdJoO0eXPeUe8N0NF1aV1SYArXk75CELjS4g7d8x2NDsIgrG7fe4Pvt1WJ3wkvoEOYzAhJkXxZNOYckD7i2fRIE5SQPpOdSeFOUOrZLbe3/hQI3Xq4OsBnGzv3rStFzbn1ILt70oCBZTnnx5YRAvB0Qe/hVGdk/cCMoo0OHEAwZ/mXpWo320tHFO1XUPtFEoGF7BnwG85NYaWUPh6k02ZXqkMa95TLfZqU+koIdX167KjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6osQfQksqfF/lpeMpMN9MqV1xIj4PaqEBST/0aRn89I=;
 b=U8emUZeLvXkjld7XE12yirVMFs9WwFp19qyivF3jQ0++zUttDLH3JLyoye/wIi4ahOK5EI8JcYCjgDQNYRmF/4BPxU2ZT5r10s22lWK6/2FRHtpvlKgRElAFdyKoIunb/tYHweOk/Wgc0+5QsOZwW9bv51SiEVGDCEQNRnoS/lU=
Authentication-Results: alien8.de; dkim=none (message not signed)
 header.d=none;alien8.de; dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5286.namprd12.prod.outlook.com (2603:10b6:208:31d::6)
 by BL1PR12MB5061.namprd12.prod.outlook.com (2603:10b6:208:310::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.11; Thu, 11 Nov
 2021 16:23:45 +0000
Received: from BL1PR12MB5286.namprd12.prod.outlook.com
 ([fe80::c1e:36ae:bada:e396]) by BL1PR12MB5286.namprd12.prod.outlook.com
 ([fe80::c1e:36ae:bada:e396%7]) with mapi id 15.20.4669.019; Thu, 11 Nov 2021
 16:23:45 +0000
Message-ID: <0006a641-44e7-5cf0-04e2-8c4499765b77@amd.com>
Date:   Thu, 11 Nov 2021 21:53:32 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v6 3/5] EDAC/amd64: Extend family ops functions
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-edac@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, mingo@redhat.com, mchehab@kernel.org,
        yazen.ghannam@amd.com, Muralidhara M K <muralimk@amd.com>
References: <20211028130106.15701-1-nchatrad@amd.com>
 <20211028130106.15701-4-nchatrad@amd.com> <YYwFUYDl8wvO02wL@zn.tnic>
From:   "Chatradhi, Naveen Krishna" <nchatrad@amd.com>
In-Reply-To: <YYwFUYDl8wvO02wL@zn.tnic>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0127.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:bf::17) To BL1PR12MB5286.namprd12.prod.outlook.com
 (2603:10b6:208:31d::6)
MIME-Version: 1.0
Received: from [10.252.84.184] (165.204.159.242) by PN3PR01CA0127.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:bf::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.15 via Frontend Transport; Thu, 11 Nov 2021 16:23:41 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 62bf4c4f-b96e-4449-c6a6-08d9a52fa1e2
X-MS-TrafficTypeDiagnostic: BL1PR12MB5061:
X-Microsoft-Antispam-PRVS: <BL1PR12MB50616E1D1E25D62809E3F4B3E8949@BL1PR12MB5061.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Gsm64WaJ7GDFR1Z0YCPhWtcMzs4gfLqUTFiCRaprttJMrNElGWaWMgzNBihbesJmcdMYcelNVgH1HZVMFx1lcxXAMJ4ui1QqB+iOTIlX4KbMaiTqHxDX3inLPrbEn4MoodF0z4cmAi8NMAqhIgx6r6huX4FGyqX+7eepFwR0RgzB6mfKlLfEbgvhr50f3Ov8yBcX1370Ofcm3wfvQpTb3WQn8qOHdBplYp+W2UbFOyaTqKA+ZALykBK0YpNMFZEiPEjQaNrZrPW/ySR4ng1Z0r8H51ItsOBAbBCqw0XB1UsafQuXqeZNEvRJYowAApitwVlxsnduiG8Yd884NGImLZziOD4sKXWRH1LREYUqfebKBKjZ76rctPoVfuII+5a2EbKft4jQciwCMCiAsGhkN8gvP8ggVicVfxsh+RvDMxF81aCKFGTcPJkLoxgcKMZ2bg0pTlxeBV8NAIJ0GCrWWLHQkSmbKkBRlRa3fXBgyUkH985SfR42V/vBbDZnGjDtUv8en88Gkp2ijH172tfwkEiCQlPvmPoSbg1uRXcwZTgmN95ZbjehAhyqzrCpzNck1pWjP59/et9IRGr4nskcsWhDap+F4AVCtxTQgsMWyviCGdaVT+ZPYl19hksV/yn3CDzdcSOLXecl0WzjO7LD5MhJhnSSXkLvlccS0t4UJdITqBcmOLyfR/rRQbCq/fDfGBQRN23Ekdij6fi/gVysIwvtjj3SOXLWx1FBzxzb2zN7Ob9ty/PC3UzR5TvxGQsedsJACgTVyfIVcWDm4I5Eo5PsKnQGsgZtnVsFP3o6/bjTS6qP0h0rpVlcOb8OMsKj
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5286.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(83380400001)(36756003)(8936002)(956004)(2616005)(508600001)(8676002)(5660300002)(26005)(6916009)(45080400002)(16576012)(966005)(53546011)(2906002)(4326008)(6666004)(66556008)(186003)(66946007)(6486002)(31686004)(66476007)(31696002)(316002)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eWNaNDhpYytHbGtHTmk5QmZqeUhJYnU3eHhkT2pyN1FITVRLN0d0NkplZjds?=
 =?utf-8?B?Zis0bGRaUnFmanY0c1BoeGNvV2wzZFY3YU4vcWpjUEloWWpvUUVoV3dtdGxM?=
 =?utf-8?B?a28xekpDVnpIVFZiZ29zZFRQczN3anFIZFNTREE2R0FKblVHcFJrZnNMQmtG?=
 =?utf-8?B?dnZYNW9udkliNVd1eWxsWHpIWXZmemtYSzB2NzlGQjNGbCtTZURyNFFvK1Fo?=
 =?utf-8?B?cTdSL3h5aUZKUXprUUFPbDdMMUNDYUhXRklwQlpyWjQzQVF3ME1wZ2o1aXNM?=
 =?utf-8?B?ajVoa0s4VVYweXJMc1FtYzNXZXk3ZnpoYzhOYzNtb291SFJKTTJhM1ROQ3dO?=
 =?utf-8?B?TUdWYTVyTTMzeGdibzB4MlJsNnVhdWF3UE9aaC9JWE5hM2Z3R2FoUUN5N2RE?=
 =?utf-8?B?VzFZdHpmSXIzVWlBK1lOeGQ0Sm5VQk1JRk9iQWFpcGRWQkt5ZElncmh0SEpj?=
 =?utf-8?B?bzZrSWhSNTJMK3d6RnA1UjMrZUpmUmxTMVkxaDFhNlIrV2NpZFFGT3ZwTkdQ?=
 =?utf-8?B?QWNNc1hLMFVOVnR4YW1DUzVOWmNUVGFFMGtLQTd0emU5ekRrMnhnSi82OGNV?=
 =?utf-8?B?bDRhK1VvSlZoUUJsRDhDT0JaTVl6d2Vzdi8zdWN2ZVRKR0J4OWtFNlVwNGY3?=
 =?utf-8?B?ZVRBSmJ6cWZZSVdqK1l3UE5scGdPMHptZ0pWT1QwZ1dYL1hzRitwdkN0cjlD?=
 =?utf-8?B?OGZ0OUJ5eDg1a1FiSDR1cDBOaUpCS1hzVGFFbDhDcG5TQmJWZHljSzJreCtZ?=
 =?utf-8?B?UTBpa2F6a3RpMmN5eXBnTVl6S2F5dHN0RnJmWTNaZWYxS2p1Um5Dc1NCWGln?=
 =?utf-8?B?TXV2U2JvVEQxUnVjT3JqT0Q2YTY0ZUJJN1hpaFVBOEtZekxES0s2MVpKUVM3?=
 =?utf-8?B?Mk5pS1VyQi9BeWFtbG1WaVFpb0Y1K2MycWxLSnRqbkJNV1ovTzFFRlNuL2ZK?=
 =?utf-8?B?a3ZjMzdGMWFuMzhzZ1YrTXM3cHNzWmVmbEJENi9KUEdRLzFwTStDajN6OEFr?=
 =?utf-8?B?WFA2aXByK0g0VjNIRWJuZDRnKzU0WTR1SGVQUXpkSEloVEdoemcvTnZlZmxk?=
 =?utf-8?B?UGdLY0pCRlpoZkIvQ0FDY0YzdFlXODIxV21TbXZQRWlUQU00UzhJd1pQL0xP?=
 =?utf-8?B?aHJpTTBmNjJmUzBGUWI5SXRocy9GSE9DdUpOVlZzVy9iZTRrK0VkaTloSGQz?=
 =?utf-8?B?cFJWd1FRSG9DaVRMcElRbFZ3YWlVcG5KWFlDMjRYZktDMk1EdGg2OXhGUDFY?=
 =?utf-8?B?UnpSdk5oMjFCT3FtVE92Zk1iV1ZDVXVCRjNZNTJReHFjb0VabTB2Y0FMOGMx?=
 =?utf-8?B?ZjhQV3RZTUJKVWtPbmE0UERaUVB6RkpvNm9ieGJQUStvc1JQd1paRU92ODBQ?=
 =?utf-8?B?NUdwT2lVaVZTOEVTSDRLTHJhdVRCd2Y4ZGc5QnFxdk1KZHFZSG4wTlpPNmRt?=
 =?utf-8?B?S2ZqVThjRmZjcG9VUUhMbmtER3ZRZFdUTE82c05uRE90WTd2aTVZNmtXRGly?=
 =?utf-8?B?QXNjems0REQwMmVUdWZEeGF5aUVSNURkVzNOeGxoUTA2eEZFaEdPZk9SckU2?=
 =?utf-8?B?cE5oanVydTlsekZJQnc1RVA5TnpzTmVTOGRUZ0U0VEk3eXozR2dhTmNielgv?=
 =?utf-8?B?OHhYdDd1Q1RtNWZiS1lCZmdsbnMzVVRBbTA1NlNtVlBVSGhWZ1N4OHphU0R5?=
 =?utf-8?B?VUwrdnpPdXdGT0Exekp3Wjk5ZGtqYmhGbjVOS3dGNU9tWjlHNW45Z2RmVEFS?=
 =?utf-8?B?SkxOVXU5TnN0TCsxTndLMDJkaG9MZ0twckZkc0o3K092d2xCUXIyaDYrNmFI?=
 =?utf-8?B?QjVDMFFUQ3lITDhzcGcvTmVOU2VVVi9QeGNncWppK0dXKzFFR1dkWkt2ZXh6?=
 =?utf-8?B?Y1hBdmgxcVU3VjUzb1R4V0JlZWZUcVNqZCtQS1d1a2NJTHU3cE5kK1BoNnlY?=
 =?utf-8?B?SWFmZ1U4SElMVGRPZklrTlZVbzRaQUVIeE14ZjlFV3F2UUNNVmRkZ2JHRnhy?=
 =?utf-8?B?ZlN4WUJ3ak5COXBxMHlUdnhvK2xKR0NEUUNkd2puT3NPcGxqMjBMY285aU5H?=
 =?utf-8?B?TUZtOENkOHVOM2VWcjZMYjF3aE5EcmZBSnJJSHkvd3liVnJiWmFXdlEveWhE?=
 =?utf-8?B?YUtHZ1kwc0VndlQwUXJyd0ZMbUg2Y1VvK0NNdzhQQmdRbWdSNnNLSmgwbFRi?=
 =?utf-8?Q?wWbj00q2Suha5L3dCdWM+Zg=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62bf4c4f-b96e-4449-c6a6-08d9a52fa1e2
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5286.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2021 16:23:45.3659
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xatSlNYlmTsPnSCqYkEc502vjXdELrnibcu/dpIfLlC5CLR/KN3Bak9dSQI3X+ahlSJgt3aQ6b+AuJkm63052g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5061
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hi Boris

On 11/10/2021 11:15 PM, Borislav Petkov wrote:
> [CAUTION: External Email]
>
> On Thu, Oct 28, 2021 at 06:31:04PM +0530, Naveen Krishna Chatradhi wrote:
>> @@ -1217,28 +1214,39 @@ static void dump_misc_regs(struct amd64_pvt *pvt)
>>   /*
>>    * See BKDG, F2x[1,0][5C:40], F2[1,0][6C:60]
>>    */
>> -static void prep_chip_selects(struct amd64_pvt *pvt)
>> +static void k8_prep_chip_selects(struct amd64_pvt *pvt)
>>   {
>>        if (pvt->fam == 0xf && pvt->ext_model < K8_REV_F) {
>>                pvt->csels[0].b_cnt = pvt->csels[1].b_cnt = 8;
>>                pvt->csels[0].m_cnt = pvt->csels[1].m_cnt = 8;
>> -     } else if (pvt->fam == 0x15 && pvt->model == 0x30) {
>> -             pvt->csels[0].b_cnt = pvt->csels[1].b_cnt = 4;
>> -             pvt->csels[0].m_cnt = pvt->csels[1].m_cnt = 2;
>> -     } else if (pvt->fam >= 0x17) {
>> -             int umc;
>> -
>> -             for_each_umc(umc) {
>> -                     pvt->csels[umc].b_cnt = 4;
>> -                     pvt->csels[umc].m_cnt = 2;
>> -             }
>> -
>> -     } else {
>> +     } else if (pvt->fam == 0xf && pvt->ext_model >= K8_REV_F) {
>>                pvt->csels[0].b_cnt = pvt->csels[1].b_cnt = 8;
>>                pvt->csels[0].m_cnt = pvt->csels[1].m_cnt = 4;
>>        }
> Why is this function looking at the family if it is called a k8_...
> function which will be set only on K8?
Will modify.
>
>>   }
>>
>> +static void f15m30_prep_chip_selects(struct amd64_pvt *pvt)
>> +{
>> +     pvt->csels[0].b_cnt = pvt->csels[1].b_cnt = 4;
>> +     pvt->csels[0].m_cnt = pvt->csels[1].m_cnt = 2;
>> +}
>> +
>> +static void default_prep_chip_selects(struct amd64_pvt *pvt)
>> +{
>> +     pvt->csels[0].b_cnt = pvt->csels[1].b_cnt = 8;
>> +     pvt->csels[0].m_cnt = pvt->csels[1].m_cnt = 4;
>> +}
>> +
>> +static void f17_prep_chip_selects(struct amd64_pvt *pvt)
>> +{
>> +     int umc;
>> +
>> +     for_each_umc(umc) {
>> +             pvt->csels[umc].b_cnt = 4;
>> +             pvt->csels[umc].m_cnt = 2;
>> +     }
>> +}
>> +
>>   static void read_umc_base_mask(struct amd64_pvt *pvt)
>>   {
>>        u32 umc_base_reg, umc_base_reg_sec;
>> @@ -1297,11 +1305,6 @@ static void read_dct_base_mask(struct amd64_pvt *pvt)
>>   {
>>        int cs;
>>
>> -     prep_chip_selects(pvt);
>> -
>> -     if (pvt->umc)
>> -             return read_umc_base_mask(pvt);
>> -
>>        for_each_chip_select(cs, 0, pvt) {
>>                int reg0   = DCSB0 + (cs * 4);
>>                int reg1   = DCSB1 + (cs * 4);
>> @@ -2512,143 +2515,181 @@ static void debug_display_dimm_sizes(struct amd64_pvt *pvt, u8 ctrl)
>>        }
>>   }
>>
>> +/* Prototypes for family specific ops routines */
>> +static int init_csrows(struct mem_ctl_info *mci);
>> +static int init_csrows_df(struct mem_ctl_info *mci);
>> +static void read_mc_regs(struct amd64_pvt *pvt);
>> +static void __read_mc_regs_df(struct amd64_pvt *pvt);
>> +static void update_umc_err_info(struct mce *m, struct err_info *err);
> Prototypes belong in headers.
Sure, this wont be necessary based on your other comments.
>
>> +
>> +static const struct low_ops k8_ops = {
> So if you're going to do this, you can go a step further and get rid of
> all those static definitions which are completely unused except those of
> the current family we're loaded on.
>
> IOW, you should make all family-specific assignments dynamic and get rid
> of family_types and those ops. Here's an example I did for K8:
>
> diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
> index 1029fe84ba2e..5f1686f22947 100644
> --- a/drivers/edac/amd64_edac.c
> +++ b/drivers/edac/amd64_edac.c
> @@ -3656,8 +3656,18 @@ static struct amd64_family_type *per_family_init(struct amd64_pvt *pvt)
>
>          switch (pvt->fam) {
>          case 0xf:
> -               fam_type        = &family_types[K8_CPUS];
> -               pvt->ops        = &family_types[K8_CPUS].ops;
> +               fam_type->ctl_name              = "K8";
> +               fam_type->f1_id                 = PCI_DEVICE_ID_AMD_K8_NB_ADDRMAP;
> +               fam_type->f2_id                 = PCI_DEVICE_ID_AMD_K8_NB_MEMCTL;
> +               fam_type->max_mcs               = 2;
> +               pvt->ops->early_channel_count   = k8_early_channel_count;
> +               pvt->ops->map_sysaddr_to_csrow  = k8_map_sysaddr_to_csrow;
> +               pvt->ops->dbam_to_cs            = k8_dbam_to_chip_select;
> +               pvt->ops->prep_chip_select      = k8_prep_chip_selects;
> +               pvt->ops->get_base_mask         = read_dct_base_mask;
> +               pvt->ops->get_misc_regs         = __dump_misc_regs;
> +               pvt->ops->get_mc_regs           = read_mc_regs;
> +               pvt->ops->populate_csrows       = init_csrows;
>                  break;
>
>          case 0x10:
>
> After that, pvt and fam_type have been properly set up.

Agreed, will create family_XXh_init() under per_family_init()'s switch.

At present, we are handling the family_type in 4/5 of this set. Will 
club them.

>
>> @@ -3735,7 +3784,16 @@ static int hw_info_get(struct amd64_pvt *pvt)
>>        if (ret)
>>                return ret;
>>
>> -     read_mc_regs(pvt);
>> +     pvt->ops->get_mc_regs(pvt);
>> +
>> +     pvt->ops->prep_chip_select(pvt);
>> +
>> +     pvt->ops->get_base_mask(pvt);
>> +
>> +     determine_memory_type(pvt);
>> +     edac_dbg(1, "  DIMM type: %s\n", edac_mem_types[pvt->dram_type]);
> Move that dbg call at the end of determine_memory_type().
Sure
>
>> +
>> +     determine_ecc_sym_sz(pvt);
>>
>>        return 0;
>>   }
>> @@ -3786,7 +3844,7 @@ static int init_one_instance(struct amd64_pvt *pvt)
>>
>>        setup_mci_misc_attrs(mci);
>>
>> -     if (init_csrows(mci))
>> +     if (pvt->ops->populate_csrows(mci))
>>                mci->edac_cap = EDAC_FLAG_NONE;
>>
>>        ret = -ENODEV;
>> diff --git a/drivers/edac/amd64_edac.h b/drivers/edac/amd64_edac.h
>> index 85aa820bc165..881ff6322bc9 100644
>> --- a/drivers/edac/amd64_edac.h
>> +++ b/drivers/edac/amd64_edac.h
>> @@ -467,11 +467,17 @@ struct ecc_settings {
>>    * functions and per device encoding/decoding logic.
>>    */
>>   struct low_ops {
>> -     int (*early_channel_count)      (struct amd64_pvt *pvt);
>> +     int  (*early_channel_count)     (struct amd64_pvt *pvt);
>>        void (*map_sysaddr_to_csrow)    (struct mem_ctl_info *mci, u64 sys_addr,
>>                                         struct err_info *);
>> -     int (*dbam_to_cs)               (struct amd64_pvt *pvt, u8 dct,
>> +     int  (*dbam_to_cs)              (struct amd64_pvt *pvt, u8 dct,
>>                                         unsigned cs_mode, int cs_mask_nr);
>> +     void (*prep_chip_select)        (struct amd64_pvt *pvt);
> That name should be "prep_chip_selects" - plural.
Got it.
>
>> +     void (*get_base_mask)           (struct amd64_pvt *pvt);
>> +     void (*get_misc_regs)           (struct amd64_pvt *pvt);
>> +     void (*get_mc_regs)             (struct amd64_pvt *pvt);
>> +     int  (*populate_csrows)         (struct mem_ctl_info *mci);
>> +     void (*get_umc_err_info)        (struct mce *m, struct err_info *err);
> WARNING: Unnecessary space before function pointer arguments
> #652: FILE: drivers/edac/amd64_edac.h:470:
> +       int  (*early_channel_count)     (struct amd64_pvt *pvt);
>
> WARNING: Unnecessary space before function pointer arguments
> #656: FILE: drivers/edac/amd64_edac.h:473:
> +       int  (*dbam_to_cs)              (struct amd64_pvt *pvt, u8 dct,
>
> WARNING: Unnecessary space before function pointer arguments
> #658: FILE: drivers/edac/amd64_edac.h:475:
> +       void (*prep_chip_select)        (struct amd64_pvt *pvt);
>
> WARNING: Unnecessary space before function pointer arguments
> #659: FILE: drivers/edac/amd64_edac.h:476:
> +       void (*get_base_mask)           (struct amd64_pvt *pvt);
>
> WARNING: Unnecessary space before function pointer arguments
> #660: FILE: drivers/edac/amd64_edac.h:477:
> +       void (*get_misc_regs)           (struct amd64_pvt *pvt);
>
> WARNING: Unnecessary space before function pointer arguments
> #661: FILE: drivers/edac/amd64_edac.h:478:
> +       void (*get_mc_regs)             (struct amd64_pvt *pvt);
>
> WARNING: Unnecessary space before function pointer arguments
> #662: FILE: drivers/edac/amd64_edac.h:479:
> +       int  (*populate_csrows)         (struct mem_ctl_info *mci);
>
> WARNING: Unnecessary space before function pointer arguments
> #663: FILE: drivers/edac/amd64_edac.h:480:
> +       void (*get_umc_err_info)        (struct mce *m, struct err_info *err);
>
> total: 0 errors, 8 warnings, 507 lines checked
>
>
> Please integrate scripts/checkpatch.pl into your patch creation
> workflow. Some of the warnings/errors *actually* make sense.
I have noticed these warnings. As there were previous definitions, i 
continued with similar indentation. Will address all of them.
>
> --
> Regards/Gruss,
>      Boris.
Thanks for the review.
>
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fpeople.kernel.org%2Ftglx%2Fnotes-about-netiquette&amp;data=04%7C01%7CNaveenKrishna.Chatradhi%40amd.com%7Ca162e192bf9a44cf719308d9a471f62b%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637721631674685370%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=eLKOAi8ljBkPLL04EVk4q1jTDQ1PzaNBv2Wltll%2FU24%3D&amp;reserved=0
