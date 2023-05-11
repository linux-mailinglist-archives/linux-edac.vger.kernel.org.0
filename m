Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A922E6FF20C
	for <lists+linux-edac@lfdr.de>; Thu, 11 May 2023 15:02:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237628AbjEKNC0 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 11 May 2023 09:02:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237508AbjEKNCY (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 11 May 2023 09:02:24 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2051.outbound.protection.outlook.com [40.107.243.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6B9B1BFF
        for <linux-edac@vger.kernel.org>; Thu, 11 May 2023 06:02:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VnPstyGxpnvA1+UMUfzhEtLQ+HATsrZnY7DMcHwkM4z35gEzGmmfx7sxmGI6SBc/Ws+kd/AIN+MoM5q+u8RQ5sl1TTwxh0gy7txGjwh4tQ0lXXK3uAGBc5zHWjt4bewlfTv03q4o0hOiKuo+j63otUvzocPn94zaBOIxpqrR4Rs1Wcka3CS8JqmOMpupVZ8lZs+x8pnRj3fM7RFdmpNkuGtiRqCdqrHzTQTzDB95tltc102dCsUqMWrGv0Ktb2sLUoA1EwTisxHWhpfCyO2dSi1So0v6jL3R7fn2kVDQSMMWtLVPryKn3Qkv6Lu/WDRkfHq+uhF2fCKWjRTV8haFgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WKdqhrrcpH7rA8cfR2wSIoUQC6epLR3dpfGFnKYO5iw=;
 b=REvfw7HlPUAng/c/IEK0dY7uA3XTaVAQ6LfFNSczFSctB8h7W2QuaW9FERUWvt6Z8we4T5tafxQvsh9ZKsM1oP59Fn8MWsmA/ECJI92wkRGvDv0V8qeBFDe20IhFJJ/dts78V4LL84bWzl9fFOVyxxogeVEvV+2RXQ4bhpvk8rQkKvtr/90XCJc7rYvE/q8NahQDiMJFns0LtOXVcPfY3bmR7MwhrMNmW4hGV1+mCOADGyLYed8rwdlxuU2NuKi+52BDmPeVjO8sQvv/0eA6RpkzPAx2lxi2Z6PNY4AQY/Fh+jYlOUJxScvoGbD6Hzq9RbaUjjlDPshnaxTpJ1nD2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WKdqhrrcpH7rA8cfR2wSIoUQC6epLR3dpfGFnKYO5iw=;
 b=1KgtbLp7XcLIUoKkkqi2BSMqBAzT/9NGzrmXD0pRRBixuG7mLuZZnkMqkaG0ZhPxuh1ZZl4CiyIBblfrOscToSYjl3Cp8fxPkee/R36T2V6CL9qCiuNorXyOAnftW/ZUlrigbe4ajcnD49H4kIRwDRuXE2VYxJ4FyNCw8ivun0Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by SJ0PR12MB5635.namprd12.prod.outlook.com (2603:10b6:a03:42a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.22; Thu, 11 May
 2023 13:02:21 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::b911:e5f7:65a1:5ea2]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::b911:e5f7:65a1:5ea2%5]) with mapi id 15.20.6363.033; Thu, 11 May 2023
 13:02:21 +0000
Message-ID: <d619252e-35c7-814b-acdb-74714619d62a@amd.com>
Date:   Thu, 11 May 2023 09:02:19 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Cc:     yazen.ghannam@amd.com, Borislav Petkov <bp@alien8.de>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
Subject: Re: [PATCH] EDAC/amd64: Add support for ECC on family 19h model
 60h-6Fh
To:     "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        Hristo Venev <hristo@venev.name>
References: <20230425201239.324476-1-hristo@venev.name>
 <1391171a-8f44-03bd-5e92-b98d2044b463@amd.com>
 <MN0PR12MB61014E91B98C620E5181BA71E2779@MN0PR12MB6101.namprd12.prod.outlook.com>
Content-Language: en-US
From:   Yazen Ghannam <yazen.ghannam@amd.com>
In-Reply-To: <MN0PR12MB61014E91B98C620E5181BA71E2779@MN0PR12MB6101.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9PR03CA0649.namprd03.prod.outlook.com
 (2603:10b6:408:13b::24) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3108:EE_|SJ0PR12MB5635:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ef91c40-c6f3-48c5-f16d-08db521ff516
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nlWnVgeZ9QNLFlobj9Kavb4dRUWyyAhfDP2RvXgtjt/5VfktOiij2uUOq7Rx0Ec+6cf6TnhtRUq6CAXZb4H8EUGyh/EYFrCy6LjJ+7ldhNKtGUSOMCGqdaI/mC7ehfhRvIXJeO8PZfm/MD4MC2wyLn5q9yAblGATAbm/WSpz9H2qstd0y0HoPlTytDC5876ts6n+YG40KiU4i0sG8PxwSQjK8ErOfKGYv674rHW4mbd+5l23QTauoncV0ygvGSaJnFp9+NFAQkuzrt0OwqWey2L5GI8A3Ooc9FtduBA9XPxf4VneucOi6YI4MqHMSxcDPPi+t8TShC3827rpbYdBmqYOODO0vYRfr8ophx/mPkHhuqInq1zURwruMvm0Sj1aJ61K7VWY+WwbuZbRdvsVVNYPPbJs3AyIV8+X5+0p6UKCwcn7fK9uq17BLFHZ+RADttpAzAadyGuzztRV6CkEgEtU2lUuwKIVMJXoTBreo+cJrikMDs+B5IHKqX2+4IGsU46jbZUR69NRj990+gm3OesHnVOjfeSjR2efDwPZuUw3/tgyqruTU+NUPjefN8C/JVleGGlNFmTo7OGzSfAsir7EhRKAxRNwD5mTl2H36zdivrQCGsmhXq77u1W9c2gAzjQh3C8nPisQM89AN+rqe9MwchCG6o3iVChJaQTRzDCT64FMf0NJk6CRyAHmTcGSGh+hWSQODrkI4oA5XEkiaQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(366004)(396003)(136003)(346002)(39860400002)(451199021)(83380400001)(38100700002)(5660300002)(478600001)(6486002)(31686004)(8936002)(8676002)(316002)(186003)(6506007)(26005)(6512007)(53546011)(66946007)(4326008)(66476007)(66556008)(41300700001)(2906002)(54906003)(110136005)(44832011)(86362001)(31696002)(36756003)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WUIzL0piT29wWk9majBuV1NYK0lsRnJsTzhNN21jMGtCcXplRW54amcxdjBF?=
 =?utf-8?B?RXFWRzlCb2EzOTV0TStHbmU3SkgzYlRyY2VKdk5pZE9XcThsZU1MNW53QlhZ?=
 =?utf-8?B?bmpRRzRTUUp4VzQxSzU5Wkt1ZXU3NVNveTVjK2J1WFAvWTg4U2lJaWFGcFFt?=
 =?utf-8?B?akFYYjJUS3dlZzV3WFFlT2lEZU9kVXJDeE5Td1hZV2NhN2ZmdjNMMWhDKysr?=
 =?utf-8?B?K3gxMDVVNG04RGZmS2RBTnRqZGhybnY0bEhDWUcwSHBSTFFHNmVVbmlCMjVk?=
 =?utf-8?B?YzlKMU5NNmIrbk1mdUZuNkdPcDRmSC9UT1k4WnR6cHBsd1VPZVNZejYvVDJC?=
 =?utf-8?B?Wk8yNHBVa3FLbVlqWWNlSUsyZWJQZjlUeS94d1hxRmhubzJqbzRqZ1hMM1lT?=
 =?utf-8?B?SFJTMFN5K1VBWmIyMisrRVZoUXFuQTZnWGlmdVhFdzYxdXZqNk9uS2h6Q0JD?=
 =?utf-8?B?TUxiRzU4K1dXd1c4dUdPTzlDOXNvVTJOQUJIazZKbFc3WWxWbU5TdGRRYWM5?=
 =?utf-8?B?aWZhYlEvMnJWeTFuYVNIMXRpSmtqNDRscUxaRWg0WW05b25WVjVxSW1xT01R?=
 =?utf-8?B?UEJ5b1NxQmFyQm4wSWxES3NHcVRHZ2dtWTluNXZyeFFDWnRMTTNCbUZxd29H?=
 =?utf-8?B?WE0xemtzbXJaM0lpd052eWpZUm1jQ2V3dUs0Q3dMZ05ndnVRK0M1V09UcUZL?=
 =?utf-8?B?K1g5RXJYUmVIelNCVytmMkZyRWdZaEp5YzFkdmJxdHpOcG94R2Rkd2NFUEMz?=
 =?utf-8?B?NjZYUGpZREk2dFQ3MEJIQ01lci8rQkd2RThoSFYzVmVhb1E1V3BjTC9mTng4?=
 =?utf-8?B?YVpJZGFJQnYxU2RhWXRZaTBhQTZvenM0L0JXK3Z3MVBBQnJMd1VBSC9La0ll?=
 =?utf-8?B?M2ZnV1VxcmRtM3h3eWw2L2plTU9VNzcrRi9iclM3TjE3TnhxR1FMc1E2bjg1?=
 =?utf-8?B?K3dtR0pMbTc1cFhtOXVTTEFGN2lyRkF4NWVkbXNJbG05dlM2VjczUzJ0WHBp?=
 =?utf-8?B?MjRSbnEwbUZwb2R5T084UXhMTnpMSytidWYrRlUwcytJN3JSUjZ5NW5qTmF1?=
 =?utf-8?B?cStSV21ERnVxQTIrNWdSeUpTRzdLUklyQStvMWxpbHBxVzV5M2RIM1RjTDJR?=
 =?utf-8?B?VkRCZVJHMmNUMnJrZ202dDYwOU05TDJLK1RFRGJWZ1VVeFovSUxPdHBUWEZv?=
 =?utf-8?B?c054V21rMktCMmhTOFM0SEw5VmJHNU1IcmJvNnlJVG02eHJ5Y3FUNDM5alNo?=
 =?utf-8?B?NGVvVjdNMFZCaElNM2owOFNvOUIvcEJsd0MxQXZFcUdIeS9OTjhyenNRMU5Q?=
 =?utf-8?B?aXU1aVo4dmd4NFAvU3lTNXZDRmNldjJLZlFXL3JYd2NmelN1S0FpVEdLNm94?=
 =?utf-8?B?N2tZTXVtdEdteVplK1Q2OUljd2ZKTHNYN0VoTjBFZmR5ekEybDZFbE45dTcy?=
 =?utf-8?B?RXlTTWhRN2tuY0wrVEo1Y2NVanRubXA5VUI4NFRCNThwL2duUFRXenI0S3Rv?=
 =?utf-8?B?TXp2MWsrekFMVThHcWdXN0lPU09pOUZHa2pBeGZjWlJvcFB3SWNlUXJWZ3Bx?=
 =?utf-8?B?SFU2YjhqT2V3ZEg0SFd3bVNGVlFGTm1yZ2JreUg4MlEzbWN3emwxaXdOVlNH?=
 =?utf-8?B?dDJGNHF6blR5ekV5VWZkMCtiVTJRcjVsSjFMQmhlcTZudm05TkdBVVFqdG96?=
 =?utf-8?B?L3NaU0xTdWF0RDQ2QVhpbjhYczVCdU5oRnBoRWRMekxqK3UrYzZ2VFU4UVYz?=
 =?utf-8?B?RlBzT2hvK3BlbU1CYU9DWmtaczg2QmRBOXBYT1V2ZFBRZkkrZTFkSWgzSDk4?=
 =?utf-8?B?OExmRWJqZUUxVDAwTDJQQnZYcS9kZmQ3VG80MG1DTnJaTTBSSHhmQmZRTG02?=
 =?utf-8?B?Rkx5MXRFdmhpRWJTSnVGdUVNamtBeVRJdzVVWUZWMXp4eHlmODVFdkFBQWlS?=
 =?utf-8?B?TDFQTXErWFROdnVRR0ZvMnd0Q0M0bGRFZnY2YzZqZHRBQWFaR0IzeWMrODNt?=
 =?utf-8?B?UWxkYm92NXZvNFJQcitpNWxiSnAxS3VnMmdtdjcybzNMZDk4eUJkdXBJK2tr?=
 =?utf-8?B?b2RqYi9rb1FPWFI3OEw1SWxRVG5YWHZtRGJVaGJWdG9yaWNLb09DT0tpNXY3?=
 =?utf-8?Q?PKN9W+ljZtn/Afkt4aIVOrSn7?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ef91c40-c6f3-48c5-f16d-08db521ff516
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2023 13:02:21.4364
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y9iSofMeUe7ge5ZRqRMV/5caJM6VAv2QeYsHw8R4kiqoGllsKcx7p9g8ahTkTsEw08YRU6Ez2j6jEM41lKbGPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5635
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On 5/10/23 7:42 PM, Limonciello, Mario wrote:
> [AMD Official Use Only - General]
> 
>> -----Original Message-----
>> From: Ghannam, Yazen <Yazen.Ghannam@amd.com>
>> Sent: Tuesday, May 9, 2023 9:53 AM
>> To: Hristo Venev <hristo@venev.name>; Limonciello, Mario
>> <Mario.Limonciello@amd.com>
>> Cc: Ghannam, Yazen <Yazen.Ghannam@amd.com>; Borislav Petkov
>> <bp@alien8.de>; linux-edac@vger.kernel.org
>> Subject: Re: [PATCH] EDAC/amd64: Add support for ECC on family 19h model
>> 60h-6Fh
>>
>> On 4/25/23 4:12 PM, Hristo Venev wrote:
>>> Ryzen 9 7950X uses model 61h. Treat it as Epyc 9004, but with 2 channels
>>> instead of 12.
>>>
>>> I tested this with two 32GB dual-rank DIMMs. The sizes appear to be
>>> reported correctly:
>>>
>>>     [    2.122750] EDAC MC0: Giving out device to module amd64_edac
>> controller F19h_M60h: DEV 0000:00:18.3 (INTERRUPT)
>>>     [    2.122751] EDAC amd64: F19h_M60h detected (node 0).
>>>     [    2.122754] EDAC MC: UMC0 chip selects:
>>>     [    2.122754] EDAC amd64: MC: 0:     0MB 1:     0MB
>>>     [    2.122755] EDAC amd64: MC: 2: 16384MB 3: 16384MB
>>>     [    2.122757] EDAC MC: UMC1 chip selects:
>>>     [    2.122757] EDAC amd64: MC: 0:     0MB 1:     0MB
>>>     [    2.122758] EDAC amd64: MC: 2: 16384MB 3: 16384MB
>>>     [    2.122759] AMD64 EDAC driver v3.5.0
>>>
>>> ECC errors can also be detected:
>>>
>>>     [  313.747594] mce: [Hardware Error]: Machine check events logged
>>>     [  313.747597] [Hardware Error]: Corrected error, no action required.
>>>     [  313.747613] [Hardware Error]: CPU:0 (19:61:2)
>> MC21_STATUS[Over|CE|MiscV|AddrV|-|-|SyndV|CECC|-|-|-]:
>> 0xdc2040000400011b
>>>     [  313.747632] [Hardware Error]: Error Addr: 0x00000007ff7e93c0
>>>     [  313.747639] [Hardware Error]: IPID: 0x0000009600050f00, Syndrome:
>> 0x000100010a801203
>>>     [  313.747652] [Hardware Error]: Unified Memory Controller Ext. Error
>> Code: 0, DRAM ECC error.
>>>     [  313.747669] EDAC MC0: 1 CE Cannot decode normalized address on
>> mc#0csrow#3channel#0 (csrow:3 channel:0 page:0x0 offset:0x0 grain:64
>> syndrome:0x1)
>>>     [  313.747672] [Hardware Error]: cache level: L3/GEN, tx: GEN, mem-tx:
>> RD
>>>
>>> Signed-off-by: Hristo Venev <hristo@venev.name>
>>
>> Hi Hristo,
>>
>> Thank you for the patch. It looks good to me.
>>
>> Reviewed-by: Yazen Ghannam <yazen.ghannam@amd.com>
>>
>>> ---
>>>  drivers/edac/amd64_edac.c | 4 ++++
>>>  1 file changed, 4 insertions(+)
>>>
>>> diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
>>> index b55129425c81..1080784e2784 100644
>>> --- a/drivers/edac/amd64_edac.c
>>> +++ b/drivers/edac/amd64_edac.c
>>> @@ -3816,6 +3816,10 @@ static int per_family_init(struct amd64_pvt *pvt)
>>>             case 0x50 ... 0x5f:
>>>                     pvt->ctl_name                   = "F19h_M50h";
>>>                     break;
>>> +           case 0x60 ... 0x6f:
>>> +                   pvt->ctl_name                   = "F19h_M60h";
>>> +                   pvt->flags.zn_regs_v2           = 1;
>>> +                   break;
>>
>> Mario,
>>
>> Are there other Client models that can leverage this change?
> 
> Yes family 0x19 models 0x70... 0x7f can too, thanks!
>

Thanks Mario.

Hristo,
Can you please also add those models?

Thanks,
Yazen
