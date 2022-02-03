Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AAE84A8514
	for <lists+linux-edac@lfdr.de>; Thu,  3 Feb 2022 14:20:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236406AbiBCNTw (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 3 Feb 2022 08:19:52 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:33050 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229979AbiBCNTv (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 3 Feb 2022 08:19:51 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 213DJHtN024746;
        Thu, 3 Feb 2022 13:19:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=zj/yWFtHaMIdCVZv4X/dqBdHN6SrM0AidxfhUPd4yTE=;
 b=YcG+T0y2Fw9ShZfPZ3s/x7UBgkvNa0nVTcB0Guo078sDRmr37QKUCUbfxqhz6GQlmpcX
 wYyMm7GvGhB0fdPs6c7MVURFgszNPtpwea2Izti4JMtNECdWQ8OSWERJtOO/+oHDqKrN
 oteOlsxQhyMxFaSAa5hzlTJchbTxljW0mo21q5WUNpzUflaLqqlBCsZYWyTxQ1X4+GYi
 zWZRZcPTZkzRS48arvR2V6nLMLXMHtFyWrscYzBwpMN6SP4XwjqVF49E0ic4rgSSb+Cg
 zIJUpMCBFlAgtkAj6fql9nttrA2SfRMtI8xn0QxgsrFKuzsKlStIwvpg1db+8V5WRynH 7Q== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dxj9g18yt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 03 Feb 2022 13:19:38 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 213DHG1r072091;
        Thu, 3 Feb 2022 13:19:37 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2177.outbound.protection.outlook.com [104.47.55.177])
        by aserp3020.oracle.com with ESMTP id 3dvwda9cnp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 03 Feb 2022 13:19:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lrxNhSWUwNhWje6aA5ZmtxM3jWpgcVQgCMxhJl2YcPPGJpLS3TjfgJjxj529NmDmcQRruIuK/OdJ5ZO030TLtl8L+m2o/2ujJFo7OKbzt0wo47OkY8+m2e4awt8WAp4qFt4iMyzgzNST7ILZ2f1bJ4zO0Nrr0JanergAHRcV2PJVPkbWOghYGntuz2KHuZ5fAnlpVO7tJh8JhyWC4DOraNxJ9R8qWbZms3JVodX80seEYVi1zyaounQl2VEOgFHGS6h497NLdOZphOxqhbfc0qRenyW7bsyG1DI0T6DN+vN40hNj5bIVl6vpxo05KLGXO56fjsHEZqn6tvEqf3Q+cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zj/yWFtHaMIdCVZv4X/dqBdHN6SrM0AidxfhUPd4yTE=;
 b=R0uN+7cFiNz+1VVDMA4yW8FJATLTFKKEyKlSoSjQQ3jpiVjsBkOkLx+lBL+EPoi9hh6WpQQOHFJ2eLTS0AguvqMyS1J3O7WoLc+SiFDgNEhqIUAC1b9pm40VxA0YOVfe41Goxvx8BagS896KiJ12otkPXrN/X1EKHlxSEt7CuP3oxicI6a9/VpbmyVHqOKPdevxwsjgN03r+EKj5nE5K325DiLstFmeX6GVxvcpmGwLpVwRRSnr2mN26nSAUhqzWqE6pjdmanNO2d8w/iSWi38hKic9zVuc79iCJkiLC5PegRb9Fe5fu/ZnFVOY4I6F5tTHjZWmpHsz2BxJU0mEOHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zj/yWFtHaMIdCVZv4X/dqBdHN6SrM0AidxfhUPd4yTE=;
 b=nBGtWAPoG9y1XMXgS2sNV0Wzrr935ogr7j+x/iw5R82BD0WYXVt4g4NFjak+sqRYOoxHenKdgEifRvaSg+ZzWTlZgjum75HvXEDtI6j1A6X3cgChY9Y+tiJV0Z5erI60IrSFejDtKgagArZFkt7a14a3JW52IQbEaNU7gEQLkhE=
Received: from PH0PR10MB5481.namprd10.prod.outlook.com (2603:10b6:510:ea::5)
 by BN8PR10MB4098.namprd10.prod.outlook.com (2603:10b6:408:b1::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Thu, 3 Feb
 2022 13:19:35 +0000
Received: from PH0PR10MB5481.namprd10.prod.outlook.com
 ([fe80::b8d1:415b:7f28:6298]) by PH0PR10MB5481.namprd10.prod.outlook.com
 ([fe80::b8d1:415b:7f28:6298%8]) with mapi id 15.20.4951.012; Thu, 3 Feb 2022
 13:19:35 +0000
Message-ID: <51e45a45-8e6c-cf9a-a5b0-774073c5e920@oracle.com>
Date:   Thu, 3 Feb 2022 14:19:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v4 2/2] EDAC/amd64: Add new register offset support and
 related changes
Content-Language: en-US
To:     Yazen Ghannam <yazen.ghannam@amd.com>, linux-edac@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, bp@alien8.de, mchehab@kernel.org,
        tony.luck@intel.com, james.morse@arm.com, rric@kernel.org,
        Smita.KoralahalliChannabasappa@amd.com
References: <20220202144307.2678405-1-yazen.ghannam@amd.com>
 <20220202144307.2678405-3-yazen.ghannam@amd.com>
From:   William Roche <william.roche@oracle.com>
In-Reply-To: <20220202144307.2678405-3-yazen.ghannam@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0330.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a4::30) To PH0PR10MB5481.namprd10.prod.outlook.com
 (2603:10b6:510:ea::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a63f0c9f-e90d-48c7-9836-08d9e717d286
X-MS-TrafficTypeDiagnostic: BN8PR10MB4098:EE_
X-Microsoft-Antispam-PRVS: <BN8PR10MB4098B3383B193FE4B9FC348885289@BN8PR10MB4098.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:421;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jN49U14V3xgyuLScgaokLadr1MNaqJeCNoteZ8HZrmks0sFmfkB1fDmIjUEAd/ONy6cEUqRy85eWwhGzW1tH2IIkLEDhwEVPJUn5a3Yvmqgt7WNbGW2a9ADiF6NitJy76+yF0JtfByyaaFPLdHH3zUEeGJBZJihwNZaNaD83+JbxpRN09MSw0CB3Qfdoew74VSEPZbgkNTozPXDX+ROYvJOQSV8Xq+PNC1+k7W1PqaMQVJMnp/EqzGSs5EPte0eX42LEgWz2tikpggv/KmwpoHDDu/A5/O4J/U6W0/LKirE4Rp5xN3+606uXVB5qHEoz0njCDk/RlzIomWI5bsqmX8VvzhN79reajCFBJbFG5aYUh9d7bF7C5bmk/j8GXkUu9JZstOXWvrtMOhcXpdHriVft3vAkEqcv+djYz+1YdzECAUAMFahCMKo1l1o6KooM841g9cgBiaucp4QZfv2Hy380wSCMJB3mqYFrCEyfQUutz2AO4Y5Asd+cmuZTfU71ERCcjnS//M6TEw67d4Iop9qcah909iR+bMZUONBNhOzALJBU+YuTWJxGbrYCaxlRmMj8IO5W77Ur2se7womYPwhTeyif0pMZlBDd3IKSPBZ77PqQGAK8ZYX4+mSlGZlbjzsZDI+z99RVCtRuK24L3h4PuHU3Fau09LlctH+AEbDushVqLThGAXCYH1VYtI+PB4b9Vx1C8pK4h3NFYzPW2LIqKl3H43GMgVwE2vHg2fN5gtMz6370vId9edahcGhM5XltYs/i0ehmNjO1Rm8wttB9WSgjD7lcrAUf9ZVSXFhGX1poML7lFZt0ugSJcNbuggnr/h2N7ANGfNqNjXBD8XSKsse56F1YuCXFZDQVITk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5481.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(4326008)(8936002)(966005)(8676002)(316002)(186003)(52116002)(31686004)(66476007)(2906002)(6486002)(26005)(508600001)(66946007)(44832011)(6512007)(5660300002)(6666004)(66556008)(53546011)(6506007)(2616005)(83380400001)(31696002)(86362001)(38350700002)(38100700002)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eGxaWlhuT1VsTzlaZHpSZFdpdFpoL2puMWRDY2Y1T3JoYnQvakZJc0Q2ZHc0?=
 =?utf-8?B?U0NvTUxiWDhLZmw5THFobjREWEpLTHV2RVM2bkdRa0c2TXBpTWNMejhnaTUr?=
 =?utf-8?B?WVVmOXpCVDZOK3ExelEvd3RXRkxzQnZtb2p6YXBlZEtyTjNmc28yYndKenpW?=
 =?utf-8?B?MFBVZkFMVXppdHJWdjFIUDFrRDlCVzd2WndpdGF2V2psa3dudGgwZ2t2cFJE?=
 =?utf-8?B?QTZ4bFlWd2ZRWHd2eXdNU1U1cngzeEtHQzBmNW5SQ2tMUHZ0djNkeFNZajA5?=
 =?utf-8?B?K0gvQTVGZnEzWGhwRVZXQjAyQjVIQWNYZENuSHRvcld4cm1TdGcreHJoYmcy?=
 =?utf-8?B?alk2RGJNTEY5d0xOSzlJY3B2QlN4M1gvNk9qQ1NNZkFqRE9kaVFVZ3Yrc0Y4?=
 =?utf-8?B?SEx1SFRabzV6WEROQVAwZlAyczhPL2labXFCVHFZMGJhbHE5MFNOWG1TK2g3?=
 =?utf-8?B?clBHMitWQVQ2SDNDUXVMNkUvWVIzUTNkV0wvSGtmQmVuL0ZIcU5uQmhndEQ5?=
 =?utf-8?B?bDBOL0VNWHNGTVg5UDB4eGJ0L3FtUjdLSUF3TFdZK2FXV2dmUzRpeEphaVlR?=
 =?utf-8?B?N25hR2VYd09vTFkwdWdUaUdOei8vT0V0aEJYUGtVaTM4dk4rWWplaE9DRmFB?=
 =?utf-8?B?VFFHRlpoZ0FwMlE2QXcyQkxTd213a1phY25xenZIdGlYZmtFNzY4cGJXY3VU?=
 =?utf-8?B?YSthdWVCajR3VG1OaHptLzhXemlBYXVSMXYyRHFmMitVd3NQNDhPRmdmakhl?=
 =?utf-8?B?Tm9maFlJNUxSVkxBaXpXQUlWREMrTzBQa0NpRmZaSUJ3UDlrM2FpM0NoM3Mr?=
 =?utf-8?B?dW9oUEM2Y2tWVWpSeEwyNW9zZG9IWGplZFU3MVFjZU1sazdlOU1YNyswVzU1?=
 =?utf-8?B?eVJHc0tuZ2RJTm5xWkdIdHZSZkJ5dm54QkErYnFBbWNEVFZIY0tQVWpRRUw4?=
 =?utf-8?B?S0ZWWlhLQ2RyWGI5RmZlWlVhQnVSSmlNTlVTYTM2d0lLM2pYMEU2VEFDSU1w?=
 =?utf-8?B?VWtNOU9XYm96VVo0bkNSQ085Z0cvK3l1SzgvL0hPY1pCRXliSmlka294UTBU?=
 =?utf-8?B?V0tKU3ZETUNKbG54WktJaWQxOUs2dUZmT01SblZydmJYbk9vV1ZFdm9LcTRo?=
 =?utf-8?B?M0Jwc3k3ZE13NEdWK0xSS0ZRRXNWTUZRcWdjeUM4K3NaT09pZ0tndnd2L2dW?=
 =?utf-8?B?eXNORkFtNE1LS0pEcldZdk1RTDM0N0ZGOFV0eUlmbjE3L2Zjb1Q0c3dhVi9a?=
 =?utf-8?B?VzZXRzRZUCt4UmZTUFN0U0tmeVhsbFY1N25yOVBXY09zcFF1bmc4NmIrWmxr?=
 =?utf-8?B?QnpFMUJMRDdTc0ZtYkdHa1NmVTVGMmxxSTNVSG1uTmlHSG5CRlM3R2htVTVY?=
 =?utf-8?B?NytFYWFWYkJyUFczWEgwL0FVNzFNRXRSNktwM2JwVEtvQkhST3VNZ0dVdng0?=
 =?utf-8?B?bFFVMktFaE1QK3pwWUNUN2plTHJaWGpZenlkam1jSER1N0VpYjhCK0ZaaUI4?=
 =?utf-8?B?eVpHMy9QZ01lemlncGdJS2EyZm4xSTl3QllXRUpuTys2a1JHWm5ValNPeitU?=
 =?utf-8?B?SmFteFBKTFp5bldRQU0rM2xNS3J0eTlRZ3JtV25GcWtJSmtUb3JSSkVUNnBI?=
 =?utf-8?B?MG1XaUxnQkl0RFNLVzdtRjRQR1orZVV3WmJvbzhLdHBMcFl1YktJT25nMWlF?=
 =?utf-8?B?ZGY2RnRvczNGSFpJR29mTnIybEZHMjhkUWlXWmEzU21jRTZNc0pQa3NrT3pS?=
 =?utf-8?B?MzZoMmlOM1cwK1ptZU5LUGZvd016bStaUEM5Q09tbTM2NXFQRUtnVzd2R01T?=
 =?utf-8?B?VmNIQzZTUWI0MDBYc0tHQUNkcFFISEgwZFlLTGRsQkVBMTVNcGNIcTFZRnBt?=
 =?utf-8?B?MlVwNkE2Mjg1NCtSUW5NWVFrODZ2WG9PTmdLelIxTk9pYmlPSkhjS2I2Q3l0?=
 =?utf-8?B?cTJRcU9XM1FlWDJBWXdIRDdNNnNxWHBPcVJRR24zM3pHSTVsQ2M0czFVWlZ3?=
 =?utf-8?B?N1RLTzV3Uk4zVFJHY2dZQXdWM2szeGZvUUJkSFhjYlRmMW5idlRBSytwQ3VZ?=
 =?utf-8?B?RTl5N09BUlNOcTYvUlNLcWlzMFdNWnFEYW5GT3B3OTdQYVYxdEgxQlI1YlJF?=
 =?utf-8?B?S1BVWXdsS1puWVZUc3hTR0Vwbi8zb2FTNW14TmJkbjhnbHlBRE8zTzU0elBm?=
 =?utf-8?B?V1J1a09scEhCNVlTeDlyQnF1bjFORW5iU0M0bmx6NjF2VXFRbW1RWGJPVytS?=
 =?utf-8?B?MDA1UHJOenAreHdiTm5aQjVnc0hnPT0=?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a63f0c9f-e90d-48c7-9836-08d9e717d286
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5481.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2022 13:19:35.3185
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pubTlJyzFyfxmUlWj8Lj//R4Pmpf5+bJpx+01rckmvjAVbTJSBw7lAtpYLiZfL9ufx8iN+lxz1iw2qIJOCRKSGuXrBNr9IgVYuhLiqrYX7w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR10MB4098
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10246 signatures=673430
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 suspectscore=0 malwarescore=0 bulkscore=0 mlxscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202030083
X-Proofpoint-GUID: JT9mdARH8whIPccnqfoqDgTZQIMchXqG
X-Proofpoint-ORIG-GUID: JT9mdARH8whIPccnqfoqDgTZQIMchXqG
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

This version is clearer according to me, and the dimm value can continue 
to be used in the debug messages at the end of the 
f17_addr_mask_to_cs_size function.
Thank you.

Reviewed-by: William Roche <william.roche@oracle.com>

W.


On 02/02/2022 15:43, Yazen Ghannam wrote:
> Introduce a "family flags" bitmask that can be used to indicate any
> special behavior needed on a per-family basis.
>
> Add a flag to indicate a system uses the new register offsets introduced
> with Family 19h Model 10h.
>
> Use this flag to account for register offset changes, a new bitfield
> indicating DDR5 use on a memory controller, and to set the proper number
> of chip select masks.
>
> Rework f17_addr_mask_to_cs_size() to properly handle the change in chip
> select masks. And update code comments to reflect the updated Chip
> Select, DIMM, and Mask relationships.
>
> [uninitiliazed variable warning]
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
> ---
> Link:
> https://lore.kernel.org/r/20211228200615.412999-3-yazen.ghannam@amd.com
>
> v3->v4:
> * Use a single helper function for new register offsets.
> * Fix an uninitialized variable warning.
>
> v2->v3:
> * Adjust variable names to explicitly show what they represent.
> * Update code comment to give more detail on CS/MASK/DIMM layout.
>
> v1->v2:
> * Was patch 4 in v1.
> * Change "has_ddr5" flag to "zn_regs_v2".
> * Drop flag check helper function.
> * Update determine_memory_type() to check bitfield for DDR5.
> * Update code comments.
>
>   drivers/edac/amd64_edac.c | 80 +++++++++++++++++++++++++++++++--------
>   drivers/edac/amd64_edac.h | 14 +++++++
>   2 files changed, 78 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
> index 49e384207ce0..5806fe657373 100644
> --- a/drivers/edac/amd64_edac.c
> +++ b/drivers/edac/amd64_edac.c
> @@ -15,6 +15,21 @@ static struct msr __percpu *msrs;
>   
>   static struct amd64_family_type *fam_type;
>   
> +static inline u32 get_umc_reg(u32 reg)
> +{
> +	if (!fam_type->flags.zn_regs_v2)
> +		return reg;
> +
> +	switch (reg) {
> +	case UMCCH_ADDR_CFG:		return UMCCH_ADDR_CFG_DDR5;
> +	case UMCCH_ADDR_MASK_SEC:	return UMCCH_ADDR_MASK_SEC_DDR5;
> +	case UMCCH_DIMM_CFG:		return UMCCH_DIMM_CFG_DDR5;
> +	}
> +
> +	WARN_ONCE(1, "%s: unknown register 0x%x", __func__, reg);
> +	return 0;
> +}
> +
>   /* Per-node stuff */
>   static struct ecc_settings **ecc_stngs;
>   
> @@ -1429,8 +1444,10 @@ static void __dump_misc_regs_df(struct amd64_pvt *pvt)
>   		edac_dbg(1, "UMC%d x16 DIMMs present: %s\n",
>   				i, (umc->dimm_cfg & BIT(7)) ? "yes" : "no");
>   
> -		if (umc->dram_type == MEM_LRDDR4) {
> -			amd_smn_read(pvt->mc_node_id, umc_base + UMCCH_ADDR_CFG, &tmp);
> +		if (umc->dram_type == MEM_LRDDR4 || umc->dram_type == MEM_LRDDR5) {
> +			amd_smn_read(pvt->mc_node_id,
> +				     umc_base + get_umc_reg(UMCCH_ADDR_CFG),
> +				     &tmp);
>   			edac_dbg(1, "UMC%d LRDIMM %dx rank multiply\n",
>   					i, 1 << ((tmp >> 4) & 0x3));
>   		}
> @@ -1505,7 +1522,7 @@ static void prep_chip_selects(struct amd64_pvt *pvt)
>   
>   		for_each_umc(umc) {
>   			pvt->csels[umc].b_cnt = 4;
> -			pvt->csels[umc].m_cnt = 2;
> +			pvt->csels[umc].m_cnt = fam_type->flags.zn_regs_v2 ? 4 : 2;
>   		}
>   
>   	} else {
> @@ -1545,7 +1562,7 @@ static void read_umc_base_mask(struct amd64_pvt *pvt)
>   		}
>   
>   		umc_mask_reg = get_umc_base(umc) + UMCCH_ADDR_MASK;
> -		umc_mask_reg_sec = get_umc_base(umc) + UMCCH_ADDR_MASK_SEC;
> +		umc_mask_reg_sec = get_umc_base(umc) + get_umc_reg(UMCCH_ADDR_MASK_SEC);
>   
>   		for_each_chip_select_mask(cs, umc, pvt) {
>   			mask = &pvt->csels[umc].csmasks[cs];
> @@ -1623,12 +1640,25 @@ static void _determine_memory_type_df(struct amd64_umc *umc)
>   		return;
>   	}
>   
> -	if (umc->dimm_cfg & BIT(5))
> -		umc->dram_type = MEM_LRDDR4;
> -	else if (umc->dimm_cfg & BIT(4))
> -		umc->dram_type = MEM_RDDR4;
> -	else
> -		umc->dram_type = MEM_DDR4;
> +	/*
> +	 * Check if the system supports the "DDR Type" field in UMC Config
> +	 * and has DDR5 DIMMs in use.
> +	 */
> +	if (fam_type->flags.zn_regs_v2 && ((umc->umc_cfg & GENMASK(2, 0)) == 0x1)) {
> +		if (umc->dimm_cfg & BIT(5))
> +			umc->dram_type = MEM_LRDDR5;
> +		else if (umc->dimm_cfg & BIT(4))
> +			umc->dram_type = MEM_RDDR5;
> +		else
> +			umc->dram_type = MEM_DDR5;
> +	} else {
> +		if (umc->dimm_cfg & BIT(5))
> +			umc->dram_type = MEM_LRDDR4;
> +		else if (umc->dimm_cfg & BIT(4))
> +			umc->dram_type = MEM_RDDR4;
> +		else
> +			umc->dram_type = MEM_DDR4;
> +	}
>   }
>   
>   static void determine_memory_type_df(struct amd64_pvt *pvt)
> @@ -2170,6 +2200,7 @@ static int f17_addr_mask_to_cs_size(struct amd64_pvt *pvt, u8 umc,
>   {
>   	u32 addr_mask_orig, addr_mask_deinterleaved;
>   	u32 msb, weight, num_zero_bits;
> +	int cs_mask_nr = csrow_nr;
>   	int dimm, size = 0;
>   
>   	/* No Chip Selects are enabled. */
> @@ -2185,17 +2216,33 @@ static int f17_addr_mask_to_cs_size(struct amd64_pvt *pvt, u8 umc,
>   		return size;
>   
>   	/*
> -	 * There is one mask per DIMM, and two Chip Selects per DIMM.
> -	 *	CS0 and CS1 -> DIMM0
> -	 *	CS2 and CS3 -> DIMM1
> +	 * Family 17h introduced systems with one mask per DIMM,
> +	 * and two Chip Selects per DIMM.
> +	 *
> +	 *	CS0 and CS1 -> MASK0 / DIMM0
> +	 *	CS2 and CS3 -> MASK1 / DIMM1
> +	 *
> +	 * Family 19h Model 10h introduced systems with one mask per Chip Select,
> +	 * and two Chip Selects per DIMM.
> +	 *
> +	 *	CS0 -> MASK0 -> DIMM0
> +	 *	CS1 -> MASK1 -> DIMM0
> +	 *	CS2 -> MASK2 -> DIMM1
> +	 *	CS3 -> MASK3 -> DIMM1
> +	 *
> +	 * Keep the mask number equal to the Chip Select number for newer systems,
> +	 * and shift the mask number for older systems.
>   	 */
>   	dimm = csrow_nr >> 1;
>   
> +	if (!fam_type->flags.zn_regs_v2)
> +		cs_mask_nr >>= 1;
> +
>   	/* Asymmetric dual-rank DIMM support. */
>   	if ((csrow_nr & 1) && (cs_mode & CS_ODD_SECONDARY))
> -		addr_mask_orig = pvt->csels[umc].csmasks_sec[dimm];
> +		addr_mask_orig = pvt->csels[umc].csmasks_sec[cs_mask_nr];
>   	else
> -		addr_mask_orig = pvt->csels[umc].csmasks[dimm];
> +		addr_mask_orig = pvt->csels[umc].csmasks[cs_mask_nr];
>   
>   	/*
>   	 * The number of zero bits in the mask is equal to the number of bits
> @@ -2951,6 +2998,7 @@ static struct amd64_family_type family_types[] = {
>   		.f0_id = PCI_DEVICE_ID_AMD_19H_M10H_DF_F0,
>   		.f6_id = PCI_DEVICE_ID_AMD_19H_M10H_DF_F6,
>   		.max_mcs = 12,
> +		.flags.zn_regs_v2 = 1,
>   		.ops = {
>   			.early_channel_count	= f17_early_channel_count,
>   			.dbam_to_cs		= f17_addr_mask_to_cs_size,
> @@ -3389,7 +3437,7 @@ static void __read_mc_regs_df(struct amd64_pvt *pvt)
>   		umc_base = get_umc_base(i);
>   		umc = &pvt->umc[i];
>   
> -		amd_smn_read(nid, umc_base + UMCCH_DIMM_CFG, &umc->dimm_cfg);
> +		amd_smn_read(nid, umc_base + get_umc_reg(UMCCH_DIMM_CFG), &umc->dimm_cfg);
>   		amd_smn_read(nid, umc_base + UMCCH_UMC_CFG, &umc->umc_cfg);
>   		amd_smn_read(nid, umc_base + UMCCH_SDP_CTRL, &umc->sdp_ctrl);
>   		amd_smn_read(nid, umc_base + UMCCH_ECC_CTRL, &umc->ecc_ctrl);
> diff --git a/drivers/edac/amd64_edac.h b/drivers/edac/amd64_edac.h
> index 09ad28299c57..6f8147abfa71 100644
> --- a/drivers/edac/amd64_edac.h
> +++ b/drivers/edac/amd64_edac.h
> @@ -273,8 +273,11 @@
>   #define UMCCH_BASE_ADDR_SEC		0x10
>   #define UMCCH_ADDR_MASK			0x20
>   #define UMCCH_ADDR_MASK_SEC		0x28
> +#define UMCCH_ADDR_MASK_SEC_DDR5	0x30
>   #define UMCCH_ADDR_CFG			0x30
> +#define UMCCH_ADDR_CFG_DDR5		0x40
>   #define UMCCH_DIMM_CFG			0x80
> +#define UMCCH_DIMM_CFG_DDR5		0x90
>   #define UMCCH_UMC_CFG			0x100
>   #define UMCCH_SDP_CTRL			0x104
>   #define UMCCH_ECC_CTRL			0x14C
> @@ -483,11 +486,22 @@ struct low_ops {
>   					 unsigned cs_mode, int cs_mask_nr);
>   };
>   
> +struct amd64_family_flags {
> +	/*
> +	 * Indicates that the system supports the new register offsets, etc.
> +	 * first introduced with Family 19h Model 10h.
> +	 */
> +	__u64 zn_regs_v2	: 1,
> +
> +	      __reserved	: 63;
> +};
> +
>   struct amd64_family_type {
>   	const char *ctl_name;
>   	u16 f0_id, f1_id, f2_id, f6_id;
>   	/* Maximum number of memory controllers per die/node. */
>   	u8 max_mcs;
> +	struct amd64_family_flags flags;
>   	struct low_ops ops;
>   };
>   
