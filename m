Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BE7A44204C
	for <lists+linux-edac@lfdr.de>; Mon,  1 Nov 2021 19:51:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232109AbhKASyS (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 1 Nov 2021 14:54:18 -0400
Received: from mail-bn8nam08on2086.outbound.protection.outlook.com ([40.107.100.86]:20677
        "EHLO NAM04-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232027AbhKASyR (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Mon, 1 Nov 2021 14:54:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NXbFXkIykUz0ZXLVgyigCgh/LbJNTtc8qmoDOvzu2DtOpLikJAgOn2e/52EbinWH0nFUbht2ssqp7cX3SNS6H0pGEyIhlipHRBNsBdHZYaqQVhrCINixkXgQhTGzehRLzJ7fTku22oBkY2n2TVQdkHdpLswEz1p1/clwcDy3ny17aC+d7i+ooL9Pwi5gA9qcAeVnEGBTFXbFq7bzW14HpzDJTBtJgdgEBUpDbmIR+i2LHFVAY1rLSqR11FGqwvBPsVQZSaqwJuufXssvZc+NIO1t++iL3MEJbmOULfSsE7yYycIzsEl10TnKtIQvlIV+2CGfZ41TOv6C1kxMsi6BUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2k1zImtbs3HLb06kVdOaGMdi8YR6zd1epASB/uhM2sM=;
 b=ccd5NpAjgqHi3sk6oMF5Uze3jsafHmW5NKeaBT52CU0cj71+ngjuYUTSoLkWcBpZMJ/AbQRbp3vp0s3CA4s2YHI0KRkUXKuYy3Epr5UsKtawmJ60wxBwDDXiER4bL+RBpiUGQNeEnw2aVB7siOfJ+3Gti5Z7cLyWUa86HoUCT7jffwUxaxopSKmS4HmD49LnAvr0Bwaw+jProeFU/ZZUeJ2PlXHY1mwBn6KZlfdj6MApFyuhveh9e9dadyP66e7dcya7MM0j4E1esxjzdi/5UapfFTRFB+OnWNfqBuG4ytBC7TaOpVzvS0wj6ptsUA6Z7mct7cxsZK0mLoyD3e6Q9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2k1zImtbs3HLb06kVdOaGMdi8YR6zd1epASB/uhM2sM=;
 b=jtEbaA+CRQXyLi2J1bXRSO8RRYj+70UufSZCMPpcf7cQcs9GsytnYEUDoxV/62hurnVGcMIFMB4t1Es59cRTjfNhD8nu3Ixv7YNtL4UAW5xZUWBFXhkaXI4bo/cORTg1kJUzVCWs3G2rxrBsV0yMkh8bBvFTjiKqELNNMe2w9ns=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB2869.namprd12.prod.outlook.com (2603:10b6:a03:132::30)
 by BYAPR12MB3493.namprd12.prod.outlook.com (2603:10b6:a03:dd::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15; Mon, 1 Nov
 2021 18:51:41 +0000
Received: from BYAPR12MB2869.namprd12.prod.outlook.com
 ([fe80::758d:1b96:8338:9f86]) by BYAPR12MB2869.namprd12.prod.outlook.com
 ([fe80::758d:1b96:8338:9f86%7]) with mapi id 15.20.4649.015; Mon, 1 Nov 2021
 18:51:41 +0000
Subject: Re: [PATCH v2 3/5] x86/mce: Use mca_msr_reg() in prepare_msrs()
To:     Borislav Petkov <bp@alien8.de>
Cc:     Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
        x86@kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, Tony Luck <tony.luck@intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>, yazen.ghannam@amd.com
References: <20211019233641.140275-1-Smita.KoralahalliChannabasappa@amd.com>
 <20211019233641.140275-4-Smita.KoralahalliChannabasappa@amd.com>
 <YXk6z9xWvS4B7eRP@zn.tnic> <f5287d1d-bb2b-bb9b-1b33-f6692eaeb566@amd.com>
 <YXplCF5ccfbl+dGg@zn.tnic>
From:   "Koralahalli Channabasappa, Smita" <skoralah@amd.com>
Message-ID: <87bee2b2-4e62-b159-75fb-22f9abb5ac68@amd.com>
Date:   Mon, 1 Nov 2021 13:51:38 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.1
In-Reply-To: <YXplCF5ccfbl+dGg@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: SJ0PR05CA0088.namprd05.prod.outlook.com
 (2603:10b6:a03:332::33) To BYAPR12MB2869.namprd12.prod.outlook.com
 (2603:10b6:a03:132::30)
MIME-Version: 1.0
Received: from [IPv6:2601:647:5f00:2790:7c14:e3cc:58f0:6cd7] (2601:647:5f00:2790:7c14:e3cc:58f0:6cd7) by SJ0PR05CA0088.namprd05.prod.outlook.com (2603:10b6:a03:332::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.6 via Frontend Transport; Mon, 1 Nov 2021 18:51:40 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 538bc358-275f-4a95-62e3-08d99d68a462
X-MS-TrafficTypeDiagnostic: BYAPR12MB3493:
X-Microsoft-Antispam-PRVS: <BYAPR12MB3493DDEDAC1A266D539E8A0B908A9@BYAPR12MB3493.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jDIPvNzF5w0vNJtSGSwj/AFoT4+4d2zJdvBGPx6O0tFqgYulq1ckD1GLVTJiMCv5TA7UgHjnJLsLy637BVK8adE+FXjSJ4vIxAKNozsBHAjC2QOkhTEbByY5baB9rgzqsJMd67kYRYK8JgiwV+wL2T/YIFaKdFsPIKYCJ/LG7ZcCn363nyRZKcYrPgBNlOKezzojbWs5Cwh2c9OFt0lsplHaqjy3Kt4ZmLycA+ojPXAyxGpS7wFqcfpF0k6iXyWtCSTiJ690N+N4qHO1/dfjb1dEUqOE+LCHcNDuGaNQMZB2cL4dskU09HZCV52aROthlusbG9esrb+BiaU8tp+2X5odjs9IAQKODxB9hMKjexXbCYEWFlDd3goH2SIdAqjcj14PIUWsxqQhCArR/ojQ8WtBg4mP+Xck2PBgHrbMuKcHNQbRkI2Fee+IEKhgjTBrRloohYBmYsa4yFYlFsUI3oa4R544EVqCOKZybVZ0AXMEzU9WP8xMD0UNvNwW90b92ABpzJQug68KAsO1B9KbRrwD/RX5pSOWnmYh1zpUGhRkbW9mfNF5QwWcL9b3X4Kj+rh1+e3iq4C0KjdrdDwPcrgiVcqeucb3fFFg22PpY+KawB7xODVRX3sgj+5gXQgce1r5vf3asgGXs6eEM23lO5AaY1IyMyY464ZzwaONksDpE/62MmoNPk2vBtHjBwJ/o0gtY2lK7ORSUiJgZqPakSzoD+QotxHKimmw3PIb9fw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(53546011)(54906003)(4744005)(6486002)(8936002)(4326008)(316002)(5660300002)(8676002)(38100700002)(2616005)(31686004)(2906002)(66556008)(66476007)(186003)(66946007)(508600001)(6916009)(31696002)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?amhtR1ZNUFFHSXZ6cUZlSUFkZk9oa25aT0tyd2NOZnF5YytHNzNRZURGV2xV?=
 =?utf-8?B?TlZpcm9KUzl0UEh6RTQ2eGkxMHBINGNITlc5dVlGTDBGR0dHQkhWYTZYeWR5?=
 =?utf-8?B?SnQxR3JaWkJjMi90d0FUSHRsZjVWN2padm5wRzV3SXBlVHR6cVhNV1VodGdp?=
 =?utf-8?B?QUdDS0tsdENXbHR5WnlvZnBCdUZxMk84VmJzLzZ6VldPaHJER2REM2p4Wk5W?=
 =?utf-8?B?QjRNMGE5NjA2N1dOam5ZTFJZT0pBeHRVMzBjRzBnQ1R5cDRmS3g2dXZKeTlW?=
 =?utf-8?B?dFNVVW8wMEpIUG40ZFhVd3ZXY1BjWk9yL1NtbDZvUFFtVG5oK05lbUFHSTdZ?=
 =?utf-8?B?aWVSZ3NFVTlRTVJSMnJhQXFBek5sbDM0NkhZRzhLVnBRclVucFZJZ0c1RDZj?=
 =?utf-8?B?SGhIMjNxSzJzZGo1S1ljWnNXVVdmQ2YvWGlFR2I3L05CeGxlUkxIU29GNjQz?=
 =?utf-8?B?OUNQN1JvVGxJMmt2cXRuYUtIaXNNaDVhZUFlSHVUYTNRTGlNMzF4TjRWRlRj?=
 =?utf-8?B?Rmtoc0RXa280andJRFRUSE5RUVBMc0RtSFBFZ3JpYjl6WlNVS1Y3cDdvWkpl?=
 =?utf-8?B?ejdLNFpxOHcxTkZTNEQrRGRIald5UTMvVzV4WFN4eFR6Vk85eXVaV0E2dmZj?=
 =?utf-8?B?WUMrT203M3Mzd3ZuSE9xeGJRQnJsT1lEN0JNaVBzaDlJODdxamlYVGdXZmxz?=
 =?utf-8?B?NmovK0FHaSt0WkJ2UHpWY2d3dFRhTjJHbUh3ZndpUmZMOUl4NkpHcFhmdWx3?=
 =?utf-8?B?ajJsMzUyeUhUZTgyLzYxeVc0TENESnJlUmpLOFUxWU1vemZYZXVpdm50Q2V1?=
 =?utf-8?B?MXdNL29Zd216Q2dUTUd4RjZqT3A1ZWNZc09NUTdDeHROTyt4clRMcmpOdC9R?=
 =?utf-8?B?bHR5OGRqWW43UHpLOVFLZzlaY2V5N29qUzBGeVErY1FRTWtKSFpNc0JvWVpU?=
 =?utf-8?B?ZFYyRG1mL1Z6QTQ1WEM2SStJOVh4dGZYOEpwOThYSHUyR1NjNTBxYlZhZXdv?=
 =?utf-8?B?eUlPV1d2MUllR0l4NHNBWkkyQS9rSmpCdnFmbjlZZ0tGRmErMWloWDJrR3Fi?=
 =?utf-8?B?cmJHWWF5eGpiY1VnY3VYcS8zZXJTNHk0Nm9IbkFNZTR2MGcvMzV2bnU0WmtI?=
 =?utf-8?B?bXpxT1Zkb0w2MVJzVVhDaDNQdEgxcU1VOFo1ZmpxTGlSMXBEVUtramY5WWNm?=
 =?utf-8?B?emU1aWgxSE9uZ1A1bzFkSWcyNVJpQ3pwT29xZXl6dGdxMFFiS3NkazJrQkhv?=
 =?utf-8?B?RlFKb09CZjZSUXF1TGxiTUlzQnF5UDJ4YXlVbysrSTRGUHE3K0M1Njh2WW5M?=
 =?utf-8?B?L3R0ckhVdHgwRWlvUHc3VERqZ3MvYUNvQWQ0akNJZVRpbmJKWVVHcG5uUjF2?=
 =?utf-8?B?YVZqUmtoejFiczdTRWdac1NrdlVCVDljS3pja0ZyTG1GVUdmUy9MTHB3d0Vh?=
 =?utf-8?B?UkNwUTQ4U3ozWFgwbklvMjh3ZmJVMzZLcHZUejRpYjZQM0MwdGxPYWJoR1JL?=
 =?utf-8?B?TjJKQzcrWUdpL1VKekl1V25WVDFxTW52cGZlVXRmcFdlOC9DdHBkN080NlhD?=
 =?utf-8?B?aUtCY3pWWTRzNHVZaWYya3NtNHEvRmo0WGVJMzJBb0Jvc3BIRTNWclpyek9H?=
 =?utf-8?B?LzJ5RU4xaW4xdTZyWnpFLzNWQ1FFK1ZmeUl4cVB3Tmg1VnhreUp1Ukh0WXpE?=
 =?utf-8?B?RDFqaWVNZTQzTmMybEJSaDBHZXEyL3NXU0djNnM1VkM2bkpzdWdKak0vYUtn?=
 =?utf-8?B?SzJMTG5OdzNMditZY1lsZUxmRzVicUVYVHNCVlkyd05OYTFZcW5sc0FiSVZV?=
 =?utf-8?B?QnE1T0h1TFM1SWFTUFJkc3cvSmxqSUthWjRDY0srV0grcW53NkhHVUZQeVI3?=
 =?utf-8?B?UnpJWUhRdDQwbTBpdGVzdndES2Fvdm9DYnF5eUhGSk56ZW05blpzN2Vzck9w?=
 =?utf-8?B?VFYyLzMvVUdGOWhnRlhGM1h4MkMyYUlpN3gxUmVBTm01ampnYzl1dGl4d3Nn?=
 =?utf-8?B?dnpTb3J6ZmhSNnUxVStQaTE4MGtGRDk4dEFic3BJMmE0YVVtWlBtSXh4N0pF?=
 =?utf-8?B?UHBscEtzdDh6bmFRdUN0WWU2TGpMVGhXRUM1V1FpY2hXVG1iZWh6eWRwZzRY?=
 =?utf-8?B?eGpINkdFN0FHeW5aYXJXMnFOcE11Q3ZkdjlCV1VNcFZCSU9XM2dxZFZZTTcw?=
 =?utf-8?B?Q2F2d2x6VU0xc0dCN2JQVXF5MTh1WkhqYUY3aHNaQUdRMlFpOGQybHNva0Ex?=
 =?utf-8?Q?gyxh+D3R/0nlFGFfs0jfwb5yIh5F6o4F13GOy+3njE=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 538bc358-275f-4a95-62e3-08d99d68a462
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2021 18:51:41.3034
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r2Aqikxi5ovftKRdqC+gZiWol3kjFB7VDSHB/7mgkT2722xp/jcYIJVAIz2LNbSbPVeyqtYurWX/iUsKHn0M3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3493
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On 10/28/21 3:53 AM, Borislav Petkov wrote:

> On Wed, Oct 27, 2021 at 03:19:51PM -0500, Koralahalli Channabasappa, Smita wrote:
>> Multiple initialization here I mean: Initializing the MCA registers twice.
>> Prior to mca_msr_reg() replacement, the MCA registers were initialized
>> separately for SMCA and legacy processors. However, this is not required
>> after replacing with mca_msr_reg() as it does the job of returning the
>> proper MSR addresses.
> You mean, there was a simple if-else statement
>
> 	if (SMCA)
>
> 		prepare MSRs
>
> 	else
>
> 		prepare MSRs for !SMCA
>
> which did the init for each type of system in one go.
>
> But frankly, your change doesn't make it more readable but less - you
> have a goto label now and another SMCA feature check at the end. Vs a
> simple if-else which is trivial to read.
>
> So I don't see any advantage in this change.

Okay. I will rework and remove this patch in my next series.

Thanks,

>

