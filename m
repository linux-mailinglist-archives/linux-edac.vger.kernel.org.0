Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97991439D25
	for <lists+linux-edac@lfdr.de>; Mon, 25 Oct 2021 19:10:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234459AbhJYRM0 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 25 Oct 2021 13:12:26 -0400
Received: from mail-dm6nam11on2054.outbound.protection.outlook.com ([40.107.223.54]:2144
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234859AbhJYRLo (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Mon, 25 Oct 2021 13:11:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SRWjpRvuQH6fdKLZrLko+myPY1NYQUlcihfnHQ2StyktbFcU+QpzzAEL9V0hablR+tVq4lNDYddR12CSz6s7O1N1veDuVCRVzad07rIyo7gaatC4fuTQxf83gXX7YXydRXFC5/fwRNiF4DY9AVpcXTvdTW72HjObIH2olJF2ZKNbz5xmJct+GMbVPzlkdKd9SBeccX+orZTsHY5yYtjNvlEvEyd9KQrlssJiODs7SvnqO2ra4xNyS4VZoH3ZyleviSRNgMhx3VqKPAF0H/uzBisfJucg3u/TwtHnMHlsxR49PKHDfzwMHVp+DMDwhvwwhuz6IPJStz/wK8z+ZkygqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rltV4zzc940HWbtcmA4Ggf5+2AXWZKQe94RFm391GOg=;
 b=A1Bp22kX0D3HMcWvZZf6UuK2Qiw/ht5vWenagCHnve6nWHISXKXcmOzTUGYW+/sZNVTTW+HKjzi8IvjfK4dqezd+wBZK6Lcf7qP7UbjANYfh6C3r9wZaGMnT56oTsVTZI1G3ioywjADXyzV34Nl4+5iFZw6C85x/GJRg6qexS/2Jh8utSV1Jyru85g7fqNgPrfU2bOWKIrWOVq2LsxThJ5x0u+pk7/PVI0TWEVZCZBDgi3VwsqsXVmfR2xvx6sbEP2vTWxj9w7ajgvKq9U/C89yovFp1jar5Y5j8nrbVVE0dVWcZueIyv+XIYP9bMJBfoI6tGtGr4dTvLZDqDAjArw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rltV4zzc940HWbtcmA4Ggf5+2AXWZKQe94RFm391GOg=;
 b=kKnG/dx6jlvJnZL25NCTPVWML3u21SfKR9U6yT5xsKRouwSjG71kMhEyWbLHNYft2WwilqjVVc2RgG2tnbQYy8zemgvd+fnkxpQowYCyIlBRzHsNFPvXbTEIUaEkr5R5DKqiYbQSm60NKQqcOD5WH3UzoTiZSsHl2x18+7JOpWk=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB2869.namprd12.prod.outlook.com (2603:10b6:a03:132::30)
 by BY5PR12MB4917.namprd12.prod.outlook.com (2603:10b6:a03:1d1::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.16; Mon, 25 Oct
 2021 17:09:18 +0000
Received: from BYAPR12MB2869.namprd12.prod.outlook.com
 ([fe80::758d:1b96:8338:9f86]) by BYAPR12MB2869.namprd12.prod.outlook.com
 ([fe80::758d:1b96:8338:9f86%7]) with mapi id 15.20.4628.020; Mon, 25 Oct 2021
 17:09:18 +0000
Subject: Re: [PATCH v2 1/5] x86/mce/inject: Check if a bank is unpopulated
 before error injection
To:     Borislav Petkov <bp@alien8.de>,
        Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Cc:     x86@kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, Tony Luck <tony.luck@intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>, yazen.ghannam@amd.com
References: <20211019233641.140275-1-Smita.KoralahalliChannabasappa@amd.com>
 <20211019233641.140275-2-Smita.KoralahalliChannabasappa@amd.com>
 <YXa3m7SWAhRcFi35@zn.tnic>
From:   "Koralahalli Channabasappa, Smita" <skoralah@amd.com>
Message-ID: <234133bc-e90a-e4e7-b128-017d61005603@amd.com>
Date:   Mon, 25 Oct 2021 12:09:16 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.1
In-Reply-To: <YXa3m7SWAhRcFi35@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: SJ0PR13CA0091.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::6) To BYAPR12MB2869.namprd12.prod.outlook.com
 (2603:10b6:a03:132::30)
MIME-Version: 1.0
Received: from [IPv6:2601:647:5f00:2790:3c8e:6a47:b510:670] (2601:647:5f00:2790:3c8e:6a47:b510:670) by SJ0PR13CA0091.namprd13.prod.outlook.com (2603:10b6:a03:2c5::6) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.12 via Frontend Transport; Mon, 25 Oct 2021 17:09:17 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 50b52470-6a4c-4bcc-8c84-08d997da2e36
X-MS-TrafficTypeDiagnostic: BY5PR12MB4917:
X-Microsoft-Antispam-PRVS: <BY5PR12MB491702D5002FBCB1235DA05D90839@BY5PR12MB4917.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 29/6vDwJlZWNipTrhLQ7PHnRe/wuB6LGFT2iq7WmaDBmBGUacCzd+QubNs6ZUU4/LFR7ffNV/j1r705LRyJ2BB3Fw9JFFYe7hKsvwWF49qLjF7DEzd+aL+7RWl6d4lMYH1l5fa1iNu+OE2Q1irDm99l1606cauSgynk+Zl+gm8FcbhkOgyLC1lKO7mSXLfyHCZt2HlGBlX/9lLGUFdr1uJZEz889Fq47dKdBglP6B/yCweQaxGJ6pHhzln2SB/XiNd5gQUEMcspnefWHxh47U7OrNPlF9nw7rHWp/7KC/8l10ZKtLrdPVhdMzmP4DEpfX3zwQikZCmqD7NZKxCvF7t/ERV0GgjVHgjP9BFczCFnvp+3j/o/mHulmZ8WsIDPHD+gb4dvU6C7i5zh4gzxpO6n6wgrxrAbBjbO6HhUCTwyVma3bUItRrg9Mmb3RS1ThX0zKESL5BG2l8R+zbWibmYNeDiOn8wcOoblCPxkBoadEdwmL9BNJarktZN0MuaVy57yr88GwgH4b/PAD0mj4Vp+Ztis7q/OAXYQYYTtMPol91Vj9UhhlvAtMa8Ezrt2RPRfgcJGX3RsKsFvhTYJbT2KHdkdUk9xdT9Zo/F9AXy7zLxNIPY4Ds5G9NqK4Akq0jmT1XcOFmnN9Rq1vBD6cgm1Nj8pTk5lpT69LqTR2vIhbKru1ZAh/qAuYJQnlU2bIXlr7oZudWMe03v23P4NCWFbcQ24IlqAGEZDuw4krf4yDFDJkHbOzZrJJxfLXfQsea/JsKys+WdnxRwUpg0G4N/iO0M7h67YxYRgFPO/k6zR/ld/padBqEsO0cqgxpwNp
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(2906002)(53546011)(15650500001)(31696002)(8936002)(6636002)(4326008)(6486002)(45080400002)(83380400001)(316002)(2616005)(5660300002)(54906003)(8676002)(38100700002)(966005)(508600001)(110136005)(66946007)(66556008)(66476007)(186003)(31686004)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eDRweEloNDNUTWRaS0xMTWthV21CdS9nQUVqRUt6VHUyU3VsVDl1RDVvcC9J?=
 =?utf-8?B?OXY1eWlkdGVuZC9NakptdFVUSUhFN2RldnArVUhNS2pabTFHU0xDMFdZNXpE?=
 =?utf-8?B?YkZFa3NTMlE0Y0h0MjJ3SmNNdDZPZWhDRWJiYU5RV1paVnFCb3FiVEV5NDZv?=
 =?utf-8?B?ejVVZkxNMU5tTHk4emxzT0l6bUxxWkVSbnNJVWhTNllVWTNPQUR5RVNUc1Fx?=
 =?utf-8?B?bWdoZWtScmtWM1hGR1Nwd09IdDI5c2Znem9jbzMwdE9Vc09HQnh1Q01OelJO?=
 =?utf-8?B?clRVVk4yOTVrODBzNUdEMFptaVJuUVF2RmMvelNGd1pIVm9nNk95Nm9LNWFt?=
 =?utf-8?B?NzNmbXh5b2xLUmZWNTBvSzNTYmxheDJIamh1Y1hERW9rSHVOeU5LUFdvSElX?=
 =?utf-8?B?MDJkTWQ5Qk9RdmdnUHFHbllZTGxnNmpiOS9FeWJLM0ZyZDFzV2RqN3YxS3Y5?=
 =?utf-8?B?QkZ2dE5zSVNTcm0wcmZFUFlKV2lNN1kxb2NDU1F0RXNLaEFSNURUeGFYMWxy?=
 =?utf-8?B?Z0Zoc3lzV3NVblEwbHltMkZ0YUhsQnduekRXYWpaZHJzaEpzK0tEZDdSWlVN?=
 =?utf-8?B?YUtrV0E4TFArMldTWW5iYnNLVTFGN0x4aXNwcVQ4U1JLYVU2U0xpcWw5ZmVL?=
 =?utf-8?B?WS9hRHM2aXBMZTdsZU5LcFJ6SFlCajU1ZjlxaTFTRE44NS91QmZsY2tvRW5w?=
 =?utf-8?B?MDY4N2puNCtkVFZuNXVjLzAxa1pDMVNVd2R2VWo0dGpQZ0FEa0g5Z2ZyRXFC?=
 =?utf-8?B?WGxDdCtKcWRiU1lKL1JrVE1RNDZIbTBRRWEvUWdZRC95dGVQZzZhNDVYNDYx?=
 =?utf-8?B?VXFnRmdFZGF1V2J1SGF6RVhpRFZoNUphTHUvTW44eEU0R3FzT2VnM1JVRldH?=
 =?utf-8?B?ekRVdDJqbEttNitndUR1VDBPSnJmcHh1L1pjTGRwUmUrcWQ5bGxLeDR6OUFi?=
 =?utf-8?B?VDFtOFV0Ujd3VXFHQWFiVzg4elhNMHJucG84Qk1TdVhod1V0aVZQTVFJbiti?=
 =?utf-8?B?dFMvM0k0a3BDakp1WUNQL1NsNDN4SmEvNVZBVVM1cms1WDJmRU5nWXpIOTNj?=
 =?utf-8?B?R3JIdUNBLzhTY3hEalVpM3VUL2hianhQRGE0Q0dmcCtJRndNdmdvcWtpRkdq?=
 =?utf-8?B?OTJmQnlHa3lZZjNxYkZvZERaYmROSHcvWGdZS0FJejdxejN4MSttR014ZlNy?=
 =?utf-8?B?OENSUFFLa1ZGbDU1WlJydHRObUQ3TEI2T2xscUFRVHpVUit4SWo4akhqY2RJ?=
 =?utf-8?B?bENvclJZQjI3Q3FFU25FeS9hWHJiaGI3ZHp4c3ltQnNEK3Z5ditUbEVJSm10?=
 =?utf-8?B?aXVwUUZ0R3krN2R2bDRUZkZXK1VKUkdueVRpZ204VStOby8wc2h5YTNTV0F0?=
 =?utf-8?B?dHRHYUZBeG51YjF0anJhVjcyTHBnUVJIYVkrVHZBYnMyTWhYWWN2d3JkbUxF?=
 =?utf-8?B?QzEyYWYrTVR0MXZsWG5tODVzbEJMTHpXRFJndXlzSENmTmpvQlRHQ2hVR0Jn?=
 =?utf-8?B?bnVGSFRRTTN1L3pJazBrMytrRmtabTdBejFRQ2g1VlFDWHJLTmZiWFVBSVRY?=
 =?utf-8?B?cHNKZlVnY1NMVm82eGpLM202M0xFY0Y4MFM0YTMyZURHRW1xTCs3aWh4Tkc1?=
 =?utf-8?B?QlNmdHlscXVrb1VhZjFYZko5K05sNVhXUHFVWTNGTHhvWWZLWGhYSldrdFF6?=
 =?utf-8?B?RWVyb0s2UVJLL1Bxd3k3L05pcmh3Snd4OVMzR1VORnkyRjB3SHdIYnN2bE9k?=
 =?utf-8?B?OWthVHV6YTNSMEo4cG9pdFRjYW5uTXZrenFLOGt5ckVhYnZTdmVrZW9IM3Nk?=
 =?utf-8?B?ZGdMZW1LdDFJRzFBL3lobEhKNU1XYjdhQ0V0L0tMR0doZWlVZEU2SjJsNFJ6?=
 =?utf-8?B?NUhWa1BEN0FiYmtINzZKdE84YkxSZnpUaUQydG1PVUJLbE5vZnd1RXlSY3Zr?=
 =?utf-8?B?UDhOdmJQUkZYZzVsWGhmVE5ZMXVzTFF0MVRvdnJpVDFzeXBhZ1FRQWZCS25m?=
 =?utf-8?B?emVYSldCZ1pnWnVRaUhoZ3c4RGk4ZjZWM0kxY3ZtR3pTajBkN2VrMno5bWhj?=
 =?utf-8?B?Y0YxVFVOZGdKTi9BWEpEc2ZPSUNvM2d5ekVFN0xyWk00TGZkaWpJTXUvQm9K?=
 =?utf-8?B?aTlhd09hY0hzSUVPK1RKaGR0SlEzMDBCb2pweUtGcFFISFlYZW8vbC9TWUdT?=
 =?utf-8?B?WkVYaUNiZnZjRkFRTGRzNHRxc0FMV1IyWE51RlhvSHVCQjdVem55aDkwNnN5?=
 =?utf-8?Q?J0u63wCZcwgi4oRBoj2woPYBjjE/K/TqP4P5jcixcU=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50b52470-6a4c-4bcc-8c84-08d997da2e36
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2021 17:09:18.5876
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OWlcvk3yp50m9DHnhDzvTnnIBZA8r17TbB5ET2QsG6/BnMVQSKG8/mZD6qK3wIxqG113g1Rgi/fsK5pEbXqqUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4917
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On 10/25/21 8:56 AM, Borislav Petkov wrote:
> On Tue, Oct 19, 2021 at 06:36:37PM -0500, Smita Koralahalli wrote:
>> The MCA_IPID register uniquely identifies a bank's type on Scalable MCA
>> (SMCA) systems. When an MCA bank is not populated, the MCA_IPID register
>> will read as zero and writes to it will be ignored.
>>
>> On a "hw" error injection check the value of this register before trying
>> to inject the error.
>>
>> Do not impose any limitation on a "sw" injection and allow the user to
>> test out all the decoding paths without relying on the available hardware,
>> as its purpose is to just test the code.
>>
>> Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
>> ---
>> v2:
>> 	simulate -> inject.
>> 	Corrected according to kernel commenting style.
>> 	boot_cpu_has() -> cpu_feature_enabled().
>> 	Error simulation not possible: Bank %llu unpopulated ->
>> 	Cannot set IPID - bank %llu unpopulated.
>> 	Used user provided IPID value on sw injection without checking
>> 	underlying hardware and defined it under inj_ipid_set().
>> ---
>>   arch/x86/kernel/cpu/mce/inject.c | 39 +++++++++++++++++++++++++++++---
>>   1 file changed, 36 insertions(+), 3 deletions(-)
> So I gave it a critical look and did some modifications, see below.
> Looking at those IPID MSRs - they're all read-only, which means for !sw
> injection, all the module can do is check whether they're 0 - and fail
> injection in that case - and do the injection otherwise.
>
> Ok?

Yes, this looks more clearer. Thank you.

>
> ---
> From: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
> Date: Tue, 19 Oct 2021 18:36:37 -0500
> Subject: [PATCH] x86/mce/inject: Check if a bank is populated before error
>   injection
>
> The MCA_IPID register uniquely identifies a bank's type on Scalable MCA
> (SMCA) systems. When an MCA bank is not populated, the MCA_IPID register
> will read as zero and writes to it will be ignored.
>
> On a hw-type error injection (injection which writes the actual MCA
> registers in an attempt to cause a real MCE) check the value of this
> register before trying to inject the error.
>
> Do not impose any limitation on a sw-type injection (software-only
> injection) and allow the user to test out all the decoding paths without
> relying on the available hardware, as its purpose is to just test the
> code.
>
>   [ bp: Heavily massage. ]
>
> Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
> Signed-off-by: Borislav Petkov <bp@suse.de>
> Link: https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flkml.kernel.org%2Fr%2F20211019233641.140275-2-Smita.KoralahalliChannabasappa%40amd.com&amp;data=04%7C01%7CSmita.KoralahalliChannabasappa%40amd.com%7C6da4cbaab660413d27a208d997bf48f1%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637707670099990329%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=Jpecn9lg2XxdqhbLpMIxuSh%2BRA3eafMReXmdLI3SkfM%3D&amp;reserved=0
> ---
>   arch/x86/kernel/cpu/mce/inject.c | 42 +++++++++++++++++++++++++++++++-
>   1 file changed, 41 insertions(+), 1 deletion(-)
>
> diff --git a/arch/x86/kernel/cpu/mce/inject.c b/arch/x86/kernel/cpu/mce/inject.c
> index 0bfc14041bbb..3333ae7886bd 100644
> --- a/arch/x86/kernel/cpu/mce/inject.c
> +++ b/arch/x86/kernel/cpu/mce/inject.c
> @@ -74,7 +74,6 @@ MCE_INJECT_SET(status);
>   MCE_INJECT_SET(misc);
>   MCE_INJECT_SET(addr);
>   MCE_INJECT_SET(synd);
> -MCE_INJECT_SET(ipid);
>   
>   #define MCE_INJECT_GET(reg)						\
>   static int inj_##reg##_get(void *data, u64 *val)			\
> @@ -95,6 +94,20 @@ DEFINE_SIMPLE_ATTRIBUTE(status_fops, inj_status_get, inj_status_set, "%llx\n");
>   DEFINE_SIMPLE_ATTRIBUTE(misc_fops, inj_misc_get, inj_misc_set, "%llx\n");
>   DEFINE_SIMPLE_ATTRIBUTE(addr_fops, inj_addr_get, inj_addr_set, "%llx\n");
>   DEFINE_SIMPLE_ATTRIBUTE(synd_fops, inj_synd_get, inj_synd_set, "%llx\n");
> +
> +/* Use the user provided IPID value on a sw injection. */
> +static int inj_ipid_set(void *data, u64 val)
> +{
> +	struct mce *m = (struct mce *)data;
> +
> +	if (cpu_feature_enabled(X86_FEATURE_SMCA)) {
> +		if (inj_type == SW_INJ)
> +			m->ipid = val;
> +	}
> +
> +	return 0;
> +}
> +
>   DEFINE_SIMPLE_ATTRIBUTE(ipid_fops, inj_ipid_get, inj_ipid_set, "%llx\n");
>   
>   static void setup_inj_struct(struct mce *m)
> @@ -577,6 +590,33 @@ static int inj_bank_set(void *data, u64 val)
>   	}
>   
>   	m->bank = val;
> +
> +	/*
> +	 * sw-only injection allows to write arbitrary values into the MCA registers
> +	 * because it tests only the decoding paths.
> +	 */
> +	if (inj_type == SW_INJ)
> +		goto inject;
> +
> +	/*
> +	 * Read IPID value to determine if a bank is populated on the target
> +	 * CPU.
> +	 */
> +	if (cpu_feature_enabled(X86_FEATURE_SMCA)) {
> +		u64 ipid;
> +
> +		if (rdmsrl_on_cpu(m->extcpu, MSR_AMD64_SMCA_MCx_IPID(val), &ipid)) {
> +			pr_err("Error reading IPID on CPU%d\n", m->extcpu);
> +			return -EINVAL;
> +		}
> +
> +		if (!ipid) {
> +			pr_err("Cannot inject into bank %llu - it is unpopulated\n", val);
> +			return -ENODEV;
> +		}
> +	}
> +
> +inject:
>   	do_inject();
>   
>   	/* Reset injection struct */


