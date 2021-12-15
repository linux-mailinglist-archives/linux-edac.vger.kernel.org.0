Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05851475D77
	for <lists+linux-edac@lfdr.de>; Wed, 15 Dec 2021 17:33:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231579AbhLOQdF (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 15 Dec 2021 11:33:05 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:19612 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230350AbhLOQdF (ORCPT
        <rfc822;linux-edac@vger.kernel.org>);
        Wed, 15 Dec 2021 11:33:05 -0500
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BFG8KaI019676;
        Wed, 15 Dec 2021 16:32:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=aPT62r5WEdS7ZQDEFSDByiCCWN68QCIb9ZCA2/wbAhM=;
 b=x0gadmdvUZsu9zIB9JRbgDbskyjTQI05UC2eWI7CbTuSP++nJxSmdpi/0jg1+R4VFtM8
 Ex1l8sww3ArZrdbxTlkTjV3bHqZA+LiqyNC3yz/d32enqImviooZxcLkuhqg2MlDt09Q
 Qbx1rj25Gd/v8QogSYQ5FXFjHy2w6E5k5H7mmiposT0LAJlN87GjFVeiRU0ovRlKD5aL
 QRPfq9FVUUn0YjGmVeFnoARA7h5mibr8MN6+VXt3fFDMlkprpAWYpFWOu4goD9FF0oup
 8zRMJmUUVjCgAZF2ePBPAFTsOVHmGX8QxekalazWEBzHmr7H1zInBNvq84KxpNEQZ/Sn Rg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cykmcg2qs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Dec 2021 16:32:40 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1BFGVi1a010015;
        Wed, 15 Dec 2021 16:32:39 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2176.outbound.protection.outlook.com [104.47.55.176])
        by userp3020.oracle.com with ESMTP id 3cvnes5c2k-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Dec 2021 16:32:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EG09cZaYrr9Sm6NJ16EoHJLBtZswVp1Vb0eNdAZeQPY8bu2s6vnxdaRMlVIvdhffJWSwIXwQpxFr5UluY895jRwEXh3qKsQSUYHZr2BNUE8QnlFSTf42RBSBWAnqNTc8e2Cl1vhnsepId5r4GVxldgvPsEBUMwy42D745Q75J4qWd0kl4bTYeASzo7chsaNQB7sAmCSUGsE/R6CSKDgzDZg8/f9Y8vTHYMO1xBzwNjiQtaXqWzqgJiTj5SjZMJcP1j84f3/NYsUCQCdpMZZizhnj7KIuLTkC0XY12hIXrg+z55SpEI0KZkIlZVrLJSUC0e+sU8nVqydhlfFqsf8+rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aPT62r5WEdS7ZQDEFSDByiCCWN68QCIb9ZCA2/wbAhM=;
 b=lCwpEokG2BIWHgLneVfnFDI782TlUf/qcYWSWOVzEziyYb7v+fA9rdP+RpBJXFOjxpVYJlrOXWNiGO+ptxrtxSgo+xeaT9o2sCnbv48Xs9bCymWbF7y/WbpsdYfIqP0STl+7f1A/N90L+MMDaA3KYoyE2wsD7MP5httye9oq/cNkAmtTSPKsiGjkISizIRIwfZAKbfLZOFL/LLe2N4CuNs5tqYYHySPqyCZqSq/W7vH5rVg0Nma6Y+b0WohFpzOouBSnw9MqE+e/Obj2QIl2ROSM5ZWPEebBoWqLUhi2kHkrnUCLQHUDSkh8uQi73Osos07VYB4wn/OrlbQwCRJ2KQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aPT62r5WEdS7ZQDEFSDByiCCWN68QCIb9ZCA2/wbAhM=;
 b=jttvIMcTV6ErAe4Div5yOhr7jepq0Z3AZdQy19QMAd0Tb/9Usb+NcpYvmq88edSaljfZP41zw0AUI7hDs2aoqX8DhccmeNvzouN1C6sb4O1ihphU1ekGmpFUs0FNwfMfZwWoao9bTdE3C7dnJE/+CkxdKiSJTnEfKMFaqG1mbgo=
Received: from PH0PR10MB5481.namprd10.prod.outlook.com (2603:10b6:510:ea::5)
 by PH0PR10MB4503.namprd10.prod.outlook.com (2603:10b6:510:3a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.17; Wed, 15 Dec
 2021 16:32:36 +0000
Received: from PH0PR10MB5481.namprd10.prod.outlook.com
 ([fe80::18e7:1b9a:a547:38b3]) by PH0PR10MB5481.namprd10.prod.outlook.com
 ([fe80::18e7:1b9a:a547:38b3%7]) with mapi id 15.20.4801.014; Wed, 15 Dec 2021
 16:32:36 +0000
Message-ID: <d327bbfe-a3c0-9b26-569d-43e17dba126d@oracle.com>
Date:   Wed, 15 Dec 2021 17:32:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH v2 2/2] EDAC/amd64: Add new register offset support and
 related changes
Content-Language: en-US
To:     Yazen Ghannam <yazen.ghannam@amd.com>, linux-edac@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, bp@alien8.de, mchehab@kernel.org,
        tony.luck@intel.com, james.morse@arm.com, rric@kernel.org,
        Smita.KoralahalliChannabasappa@amd.com
References: <20211215155309.2711917-1-yazen.ghannam@amd.com>
 <20211215155309.2711917-3-yazen.ghannam@amd.com>
From:   William Roche <william.roche@oracle.com>
In-Reply-To: <20211215155309.2711917-3-yazen.ghannam@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0227.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a6::16) To PH0PR10MB5481.namprd10.prod.outlook.com
 (2603:10b6:510:ea::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 846dedce-2cf1-47ee-7b04-08d9bfe880c1
X-MS-TrafficTypeDiagnostic: PH0PR10MB4503:EE_
X-Microsoft-Antispam-PRVS: <PH0PR10MB4503AEBEE877A6F81ED0FCFB85769@PH0PR10MB4503.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RYbOjbIydph/OyxH+F5TjCMNPyqg4pT+/9iAhjgsypd8pneJDcIPijBFxjSr0TP+0k74mOheaXSrDiQl0LLdem8yNR1iBeoxoVLIAm8Tj0fLYv2EqZLyfQ+TPlXhs3zaCfKHWUKDqvsnwZb2+W4/tBEusnfD18J7hN0IniFeM/3pNhib8WAzIINE/gotXfU+1L0R88mr4Ay4imdVt15BvNLX9q/V7NdnU4mXWBkJFvJ1IMb1uNgJwKa8RHA1DOmwsNkKfZXmC7d8yh/I4uCEPehrDakXxZegbAI770WcjgJvbQmJbMx+j51dZdZ8mPCdvoIuWq/ApKHKghewr1O81SuIKKcCPSWONeAzn6ssqFVkEJiB+HV/QU1hFU5736JPIynnV2+6AgH1h4C/qaWFrSxNJcFLgzsEXfFzF/SkmY2nw/rzX71OVPg1bPFlBrdDUQ2p8aGdXwsww8W052Fl1x5RBRbpPEDYbbT4B7m0TwL17zNRKiUIHUDAN5wSNf/AmWCJdUtprHIF3ejGjyI+Rvcya252TQD71vjWEUCQsQ/7wNkV8xomHh+vPtE+aw7ZZn8DXGp6d2ic6i5rJG5hQcM1/lhWaaUp+TvksjSJSyp8d9mma2HF3cyIR4nNNx1cU/+BIjHTAe3yPDQ86muhSyYIY7SgMafT5rJhU/0I/MzGQzz6CDOUXi3Mx4TAzQz6J/46weaoj3QyXQ7iLzBHYhR/16cW+sdgzwri3yhh9VnbtNS85GCRrjdkobCnlE8Bp72ucSkLTvJnwjpfJ/QP535ekc85mTm75x5TFRB3q3Up0oVtKRK09duEDzOxUTYX
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5481.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(4326008)(53546011)(6506007)(6512007)(31696002)(36756003)(8676002)(86362001)(8936002)(52116002)(66476007)(66556008)(66946007)(44832011)(38100700002)(2906002)(6486002)(508600001)(31686004)(83380400001)(966005)(6666004)(316002)(186003)(5660300002)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RXNEQVRxVWwzeHNNOFR2VkJqdkxnSXBIVXh4Z3dmSDVSNkRxUDFHY2M3YTFQ?=
 =?utf-8?B?b3ZXK0NkK1pTaG9GVE5rS0hrL3p2aTZDWlpjTUVkQkR2b0cwTWMzUmwwdG1X?=
 =?utf-8?B?SnBrOXJ3R0RSRXd1c25nZW9tdUFhR2tuckJBVTVBclgzeVgrQVpGTFN5cS8r?=
 =?utf-8?B?NVMzK0dWTmhOZE1Gb0FjMjR2Z0tEMHovNzRyNFoxMjhrTFkyaWtSaEIrN1pT?=
 =?utf-8?B?cXFSTEZIcWorL29GcWxtMkk3K0w4RDV4UW96TVV4bkgyTUlGYlpkZFRlWHlB?=
 =?utf-8?B?S0dxRU1DL09EQkJKcUZHS0FkRzRpT1luK0xZeDdFbElMZWhlMUVMd0ZkeTg1?=
 =?utf-8?B?bzVmbDRjNXN4cE5vRDJpMnpVYUMzMkpqTnNrUmlxaE85VTlVODdPMW5OWnlX?=
 =?utf-8?B?ZDZxaDBzWHVxWnRlQ0pxaWVDdlpFd29qbGtjN09OalF2Y1UxMHMzTWVjTU96?=
 =?utf-8?B?Q29QYWp2d1VVbTV1by9ONlhKWnlIelplQnNjbm5tbDFXbkFmaWVpRHB3N0tC?=
 =?utf-8?B?R2lRb25DSTFLRTlERlJ3cmxFR0FwMFFqRy9GNVJLWVZBTGhDcWpqY0NabitD?=
 =?utf-8?B?OUZtUHFCQ05HdWdFQjZsWndLcVNtYmc1TkdDcnYzL3B5d0FLSVVLaXJoamRw?=
 =?utf-8?B?OUgvRDQwUjJXWFN5YlBlNE5SdWx2ZUJDRFBXZXBBVTZNcGFWSFdZZEM1N3Vy?=
 =?utf-8?B?bnJwdkVZbWxoN1RiN3VRKzBjQ2phRTd1QngrS3M5VG5ESzMzRFh6VUNGa08x?=
 =?utf-8?B?c3U5aERNTTFVZnNnQzRkOENiMDV2WlczZ01ScGphZk1FT1RDdlJlZ2NHNGJk?=
 =?utf-8?B?ajFWRTYxTlRYSTdTcE55S1ZIeXFSNGZiTEpiYUNVaUI4U216b25WOUFhcmh0?=
 =?utf-8?B?bkV4aVVSb0FYVEx0dkdwT1lsd0s0WWtGdlFWdERQWUJBQUpQTmxUTGF3N29C?=
 =?utf-8?B?dTVuWlhpS05kaW9DMElzaWs5RVAwN3MySXN3OUZzL0c3MDdSTHBXNVo4MTV2?=
 =?utf-8?B?NDVBRDBIMmhOTHdsMkV2d2lkQWI0NnBOeE1WaGpJL0hxUHp2VlVuZll6UXNN?=
 =?utf-8?B?NldXTmlyUVF2UC9CRUg3WmwxZ0pQcEJGemwzbzRjUXRZMmRhVzV4OTd1d244?=
 =?utf-8?B?SE9BOTR2QXJVajc3T2RhK2pRbTVkaERRaHFVYlh2ZGh5Vk0zSDVaUWdQRWxT?=
 =?utf-8?B?NndXTFhNMlUrWEFEd0pkWkg3MTh4clBjZDBxRXVGOWp5V0Q3UDB3Y1pET1Rs?=
 =?utf-8?B?Y2FYMVhjRzF6dkdoT1Eva0hiOG1mb0lJL1FUemJxN0pXMGtCVUR5L3pjcjlj?=
 =?utf-8?B?RStpbndFbXhKVG1JTEw0amt2Tm9UcjBPOVZmekdoRDFFUWltSkNudWZzQmFF?=
 =?utf-8?B?SDQwNUpjNyt6ay9IYk5TRWU2ZFF3cFVvcTVXcnZuU2ZkaUVGQzIxcXh0MDdR?=
 =?utf-8?B?SFRxNEFoWUlOT1lkY3Q1RnlUZGxvSnN0S1lzUXZPTllMQkV0clk1aFNhOW9M?=
 =?utf-8?B?WFE1MGxSUzhDYnJzVzJNb25oa3BHVi9KcVVvekJaVE52MTRpRklpMzdHTnk1?=
 =?utf-8?B?Y2ZzdVZjOFhBditrblk2aUZhNTdBVUtuQlR3YTNhUi9halBrYzQvcWJEYW53?=
 =?utf-8?B?ZWIxN3V2N2dSYllFbmM4NHVObEdLcXlnR0hRYTJPZDBhMzVVajR1U29kQWxT?=
 =?utf-8?B?ZmxIcDBaNXkxeXgvK01GTFE5QWNOalNNa3BCYXNobE51M3lTMS9JZE5sa09B?=
 =?utf-8?B?SHJuT1RDSlFBWHR5SHBGTUc0N3JBZ1AzUmdNT0tZOElVbTQ1MlFBYS9uemRh?=
 =?utf-8?B?Mzl2RHdGUHBNVTBaUUVyakJ6MHMwdjFjb0ZjOHY5aXN1MituSWdQanJIRy9O?=
 =?utf-8?B?dGlZd2pPay9lcExyMlkxbnpuQUVvRm5Ia1VobUEyc2NLOFcvcG1CVTgrNnNy?=
 =?utf-8?B?QXQyNjlYQkxwQ2pXMS9NNGl1a0MyRnBDbWlPZjl3VkFocEZqZTZOYjZLM21t?=
 =?utf-8?B?RTRHTEpqb21taFJIOXg5YldHdFpZa3JRUDJUblNkYms3dVhNWHQ3TU9BSi9i?=
 =?utf-8?B?RTM1cjMwc25HVG5SV3M2UDh4ZWlJc0VYWndtd29VOWFHZGw1VTRtTm5RZ1Zi?=
 =?utf-8?B?cCtuL3BxTXc0ajB6VjBSTHJWU3JuUi9EZ2RRMWdvbC9sKzJJUURJT3hIRE53?=
 =?utf-8?B?TG1KY0l4U1ZxSS9kRjNGTjJiZ0JOeWw1MWtPNTFjKzlGRmJIRWNBNkZsblpL?=
 =?utf-8?B?bjlDL0dmVmZIdS9UTzZDSlJ4QVFGb1lLVVpZTENnSFViSjExUWZnT3k1U014?=
 =?utf-8?Q?1w+mjRzjJRiferbv1f?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 846dedce-2cf1-47ee-7b04-08d9bfe880c1
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5481.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2021 16:32:36.5785
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0msH1QVOxktO4wZI24Xw45DR4taerBXAbkq8sce7q5MV8TErYDDMB9xK2YmY6IZKo2iVNC9wRsFB2Vfh2OMtm2zGd6SwY5+6+VhaOn4tZXg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4503
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10199 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 malwarescore=0 bulkscore=0 spamscore=0 mlxlogscore=999 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112150094
X-Proofpoint-ORIG-GUID: h1TtDtsm037X9RcoUHQ9qhuj_PUodf04
X-Proofpoint-GUID: h1TtDtsm037X9RcoUHQ9qhuj_PUodf04
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On 15/12/2021 16:53, Yazen Ghannam wrote:
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
> Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
> ---
> Link:
> https://lkml.kernel.org/r/20211208174356.1997855-5-yazen.ghannam@amd.com
>
> v1->v2:
> * Was patch 4 in v1.
> * Change "has_ddr5" flag to "zn_regs_v2".
> * Drop flag check helper function.
> * Update determine_memory_type() to check bitfield for DDR5.
> * Update code comments.
>
>   drivers/edac/amd64_edac.c | 59 +++++++++++++++++++++++++++++++++++----
>   drivers/edac/amd64_edac.h | 14 ++++++++++
>   2 files changed, 67 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
> index 1df763128483..b7dd87636155 100644
> --- a/drivers/edac/amd64_edac.c
> +++ b/drivers/edac/amd64_edac.c
> @@ -15,6 +15,31 @@ static struct msr __percpu *msrs;
>   
>   static struct amd64_family_type *fam_type;
>   
> +/* Family flag helpers */
> +static inline u64 get_addr_cfg(void)
> +{
> +	if (fam_type->flags.zn_regs_v2)
> +		return UMCCH_ADDR_CFG_DDR5;
> +
> +	return UMCCH_ADDR_CFG;
> +}
> +
> +static inline u64 get_addr_mask_sec(void)
> +{
> +	if (fam_type->flags.zn_regs_v2)
> +		return UMCCH_ADDR_MASK_SEC_DDR5;
> +
> +	return UMCCH_ADDR_MASK_SEC;
> +}
> +
> +static inline u64 get_dimm_cfg(void)
> +{
> +	if (fam_type->flags.zn_regs_v2)
> +		return UMCCH_DIMM_CFG_DDR5;
> +
> +	return UMCCH_DIMM_CFG;
> +}
> +
>   /* Per-node stuff */
>   static struct ecc_settings **ecc_stngs;
>   
> @@ -1429,8 +1454,10 @@ static void __dump_misc_regs_df(struct amd64_pvt *pvt)
>   		edac_dbg(1, "UMC%d x16 DIMMs present: %s\n",
>   				i, (umc->dimm_cfg & BIT(7)) ? "yes" : "no");
>   
> -		if (pvt->dram_type == MEM_LRDDR4) {
> -			amd_smn_read(pvt->mc_node_id, umc_base + UMCCH_ADDR_CFG, &tmp);
> +		if (pvt->dram_type == MEM_LRDDR4 || pvt->dram_type == MEM_LRDDR5) {
> +			amd_smn_read(pvt->mc_node_id,
> +				     umc_base + get_addr_cfg(),
> +				     &tmp);
>   			edac_dbg(1, "UMC%d LRDIMM %dx rank multiply\n",
>   					i, 1 << ((tmp >> 4) & 0x3));
>   		}
> @@ -1505,7 +1532,7 @@ static void prep_chip_selects(struct amd64_pvt *pvt)
>   
>   		for_each_umc(umc) {
>   			pvt->csels[umc].b_cnt = 4;
> -			pvt->csels[umc].m_cnt = 2;
> +			pvt->csels[umc].m_cnt = fam_type->flags.zn_regs_v2 ? 4 : 2;
>   		}
>   
>   	} else {
> @@ -1545,7 +1572,7 @@ static void read_umc_base_mask(struct amd64_pvt *pvt)
>   		}
>   
>   		umc_mask_reg = get_umc_base(umc) + UMCCH_ADDR_MASK;
> -		umc_mask_reg_sec = get_umc_base(umc) + UMCCH_ADDR_MASK_SEC;
> +		umc_mask_reg_sec = get_umc_base(umc) + get_addr_mask_sec();
>   
>   		for_each_chip_select_mask(cs, umc, pvt) {
>   			mask = &pvt->csels[umc].csmasks[cs];
> @@ -1628,6 +1655,20 @@ static void determine_memory_type(struct amd64_pvt *pvt)
>   			dimm_cfg |= pvt->umc[i].dimm_cfg;
>   		}
>   
> +		/*
> +		 * Check if the system supports the "DDR Type" field in UMC Config
> +		 * and has DDR5 DIMMs in use.
> +		 */
> +		if (fam_type->flags.zn_regs_v2 && ((umc_cfg & GENMASK(2, 0)) == 0x1)) {
> +			if (dimm_cfg & BIT(5))
> +				pvt->dram_type = MEM_LRDDR5;
> +			else if (dimm_cfg & BIT(4))
> +				pvt->dram_type = MEM_RDDR5;
> +			else
> +				pvt->dram_type = MEM_DDR5;
> +			return;
> +		}
> +
>   		if (dimm_cfg & BIT(5))
>   			pvt->dram_type = MEM_LRDDR4;
>   		else if (dimm_cfg & BIT(4))
> @@ -2174,8 +2215,13 @@ static int f17_addr_mask_to_cs_size(struct amd64_pvt *pvt, u8 umc,
>   	 * There is one mask per DIMM, and two Chip Selects per DIMM.
>   	 *	CS0 and CS1 -> DIMM0
>   	 *	CS2 and CS3 -> DIMM1
> +	 *
> +	 *	Systems with newer register layout have one mask per Chip Select.

Just a question about this comment: Can it be translated into this ?

+	 * Except on systems with newer register layout where we have one Chip Select per DIMM.

>   	 */
> -	dimm = csrow_nr >> 1;
> +	if (fam_type->flags.zn_regs_v2)
> +		dimm = csrow_nr;
> +	else
> +		dimm = csrow_nr >> 1;
>   
>   	/* Asymmetric dual-rank DIMM support. */
>   	if ((csrow_nr & 1) && (cs_mode & CS_ODD_SECONDARY))
> @@ -2937,6 +2983,7 @@ static struct amd64_family_type family_types[] = {
>   		.f0_id = PCI_DEVICE_ID_AMD_19H_M10H_DF_F0,
>   		.f6_id = PCI_DEVICE_ID_AMD_19H_M10H_DF_F6,
>   		.max_mcs = 12,
> +		.flags.zn_regs_v2 = 1,
>   		.ops = {
>   			.early_channel_count	= f17_early_channel_count,
>   			.dbam_to_cs		= f17_addr_mask_to_cs_size,
> @@ -3365,7 +3412,7 @@ static void __read_mc_regs_df(struct amd64_pvt *pvt)
>   		umc_base = get_umc_base(i);
>   		umc = &pvt->umc[i];
>   
> -		amd_smn_read(nid, umc_base + UMCCH_DIMM_CFG, &umc->dimm_cfg);
> +		amd_smn_read(nid, umc_base + get_dimm_cfg(), &umc->dimm_cfg);
>   		amd_smn_read(nid, umc_base + UMCCH_UMC_CFG, &umc->umc_cfg);
>   		amd_smn_read(nid, umc_base + UMCCH_SDP_CTRL, &umc->sdp_ctrl);
>   		amd_smn_read(nid, umc_base + UMCCH_ECC_CTRL, &umc->ecc_ctrl);
> diff --git a/drivers/edac/amd64_edac.h b/drivers/edac/amd64_edac.h
> index 650cab401e21..39ecb77873db 100644
> --- a/drivers/edac/amd64_edac.h
> +++ b/drivers/edac/amd64_edac.h
> @@ -271,8 +271,11 @@
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
> @@ -477,11 +480,22 @@ struct low_ops {
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
Thanks in advance,

William.


