Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E0B1574518
	for <lists+linux-edac@lfdr.de>; Thu, 14 Jul 2022 08:30:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232087AbiGNGa5 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 14 Jul 2022 02:30:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbiGNGa4 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 14 Jul 2022 02:30:56 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2055.outbound.protection.outlook.com [40.107.92.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B167F1D0DC;
        Wed, 13 Jul 2022 23:30:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DMJKwIXM1DLUxBv48rsaoYp2HCiICVaD1Z3uThKqXPBMW+KVYpnp0e2YLloT8MzYAHahtcSJ6fVrqCof15yLcmOb4pLe4nwgnYkBJg+TYEx+qcslny5wx8un/3d69prjEwyt/jiNiDVcHaF/nncQ4a5XymP2syQFP/jOdwS3SOCjJyqNXRernMhrW9rMJEJs2Q9OrMNF2vcUfZY4qI+W0yS/80dI87tFD/8r4xDwmQ/q7mK0uITTF3uysXkHf0Oq1zFFmQpCJA3QWIW+gKwrWPyCWNwRVT7A2GfPK2n8VvNe0/WQYjXQ1euXBVXElDMpwsgCDClQvvH/kv4XoTEfsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b6WQ0bq1VjcBVYCf6wh/H1dWwgGJ95xb08QPjQT56sU=;
 b=Q8EagP0HqkfSfzBe3+NqMWDqyJ41xfHbbfHXozKjygQNSOhHDd4otaahdwB5ZIs90kAK99+vXju/dacDRrx8yMPPREcrSmwcm1W8+PeIDwum5e/WX2ofbXvQyDI0AJS0ZMfzzBopU/X3C+eGGcS4lQ5KuBIslKLeZI7admb3pXf0gEne6njPNS7EaURGUe2VlbFARosQuj7kAq0llZoNX+nCyZcaFpfAAqi0Z7S3Tb7S5ohtdNmOW3kreM0iWYs0fV6a2zsHCu25O5HxuWGVuSwb/kZoukAtIW0YDcwhTlqu4Z6r7YDGn/ffSWDisuWLrWDN4jDu9zCGXlTRIUTi4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b6WQ0bq1VjcBVYCf6wh/H1dWwgGJ95xb08QPjQT56sU=;
 b=WkUg6Q15UMXFW+WJdXCAQlD6ET8CJm7Z8DWlZCWuv/tcp4ZN+3a+iGo6Gh5Roa9MbgEtuztc65LGjkT9DmgkOs+i9CEE24z+PEmxEkYuco9NmArKWDD4ffu1S1J9ZkSAuyXTmK+FEj92UXSuQ66BKFPtMMY8Ua86vHQ7OJe9lWiw7LnOFSo14WugEz+5DI3+teS/LbaDwggnqKsdQOdVQ75w5sR0h7Kg1/7+QA4fY3rEtjtbm7Yd9Zph9TODeokszNBJfjUX4sJwF/7TYq+vpu5y1eyHUyrbsT9PENPSBVbyGHwq8Po4r5wPEhNWrK9D+3DQ7/9jNVd+a/RvSYVxsw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CO6PR12MB5444.namprd12.prod.outlook.com (2603:10b6:5:35e::8) by
 BN9PR12MB5243.namprd12.prod.outlook.com (2603:10b6:408:100::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5417.20; Thu, 14 Jul 2022 06:30:53 +0000
Received: from CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::b148:f3bb:5247:a55d]) by CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::b148:f3bb:5247:a55d%2]) with mapi id 15.20.5417.026; Thu, 14 Jul 2022
 06:30:53 +0000
Message-ID: <7620832b-9d76-175b-fe93-dc91cf3732c7@nvidia.com>
Date:   Thu, 14 Jul 2022 07:30:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [GIT PULL 1/7] soc/tegra: Changes for v5.20-rc1
Content-Language: en-US
To:     Thierry Reding <thierry.reding@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     arm-soc <arm@kernel.org>, SoC Team <soc@kernel.org>,
        "open list:TEGRA ARCHITECTURE SUPPORT" <linux-tegra@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-edac@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rric@kernel.org>
References: <20220708185608.676474-1-thierry.reding@gmail.com>
 <20220708185608.676474-2-thierry.reding@gmail.com>
 <CAK8P3a1bKUr77t9xkNAX=-RqzRme6Hymr3V=36MSHT_sOFEW5A@mail.gmail.com>
 <Ys6lXD6BSxjH02mW@orome>
 <CAK8P3a0cSq47B=acZ854TVu=RckJNfyfKdqQUMzCX7SsV7Wt0g@mail.gmail.com>
 <Ys8phjCTfQTD41g+@orome>
From:   Jon Hunter <jonathanh@nvidia.com>
In-Reply-To: <Ys8phjCTfQTD41g+@orome>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0091.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2bc::8) To CO6PR12MB5444.namprd12.prod.outlook.com
 (2603:10b6:5:35e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d94e9163-30b1-46b8-e506-08da656266f9
X-MS-TrafficTypeDiagnostic: BN9PR12MB5243:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lOmkJvT7kcJ60nSkCPbymC5ROPSH2kr6eF09JnndSD/ar1aJqtBHitNAez1YjA8WjQ3XoozN3e10q6nwXgblQYRLflpTNv3zDBFMh+TMUGOeS9puCa7ebsaTl74mil51fVHBS8IUmCdNqcXP/WV9EyeIOOvdxC4MmNfnSMsBz4TCAjpqJe258seXduoBP/Nw9voDAPWyKqSSEhXkYPdAuuwzPzV83pKwjlnZpEpmz7sPpz3ADEOruKVolzHi8HTL2FVDSupHE7IUquhUZn8Yqy1O1ihyqsF0zy0MjyY0ANpFvKoUWCSW2EqO6kSV1jCOvzY2eLIaGx3RKYVNWgeAgZAI5bHxbbMOlETlckfX/UgA0p4UxbaIzOBxPLXOTQevw+L0XZQpHxy8TzD/7PATo1EWuaXsnTofaN+3rKm7Zdn6cZWFmn2fummvxExIBDrJuwzoRzlGsf8K+sPUJItqmUnRfwrOlBKAItYyd5xHsxsGwdE+p8EbnTgJ2eJVombyvOc+q1BiuZXI6A8EVeh+AaosHGtZ+BGcTCGuoBPT4c3Y0QbUH/6r8Y3ET8NVLzFR/QmNtufVJr7+af3qiLRuWZRSLuO+JGazN+SFNgpo53B1PHkTKcXnCWWTk1Ro3g+bVCEFws3O77ipLBTWwhcPITTi30yeMig4/2SndsyMMW1fgRmvgfJBnj+6r69FiPc2OVH3Y0izpUPKL3u98+5eWWwqHanTvPZrxZQc2PRIFleLMxqCEFZbwdbfQsiIDVWlOvbFSB/gh4haaZhveD4JDGTv8D4mKAUDQ3u1E2AilqYgLI8GATUqy/EpmkXhuLm/OoxaZTsh4DzAOjC7YfrzAg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR12MB5444.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(396003)(136003)(376002)(39860400002)(346002)(6666004)(478600001)(36756003)(186003)(2616005)(2906002)(8936002)(31696002)(5660300002)(86362001)(110136005)(31686004)(6486002)(7416002)(55236004)(53546011)(316002)(41300700001)(66556008)(66476007)(54906003)(26005)(6512007)(83380400001)(6506007)(38100700002)(4326008)(66946007)(8676002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N2xaMTcyd0RpUE9UbXFnQUkwbnE5cE4wbFBXREM2OXVvckJWMDEwcVo1TTd5?=
 =?utf-8?B?eFFwTHhHaW9OSGlVUCt5Z3hZU0I0bzMrenFreUhtQ2RsZHhXbmVLS2tod3cr?=
 =?utf-8?B?YjJpN09Tc1lFWHp0c1RDYXBuZTZabW11enFCMDRrdXVVRENrd2wxUSswZGpl?=
 =?utf-8?B?dUxuMmVqdmhTQllyYXFNV21VZ1lLR01WdEtNcFpwekFrTy90Z3ZDSStncnZw?=
 =?utf-8?B?Q2V5WTlkeTlabXpPZ0hZOHRYYlNyamNjOVFmbVl2R0FWd0lvOFNDOUNKRFFP?=
 =?utf-8?B?OHljWUJ6dG1xREMvTlhtN2JDcHdZYjZVVWROK3R3ZC9SYWV1Rm9KY0NrUjk2?=
 =?utf-8?B?dlE5YjhNYkhSQUpCaER4VCtZZWtrYkZoWFEvUWoxdmhkTjB1OWtRcTBlNWZF?=
 =?utf-8?B?Y3NXeXhLMllNSnowdmY0QkJ4aWZXbVh6L09EQ2tKd2k1Tkt3K041akpPWFc3?=
 =?utf-8?B?VnpZLzNvQzlSTWV2OXA5Tmp6L1p0OHBQMllzNUpQOVZFMjdYSHVSZm1yU3M0?=
 =?utf-8?B?MGZCMGlwNXJkZG5MUkZDclpESVNRb3F5N3B6N20vOFpLZkdqaGpjNU8wRCtp?=
 =?utf-8?B?UXk3Mm5ON2ZadnYvaTRNOTBlSlNobVAzQVpDSzdtNnNwNFcwOGZhVWNiTnMx?=
 =?utf-8?B?MDFaTU5Kb1Jkd2M3WEVOQ1JsTDhFVDd1Rm9Xd1UyNFhZVUxqUWRvdDZHWWNr?=
 =?utf-8?B?c00xa2cwcFU0L1dUTVIrS2o1YW1oYWJ3bXRHalJxQ3pBNEZwTmRVcms5M0NJ?=
 =?utf-8?B?QmFrbGxnUzRySTFHV2tTeEY5bFBYb2I2b1FDaDRXVmNwaDVhZTRuMHUvSFFq?=
 =?utf-8?B?NElBbkFUcllXV2VnZUgwSnkwUXdXb29DRm9vb2QvZWM3OWhubVpyc2JTbFQx?=
 =?utf-8?B?Sk9sdzI0TFp4TlBtNG9KU09LTGpVbFVwUXNSNyt3MEF5L216aUh6UHprcTZK?=
 =?utf-8?B?ZU1KbXc4Q0pON2c0VERNMFlSamRJNkppdHlQbHh1a1RKRmk1MGNKQlBpV0o0?=
 =?utf-8?B?ckNUK0g1bkQxa2NmVFh2SEJTcGsxWGFJTGdzbVlWb1ZTaFZDK1I5T3gra2po?=
 =?utf-8?B?MGhpa2R3QXFRRGduY3UwUXZpNXd4aTEvYTB3YW1qWHVnV2MwWHJGK2xYa1pD?=
 =?utf-8?B?Z0NiT0tkWWdDWDNEQjF1ZU9KMTMwell6UmhSOUhTSWJ2NTVPbEZrdzhoYlBO?=
 =?utf-8?B?NmFvcFBLSmM5UXZYcWtxMzlxeTNHTllQbUxJSXBjc0F5SVZmSXpZaS9ObWFV?=
 =?utf-8?B?UzI5K0g3QkRFb01WVEkvQk5QdExMYmkvZVZsT1NFWEJxdlVKNEFHRFY5SFBS?=
 =?utf-8?B?SG4wWVhFMFpTSkpacG1VK3l5NlN0TVVTUXA5aGtqYVJiZXMxbVJHYlFTS3lU?=
 =?utf-8?B?bmlLdWJaVWRBckNXdEgrZGw0V1JCQU42QUo3a0hSaHJqV1dzS0l4Q0pzdDdE?=
 =?utf-8?B?THdkbEJxR21UMDdzejl6OHVjVGNhNk1jTEpPSUFwZGk4aGZ2YUxGOENQa0Ja?=
 =?utf-8?B?NktiWWUxYjFvTzA3dFNsZ05ZamNTd3JmSHByM0pLWmlieUd4VVg0OThvSk9Q?=
 =?utf-8?B?dXZCZGpJK0tINWVKZGVHM2JDQzd4SFFxem1tZEJoZVlselRQME4vdUJFUWh3?=
 =?utf-8?B?aTYyMFNTV1ErN1FTeExrSFEyMHdDRnQwcUVkZUVtU3MrZllzM3lETGt3elMy?=
 =?utf-8?B?QnFSbzRhbHN1U3hkNEg2Rkx5RXhtSUEvVENwa01JbHZKamwydFZGYkdkV1N0?=
 =?utf-8?B?dWtiakFUQWVuL2t0dm8rcjdrMklNSmpwT1FlOTNMM0NQaTNnVnRqRktGV1RH?=
 =?utf-8?B?MkVnMDJocmhUcjFrcjNFU2lrL2NtVFlMNVFPemhVRlV0Vnpld3lLOXQwMFE0?=
 =?utf-8?B?MlIwZEhueW5aUXp2WHFMMUQ4dlVtd2x0WjdzbWRPM3o2WTF1VHg2aUx6N0FB?=
 =?utf-8?B?ajdCTk5RUXpQS1hSOWdWU0RTM2JBRTRlU0tDNnkwY1VtT0E1a3I2cHlkQWJx?=
 =?utf-8?B?a2ltMkMvd2p5aDRHL2N1RXB4TFhBcDlONUNwWkIzdTRzazFCeGFDZEhkR0pK?=
 =?utf-8?B?bWZaL1oxTXdEd1pTdEYwYWs0ZThNaWIvTVJZdEdSeG9GMHNJZTFqeHVrK0hL?=
 =?utf-8?Q?X4lUJ5GJiAmk2hihpg5cEYVtG?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d94e9163-30b1-46b8-e506-08da656266f9
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5444.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2022 06:30:53.7855
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kFRPEirkGH01jcvuXnrctfgyASvSXj2Fqn8t7/MU7AeCbM01Jk1/13bp7ZKj1bGVUaG63f6PqYxnYcdLAJrC3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5243
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org


On 13/07/2022 21:22, Thierry Reding wrote:

...

>>>>> Bitan Biswas (1):
>>>>>        soc/tegra: fuse: Expose Tegra production status
>>>>
>>>> Please don't just add random attributes in the soc device infrastructure.
>>>> This one has a completely generic name but a SoC specific
>>>> meaning, and it lacks a description in Documentation/ABI.
>>>> Not sure what the right ABI is here, but this is something that needs
>>>> to be discussed more broadly when you send a new version.
>>>
>>> I wasn't aware that the SoC device infrastructure was restricted to only
>>> standardized attributes. Looks like there are a few other outliers that
>>> add custom attributes: UX500, ARM Integrator and RealView, and OMAP2.
>>>
>>> Do we have some other place where this kind of thing can be exposed? Or
>>> do we just need to come up with some better way of namespacing these?
>>> Perhaps it would also be sufficient if all of these were better
>>> documented so that people know what to look for on their platform of
>>> interest.
>>
>> It's not a 100% strict rule, I've just tried to limit it as much as possible,
>> and sometimes missed drivers doing it anyway. My main goal here is
>> to make things consistent between SoC families, so if one piece of
>> information is provided by a number of them, I'd rather have a standard
>> attribute, or a common way of encoding this in the existing attributes
>> than to have too many custom attributes with similar names.
> 
> The major/minor attributes that we have on Tegra SoCs should be easy to
> standardize. It seems like those could be fairly common. The other one
> that we have is the "platform" one, which I suppose is not as easy to
> standardize. I don't recall the exact details, but I think we're mostly
> interested in whether or not the platform is simulation or silicon. The
> exact simulation value is not something that userspace scripts will look
> at, as far as I recall.
> 
> Jon, correct me if I'm wrong.

There are a few different simulation types and I am seen some userspace 
code convert the value and display the actual type. However, in reality 
I am not sure how much this is used, but yes at least identifying that 
this is silicon is used widely from what I have seen.

Jon

-- 
nvpublic
