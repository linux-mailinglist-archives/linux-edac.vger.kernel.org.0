Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 256C44C037C
	for <lists+linux-edac@lfdr.de>; Tue, 22 Feb 2022 22:02:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235668AbiBVVDW (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 22 Feb 2022 16:03:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232052AbiBVVDV (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 22 Feb 2022 16:03:21 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2078.outbound.protection.outlook.com [40.107.220.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35630C3C1E;
        Tue, 22 Feb 2022 13:02:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PX0DfolNEnNU9aKgfyd+TkaNb6TgWSFPVDsAdXcZslV2tM8cxblFGCNL5IIS04V0knfYy5vpgGlKh3XE8veBpEXv9Pydxlm7fqWG0ANOxH1QZomreD1AnGVSTi8SGLZH4lfv+wUPezGO1lHbCtlzqZ83Kn8VxaDrfssgYo+jlh07tsJX+r+zhrtChPg4AQiS5dx9sCyhN+t4fXymaq+IoVPGaH7zstpbCf/nmU28/i4oFsN3ndDyW9PbFVcoifLoTHZQZjiSKa94vr8yQmnqWSBTa2fEFFus1p2bmmOZkoLALd9jgSXaOOEHcfmQo5Upc86M/FQ+1NU0SoHK81nOWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GUy5JZYCErp4LSwjjWCdEor0hjz41G/QCYygKl9jpoQ=;
 b=eOoDLwMcK0DbQlYIxOoj106CUDF9M1kwnYkr0DFOXfeBqdzkazJJjELC52U/AANr2VfNogQSzgfgS+OfNROthGNhSf8q5iNMkJmDuFVToc8Etc2fn0aA+BuTvKHr38y8xmCO2ZG/OWuQReaBrPXFpW27a/q5KVpq+1PnbHuphoM8e6Z2JJGxJJDfUqT9cs4lMdlF4V6PmseKnD/JnHdZ4ogcViXCtTpLtR7HTK2rj7IePTn1pbtKIv7MjBKaKQXasxJMw7c0NPpv5UHsIHNJ81W6nBcxNw2FEJsN3Z5ak/LFOUUR+xdJEvcIX5wEwQY6CF7MeZBdlSj8RV8hcaTYDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GUy5JZYCErp4LSwjjWCdEor0hjz41G/QCYygKl9jpoQ=;
 b=XnBXM67reZ+o7is/mnwRLWPsEDMKdX1YVwWKddDamYvH/baynpIfYP4q+kqgUFVWjuH4nJozZYTlLaxUfEdoh+7e7IaNAu6aZ5codl+Wv+ozTp8vgiCgPvYNf8iVl9tor4ydmekJbnKsF6u3aqIUY3mDGWTd7D0KfcmUD58qdgY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2876.namprd12.prod.outlook.com (2603:10b6:5:15d::21)
 by SN6PR12MB2638.namprd12.prod.outlook.com (2603:10b6:805:6f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.24; Tue, 22 Feb
 2022 21:02:53 +0000
Received: from DM6PR12MB2876.namprd12.prod.outlook.com
 ([fe80::50:f1fb:173c:23b8]) by DM6PR12MB2876.namprd12.prod.outlook.com
 ([fe80::50:f1fb:173c:23b8%5]) with mapi id 15.20.4995.027; Tue, 22 Feb 2022
 21:02:53 +0000
Subject: Re: [PATCH v3 4/4] x86/mce: Avoid unnecessary padding in struct
 mce_bank
To:     Borislav Petkov <bp@alien8.de>,
        Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Cc:     x86@kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, Tony Luck <tony.luck@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rric@kernel.org>,
        Yazen Ghannam <yazen.ghannam@amd.com>
References: <20220211223442.254489-1-Smita.KoralahalliChannabasappa@amd.com>
 <20220211223442.254489-5-Smita.KoralahalliChannabasappa@amd.com>
 <YhUC+T44sQK43+QZ@zn.tnic>
From:   "Koralahalli Channabasappa, Smita" <skoralah@amd.com>
Message-ID: <56166aca-8605-ec6b-6ccf-d76565518421@amd.com>
Date:   Tue, 22 Feb 2022 15:02:50 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.1
In-Reply-To: <YhUC+T44sQK43+QZ@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: SJ0PR05CA0168.namprd05.prod.outlook.com
 (2603:10b6:a03:339::23) To DM6PR12MB2876.namprd12.prod.outlook.com
 (2603:10b6:5:15d::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 96f74787-f6da-4de1-5df0-08d9f646b131
X-MS-TrafficTypeDiagnostic: SN6PR12MB2638:EE_
X-Microsoft-Antispam-PRVS: <SN6PR12MB263890E30D130162CE9235DD903B9@SN6PR12MB2638.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZCjIU8ofR//GpDKk9i2Y/EGJRl48b1My9636vWz5xfoDIiF4bXYhBSF2Wcdu+vHRbRGB+YQ9sYw4RnZ2EppBw/kBHOWfzv+RoFk3T3J2K/p5/veH/iCllkVHFY6knzLFH7LGRbI6pGDfI+4RnpOqL9yRor+9uTmc5i2PbcPXrc/v37DNB9UJ6CRk66Xq4mhuuycKypNjxBd7tYAQz2BRlAiH1uSm91qL+dMSX5q6j9kb3qMGrbLqBx4EG6E/H0cupA+jprbvHBKw/q5yubvPTQkW9MIBWRpKsTsNKBs2xJrXJ492VntCcIRiob3il/iqQFg+VXppl4MtTJPK7TQ229cZstnh/nMuWM+nJb6SWnm8AslKPannONhRntbKBT76+WZA77CBnTzS1WlKEKYcspo0HM/xXYVGlsJh7QWPMvfCEMk+NEPbzNCLqRo1pjp0bBDWwDazuSO2nNbHPgNaitkVIm/SrVIPZVIU93YNptbHCxyCA6tcpevM8wButo16DKLQ0Vx21dJxDZSoZSTq9Nlgi3SUsxZP4zPNZrFZuoEer/jDeIyPRcgNpt+sYinPkl/XMQNj73AboyyiRNH1FWbIoJHUQsdrMxgDJD/W3Xu8GMaFnHXrEIEb16dwtHCK8Sd38iWYdS5tpUexoCODShK8VwUnBBZMjFgk4DO5224RoG123WafrAYqC9/SAQpvuY8uPrZ5A26dYfhKZMczyk+oJOKozy70W2sq2ayXUe/6BUIMi/0f6wtSKma4S4vK
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB2876.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(8936002)(2906002)(6506007)(6512007)(5660300002)(38100700002)(508600001)(31686004)(36756003)(186003)(2616005)(53546011)(4326008)(83380400001)(316002)(54906003)(110136005)(31696002)(66946007)(66556008)(66476007)(6486002)(6636002)(8676002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Mzk0UGxhL1QzU0lhbGx1ak5yNUlENEN5Sk9iUXJUNlF5U3FmMnRDaFEycno3?=
 =?utf-8?B?KzY4UnlWUjhnL1cwS0VMU2g0VUE1ZGVHYXRDb3BmU25DM3c3WmRzbytPU3VL?=
 =?utf-8?B?eGJGMGlWR3RvWXkrTVU0eUJ2eE80V0NMVURvcFpoN0ZKU0F1d0k4c2NxN1Vk?=
 =?utf-8?B?aEtwcW5RL3QveXdYdys4Q0RKQUd1VDBPQy91TThTQ0RSc2p3Szk5bnJ5eEhT?=
 =?utf-8?B?Y2Ztd1VFRnQ2ZVFvNDd4TStGN3F4MGJZQytFUHprQ0tEWnEvV3puUURCNDBI?=
 =?utf-8?B?Qy9DVlF0WGZMUU5DNlF0TGk4WnFZbVRJRVFzVEIzYUpmWXhueVlvSkVnU1dL?=
 =?utf-8?B?bWZnb2RPYUx4VHptRmJ0YTFrUWZaNUhoeWFwc1pHU040U2lOaFZmNDVaV3pW?=
 =?utf-8?B?a3l1YU1KR0hCRVlqTVBJVi9CWVEvVHhRMXk3bzBEM0I4TU5yNVVsc2tFek9O?=
 =?utf-8?B?WmJCR2diZWhwektRS0ZuY1dqQndIeEhwN2NueU0vQjlYUUJGWlVrSTVpK3Nw?=
 =?utf-8?B?MXZSbVg5Z2Noam9PcFB0MnViQlNwVmM3Sng5Z1VqR2UrWGFUd0Fqd1prNGFY?=
 =?utf-8?B?Z2dmcDY3ZzZLWjZmeDlOcmlWM3RGRmpUN0ZrdVhyS2JLMExEZXZiS242TDBl?=
 =?utf-8?B?UkV0bmdPTUhBR2J1akRGd2JFellOSkhoUzNva3E3WE9EVVM1Q0srd3ZoYTJ0?=
 =?utf-8?B?aUFZRDNFeFBwRjR2R3RUTGp5dDZrZEN3V0FNejZ2V1RYNmVaOVpYUjhwYUNx?=
 =?utf-8?B?TWhDK2NBSHFDTkp0cy9zajE5Z2svYm5yRWNsK3VPazhrSUd2dGdHWE5MaGFz?=
 =?utf-8?B?WWRuUHE5VFZoZWE1MWlKQ3RYajJTcVdCazlKaUtENkMzWVFxMWc1a2NwTzV4?=
 =?utf-8?B?Y0QySVJxaC85K1BjRWlUTUFLQWpxMlNoQ1BkTW0rTGswUHBOSWJFVXNtQ0pi?=
 =?utf-8?B?M2pEaFpQSS9NbTRhSjJNZ3oyck5zam5ZcGE5ZHJMdkJ0bjBVSXFQMk41c2Er?=
 =?utf-8?B?QkVndHZsQ056V3dCZk9hamZvUW1JQmpDVkFqN2F0djNIZU1CR1AxdFhxWmtI?=
 =?utf-8?B?dnZRbko1UXhXaE5yU1oyMHRGdzFKS0VpKzhRclErOHAwLzFPVk5peXJ5b2N1?=
 =?utf-8?B?ZVNrbmVRempoZjFZNnZIMmtvblBqTHZUdkxNeUhlbVBBZWRvODZxQmphd2dD?=
 =?utf-8?B?Y21nL0hlZkJOSGlBUyttN0hKMytZY0JiVk45d3ZHQ3RYWldWMGNWK3ozVHp0?=
 =?utf-8?B?RWRVbW9mMTdEYU5adkc0ZGpVbUpKMU1waFR2d0ZPeFBOTDFQQ0J6M2o2QzQ4?=
 =?utf-8?B?SXZRUk41c3JBWjBkWjc4K0JsRjI4d2hoVEN1K2svWTVoaVBtRkNQTkVyeXdM?=
 =?utf-8?B?d3lxcnRUZmdZNFJ5aEt5VFd5dWVxWkdRZmFTbmdmd0dIVWlaSnFUbW1nSWJ3?=
 =?utf-8?B?OHVIWStoeVRrZ2lGZEN2TGNiNXVERjVCWUZhd2dnVmpOWGduV1d6dDhpdmwy?=
 =?utf-8?B?TGhVSnZ3WWhRQ2c2bTNkZU50Sk9Sd1NXYm5OTk4yajl2YmxtOWVaVGhkeU5h?=
 =?utf-8?B?NG8xOUxQSTBnT3BtVUtJdUdHcC9VTXZpa0N3WTlvWEx0Q3hLYUh2NUZ6c0Fy?=
 =?utf-8?B?VTE2ckR6S3Q2WHFVNnByc0M5RE5QY0hQdmhuTkwyaFE0bDNMNzRzSTF5aTJU?=
 =?utf-8?B?ZVVCbXpKejUySTZNUk9hN2pzZElGdzB3YWhaV0RHU25jWTgrVmpLZ0FDc3gy?=
 =?utf-8?B?NjZSSExpR0U0QngrYUpGT1IwclVDYWxKVWxkK1JvOXdCbUNLeUpGMlY3N081?=
 =?utf-8?B?YUFRaGc0a2tKaGtXTzdZSGRJZmlUNFZva2h2aVN4MGtHa091NTFUZUM3L1RT?=
 =?utf-8?B?SS9Za2RtTDhuVXRYaDdIRytQNXUzRUswZ2dtRSsxRnJnaCtZTVV2OVBSUGxP?=
 =?utf-8?B?MTcyNkcwMm1GUVFXYXQ0d0pteGVWWjhWTUhIWWZlTk5NYVVJRE44dTBKN3cx?=
 =?utf-8?B?UHJyenpSZE0wMmhGT01SWlkxYkRIME5GV3FsdWpLQTJIM3AvRFZPYzJ3T2FR?=
 =?utf-8?B?RFJSdDQwK3ZSNGhtbHdiZERubkRzWmlCT1FmWHRyUEV2MW9Ob3YrcVJCYXBp?=
 =?utf-8?B?T0N4N2Y5M0dZbElhVlFFUUZOa3RnMEd6L0JMMVAxZWl0MlRYcW51QU9nUjFJ?=
 =?utf-8?B?TE1aVlRiYmc1T0srMDRTblpoVHptdHdsSFI4b0Fidk11Um44Tk0yYjJMakNx?=
 =?utf-8?Q?qArtEM3/cO0QsxO7b69S53yQ2AiR+OCyOL6kgwnvDc=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96f74787-f6da-4de1-5df0-08d9f646b131
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2876.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2022 21:02:53.5425
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PHgrLRtoSpgoykC7DZo3WlbtpHXPYGqCZPIAFaeroNBEecu8bLIJtfEpmltOYgSlGKil0tj3OCQ5a2fH9Z05zg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2638
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hi Boris,

On 2/22/22 9:36 AM, Borislav Petkov wrote:

> On Fri, Feb 11, 2022 at 04:34:42PM -0600, Smita Koralahalli wrote:
>> Include struct mce_bank member "init" in the bitfield by changing its type
>> from bool to get rid of unnecessary padding and to reduce the overall
>> struct size.
>>
>> Outputs collected before and after the change.
>>
>> $ pahole -C mce_bank arch/x86/kernel/cpu/mce/core.o
>>
>> before:
>>
>> 	/* size: 24, cachelines: 1, members: 5 */
>> 	/* bit holes: 1, sum bit holes: 62 bits */
>> 	/* bit_padding: 2 bits */
>> 	/* last cacheline: 24 bytes */
>>
>> after:
>>
>> 	/* size: 16, cachelines: 1, members: 5 */
>> 	/* last cacheline: 16 bytes */
> I don't mind cleanups like that but when you send them as part of a set
> adding new functionality, the usual rule is to put bug fixes, cleanups,
> improvements, etc to the existing code *first*, and then, ontop you add
> your new code.
>
> IOW, this patch should be first in your set.
>
> Thx.
>
Thanks for letting me know.
Will correct and move it to first in the next series.

Thanks,
Smita

