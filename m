Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0C93574542
	for <lists+linux-edac@lfdr.de>; Thu, 14 Jul 2022 08:49:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232740AbiGNGtz (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 14 Jul 2022 02:49:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232166AbiGNGtx (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 14 Jul 2022 02:49:53 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2067.outbound.protection.outlook.com [40.107.244.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A29DB248F3;
        Wed, 13 Jul 2022 23:49:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cK3sfR7NL1gZj3ZiP+drmLqqWFBsj/2v6WaPWarnvxiIRrxBiHO2jfk7qi54v46pfdfVpssRmtrokzSY3sAjic9pW81BZOUlJbAu8C3HPdtqbBfMbASPpIY+t3Ul0FNhhmvgavFTzmqUYNjPdCj33ypWpXllXfL+tMESNEPALtSxM1JTTEnZ0Jesl8o9U57v6zc0+hnMhTh2aFSUTF2zaxcJOA2h5mrTU2kyu5ZABIr8lFZ54LNAGpLfWsVxqcNQxlbx6cHMkGcb3Pta9cF7ZJpGudh6E09B4z0EYO7EZbwns6pNPobB2XKVpybSHOBPd0AW6JKILoX5euRaN5YvFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U1MTe11M8InRq0mXZaKrsH1hS7ogsyaztNB9+XCzSq0=;
 b=HXOMA9GpcgWy7wq77TGOrQRZV99jtQpE69G7oveiqA5k2mt7tSNPFaYcjwc8DEWa1+y1/JKtszFg5AweygZmwNhMtgJmwGnTiWJivEEu+nNwoMNVVL33VjU9JWDBVkp8dNDZoLdERSN3G+dxr5XXA2VVN6heuDQDH2/oV54Z0bU5F38Azf+Tpu9H9A3iiwFCHnyQ7+iVVNHuzTjN3rY6JPD7hFf9TgomiovQMTeCk6fCuElnemcXM/mYARMWLBgq9NRfMEC+U6aEByimoAspy91h9qzjmeoAS/Brf+p+TAVdEBC1+5p/TTry30BE/0hL6kTy2amHi79C0fHP3eJEhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U1MTe11M8InRq0mXZaKrsH1hS7ogsyaztNB9+XCzSq0=;
 b=FmGc8o2KBSerrqiHxCijaJlx6+kqntxFC7nsBYcfzgFL0LKHOLBdhrH/ZjH4DCTXUaibfqX0JQMekg52v1+ScqYpgDxtdeBib8CalMUWVQlf723IS3djERf8SdKwuQu3mYr3Oie6n/eL43yk/rRo5JYGTx6CLKEQTcpFRwH2Y53E2b6CDyY32Y+NiAM6zWpsViRxrMmU9M7fwdBB1j8vMu7t/TZOpUCarg6YoztwW18vuf8w0wtNIVXdqgiN4daSApXC2SULaqG9NBG62hlndbJlJtotDXIK3/NCepcu4pV7oI4tV6+nCYfHv4MHTyewccsmhlwyMvivD9zibsvi9w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CO6PR12MB5444.namprd12.prod.outlook.com (2603:10b6:5:35e::8) by
 BYAPR12MB2744.namprd12.prod.outlook.com (2603:10b6:a03:69::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5417.26; Thu, 14 Jul 2022 06:49:50 +0000
Received: from CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::b148:f3bb:5247:a55d]) by CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::b148:f3bb:5247:a55d%2]) with mapi id 15.20.5417.026; Thu, 14 Jul 2022
 06:49:50 +0000
Message-ID: <da970752-0d99-9c81-07d8-2eeb783093d3@nvidia.com>
Date:   Thu, 14 Jul 2022 07:49:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [GIT PULL 1/7] soc/tegra: Changes for v5.20-rc1
Content-Language: en-US
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        arm-soc <arm@kernel.org>, SoC Team <soc@kernel.org>,
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
 <d12fa14a-bf0d-4e98-acd8-69229315d660@nvidia.com>
 <CAK8P3a1sDbtEUaT7Z5k_SfUcA7OBUxkny7kmKOMFaE96qaGeXg@mail.gmail.com>
From:   Jon Hunter <jonathanh@nvidia.com>
In-Reply-To: <CAK8P3a1sDbtEUaT7Z5k_SfUcA7OBUxkny7kmKOMFaE96qaGeXg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0048.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:48::10) To CO6PR12MB5444.namprd12.prod.outlook.com
 (2603:10b6:5:35e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a30e60d1-da49-408e-f55a-08da65650c31
X-MS-TrafficTypeDiagnostic: BYAPR12MB2744:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MJfDxU+7WTxgQDb3Vcm/nL1nmFEnyEBfiBYA/uZmbTPmXPDFADj4iYjMe8PCe8FfUFgIcSLz4GsVkv7S/NQUhX5hau22SzPkPro6N94n1zR1cTGgHC2dCmhLUd7N3Mh+p+vpdc0jmVnVQtxmR3+/XDwnjjFFMfIMLb2awYpcPgfPDNIPzc84Oy1LQ0Sp/zDdBNQJDVFmAATTRGI/JvMo/TW/imtyVKb2CKiw3Ma8fDn41zaNjlVGwF1H5NPyIX3t2Tc8nb5uuSWOM8A5eIG/4DT22VcdZRIUwT5pShwelmV7ZZgcnpOaxauPint2Pbvd4tgN4US+oAc4Ca9IVwTQO+jPDnkzFsSicoga6talaWvoe17o8rvrP6wGA+3zOt/Dp3mHkn06EpXK2qDIHehmXKUBM8JCj3YVllxLO8Ht0fqFRVp1MZggcReax6ahCnGqNIOIlDBfNXyyA2AS6ojKGtccUC6shmE8mKt+JWIJ8tWW7cVtj+7pQsKI/KUtRbGaC2fYTH0gQBmxwFMu1AlKUYFFvIKnVJ7VgA5FnC9IQfm4GauZeoIEzGgOu0c97y/ZakkRAskCT6HJB/RDpXyxibIcg6+e9jVSvApdJuj7NmT+Mf2YoisYPRKhH+amRW1GpvVeQHCcYuO39s8PFzQZQUPMCrQK0ISGWHwHm3CFDNpO78RCmZ79Iz79bDmm69/nS061KRp6FPeMjBQmqn3bJc/eaJrfUnfz7WvmcdlI3c3NrQvo1lbPOHYc/Xk1dRFc6m5DOidUQ0+nL/4I+dgf7OelGtntGn41rDkUC7qFJ89+xB6J5Y+SReCu1IzcWxLbKnDz1JpWWFexwx5UBrAoyyqKGHh1V1sPJ4KHJWauPKU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR12MB5444.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(366004)(39860400002)(136003)(346002)(376002)(478600001)(54906003)(316002)(186003)(36756003)(6916009)(2616005)(83380400001)(7416002)(66476007)(55236004)(31686004)(41300700001)(6666004)(66556008)(66946007)(4326008)(8676002)(8936002)(53546011)(5660300002)(2906002)(6486002)(6506007)(86362001)(31696002)(6512007)(26005)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MXJBTG5ZQlRhY2tuV1p1OGtnQWdxODBKK0daQlZZU0gyc01HUFJTdlV5U05J?=
 =?utf-8?B?ZDVnZlV6TVZ3endnSkM0c0lLSjlWVkpuR0doTFdmMm1aQktyNDJCaWh2ak5s?=
 =?utf-8?B?bTVEWTkxQWlUeEdYM1QxOStIeGJLc09nVUExcUgrUldadFJEZjlMTU03UHRK?=
 =?utf-8?B?bE4rK2dDbFdzSEpxRFc2UUp0NzdqeiszOWhBaHB0RGdiNFJmcnA5QjRURjkx?=
 =?utf-8?B?dXNvZFM0QjFRVzVEc04zQVkzU0RacjhqdWVCU2NFQ2lrSlU5UlVtL05HbTd4?=
 =?utf-8?B?a0VITlAwNmJTMjdMcER5eFJsTEQ1SXQ2d1lWNnF3Y2h5YVdITURYMzlEZ0xq?=
 =?utf-8?B?cXo4Z0hycTl6R2lIcEZZeHhMQUZnUUR3TmgrcFcrZGEyUEJCdVhrZkd1dTBM?=
 =?utf-8?B?Q25ITnFDK1lmZ2lkejRnaWl4RndudkdZbmM5NnNWWmN1dGxjdnpTbHIxT2I3?=
 =?utf-8?B?VngwSTh0VEZ0ek1FNDVma3J1SjNYRnJkV1J3NlJyb0RKL3l2QXpaRk40SVYz?=
 =?utf-8?B?dmRLNitGZWRzV3V2UDg0QXNsVGZBWHpNdEdEbStKSHltNVMvQnYvNHZaN3Yy?=
 =?utf-8?B?WjVBL3dGU25URGQreEZvRytOT1gvOVZTVGlJd2hFMHcxdy9WNjhFRm9RbEZu?=
 =?utf-8?B?VHNjMk44OVh2eWJka0lodUxEYmh4alU3ZWJESVIwNlVDbEU0OVEzZVYvV3Rs?=
 =?utf-8?B?VExHZVQ0KzJ2SUFLU2Nwc0pPN0xjMndld0tBbC8zV3UwVWRRRzhjZHJ4K0xR?=
 =?utf-8?B?NUZtL2dWNVRYSDU5aFVoWFNTc1NRSWMzUGRqcy9mMUVyUUhBUXo3T3ZNYlo4?=
 =?utf-8?B?YzdxQm5KZXpLV1FjNWpmMDRsNmV3emF4SmV2Z1p1emJwQXo3VjI4a0FiOGQv?=
 =?utf-8?B?NzJBR252UW5uSDk3dThoYUREZGRSMjBlaUFBTjNXOHNxam0wRDhuSDBDUXpN?=
 =?utf-8?B?d0tmck1UMHFBV0xvcGNqalB4SXJMVCtYa21WUlJPOWljck5pUUQxQkswZDlh?=
 =?utf-8?B?RUVVeXNVVkdXOFkxU2pGbHdZa0tRZ2lCTlJpOW00cW1XSzc4WUJxcGNvRk95?=
 =?utf-8?B?ZTNjNEFHd1JURWx4NjMxM3hPZkppVHlmRGl1YmQ2dlZEZXJKeHR0amtzbUJi?=
 =?utf-8?B?a1BwYXMyclRGbE4rdHQ1ckdqZmpxUWxheGhPOHI1SlFLcDVURXRTNXAvY0lT?=
 =?utf-8?B?UDc5MjJicU0vc2EzZnNZZDI2d01MVDRqZFJoTWpQVlBidy9YSUZHUHo1bVVq?=
 =?utf-8?B?NDVMSnRvZ05ueWNQR0d5WXh0QlJlZG9rR0UwbGhkazJnTHNjYWw3WFQvcFJP?=
 =?utf-8?B?WVFRdVFsR1N2dVpVWUpLRVY0VkNKQjhNTHJpdGRZOU0wMGc0KzRIYzJOekRx?=
 =?utf-8?B?aHRlRVdCd09EZkJKYm92ajlUY2ZEOTB0dUlPSzRkL3o5bFJZMUlUWjRycThk?=
 =?utf-8?B?VTZmcWE2aUZmYkNEZE9VSGtqUDdWVEdHWVpHRTRKV2ZIOXc1L0puV3lONDFC?=
 =?utf-8?B?MlhpNmcxMWxVM3hDN2RVS2JOM1pQS3RweXhXMUdYNE14OW1zeDM2V0ZuOGs4?=
 =?utf-8?B?VENoMlFOVHJUWXV4dThuVFh0eS9uaHVJRHRETmE5d28rdUp1S2RFV0dlRy9x?=
 =?utf-8?B?VU9OMlpONko4cVNkZ2VCV0VpSWh3ZC90Um41M1ptazZzSG5oYWtER04rbnFH?=
 =?utf-8?B?WGxOeFEvUERrOW8zZVRNRmxueTZzS2RQbGNudFkwUTYyU0wzTDRiZWVTcnZh?=
 =?utf-8?B?YXRtOE9oREFGbjd0elpycDZldFhGOXNTUHJiMFBpaVNGakNPWHNJQWVlWjcv?=
 =?utf-8?B?V0dsUXlZbWhIWEtHOXNiKzR1VnhYSDFxSDJUc0U5eVlONHpwdWp1eldtdlZs?=
 =?utf-8?B?NzkxeXA5Uis5T3pLYUpCNkdaU25Rc2ZRMENXVitaYlArNzg5d2RHdDVHS0Mw?=
 =?utf-8?B?OEhwU3ozYWtYWUVGb1Z0WHRzdnVodUgxbjJ6UDB5WUVBVG84UkoyYlprRlNn?=
 =?utf-8?B?QW92T0dNZXNmV24weG84eitzZzF5a1pyd3FrT1JRNDNqajRKSWN6LzJhUDJs?=
 =?utf-8?B?NDVSN3dZYmZ2YXJ2ZzVBaEFaM0NwdktZOXQ3QzRGN094QVRaWFlIVXNQUkhS?=
 =?utf-8?B?WWwyM05PdFlXMEFvaDVqMUw1U0lkT3AwUjY1TkZnWnhmNUVRdnlUcUZ1TVVL?=
 =?utf-8?B?N0E9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a30e60d1-da49-408e-f55a-08da65650c31
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5444.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2022 06:49:49.9392
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nnjtmS6GuWrMwR1exjf6sGXk1Uq8OVXrDFt2xhB5wDhSoawZ6irEg4zD6PIIe7cNUU6ud+1+FkRk6MSQx7q1SA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2744
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


On 13/07/2022 13:36, Arnd Bergmann wrote:
> On Wed, Jul 13, 2022 at 2:19 PM Jon Hunter <jonathanh@nvidia.com> wrote:
>> On 13/07/2022 13:14, Arnd Bergmann wrote:
>>>>> For the other patches, I found two more problems:
>>>>>
>>>>>> Bitan Biswas (1):
>>>>>>         soc/tegra: fuse: Expose Tegra production status
>>>>>
>>>>> Please don't just add random attributes in the soc device infrastructure.
>>>>> This one has a completely generic name but a SoC specific
>>>>> meaning, and it lacks a description in Documentation/ABI.
>>>>> Not sure what the right ABI is here, but this is something that needs
>>>>> to be discussed more broadly when you send a new version.
>>>>
>>>> I wasn't aware that the SoC device infrastructure was restricted to only
>>>> standardized attributes. Looks like there are a few other outliers that
>>>> add custom attributes: UX500, ARM Integrator and RealView, and OMAP2.
>>>>
>>>> Do we have some other place where this kind of thing can be exposed? Or
>>>> do we just need to come up with some better way of namespacing these?
>>>> Perhaps it would also be sufficient if all of these were better
>>>> documented so that people know what to look for on their platform of
>>>> interest.
>>>
>>> It's not a 100% strict rule, I've just tried to limit it as much as possible,
>>> and sometimes missed drivers doing it anyway. My main goal here is
>>> to make things consistent between SoC families, so if one piece of
>>> information is provided by a number of them, I'd rather have a standard
>>> attribute, or a common way of encoding this in the existing attributes
>>> than to have too many custom attributes with similar names.
>>
>>
>> Makes sense. Any recommendations for this specific attribute? I could
>> imagine other vendors may have engineering devices and production
>> versions. This is slightly different from the silicon version.
> 
> Not sure, I haven't seen this one referenced elsewhere so far.
> 
> What is the actual information this encodes in your case? Is this fused
> down in a way that production devices lose access to certain features
> that could be security critical but are useful for development?

Yes I believe it is precisely that. Exact details I am not clear on, but 
I see a lot of references to this throughout our userspace and testing 
code.

Jon

-- 
nvpublic
