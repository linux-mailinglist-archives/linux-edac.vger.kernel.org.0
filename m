Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA4C6409CCB
	for <lists+linux-edac@lfdr.de>; Mon, 13 Sep 2021 21:19:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229460AbhIMTVA (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 13 Sep 2021 15:21:00 -0400
Received: from mail-bn8nam12on2048.outbound.protection.outlook.com ([40.107.237.48]:60000
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S240432AbhIMTVA (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Mon, 13 Sep 2021 15:21:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KxLcHPL8id/3LDKYUgniTmuOOqxiqA7grkwuklO8q+5DzahOz47qHpaKln1bYQP2ZCQzwnQma4cJJOgq0TGH8XiHKT0eDS3hQtGKVRAHK2kql8vBIfyFznUnsC4MN1KkwTKL6hQACbwfecTBk9HCmbDcoXdu7SjiPL1OfCG03Tyk0hKG63q4Ro9cWp2D/rFsDHnuvUFMsVtZYayr84zOBx+FOtXmlM3IxnonOXuSVMjKWrU40O0U4yiVV5RctOu8F/89domsECi1nUb0MQRAe/2i8D7GhaalW5GtemFaGSPJ5ZoyLsadamUY4aolxFfC3qnxWW89S5Qxar6ES0AdOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=Eoz+sBkzXgFKJw6MBytLZblQALvB6ZrrvnSGH13luaM=;
 b=SZp/z7N/X511yuHMyv1vwCcR2dZSfIEJj4xQjX5lQhuTrqPAOA4ay0x9N7//FYuhEH9VtjY8rY6mN1JEktSpWs140/qyyBzc0ZeJf/cKkBewRL8+rqeuJO31BP46SH6S+3LQkeWa/Y5fa6j/tEPpm8rBNzsaYAyG8ffxAtOwRF/kxYfWGR1oWlS4xgApm7DYHocuvwxx7n/+K+mEWSw/N8qBX+A7eF/XAIPFu4TxWwIVqQnoILbbq5V0ZhPmtjsCEs+02/HHzrN1NShKYA6RYJOGW6lMzv5TVdLazMtQu843sKD2mvO15Cw+WokjLja6ma7lvU2JDTvbyaQaqyTFug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Eoz+sBkzXgFKJw6MBytLZblQALvB6ZrrvnSGH13luaM=;
 b=opK4kryfxFPnxwgmGQzfM5DrWawQ2xQqqshMikhPMgCQ7ajhmu/txB/J5nLwgdN6xdYTQPpElPUj4IlUKp6zSSwPCI1nwn0PT7j2FOS77OoBXYaRl3MpZqxu/B2w5Fj21QCzjCCq8R5I091UR4bfunERozO4oAadsT0B+V0Oq9Y=
Authentication-Results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2685.namprd12.prod.outlook.com (2603:10b6:805:67::33)
 by SN1PR12MB2509.namprd12.prod.outlook.com (2603:10b6:802:29::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14; Mon, 13 Sep
 2021 19:19:41 +0000
Received: from SN6PR12MB2685.namprd12.prod.outlook.com
 ([fe80::4913:ca1c:92c3:64c]) by SN6PR12MB2685.namprd12.prod.outlook.com
 ([fe80::4913:ca1c:92c3:64c%7]) with mapi id 15.20.4500.019; Mon, 13 Sep 2021
 19:19:41 +0000
Subject: Re: [PATCH 1/2] x86/mce: Define function to extract ErrorAddr from
 MCA_ADDR
To:     Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        linux-edac@vger.kernel.org
Cc:     Tony Luck <tony.luck@intel.com>, "H . Peter Anvin" <hpa@zytor.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>,
        Muralidhara M K <muralimk@amd.com>,
        Akshay Gupta <Akshay.Gupta@amd.com>,
        Youquan Song <youquan.song@intel.com>,
        Zhen Lei <thunder.leizhen@huawei.com>
References: <20210625013341.231442-1-Smita.KoralahalliChannabasappa@amd.com>
From:   Smita Koralahalli Channabasappa <skoralah@amd.com>
Message-ID: <eb77b76f-742e-c9b5-982c-00f293a1620a@amd.com>
Date:   Mon, 13 Sep 2021 14:19:33 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.1
In-Reply-To: <20210625013341.231442-1-Smita.KoralahalliChannabasappa@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: BY3PR10CA0012.namprd10.prod.outlook.com
 (2603:10b6:a03:255::17) To SN6PR12MB2685.namprd12.prod.outlook.com
 (2603:10b6:805:67::33)
MIME-Version: 1.0
Received: from [IPv6:2601:647:5f00:2790:9266:2b85:4e53:c4f5] (2601:647:5f00:2790:9266:2b85:4e53:c4f5) by BY3PR10CA0012.namprd10.prod.outlook.com (2603:10b6:a03:255::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14 via Frontend Transport; Mon, 13 Sep 2021 19:19:39 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: adac89c8-5c21-48df-c504-08d976eb6f41
X-MS-TrafficTypeDiagnostic: SN1PR12MB2509:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN1PR12MB2509CEC9131DA0943254099190D99@SN1PR12MB2509.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YG9xGsJFM4lAoPsQdBdorE2wjb3rmvOavxNr164L7FR4PMZUBrqYQMlhsZ5sycYpXSX1BqJsOL63j94xAM4KbS6mersv2K9sLNhedMezlsUoQQqNEXpujuXl6JML3sSzueTB3fD1WjI4Di/pxfl7N/P+/oY+KDZy/e9D0FqOJVhObllpf5zt+k+QfIiZytZIODg+Xo/8DzMDM0E5+tZrJnfHaLjsVrJ7dxST2+OzzqSxSIZMlFuXp+uCyqM338ona970NhxY+sVBf+lfPv+6VE6Jua+gWqQk+Zj+mO6sQ4Pv0GVaW6mvf1IYVPL6A0m5YrgXSm81jfmVRShXvRTzl1JAjYF+CqmOFMwyeN4hWld87CQDhQcbz+Wh9nTEv8HOULWo/KCMYEwBcH8t6zQ3eT02MRHTCEcAn2Lz/g+lMk1hKXBpZ25hld//y2A9BbRinm6+WzMapgpegUDc1ZQM1D4qzJriJHf8vbrEBehv+PG9dDM68gAFuY306zz5gZhG8wGCVOW+3r1V5hsE3FpSvyaCa5JEMzd6nRzwmn1ww2M5xhMuqqJcKCDCXAzEuJEd1h33gIEx66cUoMP4qnHDfqtBLsNRaMWRv3w43PrAYLI9ulng4waeOu0J44r/G0AtyJ2ykv62vtmS9hpZU9ei7qXbu5W4DT7/N0TlnGdAAq4vwKCIKp2uGxgQIv7rLm0t/CAs6RCL+5aF47woiPY/87Lg/r2O1IG5WjV+Xd6IJeQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2685.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8936002)(31686004)(2906002)(54906003)(66556008)(4326008)(38100700002)(6666004)(31696002)(316002)(508600001)(66946007)(66476007)(83380400001)(8676002)(186003)(5660300002)(52116002)(53546011)(6486002)(2616005)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bndSaU5DVFY3M0hYMHBZQzJ1WkIxcWVFYnNUd0xRbFh2L1UybnEwelJVaHlK?=
 =?utf-8?B?RDRVc2RabWdFT3FjVGQ2QzFJdjZvM25BV0tOdWkxaVRsWTErS2k2YVB0a2FU?=
 =?utf-8?B?SFdLZDF5eE9TYjBTbnRoNFBFTUJiSlRoZzhPTzNmSk50aHBzTlBKb2U3d0JW?=
 =?utf-8?B?OUpLWUVOaVZXOURnWmlwUFI4czVYd0NCbFp5aHNpc2xRQWkrd1pnRFpCSGM0?=
 =?utf-8?B?WlV2b25majcrTUFYV1ZyOE5CRk1oblE3QUwrN0NpTnFzcTMrSmJqWllvZGl2?=
 =?utf-8?B?ejJKTnJFbWxGSmI0dGl3TGJRWW9pR0pFWjQrQ01EOTNYN3JiSldBbEExckpU?=
 =?utf-8?B?bGFqZEwzc216U2I3SFVTZlc4VnV4V1U0SHRLTmFBVG0yVUdNZkxrT1VBVmx2?=
 =?utf-8?B?dkorNWZPdFFVcFRod0NGMTluRzJnVERmWUd4ZzcxSHdSR21NelJhbmthaW12?=
 =?utf-8?B?b3k5WVRVU3dzb2x1UXlqd3FONy8wOEZ6VmVkaXlvNUZPWWl2bTNDODlKcml6?=
 =?utf-8?B?aTd0MFdXL3EvWUFMYUVLWlFXZVgxSnFVUnN2YWZ4M2tiK1hxUW9ZTWxZRWFR?=
 =?utf-8?B?eE9LSGM1VEFERkh6cHpUOFZ0NDRkTGZvWjJhY2hWdnREU3o0eloyUHJpWnlG?=
 =?utf-8?B?Q2hYUDB0OExCajM4UHNaUGdoZjFTVFlBdmFPZE1zQ3ZvcVpuTVRqaVdZNU13?=
 =?utf-8?B?OTc2ZHEzV01NNjJENEpZL0dhWUlXOC82VURhTHpXOE9iOHRtRXNWdFBoWG1m?=
 =?utf-8?B?UTM2MHIvN0tKUkZFQmlBNXNTRnozWkcvTjdxNXFrTnAyZ0phTE40RUpaMzhj?=
 =?utf-8?B?YndjZEdZYjZZa2xORlhaQXlyaHlobTBEK0NSaDZON2YyS3JQd0phS2RmbmJm?=
 =?utf-8?B?eDlNRW81UldYeFpLMk5YSlVTOVBrcWxtaDhJRmZkRnlyU2Q0VlBlWXpVbU5D?=
 =?utf-8?B?ZEY3QkloR3JpcCsvRTd0aFZmbm5VS3pGK2RIbGtTdlFkRHEwZmVEZTQ1emxP?=
 =?utf-8?B?TmlId1VVY0hXOGRIYndhcG44c1AxV0tHSklmbEVWclVTT3d5akpsZjNRdER4?=
 =?utf-8?B?eE15M25VeVRQYjlqRlY5dHVmSG9sTGRGeUdMaEYwTFQxY3VuZVhsd04wNTl5?=
 =?utf-8?B?UHJMMHJhcG44UXd6UStlYkgzT0dXM1N0eUVtMFRWT2xoSUhNNUdZNWE4NTFE?=
 =?utf-8?B?QWtqV0NDVVlSUlhIR1dGMzhMNGwwNGdnMEo1YkhMZm5LOVM3QzdqR0FLdngz?=
 =?utf-8?B?b1VxWi81M0ZsSEthaHltdkJRQjRwcVhlaHU5S0o2Z3VoZnV2YjJsbEFOUTJh?=
 =?utf-8?B?b2V3MGp3SkpMbzh0dlhVZ1loaWtZTVd0YVNTVWlqOE5RbXhrWVl3ZFN3SGlx?=
 =?utf-8?B?bGc4aXJzUFYyV2lSN0JtTllLeTBBbmhRaHFCbTZSZDRiZmNIZVl3QUV6R3JY?=
 =?utf-8?B?YjhuYlFnbkJrUFNZTXI4NWtrK1VMUFNWNWg4MnhCUXVnd3QzTEk4MGpNN01O?=
 =?utf-8?B?QWFWS1A0YXdBYWgyb0Z1a05KNE5IYytBU0hpZzRieTBjdkZFN2o3ZFhyeXFo?=
 =?utf-8?B?SU1zdXRHbGlnQmJFU1FYUVpMTEpxWGlmakJJT2hMQzg5b2dnZHl1TWtiMkpF?=
 =?utf-8?B?eFhqaHNmU0lMYW5XZ3JQVHBrUGdkdHdmSEVRcXFLQU92TUpmM041MzdKRmJW?=
 =?utf-8?B?TDlZNnY5eDk2cXpBQTFDM0RwOG1uNjRndzlHemNqNGVxeEhXTEhzUlJMajJF?=
 =?utf-8?B?ZFRUTkdyOW1ndGlNa2JGL3pibFUybitWWlNGSFZPeUtVOGM2WXlhaHRPd2VO?=
 =?utf-8?B?aWpvZHNWYzdTUHppaFBZR3lQamcvdUl4cVlVZzEzdlNJazlvTEVVaGU2cld3?=
 =?utf-8?Q?/3UTEysd8Ydfg?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: adac89c8-5c21-48df-c504-08d976eb6f41
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2021 19:19:40.7877
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gHzlqiimTwh+iDrIflhTfq5szffg5FLwd8Pgic00p7P6IEw8DLAfNaVX4Xl+elFJtqlttZ+zdMAEcJdXD0JRQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2509
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hi all,

Do you have any other comments which I need to address on these set of patches?

On 6/24/21 8:33 PM, Smita Koralahalli wrote:

> Move MCA_ADDR[ErrorAddr] extraction into a separate helper function. This
> will be further refactored in the next patch.
>
> Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
> ---
> v2:
> 	- No change.
> ---
>   arch/x86/include/asm/mce.h     |  2 ++
>   arch/x86/kernel/cpu/mce/amd.c  | 14 +++++++++-----
>   arch/x86/kernel/cpu/mce/core.c |  7 ++-----
>   3 files changed, 13 insertions(+), 10 deletions(-)
>
> diff --git a/arch/x86/include/asm/mce.h b/arch/x86/include/asm/mce.h
> index 0607ec4f5091..0a1c7224a582 100644
> --- a/arch/x86/include/asm/mce.h
> +++ b/arch/x86/include/asm/mce.h
> @@ -357,6 +357,7 @@ extern int mce_threshold_remove_device(unsigned int cpu);
>   
>   void mce_amd_feature_init(struct cpuinfo_x86 *c);
>   int umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, u64 *sys_addr);
> +void smca_extract_err_addr(struct mce *m);
>   
>   #else
>   
> @@ -366,6 +367,7 @@ static inline bool amd_mce_is_memory_error(struct mce *m)		{ return false; };
>   static inline void mce_amd_feature_init(struct cpuinfo_x86 *c)		{ }
>   static inline int
>   umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, u64 *sys_addr)	{ return -EINVAL; };
> +static inline void smca_extract_err_addr(struct mce *m)			{ }
>   #endif
>   
>   static inline void mce_hygon_feature_init(struct cpuinfo_x86 *c)	{ return mce_amd_feature_init(c); }
> diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
> index 08831acc1d03..f71435e53cdb 100644
> --- a/arch/x86/kernel/cpu/mce/amd.c
> +++ b/arch/x86/kernel/cpu/mce/amd.c
> @@ -899,6 +899,13 @@ bool amd_mce_is_memory_error(struct mce *m)
>   	return m->bank == 4 && xec == 0x8;
>   }
>   
> +void smca_extract_err_addr(struct mce *m)
> +{
> +	u8 lsb = (m->addr >> 56) & 0x3f;
> +
> +	m->addr &= GENMASK_ULL(55, lsb);
> +}
> +
>   static void __log_error(unsigned int bank, u64 status, u64 addr, u64 misc)
>   {
>   	struct mce m;
> @@ -917,11 +924,8 @@ static void __log_error(unsigned int bank, u64 status, u64 addr, u64 misc)
>   		 * Extract [55:<lsb>] where lsb is the least significant
>   		 * *valid* bit of the address bits.
>   		 */
> -		if (mce_flags.smca) {
> -			u8 lsb = (m.addr >> 56) & 0x3f;
> -
> -			m.addr &= GENMASK_ULL(55, lsb);
> -		}
> +		if (mce_flags.smca)
> +			smca_extract_err_addr(&m);
>   	}
>   
>   	if (mce_flags.smca) {
> diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
> index bf7fe87a7e88..2c09c1eec50a 100644
> --- a/arch/x86/kernel/cpu/mce/core.c
> +++ b/arch/x86/kernel/cpu/mce/core.c
> @@ -703,11 +703,8 @@ static void mce_read_aux(struct mce *m, int i)
>   		 * Extract [55:<lsb>] where lsb is the least significant
>   		 * *valid* bit of the address bits.
>   		 */
> -		if (mce_flags.smca) {
> -			u8 lsb = (m->addr >> 56) & 0x3f;
> -
> -			m->addr &= GENMASK_ULL(55, lsb);
> -		}
> +		if (mce_flags.smca)
> +			smca_extract_err_addr(m);
>   	}
>   
>   	if (mce_flags.smca) {
