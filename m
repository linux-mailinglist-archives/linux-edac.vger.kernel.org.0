Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9575543D2C0
	for <lists+linux-edac@lfdr.de>; Wed, 27 Oct 2021 22:19:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232025AbhJ0UWX (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 27 Oct 2021 16:22:23 -0400
Received: from mail-bn7nam10on2055.outbound.protection.outlook.com ([40.107.92.55]:12833
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S239306AbhJ0UWW (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 27 Oct 2021 16:22:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UcvL+uRMrYdVUO+4D59beZwSKIx7Cermgm4lEy7C4EM8nBui+FOW60Ey2G+CrTHdGU4Yeisjhy829cZVTxmXQnQ61v8uQD44SqNFa/ebOYd+ZLHY9svmAl6LTGa+pT7X1ZhlIlzHym9FvZ7STSKmYN7rXZ5dV3QHidbcDBmacVchk2xw7lZy3SNuLjsNQRBVSCqbNa+HcyTLjqipW5FBHTDVxJoAJXgRkdqEeCmRv6jJ//5rYGHJgsXhJZfvBSE0gi1dN0rCPyGy5rD5nY47wz7FwKBA8QS2Sx+YbH+YmFUPNVprQzN4lmZ6tx3dWBPqXmnaEIQZjAwI2lRSHTYd7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IuTtNVfMsxFYHLHNI5fC60FahYfMN6tNICxhiPWEFxk=;
 b=dkDg9pZHAFnkDKm2cRsfRk33F3LgshECOx4GPaO98MdWTu1NLnPYZu6l+BwT0w9dMFyjXMpOmRP/dqZJ3UWw/fkxO0hdXGxGeUt+kzjNtYJSS+QGu0z8lNdn4KPJ3wQ30zgH/7g7PwIxd1LgCVWw/DdzO25xeHMZ22YcELuO2/L3A/Akp3+hcxtARQb4pz8fK99KmG37+ShyTHE1821aBBh1zjupAKSfgQxztq4fxYozj6R8R+QWiWkYtY2KuvsAnIWv4bS/KM/+/1ApurDwPYSx9uBas9pr6PnFSELoTRrBjM9HWkthdX0aUO2v+Yw1ChK8phZxBnpn/jWAoQaYiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IuTtNVfMsxFYHLHNI5fC60FahYfMN6tNICxhiPWEFxk=;
 b=QXjTcQEL16Vvh1S+qyQ0+3bHI2w3R/Ckxe6BaxqgkEbVOB14Jaso3GkyndUaAHKkyaXrhjMxdsHVzAiO78oQ6gAt/EvbvzYsP1n1v98ADyR8Pu/SWF98pVvdTufAZuUGIFCLN+u2Y6wrOzBg18+6Y0WCQ+fCOqkO+KRDoswWQtY=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB2869.namprd12.prod.outlook.com (2603:10b6:a03:132::30)
 by BYAPR12MB3365.namprd12.prod.outlook.com (2603:10b6:a03:a9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.20; Wed, 27 Oct
 2021 20:19:53 +0000
Received: from BYAPR12MB2869.namprd12.prod.outlook.com
 ([fe80::758d:1b96:8338:9f86]) by BYAPR12MB2869.namprd12.prod.outlook.com
 ([fe80::758d:1b96:8338:9f86%7]) with mapi id 15.20.4628.020; Wed, 27 Oct 2021
 20:19:53 +0000
Subject: Re: [PATCH v2 3/5] x86/mce: Use mca_msr_reg() in prepare_msrs()
To:     Borislav Petkov <bp@alien8.de>,
        Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Cc:     x86@kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, Tony Luck <tony.luck@intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>, yazen.ghannam@amd.com
References: <20211019233641.140275-1-Smita.KoralahalliChannabasappa@amd.com>
 <20211019233641.140275-4-Smita.KoralahalliChannabasappa@amd.com>
 <YXk6z9xWvS4B7eRP@zn.tnic>
From:   "Koralahalli Channabasappa, Smita" <skoralah@amd.com>
Message-ID: <f5287d1d-bb2b-bb9b-1b33-f6692eaeb566@amd.com>
Date:   Wed, 27 Oct 2021 15:19:51 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.1
In-Reply-To: <YXk6z9xWvS4B7eRP@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: BYAPR01CA0028.prod.exchangelabs.com (2603:10b6:a02:80::41)
 To BYAPR12MB2869.namprd12.prod.outlook.com (2603:10b6:a03:132::30)
MIME-Version: 1.0
Received: from [IPv6:2601:647:5f00:2790:2066:52f4:f9ff:a8bd] (2601:647:5f00:2790:2066:52f4:f9ff:a8bd) by BYAPR01CA0028.prod.exchangelabs.com (2603:10b6:a02:80::41) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.14 via Frontend Transport; Wed, 27 Oct 2021 20:19:52 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ef76e4d4-b15f-4cb8-445b-08d999872273
X-MS-TrafficTypeDiagnostic: BYAPR12MB3365:
X-Microsoft-Antispam-PRVS: <BYAPR12MB336588B2CE0FEC5025B07ACE90859@BYAPR12MB3365.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2043;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: miftTx5yYtyKmphHuoBr/lHD576xNDzlzsQZ8rzCynGVHA9EU0iAzsPtE+hrm0ZlBVDhmGwMJr+fKLoZVX/0kS0JgjDt0SaXLwlDjQKWdQHtOfYZvgbeAp/Pb9eWSo6AxI29sL1E9b6Oz16QVut4rfpDTK6DgTgNfVAvWOZB2VG/ujwEsZ8IPl4tduvOrDcT1kCNARvd32pUWyeb3SXRMrgiSAN/jUqETMRNHQYincaABSoSw+JmLXeOC2IuEOCgQ0r9HOjOZup4FbjdNnHEGem0b3DRxpIj0m9fUApNEkG/K/gHozohFOiQVSCpFjC/NijWl68TU13fWeLsAQ/jAXrCklImDZlAtRrkSXYFxgAw6my1qSXaNM4h0z4P/FyBN03hJ+sIdlDsN0nIxJ9v04f2m0+vo8Il8siS78YEwRM0DnzzPgvZ1U4Ab4tFCokI+3UrHqKCLmViviU4Hp5WhvtyDLYRqgX3MOx50xEskKt1omdLE/HQcZGNVZ6R3zVIXkm0QEuTQqOqloyF+jeblorYXramSlxbFiEn3/dOpS4JZtudeuDmV2xXrMg/VZEO5Rr03ZkKvtI/pG43dBT+Ui0odm1aEXPmVjhY2ZMQkuaRqyDsL6iQji+dPJhpU/wW8/OpocgtfKl/tGo+F9Re1SKaiOsuAHA6iZEiCd6Wi15gn/vZ9HqCs8J+VOTHNvQ68FgPjjGBn2BGRxahXBM3rw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(508600001)(66946007)(66476007)(316002)(186003)(5660300002)(83380400001)(66556008)(54906003)(36756003)(4326008)(2616005)(8676002)(53546011)(6486002)(6636002)(31686004)(31696002)(2906002)(38100700002)(110136005)(8936002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S0xMWS9YQ0hnL0NFUDVGdzdtRkNkaE9UN3A0RWJoaVU5NG9LUnovZFBNb1dF?=
 =?utf-8?B?VjRMUEhKaDQwT2pzbk1SNnYyYXBMRit2NXlINVhxS3JVdmc3MThzVVFwUXgv?=
 =?utf-8?B?bzhIbHd6Wmc4V2xsaGhtV2p5elVrL3Z5YklWdkMwZC9rU2pPSi9jaXpqZk5G?=
 =?utf-8?B?LzhIcnhBYUxBWndaWkt6dGtQZ1VNWkFNVmJHTE9XZFlCNStxYy9BeTMvTWM3?=
 =?utf-8?B?K05vS2FOcCtSQnF3NnpNWGZYalVpL25yR0JTRWdjcysyNG9MZnR5dmRPY3VN?=
 =?utf-8?B?S2NCZjVvcnlXYy93TWtDUUIwVVRsWE03WVJyUS9WSEJLMHRueHVPSy9hWTQy?=
 =?utf-8?B?K3VkVWxEU1dnOUNiU1BUUHJUeDFvRENUQWRkQ0dsVkNTQmtCbnVDY1lyMERZ?=
 =?utf-8?B?d0Y5b01zQkJ1ZnJGMFBqWlNZWDdFbE5xd1ZtR01kWkZMdi9JZFJVeDkyMi8r?=
 =?utf-8?B?NlprSTBPTXlWbDRpeVFWSDdITnJBVjdrKzZWcjh1ZUViNVkxd2E5QWkrQlhJ?=
 =?utf-8?B?UnJNY1FCVGhLVFArakwrTXV3VUJQRndzYm8rQ2R5SklGdmpvSVdrWkZsVVFE?=
 =?utf-8?B?Rm1rTEdQQnlOMUhyVUMzbkx3amYzM1BTREQwSlc0djRtYUN0S2Q1SUtleEVX?=
 =?utf-8?B?S3N0MC9leDh0SkM2dncyaGM4REdDZmVPWjE1aXVRTmt6ZmlKc3NvR3l1aGg5?=
 =?utf-8?B?OXRPaDRXK2hCUCt5Z1VYVGhuRUIyMXVVclZmNm1xaTBOQmUxa0Y1cFc0am9S?=
 =?utf-8?B?bnU4QUVWbzNZOTZSSmUxb3lHdk1mRVAwa0R0RjRsMXFENDJuVGUzQVFKb0ty?=
 =?utf-8?B?N3ZJYWRtNnVUblJjaXEvS1lNVTdlUXlhUjZwSlA3Nng2TU56eG1kd3hLWVI1?=
 =?utf-8?B?VXdDSXlCQkFXYVk5RE1nS2FnWjNYNHFGbk0rUEtOVkoxN2p0d1dhUmJhejdW?=
 =?utf-8?B?UGt0QkxHbUI2enJhZmlHVXU4Ni8xMWRtM3JRQ0ppY0J3Z1ViclpwWkRWVjUw?=
 =?utf-8?B?WVNLWDBpK3c0dHpGbk5KTkFvS28yWVpqNTJTQk8rc3FWQlhDbWZsYkEzMk0z?=
 =?utf-8?B?SWJya0dtb3lSRm9zK0ZCeFZ2RFVhVlAxWGR0NytEZGRCOXZjTGVSUXBvZUk3?=
 =?utf-8?B?ZmN3UDNkbUVjbnhoTDh1M28wZGJ5NitqYUpmV1o0NTcvbkhES29kbEtZMXhR?=
 =?utf-8?B?SEpjT0lPY3pUd1lncm9xcmRpOEp6ejl5ejEvZTVLVjVyemM2eHZhUzc4ZllU?=
 =?utf-8?B?b0R4eUZTeWJ4VzFTL3AvNG1hNWlZakFTcGpnTXFaWGI3N1l0UDVqbU1lRjdI?=
 =?utf-8?B?MG1MQjFBN3YwaDYzTWV2ODdkL2JZRFlZR2xraGJvOW1KaHVTNHkyejNOOEZU?=
 =?utf-8?B?MUl4c2pqNkhYL1FWM2x0RG9QMmJxNkFEU1l2RlFrOU9saHdzWmtnN3BKMDlF?=
 =?utf-8?B?eGxWQU5oM2ZNWUJQWTR5Q1JDa056clpnbk1DTTZEb1hKRDdKbXk4UUUweXJw?=
 =?utf-8?B?U3pnT2EzYlJaN3U1ZFNTcTVBVFFybldiV09sSHJmS01QZEd2ZXkvUDV1clZz?=
 =?utf-8?B?cnI2QklnaDdHMjUxRFhPZlBOK2p0ZEp6ZVVqR3lPQVZpZkhMeFl4K3J0THpt?=
 =?utf-8?B?K3l0M2JZRVFQbDV1TFZvZFhXWVg3N3BsSzN2bWJ4QUQxVG14S1lzenlUVTA5?=
 =?utf-8?B?bnMzSjl2QkpwLzhyMklsSnY4cUh0NzRUakhzZFZDZGJqaVljbXV5YVlvem9v?=
 =?utf-8?B?UEpBMFRPeEIzSUFldVBvMmFOZEhkanFLYS9zUFU5MUg0WjdjQldzQ0FQQzA5?=
 =?utf-8?B?bDNnYVlMZUIzVGJSOU1XWGVzV0xaZ1Q3L1JQZmpUa3kySUNDRFB2NVlJWjNl?=
 =?utf-8?B?YXByOG5yRnNPMWpTZnlNd2J6Nkt2dSs3dFRkdFN5a0lYZks2ZjgvSXBxOTJs?=
 =?utf-8?B?M3NhYi9Gc3lSV1p6ZlpqbGN4M2NmS3dhZzlDODRoR2lLSDQ3QTN5Yys5ZkFp?=
 =?utf-8?B?RHA4ZWxONFZkTk0vd0wwemUzdDlVQ3JUWnZqTEpCM3pSK2dwOGhKTTZmN3oy?=
 =?utf-8?B?K1NBQ3B1dGFLWUJwV3ZTOUZzaE9OY25Gd2FJZU42SXFUd3g4SVB0RE5NTTZw?=
 =?utf-8?B?VlBWWWFITWhvcUxyQ0pKWEZDak4zM0N1Q1dvdzJiSktaMmo1WjR2bjBBUmVF?=
 =?utf-8?B?N21ocFIwSnBJcnIrM3AyMHRGaWNLUmh4cExLSVA3d0xXMVlGV2YxTXR6Wndp?=
 =?utf-8?Q?x5fWg0YqUWzHzMYwaiQD/ZhWrDuuhY5wR5n1DIifF0=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef76e4d4-b15f-4cb8-445b-08d999872273
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2021 20:19:52.9728
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gb2gtYCL9NqkxXc48oMr+5tnVJqhWWl7his80DuMtqKxgKXS/kQZes02V+id+TbrbttB3wI13YvZ5Z5Wp8e/Dw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3365
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On 10/27/21 6:41 AM, Borislav Petkov wrote:
> On Tue, Oct 19, 2021 at 06:36:39PM -0500, Smita Koralahalli wrote:
>> Replace MCx_{STATUS, ADDR, MISC} macros with mca_msr_reg().
> And this is where your commit message and patch should end. It is a bad
> idea to do textual replacements *and* functional changes in a single
> patch: it is hard to review and debug if there are possible issues. So
> you do the textual replacements in the first one and then the functional
> changes in subsequent patches.

Okay I will break this down and send v3 as suggested.

>> Also, restructure the code to avoid multiple initializations for MCA
>> registers.
> What multiple initializations?

Multiple initialization here I mean: Initializing the MCA registers twice.
Prior to mca_msr_reg() replacement, the MCA registers were initialized
separately for SMCA and legacy processors. However, this is not required
after replacing with mca_msr_reg() as it does the job of returning the
proper MSR addresses.

Probably, my wording is more confusing here. Does this seem better?
"Do not initialize MCx_{STATUS, ADDR, MISC} separately for SMCA and
legacy processors as mca_msr_reg() returns the appropriate MSR addresses
for both."

I will split this into second patch.

>> SMCA machines define a different set of MSRs for MCA registers
>> and mca_msr_reg() returns the proper MSR address for SMCA and legacy
>> processors.
>>
>> Initialize MCA_MISC and MCA_SYND registers at the end after initializing
>> MCx_{STATUS, DESTAT} which is further explained in the next patch.
> And this should be *in* the next patch.

Okay, basically break it down into three. One for replacing, one for
cleaning up the multiple initialization of MCA registers and the last for
moving MCA_MISC and MCA_SYND to the end.

Will do it as suggested..

>
> Also, there's no concept of "next patch" when you do git log on the
> upstream tree and use different sorting etc. So a patch should be
> self-contained and do one change only.
>
> There's very good documentation in Documentation/process/, expecially
> Documentation/process/submitting-patches.rst, which explains how a patch
> should look like.
>
> Thx.

Ok will take a look at this again to correct my mistakes. Thanks for the
inputs.

Thanks,
Smita


