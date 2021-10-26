Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B30743B7B6
	for <lists+linux-edac@lfdr.de>; Tue, 26 Oct 2021 18:59:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237625AbhJZRBc (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 26 Oct 2021 13:01:32 -0400
Received: from mail-sn1anam02on2054.outbound.protection.outlook.com ([40.107.96.54]:3937
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236241AbhJZRB0 (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 26 Oct 2021 13:01:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NddR1a4jZ6mOav1pJQNbW98kMLE7Pf9y4Yn0xDARGyE3J0XskdgRVioWjmnWYtHwvxGMZdaEO0uAfUIZ9j1+pFDr/9ctIQK95rnjsiOkIbuvhSkz3/niwGl7Vl1/tuNlQxszVKJd7IRnXf1b9I2/IUd6XNWNRLODbt+1aOlldDt4/XeSaWtR6W+7LXgzuRqtLy/SaBL3jMP6gTpwRhqE4jKbtwyh1gSkvYgVKvaREhWAgavbg/WLWQ2h33ZzUAISG0mDD00LV4k8rlTjwkWu4c6oLVVvgnb6CJvbBMeJxE0BQNfKSWTLWYIvZrEtX7eQTkP5+LPW8pv4HUNZIXX7vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S1sNbRD6HzTA3y+lyTYJimWdC3JlH4LmWuF60zg2mZ4=;
 b=eoBsg0mJjmoloE7TUyZt1TiPVg4CeAStbPBz/fgwF9/Qrl/JLhwUaudhRFo4uqatV60tXzJZyvhFvBv1GuSjE8pOdFSyZIcbz8I3JMrsn9T1FEpEqhGf/nYceV35uk2ge8IKznQ7DB0JssMRkxZgyNxmn0bxXyS8ktZqN03NaiKpoDGT4zIpz3plJpt/NFSMKifEpTnpiHXFJ1AR73vCT9aJGz8/45u/msjV0IaZmviN6TB2ZP4Q+vi59/Pe3SKg8H6U6yjIa3CRQqxw0fVkzrr1tqJjmarJt08PWdTo8K7UIwLC/DgkbUhjgP9kA1sTB2koomYSaoNaQu9lQobogA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S1sNbRD6HzTA3y+lyTYJimWdC3JlH4LmWuF60zg2mZ4=;
 b=utk1Zcjy1JWUoXpdbv8LufNzqQrGqQ+H3xlnc9wz5IH3tTy0QDtq47qy8vAnIscMBCboRqq0p/91Tx4IqGdI9m3D5kORWeQsdMKj5jARbzgZbWDN6E5gVsZXptsznX5un5ky+tlAfSm5D2XX1wNxB/qAL7Lhz//q9cfUMztoFa4=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB2869.namprd12.prod.outlook.com (2603:10b6:a03:132::30)
 by BY5PR12MB3987.namprd12.prod.outlook.com (2603:10b6:a03:1a8::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.20; Tue, 26 Oct
 2021 16:59:00 +0000
Received: from BYAPR12MB2869.namprd12.prod.outlook.com
 ([fe80::758d:1b96:8338:9f86]) by BYAPR12MB2869.namprd12.prod.outlook.com
 ([fe80::758d:1b96:8338:9f86%7]) with mapi id 15.20.4628.020; Tue, 26 Oct 2021
 16:59:00 +0000
Subject: Re: [PATCH v2 2/5] x86/mce/inject: Warn the user on a not set valid
 bit in MCA_STATUS
To:     Borislav Petkov <bp@alien8.de>,
        Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Cc:     x86@kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, Tony Luck <tony.luck@intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>, yazen.ghannam@amd.com
References: <20211019233641.140275-1-Smita.KoralahalliChannabasappa@amd.com>
 <20211019233641.140275-3-Smita.KoralahalliChannabasappa@amd.com>
 <YXfSGW1i5dLsiX84@zn.tnic>
From:   "Koralahalli Channabasappa, Smita" <skoralah@amd.com>
Message-ID: <00f4a0ab-f241-6674-f37f-623f3d9a8337@amd.com>
Date:   Tue, 26 Oct 2021 11:58:58 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.1
In-Reply-To: <YXfSGW1i5dLsiX84@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: BY3PR05CA0031.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::6) To BYAPR12MB2869.namprd12.prod.outlook.com
 (2603:10b6:a03:132::30)
MIME-Version: 1.0
Received: from [IPv6:2601:647:5f00:2790:1612:d93b:ad68:c0ae] (2601:647:5f00:2790:1612:d93b:ad68:c0ae) by BY3PR05CA0031.namprd05.prod.outlook.com (2603:10b6:a03:39b::6) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.13 via Frontend Transport; Tue, 26 Oct 2021 16:58:59 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0f239f83-49ea-47e1-a2aa-08d998a1e7fe
X-MS-TrafficTypeDiagnostic: BY5PR12MB3987:
X-Microsoft-Antispam-PRVS: <BY5PR12MB3987314D7206FC79FDFA4CF490849@BY5PR12MB3987.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6rRnVPrX7pSC0iyIxO50ioLv+K7xUK4GxhPgVT2ob9xAvIjqqy4f9NUTxdTYZCasLB9kfW3U7G9VaEfAwrHMAxjDgRmWIU0OxCrRdB1IhV97vjaOcw3PVbS3HNQwQvAe50FgQUmIS3bKc/vdcasf/kQ8IoG+yej6FI7I31ETCoSnWL3qwGaTWPhJxHURzyshcI/vhEdw71jdamldCQldydqBpixY9S4aZmBHsKFMnBhJePUCKyOcrS2Dvv9c4CIJgGbOSkM7R9piKXTdt8HZc1CHS7iRTxfdlr/bwqERjPJxoMSDdCqFlouJXZyXUw46F0GUo+0X4BTPSjT6BBR7mrawmy1iWfPAhk2jbxQWg9ySJXiA98eWIXjKy0lm0y32vevyvfaB0ejBlLlZKTZEJupqauzbUID3l5ZkhMz8mzuh410TpqWxvzARHK2z81i1fCzMwSlfPpvCa65+QjAPJmeAbMgxMwwkyrai4FZokeUogwdYUhdBQ1H5OLrog1DKerAb0UfXia3Cztl9Ow+bJehUuT5bRcXQlWuAsugdSWAS7anCd6lq3qsn1ThBk+AqSHNq+kZ8fFsiFtv90mwy1I4UGKsza7POxovJBqp++6eM/I9Gten1dnUlKUzChmx3w+ieOrAdA9fluLwoAmVn91nSb0NDHCc3A7waF/6ZtwA74ZS410lO+gFVZE6CvyZTyDiZxJo4W8d7P1XJFEhdNRzNOLugqlfVH7py4cfPzGwd9TFcAdHAZUQeMrtKnkqcVy+4ldv+4qFFT7GBnQrDOB0U+21f8xp8w93tjkKG6F3f0QMdTIg90LDbBjjBve8t
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66476007)(2906002)(83380400001)(66556008)(31686004)(6636002)(316002)(54906003)(4326008)(110136005)(38100700002)(508600001)(36756003)(66946007)(186003)(6486002)(8676002)(966005)(8936002)(53546011)(5660300002)(2616005)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dEt6dEJpS2M1Zy8xdGoyVTZmZGwvNGJkemN3NVNaNnJSNTBDZkJEMmR6VnEr?=
 =?utf-8?B?eFpBZXFZNGtWU0UxZm9FUDViQ3JvQ2tWZlBRMExMSGdwSDdTNXpuZEFkc3R4?=
 =?utf-8?B?NU5NdDUxUEt3dmluU1FFaHpoOEkwNlhxNXB0S2oyV3hrV3pKQ2dJQUR4SnZv?=
 =?utf-8?B?ZHYybmxialhDYzJmc3VHZTNUSUhpcFhubE1Da2U5YStISGNoVXpsSmVlYzkz?=
 =?utf-8?B?ZUpmcUd3dmdMUm9CclN0VTVjWkcyQXBnTy84S242VWkwUU9ObEM5T0VWYktv?=
 =?utf-8?B?WmhoUjg5NnVDU3VseWtVSHZ3bEYzRUMyWHJRVFoxVk5UMzhPWE04eE5acFha?=
 =?utf-8?B?bitDbExlbFZTV2VtY2pUcUZCaG9taU5ZTGFOUEVyVkVnWlFCRU1PK0tUTVhX?=
 =?utf-8?B?c0FpcklraUIwd0NyTzVuT3hSdm83VTRVeDk5Rm5waUNOTUU5ODQvU2xlend6?=
 =?utf-8?B?Ryt6cEV0T3BmNVZ4RUJiNk0wUFBZSWZsTW1zTWhnd0ZmT2ZFUnZ4R1kzZFBo?=
 =?utf-8?B?NzA4WFF2cCtrSjhvWG1iQndhanlZV2pKM1JsUzFuZU0vckU3VmxtdTkvVWhK?=
 =?utf-8?B?OTZrTCsyNW5FTUxZUDdFNHJmWXBmaFFaOWJPTnhtdEtjK2RiaXE5Ym5qVi9H?=
 =?utf-8?B?WUdvc1ViNndJeGpUQW9NR1M1a1VHWXZCQjd1WWZkdGJWRkVsSnB6ZDJncyto?=
 =?utf-8?B?ZWdNZkR2M2VpbmcwMkVvNm9SRXhVODBoM0RNRCs1SjFNWVR0VVBDcUltejNz?=
 =?utf-8?B?M1RoRmQ1a3NpTzB6WENNUzFCVldsYUVYVjFjL1VnajFwdmVscGVWTEh1YTVI?=
 =?utf-8?B?cnlGVWl1QzlyOVB3K0JIblplWEp6YWZRL3RoR280M2kxMHdGNUo2ZHZTTUNB?=
 =?utf-8?B?cnc4SUdpZG9ETDA4VTFGbGFOTmdpd0llbEtjQUZTZ3VYK1hwS0xsSzZCUEZ3?=
 =?utf-8?B?OGlRckZLOFVzSTZZTXJCMFI5dmd0WEFrTXFjR0hYVGFkRWF0Tno2T1BlRE5E?=
 =?utf-8?B?NjhZQ3R6d1pNeGRlQ2NMV2NwR3BFdUVBYnhDV3J6K1NYUmFzaHVGVHZYN3dQ?=
 =?utf-8?B?UVZOdVYrenpRTjZUK0diL2JVOWNCN3Y5cHFEa2ZkMldLbzFRZklEenU2RW5O?=
 =?utf-8?B?clRkeWZnM1BTWEJhS2Niek5XT3dyZ05RMm5XRE13aGt1bVkwUk5aMUhpR1lw?=
 =?utf-8?B?VW9kbFNMekJqOCt6aDNPNDhKZzRxUnFrTWR4RThuNVRpMi90aFc1WU9lbnE2?=
 =?utf-8?B?cnArZzY0ZXkwMFB2WnlOWURzcStLUGR6dzJHYk5DZlE2bDJMaGpsc2NBNHF6?=
 =?utf-8?B?SklPMWcvMVI1M0huWTdtMDhta0IwTHk3VEJWMFFPUFdjeUl1Z0h0QStBUHhS?=
 =?utf-8?B?TFFzYU9BQVdVaDFYdmJDREd0NjNVUjROZHFmRU9wVzEwYTVNdjF3ajZQSFQr?=
 =?utf-8?B?cnQweVZEU2t5dm1EN0RxYVNLY1I0RDM3MTlleVhqWmg5dXRWQ3RvWHBhdzNy?=
 =?utf-8?B?VE1FV3JEY1NHVFF2Ni9pbHp4RXVmdzl3cXMwV0lHdWRSaVV3NWptTUgvN1pj?=
 =?utf-8?B?OE1mVmt0UWpjTyt0VEs0SWdNdHpUZEUveW1HdHpwODA4MkR6ZThxV2c5Z2t5?=
 =?utf-8?B?TWluQ0xubXJpN1Y0M0hlNlZpS2xiZDFva2kwcC9iWkpNeEh0aGdrOXFUNFAv?=
 =?utf-8?B?NXEyaTkyWGluc0NOczR5aStoaVZEdHFIQkJBTTc5TTMzU2YvOHdpa1FqYkZS?=
 =?utf-8?B?SzA0aE13R0tBelNhS3A3VnFaOHlXRnQ5Ly9MeWdTay82VkxhUldGS3VhTzdr?=
 =?utf-8?B?ckI0cWRkUUNXYTd1dGNNYzluRFprMzJNT0dPd2w2TkM2K3BTdjg1TkZjY1Rj?=
 =?utf-8?B?QVM1aFVmUVBpWEpjNy9HVWF1YkZRTVZ2ZTh4QTFEeVVDakR6QXN5cENia2ln?=
 =?utf-8?B?SWdYU1E0U0NwOWRjdFBoU05RWjJickNSdjZSTnoyYzJudHd0cUlWa1BGUDYx?=
 =?utf-8?B?UkRWV1lvZGtmcG9rbFMwVmd2d1BKenJCT1ZYOVkwSVVGQndCMVlpZFIvYUU5?=
 =?utf-8?B?WDFjQkxDUFBROEJBYmtGMXlKSUVYQUJBam55L3k5SHlIT0lBSDRyU2htS2pC?=
 =?utf-8?B?VmRpRGpBQ0kvZVZvd0o3bklSMGlUMDZhU0dJRytpUzNMMFovUXlPT0x3ZTY4?=
 =?utf-8?B?M3ZpQ1FoRmR2S1Nsd1Y2TUpIKythbUpoSlZaVTVyNkxjcjk0QTFKdG1yTVU4?=
 =?utf-8?Q?pb5trUscLUxSXdqK6M1ihRmyhbquotr0hdUlvA2eMk=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f239f83-49ea-47e1-a2aa-08d998a1e7fe
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2021 16:59:00.0456
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WRGGA+oQgSt5Pc6tQfiF+gtuH3317PQBPZwFmnVmEHYLxQBW/uL3nKtr5K1QDzqHK1qW01Kd4qC20U795VBO7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3987
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hi Boris,

On 10/26/21 5:02 AM, Borislav Petkov wrote:

> On Tue, Oct 19, 2021 at 06:36:38PM -0500, Smita Koralahalli wrote:
>> MCA handlers check the valid bit in each status register (MCA_STATUS[Val])
>> and will likely ignore signatures if the valid bit is not set.
>>
>> Warn the user if the valid bit is not set before doing error injection.
>>
>> Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
>> ---
>> v2:
>> 	Added a warning statement instead of setting the valid bit.
>> ---
>>   arch/x86/kernel/cpu/mce/inject.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/arch/x86/kernel/cpu/mce/inject.c b/arch/x86/kernel/cpu/mce/inject.c
>> index 601efd104bb4..a993dc3d0333 100644
>> --- a/arch/x86/kernel/cpu/mce/inject.c
>> +++ b/arch/x86/kernel/cpu/mce/inject.c
>> @@ -487,6 +487,9 @@ static void do_inject(void)
>>   
>>   	i_mce.tsc = rdtsc_ordered();
>>   
>> +	if (!(i_mce.status & MCI_STATUS_VAL))
>> +		pr_warn("Handlers might ignore signatures with Val=0 in MCA_STATUS\n");
>> +
>>   	if (i_mce.misc)
>>   		i_mce.status |= MCI_STATUS_MISCV;
>>   
>> -- 
> So what's the real reason for this?
>
> You've injected and you didn't get any feedback and were wondering why?
>
> If handlers ignore !VAL MCEs, why don't you simply set it
> unconditionally on entry to do_inject()?

Like how it was done here?
https://lkml.kernel.org/r/20210915232739.6367-3-Smita.KoralahalliChannabasappa@amd.com

Thanks,


