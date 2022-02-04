Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15A664A9D95
	for <lists+linux-edac@lfdr.de>; Fri,  4 Feb 2022 18:21:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376859AbiBDRVi (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 4 Feb 2022 12:21:38 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:45994 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234250AbiBDRVh (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 4 Feb 2022 12:21:37 -0500
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 214GU9LT012101;
        Fri, 4 Feb 2022 17:21:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=AtqsSWN97AIDCA/sv4mM1B5jxLXF1GcwXs1RYxqpfrE=;
 b=kItzVqXmTOJCg+GcwWBXLACUyLnpU1rovsd2qqA1RNaQQit5Gv3lXSZpo86smZk8xQWY
 jEuGuRsr6+sffG+WZkBEqfG1q+NovKAMWL2zBktnKq1R/yzAsU+UNoDq68Eg/5QGHAQ4
 AARjT3noD7WanrZAVNozMVtlkKZFK4rRunwI8eGcMug1lcKeOt9M1XeNjxz6KpyEmWUH
 bSDggrQA6RaLKepshXcvEAG4YmUtpUl97e5BF4Vy9KOKB1JNjugTpoVMOAYZS6TP7aEZ
 XF+sU6cpJr73a0RWiBUS5QnT7l7KhS365OYFH3RGUFI3e3sVFHUDiXDX59K9OmTsPl2Q Jw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e0hfsu9ap-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 04 Feb 2022 17:21:12 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 214HBnGA106560;
        Fri, 4 Feb 2022 17:21:10 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by userp3020.oracle.com with ESMTP id 3dvy1xn13q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 04 Feb 2022 17:21:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dQArEqWY+duv4nlxEJ+4P42p6coWk8tJ+T7tFxHNKUepfE22/gYjvKUdG9yTiSokivHMf4CQa6uBktvmrdSDYyKUGOeLd/kgkuhdmQDnkv1qql7flxIPtv5eTz6tpzsKDPWDvwvYbYYG5c5/AxLom1ds39eMdSPa/4/EIpS8N6fTBS01LhEl4gaiQC1lF/nl1OQvZYbtg/DlhvSDFgMH+nZAMpgbwgoemGJ8leOTk4V9Z3CCXvwBop0KIGDpShUqs036+b8dEdEZm97rnk8clKApUUk1Wgidvx0rXVzbSq+WPhqr58XbexOklXXirXGoK/wiz/jR0q+0Fak4/RJsBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AtqsSWN97AIDCA/sv4mM1B5jxLXF1GcwXs1RYxqpfrE=;
 b=IfigaBhFpN9ctLW2HIpxigpgH+LM9uWefa1zVQmQWV28+rQV2+xtqh6XU91E19yUDNrDRNWaygpXOyV1UCqiknH8QE9hBI+94v1OJ7C+6HIrb25CUM1NRWWd6Nez/QLgmdE2InriooFujwvjhfiPxfDE+MdUHy8rklJv41XS//1FMRk8+bQKet1gPIGHb0XOXtFgeN2B3XFXgO35RBLONaolPKO/QfgkFzscuOernjtnPz4/416X08uCmGbEr/MOucbSgw7qwgdNsZDr2eyg7ljU0EaDo9MwIzMy4yQY0nQ/g/q/SHaj9LNS/gXXSqGX43zApCfcTyXgD+pa8Kjw5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AtqsSWN97AIDCA/sv4mM1B5jxLXF1GcwXs1RYxqpfrE=;
 b=KbqhX35mtKeS3LPx4yDEaZBPF1J5x5De9lsSN1ug4B6NQMWaUWlsXWjdniR/WeXjJ2R30HYud1nG1+kZ8wmN/ptqQ0sjwOlPwmSxC/YAXgE32l5980mjTr71SIBuzKLth0nJS/Qj5dUrSJZMe+VSbQYJxzOanj5nAR4mVhPxkME=
Received: from PH0PR10MB5481.namprd10.prod.outlook.com (2603:10b6:510:ea::5)
 by CH2PR10MB4342.namprd10.prod.outlook.com (2603:10b6:610:a4::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.11; Fri, 4 Feb
 2022 17:21:03 +0000
Received: from PH0PR10MB5481.namprd10.prod.outlook.com
 ([fe80::b8d1:415b:7f28:6298]) by PH0PR10MB5481.namprd10.prod.outlook.com
 ([fe80::b8d1:415b:7f28:6298%8]) with mapi id 15.20.4951.016; Fri, 4 Feb 2022
 17:21:03 +0000
Message-ID: <aa81c069-2471-34bd-b7e1-f06508ae6104@oracle.com>
Date:   Fri, 4 Feb 2022 18:20:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v4 1/2] EDAC/amd64: Set memory type per DIMM
Content-Language: en-US
To:     Yazen Ghannam <yazen.ghannam@amd.com>
Cc:     Borislav Petkov <bp@alien8.de>, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, mchehab@kernel.org,
        tony.luck@intel.com, james.morse@arm.com, rric@kernel.org,
        Smita.KoralahalliChannabasappa@amd.com
References: <20220202144307.2678405-1-yazen.ghannam@amd.com>
 <20220202144307.2678405-2-yazen.ghannam@amd.com>
 <a42a7696-0150-6d63-953e-adec19e25d02@oracle.com> <YfviHFrzzdapbwDt@zn.tnic>
 <962dc65c-6e52-bf02-5ba5-7e8731442390@oracle.com>
 <Yf1LchOlECslWK2b@yaz-ubuntu>
From:   William Roche <william.roche@oracle.com>
In-Reply-To: <Yf1LchOlECslWK2b@yaz-ubuntu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR02CA0150.eurprd02.prod.outlook.com
 (2603:10a6:20b:28d::17) To PH0PR10MB5481.namprd10.prod.outlook.com
 (2603:10b6:510:ea::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 45463029-06ea-4f41-d71c-08d9e802b821
X-MS-TrafficTypeDiagnostic: CH2PR10MB4342:EE_
X-Microsoft-Antispam-PRVS: <CH2PR10MB4342C9F017C7D00AC945019A85299@CH2PR10MB4342.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2x4s/uPpyQlpbEWt8Ej2874pYARhfKW2ACxJmeeXLQSY0j0ZsDfQJPqaxXvHQarIJPsAL7dFWfw/wdOYMzC0wYO20oaYTugjDEJmfgsyanW+7OmrbuN9KZLNf96qCyX5rGgR/iz4ICxkYwzgycrElpsUvH+VOG8yRv4u2Bi7dT4OoW5tSYlQ4lmrT6WnBvFNRVFxcUh7AUx4wRe5/hXDOHR57eWhcaLOCSm7DbpeRO7KyxP4P7FB1XAl0hwvO3LBdNbybTGFX7pZh5EOrmuv2oQvNXnXpHYyRPwlc3xp/2Sokn/xBYW7XdfJ58Vp6ZhdB59767ypxv/bU70t2KfsqH5Kb2Lnr0KdEbSPlXDkitOCybCTIl12alPVUcFNzJVofh79+A68nr/x930HlF6TvXlJ2rTz6sHOyXlGsrkSD6xllZ2p/zkFXhcrEw+mesoqWiVZyyZPfabNe0agNnKxqsP/YoPuygsN4dAOrTTpthxcpNCAkNol3bpngO0vLfJEgl0H8iRh4ArwSOsHOuq21kdaXJoNsOi/1z78Cyy2GFtD+nzOn5HBkJeEsZYWVXKisSBRyK0MYc3+E6GnHzAfHayjYOekRwsfOL96bTzTtEtmXp/vY/vOoT+FGGEaJOt1MddJTj/pZeoULKhkCKZ/NNn3TFJVvq0QXEEzm38e2NF3uwzGzKm0QCxKljksT0vdv166Y8QbX907ipDOQ2hcGUyjXLy9ATw7fIVV3Tl85ZEpvdAIv0QjP0eFOdif8FTUA/KkT9XnA/LFg5W4qxiS/Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5481.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66556008)(66476007)(4326008)(2906002)(6512007)(8676002)(8936002)(4744005)(66946007)(26005)(186003)(2616005)(36756003)(5660300002)(52116002)(53546011)(6506007)(6666004)(508600001)(31696002)(86362001)(316002)(6916009)(44832011)(6486002)(38350700002)(38100700002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UHJ5Wmw1TXFScHFETGNqOHhwUFhnT0dKeldxTkt4VWUvYUFTQVFSdGRvanVr?=
 =?utf-8?B?L2t2cksxZTVqallFdWcxYUZnOU55OFJGT3lKMDRjVFZyTmg4M2V3aVNBMGN0?=
 =?utf-8?B?SFJYMzF2eHl6QWhqVytMSi9JMXZsRmFXaWtlVitJVXdHSW5TeFJxRG9oM0Fx?=
 =?utf-8?B?MTcyUkxLR1BwZjVIYmRJMDIrazRsSVNiWWJiWEQ0aFRFOWkrLzBvYkt3U1Jo?=
 =?utf-8?B?bHdnSXJCeWoyU3d5Z1JHR2paUmxuUmZNUkdFVGRKMjJ2MjRDeDBrWHczTytI?=
 =?utf-8?B?MWx3SktXR3Z2ekZMdStWWjdoWmJiTjZjNkFHL3hkRWVvNHN1L3lMdzZ6V1c5?=
 =?utf-8?B?YVBhcFg2NzZOOXRONEE3MTVGRXBmUGFMck5MczkwbXhnZlYxY1dlSFV4SHJm?=
 =?utf-8?B?MExIUVBQY2RQZHorRUVabURObU90dUhKR1k1YXFCTzdUaXgrR0gxQ0tKMGVo?=
 =?utf-8?B?b1lVSlNXRWlib2dtMjBVWVViY1JBRHY0RmZGSXo1RVRmcDkxbitGM0FSbS9m?=
 =?utf-8?B?dEppenBFV1lsQXpUeUgxZnlVSitSeTloM2J3NElMQlpwQ2ZndXNvcSt3Z0NL?=
 =?utf-8?B?TzhxdG1hQXVWQU1wSDE4YUhOZ3pUZFIvU0gvWllUTzluc25rejhlRXArRVhp?=
 =?utf-8?B?akx3a2pRY1BKVUZwZmdjV2p2L05EYk02RzVXbGRkYVQxWStGdW51VUFJcXpU?=
 =?utf-8?B?ZkZ2Vkcrc1NTcmJzZU43Q0Z3dEpLN0VHZ0tHR3diUjh1SEZ6aWlJcXlHTytt?=
 =?utf-8?B?TWhMQ0RvQ0tHZ1ZPYjEwb1dKY0pOMlRFeG1hWEFWNjljcVFjWmdhOHNqVkxG?=
 =?utf-8?B?MkhsQnpucDI0anF6OHhISURITkJmZ0JRaGlHTEFkem5NUnNxVnFRbkhvRFVa?=
 =?utf-8?B?blFnVXJDTTZSclk5eWlkSXVENDlORHV2RDEvcCtkd3hMclhEZGVpSTkvYjRG?=
 =?utf-8?B?V29WNFpTdnZrbkJCekg3cmsybFJwMHp3L2x6dVRKTzVVRDhrSDJBK0I0Rytx?=
 =?utf-8?B?WGFmZW9YS2Q1OVUxSzZnbGp2UzNBbzJJb25PczVvMkNTUjFqdmM0cWZBVmdh?=
 =?utf-8?B?eWh5VmtPNXNJRWFGSW9SeWZOS3orR09seVBOMW5YTkp6Q1J1bXNoUERnZGVq?=
 =?utf-8?B?RXMxQ29Oa1Bmd2gvKzVuZlM3T0VZUWJKN0ZrNzdQMVZ5VGJTT3VHUzhGWXZD?=
 =?utf-8?B?ZzNFZjRHTlpXU203YUNWOFdtbGFvKzJDeFJZN0dvMU5kUWlyTnJOUzNhVHkr?=
 =?utf-8?B?bGh0eEtjSTkzcncvL3p5eDkvV3JHWFVHZTF5Nm03TlE0T2pKdnFYRDlNWThB?=
 =?utf-8?B?R1B3bTBmTTJYTHF0b1F2RzlycmRNMXJMelJxQlY5RVkweFVwd0V4QldNSFU2?=
 =?utf-8?B?U0cvbXBEOTlyczBaTWlxOWkrcDVueVJaMzc0SWtLZmQ3WTdCUHh6NkY3YWxG?=
 =?utf-8?B?NUNzWVl6ZUg2MWJqRDEyTHZrSXRENGpwcmZ2bENnYkVoelRJMFk3NWtXVU1L?=
 =?utf-8?B?UTZrVVdlUDBIbW9jaVdPZG5Gb2Vpa2NQaHh0TE5uRVV6NUJoRmowd1Q2KzZ2?=
 =?utf-8?B?YVhFck1Vc0pCZWtGdng4NjNmQ2lselVLTml0ZlhCVlhtM1I5S2JzWk5YYmlt?=
 =?utf-8?B?aDFSSmRSRVlHaGF3NXJVUC9Ja2dGVmg1Y2RrMExERHRKT2JPZjdFVWhsMVJJ?=
 =?utf-8?B?RFBUYzlJWEl3M1BkdE9TZ2VXVkNwMmlIclhhNEFxRFB5dnJkeUFSWjdrVXhG?=
 =?utf-8?B?aTBPWlBYMzRaT3pwT1Vybks4WkVrS0hZVXRybVU2NFlJYzNmU1hyaVdHQlBM?=
 =?utf-8?B?bnFPOVhrRXhqS2gxTnArV0gxMXlnY0VpbFVPRkpxT1BCa1dPczhmTDRFdVJw?=
 =?utf-8?B?T3ZOLzRMU3V0VUZlSkorV2NjTWxhR3VkeVNHK2llZVVzLzJ1Mk00VFRFZUxT?=
 =?utf-8?B?OGJqR0lmR05WWEtzMHFoTGw3aWxLVXJyZy9uWUZ5dDI3N0lrcU5PUURCbXUx?=
 =?utf-8?B?SXFLVHdXTWZuR2NCaEtrZkhCT05KSUhYUE5UUE1vM3d2WFpHMmQ1L2s0UVhm?=
 =?utf-8?B?UWpITy9OaXdjN1BxU2pZNlM0V3BMd1VvWmJscVZrUWhjTGtOOGs2SkZHQU9v?=
 =?utf-8?B?NWd1ZmpHSHc4M2gyWFlSS0pnYWJVclEzNzhEVk5uZS9oM1owLzVHejNqSkQr?=
 =?utf-8?B?aUhFbHZzLzdFMXF2djJIdUh0RXRkT2FTYzhoWWtvTytJazNqN01NOGxKN0Zj?=
 =?utf-8?B?azI0UEl5VHVvdDgzQ3J5T3o3OUFRPT0=?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45463029-06ea-4f41-d71c-08d9e802b821
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5481.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2022 17:21:03.0033
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EhUY6IdKMCse49sPNRqybJu0FF1cK11kdZtSWSpVZ46oge1VzV7BJmCbmEQklWfWoOju+kKH/Sn6j+SrqzPWItijBUgy/VIskF4zBbpu70M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4342
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10248 signatures=673430
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 spamscore=0
 bulkscore=0 adultscore=0 mlxlogscore=939 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202040096
X-Proofpoint-GUID: sTi2gbA44r867PM8BHphhChXvQoDb-l6
X-Proofpoint-ORIG-GUID: sTi2gbA44r867PM8BHphhChXvQoDb-l6
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On 04/02/2022 16:51, Yazen Ghannam wrote:

>
> diff --git a/drivers/edac/amd64_edac.h b/drivers/edac/amd64_edac.h
> index 6f8147abfa71..38e5ad95d010 100644
> --- a/drivers/edac/amd64_edac.h
> +++ b/drivers/edac/amd64_edac.h
> @@ -397,7 +397,12 @@ struct amd64_pvt {
>   	/* place to store error injection parameters prior to issue */
>   	struct error_injection injection;
>   
> -	/* cache the dram_type */
> +	/*
> +	 * cache the dram_type
> +	 *
> +	 * NOTE: Don't use this for Family 17h and later.
> +	 *	 Use dram_type in struct amd64_umc instead.
> +	 */
>   	enum mem_type dram_type;
>   
>   	struct amd64_umc *umc;	/* UMC registers */

It works for me Yazen.
Thanks!

