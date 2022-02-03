Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDB614A8515
	for <lists+linux-edac@lfdr.de>; Thu,  3 Feb 2022 14:20:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229981AbiBCNTv (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 3 Feb 2022 08:19:51 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:32412 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229565AbiBCNTv (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 3 Feb 2022 08:19:51 -0500
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 213DJ21N008771;
        Thu, 3 Feb 2022 13:19:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=S1eSgI+TTo8ODYXSMrombRXZKN0BgmXm3x0yCebNbU0=;
 b=c7FJhLgHUJuq3TBBOlYoHtpC8cojfKI0zRCRcyriH915yu4821q6kMojt3WHG0ydTVMX
 wRsKDMrccyDn2JHwErdFD3ewHJH9HRzLXEmUGKx7UjUZILvFGnNqFKS6poY0rlEp4lbk
 8ZyW9XR5WiE3PweSkE/M9FMV0ywvNWJbFrigVRmTCOiTK4Cx04pTTsOa25iDYUvPkCgh
 3TogBdRgFHAXsQLQLcIFwx2/WsfdO8Y9TtMNXn+6LuXlEr/utvAv8daLosFQCrr5FVw7
 qqd1qRi+OCzLgCJn3G3J/5n7QPCx7F5n8+TJzzLxgpvRxjA3L3AGObQIqHM5sRwmK87/ lg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dxj9wh17s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 03 Feb 2022 13:19:30 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 213DFnDM096867;
        Thu, 3 Feb 2022 13:19:29 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2172.outbound.protection.outlook.com [104.47.55.172])
        by aserp3030.oracle.com with ESMTP id 3dvumkf5r9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 03 Feb 2022 13:19:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SigtGvHEjbINv6az82dV/KZEi/ddlugUGiCL5/akPwC6b/j4+lzU26XPrTFphFWsPekTytwYkcZY+44biSHdT7wqLmfeUKAsRYwUaeHE2yQuccQiMR8gPrEauJqJclH05CQJGmxycB8bx8ik9fKphNRm0wVYBQcblXjEk2XJSQ8HmwZMn/0sWuZg2M1t6vK/pEdemnoIgiubPHZ7HZINAF/4FHDxGHq/K9NW5/PzhU6QjUkf/+HP1DEJrcAtByhbnPZZVaUhrUy/ktlxtlYWuBax5Dr7AEKSPEHeK0WPiGOUKnK6vxxvvWKQAESu9ECv3al4gkA9NwfHQY3aC5vJfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S1eSgI+TTo8ODYXSMrombRXZKN0BgmXm3x0yCebNbU0=;
 b=VMhKpEmJCHTOrSPYgRdAMm9BLugYiNQ7JdIlBm9PIRfWp2awaMXmDhyUlg9XGNjYlihdA9ozscdkRhunKsBTAWUC6/oxAkM/WvbL2DDPZusuuAOSkyFmuDYZK8dzeLbxw6u4TevbyDJo0NAian0Z24yLytNNw4lMAJU/ngbY/TUmuDr5xpEHSKT8peMDhoUlilIAkI/bQYicvTtQ5+FTjouBdVnVPyGqx63Vuns6pZyjxFQ6Z9arHZbQ5TtiMr2/JResCFcw8knN5YzstbvvIFt4BPvtxHBRAL9av781ANNlC+LSdxITosTPIgzDp6N6qUN5mXnRcpDu2qkTCOKZlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S1eSgI+TTo8ODYXSMrombRXZKN0BgmXm3x0yCebNbU0=;
 b=O0i7wxJ0t4uHXz6e8FxZRWcPi5osjpVRktLLgfXH4j0EgKeMaIxyfqn4jzQrnj6c3QojTYuctOUQDywU6/iBjWwKz2SlTBsIlxv015AhOI20kQcAKQRNZuw3d4LSpCg+HJxZ46s/S+iSNO+3HQzoNcnRtWKnNTg8APaaHzUtYFU=
Received: from PH0PR10MB5481.namprd10.prod.outlook.com (2603:10b6:510:ea::5)
 by BN8PR10MB4098.namprd10.prod.outlook.com (2603:10b6:408:b1::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Thu, 3 Feb
 2022 13:19:27 +0000
Received: from PH0PR10MB5481.namprd10.prod.outlook.com
 ([fe80::b8d1:415b:7f28:6298]) by PH0PR10MB5481.namprd10.prod.outlook.com
 ([fe80::b8d1:415b:7f28:6298%8]) with mapi id 15.20.4951.012; Thu, 3 Feb 2022
 13:19:27 +0000
Message-ID: <a42a7696-0150-6d63-953e-adec19e25d02@oracle.com>
Date:   Thu, 3 Feb 2022 14:19:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v4 1/2] EDAC/amd64: Set memory type per DIMM
Content-Language: en-US
To:     Yazen Ghannam <yazen.ghannam@amd.com>, linux-edac@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, bp@alien8.de, mchehab@kernel.org,
        tony.luck@intel.com, james.morse@arm.com, rric@kernel.org,
        Smita.KoralahalliChannabasappa@amd.com
References: <20220202144307.2678405-1-yazen.ghannam@amd.com>
 <20220202144307.2678405-2-yazen.ghannam@amd.com>
From:   William Roche <william.roche@oracle.com>
In-Reply-To: <20220202144307.2678405-2-yazen.ghannam@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO2P265CA0319.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a4::19) To PH0PR10MB5481.namprd10.prod.outlook.com
 (2603:10b6:510:ea::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 34f729e1-da45-4a3b-ea9c-08d9e717cd87
X-MS-TrafficTypeDiagnostic: BN8PR10MB4098:EE_
X-Microsoft-Antispam-PRVS: <BN8PR10MB40985288E80C154A1D19E1E585289@BN8PR10MB4098.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:127;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MFz8kVA9oZPuMaFUrjRIaPzJVba+njv0PXnu2kWMbXNmac3SmiRmRnZ4VdV3lNd54oQKOFnPMeqy4Cwh3fTH3KXw+06zCvaZjhF/o8vIgjbm5axNpXowsSRqUdBUhvhwj7GuV7BM+CHNYFWeW2B4uQ+J7lPcBoYtN8f6BYYNlMmS6kS1urYt2IJtyz0FdfO3PGu18f0HtuNARDIb9sYmXl4C6PBQaQUOljPGG9w3sg+nHYT+IxAjBuxe8O4szpYgY/9dT2a8RZSta4WoR2lBXZQaYFYpCb1G+tg5War3k0GdaGl82RB5EQpN7YebdeArUld+ZJjumkYBjoXMsieVU5+bkic52UB0qVjnAJYtEujZllAgNw84K+fNpW+jQTrjIr3Jd2QoBEW2vG/xxedbpiWqNkxehJywj9MauMn8hwMAJRmCf64ecBMYeYLAuvFwBW7SN/KhE6Hj4MmFlqCFLAe4Oln9cHyPBPtT6xHm0PsivEv8bqSDtjcKIbzhKeN3qADNsxkwTpwH8ET98BtdPfqKRqprm9x4HvfXD/uRmnGK+MjTGfMZl7Hv85phhELrU1fxLsZHhmnjNXqFD4fvU+qjiZOvqKc8a9JVbOSuO3HCBXNYBAZE9WhiwsB+nZ2vkPrfUa6c8N4+IIy+eum1N0g3PIrvj7FRNoaIY2yoEqyFYjFPo7jXmHVk8Ob4/azSoeDcvxrEN4u0aMnrSLA2ADE7P7JEulVYLwsT3Y8p7X2Qsisdd0Iq2dIWAnaxgo2s21YQwQ4NvAKvibTAE59AgTL1UDDDkQsJ79ZRCGShNPfaYnRKJGaHW32IPIABt8NiLtGACu7VMPcG3ivJ0rVEPg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5481.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(4326008)(8936002)(966005)(8676002)(316002)(186003)(52116002)(31686004)(66476007)(2906002)(6486002)(26005)(508600001)(66946007)(44832011)(6512007)(5660300002)(6666004)(66556008)(53546011)(6506007)(2616005)(83380400001)(31696002)(86362001)(38350700002)(38100700002)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TzJQeGtQaktmdU1CMHAvL1F4eTNNWUZSZ0wxQVVQaWI3UXpES0FzbmF6WjNE?=
 =?utf-8?B?S3ZBZlV5bFVZNjNMbHZLQkt2WkR5bmFpUy96SDJpaEl5SDQ4QTVGK0pudzdH?=
 =?utf-8?B?dUo4YU16TDJUTHp1S2kvTkRDMG5IR3lXMHhiaTI2RUxoRzhQcWFCOHJ0Uk9Z?=
 =?utf-8?B?SVpsRFZwV0Q5L0NpL2VySWhGUmpoMXlUb3A2YUQ1OVJWODZxSk52bEZ1NTBy?=
 =?utf-8?B?cXlDWHI4VUNVVU16RkxLNTlsZHB6bTJ5M3MrV2RKMmd1Q3QwZXBPK2FhWEVy?=
 =?utf-8?B?WjJsK3hmNStSNlZkdjlua2VGNHZ3T21aamNIMERIeFFQRnF6aG1Rc1NONUMz?=
 =?utf-8?B?MmkzTFVPeXg1OWVvak50eDBBbVBtV2k3L0VsWlFpbXVXc2FvN2UyVzJiZXJu?=
 =?utf-8?B?c2E4RG5ZTmdTSkhNTjhabzVhV2VDc2JxandFdTVGaW5vOHFsSVhqOEp3YWpS?=
 =?utf-8?B?blFaU0JpMElTTE12blRzeEc2OEVjSWRYUjlnR1liZy9BRStiREhCVnB1dVJN?=
 =?utf-8?B?SElIbU8zOXpKSDVlZ0JkTHAybDN4RnFOV21KNXVqanZzbnVnTXVNS0RIbHVJ?=
 =?utf-8?B?Y2NFSnh0Y2FTRmdpTmJqckZndmJOMmhOTkxkVjlPTXlsdHlicVM1Q2JLS3Jk?=
 =?utf-8?B?SjlrT08vTSt4K3NrRmRndmRiR3ArWGpTenJHN1k4NzBUV0NDb3RnTzk2c0RS?=
 =?utf-8?B?TXBoaFJ1UjI4UlVhKzdYRXFHUWMwU1B6NmlnejJnQkFXZUpFNnFyUDdlTmpQ?=
 =?utf-8?B?cnQwOG1nZWo0U1d4S25hWEN0SEErS3Z5aGJkVms5RnM1QVJwMmVUTDZISUx1?=
 =?utf-8?B?YmFQWThkWHA4WTZaMnJBQkZROUdlN0FmQVFHbXhJbzRUM0VHUFh2Y1N4OFA5?=
 =?utf-8?B?dkVBSkg3UzVpRkFoU0lwSzBIVklhY2pMODByc0ZqejlPK2ZvWXFza2hkQ2tw?=
 =?utf-8?B?cGhtVkdhWEt6SzhwUFliVnFWMGY0bUdSazZYSGZjNS9HbzYrcmZTNTFOR1NF?=
 =?utf-8?B?cEdaV3RVWitlTmQwVjVSZi9meHZHM1VtajB6VTh2SWFVQ2hBWVQwUG9TY0ll?=
 =?utf-8?B?d1pEYkE2Q3VKbVdSMGRzQVJURzY1NWhlRS9IdHFaOURUVFhWWWhENXVYVHpw?=
 =?utf-8?B?R2pPRStXWFlaTnE0ZXBKM0FVVmpsMVlUR20ycHNsazgzODFGN0JSVWg0VlNk?=
 =?utf-8?B?Q0NEVnRlZ0pjM250NUFyajBYTlVnRXF3emxscDdkbnVuQ0ZFOHJ0UGY4OHFv?=
 =?utf-8?B?Q25pY2hDMDdCb2IwaTFRWVI1MFlZVXJVRXgrY2ZObzdQRzd6OXRUQ2Z3Z3E5?=
 =?utf-8?B?UnQydTVIWnNITUZVbjB0MFVZSWdOeXozR2xWYVl0cXBlUnltUXVHYU5zaktv?=
 =?utf-8?B?QTdrZU1HTDZJZkNwcXVURFhZaU16L0ZnUmZiUzJwWnpEdVg5d0ZXcGVzSUJP?=
 =?utf-8?B?eFVpSTFDU0YrR0J6NzdwUEFxamF4c1JTSXd4T055UXZHb0tVVzZCWXpNOG9u?=
 =?utf-8?B?VXhiWWhCcUtkalIxUTVCdU40ckpwWlZoSmFUT0xHRWlrRmQyNUNYR3pheG80?=
 =?utf-8?B?dHpualhvMTFFUFAxWm1tS1pJVEJDaUxtdHpuMkV3SXdXOGY4TnJTSUxqbVR6?=
 =?utf-8?B?bkl3TnpDb0lyTThjdUtCclVON0JuVzB3Z0ZYK2YrWnJUZHdCN0d6UVcrNmQw?=
 =?utf-8?B?b2FZOWNhSHZFYjNwZm5DTXpWa3hSYTNXNHYwbmd5NkxjeXFoa2xPWkdNd2Jj?=
 =?utf-8?B?MEVKYTQ2NVFhaE5wOTV6V05DL1RZOUxZRTZTbVFlekNaZVJMckp4b1BxTmx5?=
 =?utf-8?B?NFlvd2ZUZ2o5anVka3pHbzdGMVFscFczZnJBNERtOU4wbXRJa0dpYlEvU05T?=
 =?utf-8?B?R3JqUnJIT3RWRUhmYks0WWdEcjc0WFpWR256SEd3UDhSaDgwZ3RTY0krV3lK?=
 =?utf-8?B?TmxhMm5GbzNwQXdEM3pqNU1DYk1ZNTJ2U0hxNFJQUG5TelJzTWIwdFlNV3U5?=
 =?utf-8?B?L3hwaUVMZGFQbmJSalRqNThibmZRZUNvcnlqYzVCVXVYY3A0aDZsbERDVFRF?=
 =?utf-8?B?Sy8xTGVQbUpaMnBwVDYxdVdUeWIxMnRRZUcwZWxQSUw4WUtxVXlXSkp3M1lP?=
 =?utf-8?B?YUtDQTF6THVnZmo1NEhmYzRXMjM1azJVY242RTE1cVdnRWJ4d0JCcTFBcXA2?=
 =?utf-8?B?S2kwa2dmVm1LS2MzOE5mR09sWEg3TG5YQ2UrYkJ6YzlXbFJFREtjNDY0OTVv?=
 =?utf-8?B?dnA1RDNPM0RvS241MVhOOVhVbVRBPT0=?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34f729e1-da45-4a3b-ea9c-08d9e717cd87
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5481.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2022 13:19:27.0323
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: seS+hOiudo31CVHhp/dQ3WVZvy/KFke1R7IjQjZBMG+TMdXgOy+Vpx7YMQTvkTGi7jgQyHCcZJxIoS5xmv0TEdo30YRC+o5702Ecbqvw7oE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR10MB4098
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10246 signatures=673430
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 phishscore=0
 mlxscore=0 adultscore=0 suspectscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202030083
X-Proofpoint-ORIG-GUID: rzq0mFnGuQ_7C-Bo_CD7IzN-zJQPtAcJ
X-Proofpoint-GUID: rzq0mFnGuQ_7C-Bo_CD7IzN-zJQPtAcJ
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

As we are moving the dram_type cached date from pvt to umc for family >= 
0x17, should we also add a small comment for the dram_type field in the 
amd64_pvt structure to indicate that ?

Something like that for example:

@@ -385,7 +385,7 @@
      /* place to store error injection parameters prior to issue */
      struct error_injection injection;

-    /* cache the dram_type */
+    /* cache the dram_type for family<0x17 */
      enum mem_type dram_type;

      struct amd64_umc *umc;    /* UMC registers */


Just a suggestion.
The code looks good to me.

Reviewed-by: William Roche <william.roche@oracle.com>

W.

On 02/02/2022 15:43, Yazen Ghannam wrote:
> Current AMD systems allow mixing of DIMM types within a system. However,
> DIMMs within a channel, i.e. managed by a single Unified Memory
> Controller (UMC), must be of the same type.
>
> Handle this possible configuration by checking and setting the memory
> type for each individual "UMC" structure.
>
> Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
> ---
> Link:
> https://lore.kernel.org/r/20211228200615.412999-2-yazen.ghannam@amd.com
>
> v3->v4:
> * Cache dram_type in struct umc.
>
> v2->v3:
> * Change patch to properly handle systems with different DIMM types.
>
> v1->v2:
> * Was patch 3 in v1.
> * Update commit message.
>
>   drivers/edac/amd64_edac.c | 47 +++++++++++++++++++++++++++++----------
>   drivers/edac/amd64_edac.h |  3 +++
>   2 files changed, 38 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
> index fba609ada0e6..49e384207ce0 100644
> --- a/drivers/edac/amd64_edac.c
> +++ b/drivers/edac/amd64_edac.c
> @@ -1429,7 +1429,7 @@ static void __dump_misc_regs_df(struct amd64_pvt *pvt)
>   		edac_dbg(1, "UMC%d x16 DIMMs present: %s\n",
>   				i, (umc->dimm_cfg & BIT(7)) ? "yes" : "no");
>   
> -		if (pvt->dram_type == MEM_LRDDR4) {
> +		if (umc->dram_type == MEM_LRDDR4) {
>   			amd_smn_read(pvt->mc_node_id, umc_base + UMCCH_ADDR_CFG, &tmp);
>   			edac_dbg(1, "UMC%d LRDIMM %dx rank multiply\n",
>   					i, 1 << ((tmp >> 4) & 0x3));
> @@ -1616,19 +1616,40 @@ static void read_dct_base_mask(struct amd64_pvt *pvt)
>   	}
>   }
>   
> +static void _determine_memory_type_df(struct amd64_umc *umc)
> +{
> +	if (!(umc->sdp_ctrl & UMC_SDP_INIT)) {
> +		umc->dram_type = MEM_EMPTY;
> +		return;
> +	}
> +
> +	if (umc->dimm_cfg & BIT(5))
> +		umc->dram_type = MEM_LRDDR4;
> +	else if (umc->dimm_cfg & BIT(4))
> +		umc->dram_type = MEM_RDDR4;
> +	else
> +		umc->dram_type = MEM_DDR4;
> +}
> +
> +static void determine_memory_type_df(struct amd64_pvt *pvt)
> +{
> +	struct amd64_umc *umc;
> +	u32 i;
> +
> +	for_each_umc(i) {
> +		umc = &pvt->umc[i];
> +
> +		_determine_memory_type_df(umc);
> +		edac_dbg(1, "  UMC%d DIMM type: %s\n", i, edac_mem_types[umc->dram_type]);
> +	}
> +}
> +
>   static void determine_memory_type(struct amd64_pvt *pvt)
>   {
>   	u32 dram_ctrl, dcsm;
>   
> -	if (pvt->umc) {
> -		if ((pvt->umc[0].dimm_cfg | pvt->umc[1].dimm_cfg) & BIT(5))
> -			pvt->dram_type = MEM_LRDDR4;
> -		else if ((pvt->umc[0].dimm_cfg | pvt->umc[1].dimm_cfg) & BIT(4))
> -			pvt->dram_type = MEM_RDDR4;
> -		else
> -			pvt->dram_type = MEM_DDR4;
> -		return;
> -	}
> +	if (pvt->umc)
> +		return determine_memory_type_df(pvt);
>   
>   	switch (pvt->fam) {
>   	case 0xf:
> @@ -3452,7 +3473,9 @@ static void read_mc_regs(struct amd64_pvt *pvt)
>   	read_dct_base_mask(pvt);
>   
>   	determine_memory_type(pvt);
> -	edac_dbg(1, "  DIMM type: %s\n", edac_mem_types[pvt->dram_type]);
> +
> +	if (!pvt->umc)
> +		edac_dbg(1, "  DIMM type: %s\n", edac_mem_types[pvt->dram_type]);
>   
>   	determine_ecc_sym_sz(pvt);
>   }
> @@ -3548,7 +3571,7 @@ static int init_csrows_df(struct mem_ctl_info *mci)
>   					pvt->mc_node_id, cs);
>   
>   			dimm->nr_pages = get_csrow_nr_pages(pvt, umc, cs);
> -			dimm->mtype = pvt->dram_type;
> +			dimm->mtype = pvt->umc[umc].dram_type;
>   			dimm->edac_mode = edac_mode;
>   			dimm->dtype = dev_type;
>   			dimm->grain = 64;
> diff --git a/drivers/edac/amd64_edac.h b/drivers/edac/amd64_edac.h
> index 352bda9803f6..09ad28299c57 100644
> --- a/drivers/edac/amd64_edac.h
> +++ b/drivers/edac/amd64_edac.h
> @@ -344,6 +344,9 @@ struct amd64_umc {
>   	u32 sdp_ctrl;		/* SDP Control reg */
>   	u32 ecc_ctrl;		/* DRAM ECC Control reg */
>   	u32 umc_cap_hi;		/* Capabilities High reg */
> +
> +	/* cache the dram_type */
> +	enum mem_type dram_type;
>   };
>   
>   struct amd64_pvt {
