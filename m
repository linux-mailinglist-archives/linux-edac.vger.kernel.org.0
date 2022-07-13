Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6362F573638
	for <lists+linux-edac@lfdr.de>; Wed, 13 Jul 2022 14:19:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231351AbiGMMTs (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 13 Jul 2022 08:19:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbiGMMTr (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 13 Jul 2022 08:19:47 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2082.outbound.protection.outlook.com [40.107.244.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1BAF2C654;
        Wed, 13 Jul 2022 05:19:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DjtoptSrRCoS35GLe5DDxr+wKw0Y37ZZhm/4NCLlxHIKRM/7SGD9fHrQFaarSkQFeeCYFRVdv7I19rJySpgpedmR35DH3bjrA+4+61+8d7bQn2Q/GA6Ludz1IytUJlAyp4CXcUO0ZV4tTsLJaB+PbhRbA5K/AjROLQgq79mswXWscN95/2ZTpnUAOARUKw7/IKvTpKLSyioa9gDO7xvIRSQbqTF7QRtteXwnRUoHzi6xs+sFwh/drkpPVC6vT1cWj9UlHACP2yRcXRxcjxWe2j4tOHrCYL1IzP1d4zwO6ha6iudpzR+GHthsb+82WDJNrkVdkkN+OxHUfMd/XcUnnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KAP6WSF9oa2oQ5XDuOgr3O0buEmBwg3V8TWsA6jSegA=;
 b=jqOijv+YvhhTjpw9d+Yt6IpM9M0fGBZJTqtk7xLCeVcycAOolALCWCn9jffKB54clIx0Qvro0yM6abl+fWC7/v//sfretp5CQdBLOhPd90HCAaXBQKjMluAeLKdfqoNpFwgKg1uIV0fv9gLQRuv+o/3W0+0E79o9+zA9JOOgFJt4mEBLyHkuhSH1rKmC2Psu8qb6Cplky0ugvO07dC5HmPDugfCwS5D3+vyx2aWqyRrPU7znVTZkOo+UOYAWefK+O+h3Ef1ZHVKG3L32L7we5rqdmnfGfmG4D38xxoj3IXzrB5EJsnvAHAWYSLOX0V/novYDQUnVCD0cdfesshb1Rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KAP6WSF9oa2oQ5XDuOgr3O0buEmBwg3V8TWsA6jSegA=;
 b=NvupAUOj7d0CEUDH7O0RONygRwOlkSp9u/75GTUDNygSu/E9S4OJSNb9DC/wGP6wM7G+jWrfpiZLQEKtkzbq6YXzGM+Q8zg7Cn190hsN+PG6s79b9MWjdP4/IsSN7VLfW2S7xpJqZSkMAHnvyedndondMN0XJnbp3JFxtd08jc6YekunZxkQGnVt0wIOndN7DTdZ3gRJNfSeNNX8W2ephi9MuL8Q+D88ti2Ez8XKjbguFDJLneN4gZgQYtKK8Pzzycw/pkHSf+KxQQFmKoi0Qa7IZWVK3EzkpZK6Zspy0JiECH00wMn2jugZgtep2eiwv/hXUnveyveAJnkiRjCE4A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CO6PR12MB5444.namprd12.prod.outlook.com (2603:10b6:5:35e::8) by
 BL1PR12MB5825.namprd12.prod.outlook.com (2603:10b6:208:394::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.12; Wed, 13 Jul
 2022 12:19:45 +0000
Received: from CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::b148:f3bb:5247:a55d]) by CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::b148:f3bb:5247:a55d%2]) with mapi id 15.20.5417.026; Wed, 13 Jul 2022
 12:19:44 +0000
Message-ID: <d12fa14a-bf0d-4e98-acd8-69229315d660@nvidia.com>
Date:   Wed, 13 Jul 2022 13:19:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [GIT PULL 1/7] soc/tegra: Changes for v5.20-rc1
Content-Language: en-US
To:     Arnd Bergmann <arnd@arndb.de>,
        Thierry Reding <thierry.reding@gmail.com>
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
From:   Jon Hunter <jonathanh@nvidia.com>
In-Reply-To: <CAK8P3a0cSq47B=acZ854TVu=RckJNfyfKdqQUMzCX7SsV7Wt0g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0120.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a8::10) To CO6PR12MB5444.namprd12.prod.outlook.com
 (2603:10b6:5:35e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: eb9d7c5e-66c6-4897-9d7c-08da64c9f879
X-MS-TrafficTypeDiagnostic: BL1PR12MB5825:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BwJi2pGo996gJ2sQktn5Cg0zbTgnRJ9TDT6NHZD5InLPyphBSr5PyAOfFCFyskx42d0XtqrYzh/R+iXP8gN3h/+CP0pZWunruO3tiodPWijDQC+sbbJhEr2bhvEW1QTaS1OhUo8zkjEdsUxRmpoyw9MU21wMxV3n2sW0s6SB8X+skbGX3e3fZc1z3olt2rAJU+fMed4enNAQX4YFeMsUSSWXxa0JLpuqdhqj4rDDvd/4seYf6MMHkjHtGcl6HnvjAilZoywqsbcZ7WjETyAt6WeFNo0QDJDKTeMnw5qBJTCpA3kuLv2kS/LBcsuuUqHG2/bLNoa432aL8HGnIXZvyxUDij4/YrveO8SR6x2g2o+kDBbWPRtNdqNXgsPzgo0QsmMxZgGYDN4unxVDwylhjrBocqrlj1NBaNvBOjtESo7U2c2eOPqxp3MQsIPrn/l88Rs9SPoOFTJin9ww+dbYUB42ChuoNCEy86VAqagIe9/uxU5mUKVgq4slKwgRF/FJRGOI3tTKDdaSksJha17u41A31yBeJX/fFVkyTG7kbIGIUv6g9fxo72/fIIuWzK0TkD6O4YMcx2eBKIDRCRKda+Sb1h3DAo0P91zIEGPsbBWNXSJgrchMJ6SW/MOl0QUbwVh1RSmp21gwSsaSyvDW8sVlbwmNPMTelmk6fq2lPNFnABcqOLPluX6ByJs1b+5NpQRHGN2dODwgOtS0os+IbVMlC60OoZgor6sBGLRmCk46N0kTbA056zvYLFT0WTCuRqHJZORMNV6CXee61tsyLRDZBZpBPfOKlyj/bo/wf/kwa47QxNqWUvM5fhUhLdMuGUOdQMIgrshFfpiRvnRa2pfl/f1oPBk9uJpyPMCQsV4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR12MB5444.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(346002)(376002)(136003)(396003)(39860400002)(41300700001)(6666004)(6512007)(66556008)(53546011)(26005)(6506007)(55236004)(66476007)(66946007)(316002)(110136005)(54906003)(6486002)(86362001)(478600001)(38100700002)(5660300002)(31696002)(2616005)(83380400001)(8676002)(31686004)(8936002)(2906002)(186003)(36756003)(4326008)(7416002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VGo3WWN5V3YvQjhZQTk0Wks5bUppN3RQV1BZYjFSQUV0a2tuYmhGMjE1T2N6?=
 =?utf-8?B?KzZBSGFWNGM2VGFxUmVXUFZQUmllaHZCN2ZiZ0tVc2JyZlU5d25HQzhGNXJ1?=
 =?utf-8?B?N0YwT2dneWFlOUsvd3o0VU14WHI1K2lVNkhHb25GcnVidmk1VlRLREpRTzJG?=
 =?utf-8?B?SHo3UTErRlhCNmg3RlZXa0F6TXpnYVJJN1VPYk40QTRHN0RUVWtEYzh4bUYr?=
 =?utf-8?B?U2JRcFBKaUpVdHd5SFhEbEdnL2xOMlI5NUcyZmZ0Z0xYY2VsNEFkS1AwQmhJ?=
 =?utf-8?B?Mzd6VDM3c0sxWFIyT1JSNktxcWJERSt1cWl1Z1hHa2dXMjBBUDFwcEYwaGsr?=
 =?utf-8?B?Q0IrajBSZ2lvM0FzNFpwWUpHU2YyWllMMWthRnRBWmRPVENjbE9ZZ0RDWUZG?=
 =?utf-8?B?bHNiYjdKdW1uc0lUM0U2dFIwakI4TS9DZUF0QWFscDhtVVVCaWZydk5YZnQ3?=
 =?utf-8?B?L3IveXdubmVNK0NHeFBPZHJRek4wMWFDblZtckpsVUJyaUhxTUNtZXFKNTE4?=
 =?utf-8?B?UUtZQVJMY0VKWFl2WFphLzhvYVplUWhsUGI2TVVQQUZaWWRCVkF0KzFYeks3?=
 =?utf-8?B?SW5uUTN2cGhHWVFGL0NQZ3kvVE1nNWhwS0o4MDhxTlZocThIb1c0dmRPZEgy?=
 =?utf-8?B?L0tyZERYVHdOUVM0cEQ4cisxelZqYWRLV09VTzJHU3ltWXJUV041a2piYWJk?=
 =?utf-8?B?b0Q5THRXL1VGVEI2cDduNXFUQzE0TlV0RDdWOXhBbUdRQ2lLY0lPdjhtaVJw?=
 =?utf-8?B?YmVWL1VCM0kwRENBb0VrekZUVSswV2xJb0t3b3FCK2huK1lSMHl0eHBqb2Nl?=
 =?utf-8?B?Z3N1MTlTUWZqZjJXN1QxTzNxU3h0eWk0K1g3ZGN0WnF1dkJ2NkdsUERYUS9z?=
 =?utf-8?B?OW1ZWWI4Q3hkQy84S3A0d1F0cm1JbXFxcHpEQTcxck1FVkRINjdXWW9qTFpF?=
 =?utf-8?B?czlZWUplZkNibkxiOW1kREJ3QWIwazdFWm1wTzJONkJ6S1IxMmowb1E4Nm13?=
 =?utf-8?B?cmxvN09wUlp3V3dCRHY4RXlXOHFEVktWbUNDVnNobTh1YkVzN256c082SjZG?=
 =?utf-8?B?dlg2encySVhuVklPN3FGa3ZyYWRJU3dCOEFieFhRUTkxT21YN0hJQUpYK0xJ?=
 =?utf-8?B?VE43MFU4YVQ4Uk8xMnd5UmJlS00xOEQzN3FWRmRyRzVBejJYRHFGUVNMenpI?=
 =?utf-8?B?UjRRUjh5YVMxdS9CY1pxMUFPczdVWGg1dzFMd0JzNUplZmkrRDhwSXo2bGI5?=
 =?utf-8?B?dGp3K0xxWXhyS2x1WWU4R2l4ZmdxNzY0K2s0bHpKc1pDdFFreVg5WmVEeXVm?=
 =?utf-8?B?dmNsU0dySXVSY1dOQWJFZStPS2JScjU4Y25pL29aNTQwUk4yTGRDTTN2ZGxi?=
 =?utf-8?B?a1ptUDY0SXhJVFRQbnBBUWtTYTZvTGJkbDFRUk9zZ2ZEdlkxZnl0d1VWUWdT?=
 =?utf-8?B?MVovZDFYMHlEekJndUhEVkZuRGMyVUFPLzRhMTFieXkvRE1GenJkQk1mK2dU?=
 =?utf-8?B?MEZQbFVjVjdmL0s3bkE2WmkxdnpsbzZDNjBUTEI3MEtpUXo0Nkp0NDhIb3Zm?=
 =?utf-8?B?NzJRb1Bha2NFMk1EWCtnTExNeU1jV1J1UjJRMWtZU2RpUXgraVlLWllUWVhj?=
 =?utf-8?B?RlB6d2lMb01odW5xODlOOWx0ZjhTZlZZWXBOUjF3ODZSTGZFMkh2OVF1Zjk5?=
 =?utf-8?B?dmEraG8raDhEbmRHclkyQUlid2pCMFMwQzZvOTVtenlEd2Q3ejFnWXQwY3Jl?=
 =?utf-8?B?WGlMc1Q1ZS90UWZrSFZGZC9rN0x0OGRzTDRjQWhPdTY5ZTYwdkNNaGlaTmtK?=
 =?utf-8?B?dGxNeUtlRmNtTUhxQzFHK29yRCtMWXZzRVZ3NW1aYWQ5UHVTYWVYNGR4UWdU?=
 =?utf-8?B?VTdPeUlrSWU3MUNLRXNUdjRiNm16a1psaDVPcHdCSHlkdjZXZmZvUTBNVWgz?=
 =?utf-8?B?cVZMcGlaLzRmMkpZQmEyM0hlNmdvdVZ6dFVzT01VRUlzWG9iN2RqSzNkZ3Jq?=
 =?utf-8?B?SFo1d0RlSDNTK2ZqZDQ4RWFqbTFuNGNtZXBQMFJqcXFpZkp4a0x6cnI5ekRJ?=
 =?utf-8?B?bXArN1lRTlRFdzVJWHlHY1BmNGRGbDJDdHJXcmlqREpIQlU1RWduZmQzVlhC?=
 =?utf-8?B?VXo4QnQ1dW9peHBWNDd3YUxwdmN1UlRjNE9qdXdWRERtZ2xLWGt4dHN5WWZP?=
 =?utf-8?B?dEE9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb9d7c5e-66c6-4897-9d7c-08da64c9f879
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5444.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2022 12:19:44.9238
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B6yHyklDXbkkOLRx/7Sa39VoOevoAbm7NK8hszYrqL1eYkITrdmloZomGAlpEltV5a75M2SZD6vG4e+9jRTWxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5825
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


On 13/07/2022 13:14, Arnd Bergmann wrote:

...

>>> For the other patches, I found two more problems:
>>>
>>>> Bitan Biswas (1):
>>>>        soc/tegra: fuse: Expose Tegra production status
>>>
>>> Please don't just add random attributes in the soc device infrastructure.
>>> This one has a completely generic name but a SoC specific
>>> meaning, and it lacks a description in Documentation/ABI.
>>> Not sure what the right ABI is here, but this is something that needs
>>> to be discussed more broadly when you send a new version.
>>
>> I wasn't aware that the SoC device infrastructure was restricted to only
>> standardized attributes. Looks like there are a few other outliers that
>> add custom attributes: UX500, ARM Integrator and RealView, and OMAP2.
>>
>> Do we have some other place where this kind of thing can be exposed? Or
>> do we just need to come up with some better way of namespacing these?
>> Perhaps it would also be sufficient if all of these were better
>> documented so that people know what to look for on their platform of
>> interest.
> 
> It's not a 100% strict rule, I've just tried to limit it as much as possible,
> and sometimes missed drivers doing it anyway. My main goal here is
> to make things consistent between SoC families, so if one piece of
> information is provided by a number of them, I'd rather have a standard
> attribute, or a common way of encoding this in the existing attributes
> than to have too many custom attributes with similar names.


Makes sense. Any recommendations for this specific attribute? I could 
imagine other vendors may have engineering devices and production 
versions. This is slightly different from the silicon version.

Cheers
Jon

-- 
nvpublic
