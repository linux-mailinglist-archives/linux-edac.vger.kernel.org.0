Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27B0C4A87EA
	for <lists+linux-edac@lfdr.de>; Thu,  3 Feb 2022 16:47:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240972AbiBCPrK (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 3 Feb 2022 10:47:10 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:20306 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240401AbiBCPrJ (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 3 Feb 2022 10:47:09 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 213FBpsj003826;
        Thu, 3 Feb 2022 15:46:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=u+lk4f3y5ZtXX4ILEV2t/D4iUllBiarAs1IyPdjoHfQ=;
 b=ZszxMKMvPfaq1cvq+3QpgHbwJ4eupM0JLBiINLOsBO2kIA9aVUxNFXulhoaIKl93uY1Q
 Oag87+lup1JR1dUNm57CHOgUyDNfs/jwRt9sTtdd2MwUNb00SJ0ig418p8s9+5B1/hY3
 kEYhwhavPzBq55aD/iDYrWK98iJnNZbYctq0c2rIvYBM3EuL0K76zQzPtNwJxt81KHR7
 dY8T2evefDl7Ej3JVSyy4JLtZMJ6TWbQdnNbbJ2/v4a+w1LmvuINI7HFsw+d5HfRoIFB
 FBFtVxygd+7ak1Gl6CyWSY561lapcXZCQjzytQ3Ks5cvCTvQE09yeYKmiBmc8rBLo2cT sA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e0hfw83ac-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 03 Feb 2022 15:46:54 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 213FVI0H184570;
        Thu, 3 Feb 2022 15:46:53 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2104.outbound.protection.outlook.com [104.47.58.104])
        by aserp3020.oracle.com with ESMTP id 3dvwdajy6g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 03 Feb 2022 15:46:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gtBzcbMKTVL6FDldkeQbKi+snoYUdDS3O40W1IgOTkpCDxi8sT4ZC8i4v8YcboRsWXPr7ogWL6S8YzvdYyBseReAbBddMpJ4ymKMS0xs3biICOVRxS+QLens6gWMryRxpCWnOkKohpAyidRg8UjlmAhWXyNevvEhinO31saKFjfvvFwGs4ZVs5ut8++Rlro82wN4PnEG9kxulKz0Bv1xwTEUuaM8IO6GbY+Akx3/p9K1IZ4qde4r33f8+JFiHc45Zs0h+aKkNI32d+nnHYygJ5zIidUb86whsQwmz6FtJ85+Q1nz9QFSjfybItvUhMvNRlFLNzm1d1V5j9nTB8oQxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u+lk4f3y5ZtXX4ILEV2t/D4iUllBiarAs1IyPdjoHfQ=;
 b=YqGhdNm6MA/Xit7/JXcdKDjtaCMnto46mazSLZcZpnyUlx555X4N+bD1udbDZERRYnvuif6oBYmi52unGw/YSNRlsI/0uiLv/HkVmWtCTfhlxYxZzyCoTrjo3Mp10YQCXORuC1TLdIr0BMJJSujlZFGxFEjoOtzlwx6w1+B0LhRz+k7SDAT3Ag89QxWnVar/HpFDJSPDf5K24KOd7/+4JSUVplBPw30Q8bsNAX4RwtaBq59yPehjZ6wlJeeEf+vML6PIC267ff6IbVKJt7iL015fWXpXUZidp6rfDD5uriQAKTzuuT4lR2ofpT/3g2HN+lrn0/tvNwsf7xjz2/HIKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u+lk4f3y5ZtXX4ILEV2t/D4iUllBiarAs1IyPdjoHfQ=;
 b=Q/4Uy5p4ZNE9fv0n3Y8XKWU6dnlrhDJuLWntTq0u6Qxwq7RaPy2f6HrTOwEL7J40LOPXgPOF26AlAPy294ndZNjGZhYejbNe3uAfqq0myiwFQU5EG1gQDezxDRCjeeoy7sqA9aCiobGieMoeGbF2gz7QEDPi3DxFUonT4xbQk+0=
Received: from PH0PR10MB5481.namprd10.prod.outlook.com (2603:10b6:510:ea::5)
 by CH2PR10MB4133.namprd10.prod.outlook.com (2603:10b6:610:a6::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.17; Thu, 3 Feb
 2022 15:46:51 +0000
Received: from PH0PR10MB5481.namprd10.prod.outlook.com
 ([fe80::b8d1:415b:7f28:6298]) by PH0PR10MB5481.namprd10.prod.outlook.com
 ([fe80::b8d1:415b:7f28:6298%8]) with mapi id 15.20.4951.012; Thu, 3 Feb 2022
 15:46:51 +0000
Message-ID: <962dc65c-6e52-bf02-5ba5-7e8731442390@oracle.com>
Date:   Thu, 3 Feb 2022 16:46:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v4 1/2] EDAC/amd64: Set memory type per DIMM
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>
Cc:     Yazen Ghannam <yazen.ghannam@amd.com>, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, mchehab@kernel.org,
        tony.luck@intel.com, james.morse@arm.com, rric@kernel.org,
        Smita.KoralahalliChannabasappa@amd.com
References: <20220202144307.2678405-1-yazen.ghannam@amd.com>
 <20220202144307.2678405-2-yazen.ghannam@amd.com>
 <a42a7696-0150-6d63-953e-adec19e25d02@oracle.com> <YfviHFrzzdapbwDt@zn.tnic>
From:   William Roche <william.roche@oracle.com>
In-Reply-To: <YfviHFrzzdapbwDt@zn.tnic>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM3PR07CA0137.eurprd07.prod.outlook.com
 (2603:10a6:207:8::23) To PH0PR10MB5481.namprd10.prod.outlook.com
 (2603:10b6:510:ea::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 949515b2-ff2d-4dba-8c06-08d9e72c651d
X-MS-TrafficTypeDiagnostic: CH2PR10MB4133:EE_
X-Microsoft-Antispam-PRVS: <CH2PR10MB41335667750594BF2BDC92FC85289@CH2PR10MB4133.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2c5LJUzZ4IqbaXzb17eIYO+eRXYPJgV7DzZFY9UVYCnnYRMC1+r9UoCg4F/SfP+wcO56NumKPZWDNi03I6ZG0PVJQUxQ0WqyizOtXyUs3jwRKHLZEQQGAY+Ab1AcJIFAZsQ/0QXsqlhPTbWksO5NYurjUOOxjxd1xfcETmzW9WzqGhvgPgqxnNiwMjMuZzj4sR+zak54CtZ1w2s6fNAygqmtl/3HzF70N9CEkd1GyiQHka77bKTB6K3Q2roSDr2uaPYxGI1o67cPAOU3PsRYalc3Z771yjKgk1svlJYkd3o8P3T1xwUy8JC7Th/o7xoiTMDktFe2ltSlQlZxYhn9QlZFFIgeRPRh3Cr+3Zc8QmY8hp5No1lvpOah2BUSAy5AS2IzP1ieJ3b37hrzPN497boNpFLOJvXumKUg+JHAFVHnCJgqV+yTFiPvHEchRofegjzzEqxS+oKgijseMK0vdi0wRfSN0RI3r3Pek2+SnVcXzjSinlwY37FbjJBE7laUMNtma46lLC0+uEbLp+H5CUiW3laVtGb8nkDhzvusZGrgIrfkr4pDECOeNGSKdPaIwEfXU86HUynqvLuOQ/JfCce5ZGncEQY+44aX1/ZqnpykXzocR+c6lNSGjPRtT1eCwE8k7kMlvXF0JslTfiVxo+JwwV8oQYJHApG2Zs9HExb5vDxZWUeWcfS2phbT1xAqjvC90mRPVbuEVYjfSdlvE90Oof8lua0m2a775daxM40k3wCgY8FcohCUDhtnzZvlHjvxOGVKPTyXGstBPUECVw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5481.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66946007)(38350700002)(26005)(38100700002)(36756003)(186003)(52116002)(53546011)(44832011)(66556008)(316002)(6506007)(6486002)(2616005)(508600001)(66476007)(31686004)(8676002)(5660300002)(6916009)(2906002)(6512007)(31696002)(86362001)(6666004)(4326008)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WnV3L0t0Z1d3ZUpJTDJLS054bXpUYml2d3Q3MVR1MjRPU1FYQXhmdTYweFJn?=
 =?utf-8?B?VlRGNFkvdzkxV2ExWldhaUZVYjNVTmx5OTVMbCtnYjJScGoyUEFmU3dFWUNh?=
 =?utf-8?B?SGp2eXR5cSt0Y3RpVGVuUUhFOS8xNHMzNkgrdlpGWHFZdDR1RlZ2TWpuTWlv?=
 =?utf-8?B?WmRqSzBUMi9QQ2xQaUZUaU5ZYzAwdU9udHUyYysxYzVDSWRrM3JqaHJSSVZZ?=
 =?utf-8?B?NElYQlMxODkwOUJEVlY0VHppb3dIeXRtRmhta3dBSzlTUGRSRlBZQVZvM3dC?=
 =?utf-8?B?dzFUWGNwVHA2eXNBZkZUN3ZaQ0lYUzhyNFI0UEtCbXFGVVJFc2hxa2M1Tlh5?=
 =?utf-8?B?djhMajdaeHY5Wm5JL3hvSzI0aXdlTUJwdk9aczlnTGJmd2RrUGlHa0lXQ0Rq?=
 =?utf-8?B?TGt5bDlOMzIyYld6T2FSR25GdlZTa0lnQWY5OWJNd0liNEJiVWVxNW1haHdn?=
 =?utf-8?B?NTAzY092TlJDM3YrbTE3c3VJM3huUlFOQ1ZRWmh2RUluMmxESEtOYndObWNV?=
 =?utf-8?B?bkpkVWNzWTVVWElxSGNrUkMyd3ZMZ1cvaitBUk1TZkhnbk85UUJwY2tJTlNa?=
 =?utf-8?B?SytsemZpZUpRNkZnaERDU3YwMjFJaWdzVmZDdllBZUE3TUpTSHVnTDRPUy9u?=
 =?utf-8?B?R1BBQSs0K0NOSE5yalVmSVpxVDFHd291RG9ieHRXbHpVaWx5aXFFVXdnbnV0?=
 =?utf-8?B?MVlKVk5iYk9XVGN1R2dEa29FTzJXYzdOMHEzWEZSUTk2ZFJWQ3FlQ1dHWWlD?=
 =?utf-8?B?dXRqYUdROVhsMUxzaVYvUEtrc0M0RTZFd3RkYW55ZS9VNE1GVzRwZXJRbVlF?=
 =?utf-8?B?WU9PYWFmcXFIR1ZRNnFhYVprWlQyZU4zSE9DY2RYN0xuWk1rV2NDakRFMzND?=
 =?utf-8?B?dkQwWFpycHB6VFhXVTUzSG9NMHM3KzFiV2pPSnp0NGFidXRwRHFRc0YvQ0ZV?=
 =?utf-8?B?MU1WcVYvbFk3aStyMUxaTnh2dHJITUV3Zi9Hakl0ai8xd3htcGMzb0N0aFlX?=
 =?utf-8?B?SVJhQ28yYVcxS2NPeDNPTzd2bkpKYzNoVmVmU1lIZ29wOTdaak5NUXdOZEJ3?=
 =?utf-8?B?TGJNcEQzcTJvR3lRTkRkZnNhZ3FCVWY2NnVuRnBLUnJLMFpYSFQxczZ4eW1q?=
 =?utf-8?B?WmlxeGV0QWNKWklHdjRvLy9IUk1Lc1BtTjVweGR1WUZDbGx3blJtNUlmRjNm?=
 =?utf-8?B?ZjRwUjRVc1kvOG1jZkRvd1N4NVBUZERGcURyOGd6UnN0bnlseDJXYWlhMWlv?=
 =?utf-8?B?N0k0Y0VsOEtzNUZzbUt1TWdsMXpRUnlOMXhmRlRyQWpzSWF0UTF2aU54bGFq?=
 =?utf-8?B?Y1JsOW5tVElJajBOcUY4MGZBeXg1SGdpcVptcmpya0V4VzFKcVdxRldkODNI?=
 =?utf-8?B?L3l5d09TMVpTSUIyZnNPV2U1bmZVUHhrQ1dJWmxkd2pPSk5SZ01hMUhaNm5W?=
 =?utf-8?B?V2xycURDMVYvNnhPQnFOU2N1WnFXUm1tdnZOMEhKaWtlbC9Zd28xejBIcmRL?=
 =?utf-8?B?VmJLVkpjaHh5NU1DYnp6TXB0M1Bad0x5TDNqUXNOb1gzZ0FhRiszZzhmanZj?=
 =?utf-8?B?YVp0Ulk4UW1QNjY3OTlhd1RRRWNRT0U2cmNkTzBCdms2QnNRcW1TOThiSk9J?=
 =?utf-8?B?R3IyUFBqbDVjVkJ2NWV1b2hiQkJML053T1hZOHBjdVJXOWYwbXVxQmVEOWRX?=
 =?utf-8?B?K1Y0cmM0ZlVseVowTWlDM2tDV2laRjRUd0lwTlZkTDBqMDlHbmFFbURIbEx1?=
 =?utf-8?B?WUJabGxQNk1QbWJkVlFmc1ljalVDOWRVbjJvazdpaEloS2pDK2gvcTFnUlRm?=
 =?utf-8?B?eXBBY3R0YlgrQmRxWHBBeklSL0lEWlhlR3VHaVhFMmpXaDkxWFVSRFViNkdM?=
 =?utf-8?B?SXM5QnNmTWZSV05RbzUvck9QQis0L3MrWEhXVUZveS82cE9xcFc1MHBqUURw?=
 =?utf-8?B?N1pwWXZ5dTZxckJ4Q1hLVG5OaU1ERURGRVNJdjR0Zi8xTzBnbFhKUE5Ba0xw?=
 =?utf-8?B?SkNjWGZVR0J6TTdjQTJGMUhnbktUbmZXUVN6bW1yU0ZCSE16YU8vZTVXWXJm?=
 =?utf-8?B?UzVwVzVJSjdFSHRPbkMvbUUxRVFTdnpvVkNwUElLelRhZERpanhMc3RxVFdR?=
 =?utf-8?B?dis1L1o0ZjNNWkQ0cDJwbGlkRkwvQ0h6bTJEdUQ0Y24rSGtxV0tUVnQyWlB2?=
 =?utf-8?B?Tk14WUpYUThkbDc2enNDS0d4aFN5SGpGbTZib3NkNnh5cUR6ZlZlSDJNU2FV?=
 =?utf-8?B?ditEQktkczVETUVNY0wyRVVNSnNRPT0=?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 949515b2-ff2d-4dba-8c06-08d9e72c651d
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5481.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2022 15:46:51.4397
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 58WJTvjHM5/VHctErDh7zyHzdc8SaLkHj+pPX0AxsnhXb5w/dDibh8Cg/QHmk1AI78H/8KA4qzBVnk1pf9SQDcjYvW5mcXAFjYyXQuXXtaI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4133
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10247 signatures=673430
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=838 adultscore=0
 suspectscore=0 malwarescore=0 bulkscore=0 mlxscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202030096
X-Proofpoint-ORIG-GUID: YhkMrY1e9g5SjkJ0ZVwZLxrw15Fky51z
X-Proofpoint-GUID: YhkMrY1e9g5SjkJ0ZVwZLxrw15Fky51z
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On 03/02/2022 15:09, Borislav Petkov wrote:

> On Thu, Feb 03, 2022 at 02:19:19PM +0100, William Roche wrote:
>> As we are moving the dram_type cached date from pvt to umc for family >=
>> 0x17, should we also add a small comment for the dram_type field in the
>> amd64_pvt structure to indicate that ?
> Who would be that comment for? People who are looking at the code, so
> that they know which is which?

Yes, it could be a hint about the use case of this field.
Of course we could be more complete and also comment the umc field use 
in this same structure that depends on the family higher or lower than 
17 too.
But I had the impression that the creation of a new dram_type cache 
field would be clarified by a comment on the old location, that's it.
It's up to Yazen and you to include or not  this small addition about 
dram_type.

>
>> Something like that for example:
>>
>> @@ -385,7 +385,7 @@
>>       /* place to store error injection parameters prior to issue */
>>       struct error_injection injection;
>>
>> -    /* cache the dram_type */
>> +    /* cache the dram_type for family<0x17 */
>>       enum mem_type dram_type;
>>
>>       struct amd64_umc *umc;    /* UMC registers */
>>
>>
>> Just a suggestion.
>> The code looks good to me.
>>
>> Reviewed-by: William Roche <william.roche@oracle.com>
>>
>> W.
> Btw, I'd appreciate it if you do not top-post.
>
> Thx.

Sure, sorry.

