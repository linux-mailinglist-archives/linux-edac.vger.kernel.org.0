Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0DF834B220
	for <lists+linux-edac@lfdr.de>; Fri, 26 Mar 2021 23:25:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229933AbhCZWZK (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 26 Mar 2021 18:25:10 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:36862 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230026AbhCZWY6 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 26 Mar 2021 18:24:58 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12QMFehq012123;
        Fri, 26 Mar 2021 22:24:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=j/19LimzSziWa39pPmU3NKy0bpGY7bw5Rh3kkPAcWr8=;
 b=T87qQ1TEANt07mX6OjSA+ygnRvT1R/Knzy18Ji0/ofTBDVDPvXJNlQ/syXWjUbVswTAl
 PzKolFl4cbGQjSufhvya21VvGBenbGUO2T4iE7eM7J3IASbYZpNMTpF4Hp/A/ahfT3+u
 974gGxL31uciNZ3LksOB+wG3CDVwgg67Pcb2VN5I6QjERrG6sFnTsHRdjm/6zMcv9JlO
 7xxbbkdv4EU/dL/47QVXpcNdtWupz1fu1QqUaD8ZUnylC9HJIj+2nM0kFMrsJHefiAgD
 pPPMWsolbIl9T+LyLLXDx63pfbZcPCgUYr1wnHHjNvF/xzAgixkvDj23bQLVMn5UNon1 Tw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 37h1423gr8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 26 Mar 2021 22:24:54 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12QMKMTZ132264;
        Fri, 26 Mar 2021 22:24:54 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2170.outbound.protection.outlook.com [104.47.58.170])
        by userp3020.oracle.com with ESMTP id 37h14hr32d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 26 Mar 2021 22:24:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PkjJWFzW9VUQfOmrrz7athK9CbQIddZhVv6o/3osgxxYKg2ZacWi7qZQNe1++S6aw003Zu1y86X9Bphw6B7tajZEUQIPN/o5Sop3JlKYQyFDX3WgHqaX89czGE/2EaS4NqfXXIKk8HZeIQHzT4vSvPA2f6WhgenHJCBTa+D2wn+HL2lFg3sPrhjL4iVUrcgqGTzYoNuhI7keWpaQjItl2fzeg5X/mGNKBlCMDzuXrxnV6BNexc6PittpoMuD0JnEChSlyeCGA3ryvupVNFm6QycqF3uOSjWMF5Cnyowlb/6SyiktqHuuu/pLyWsQ+USd4BFpbFJ/SvhjtjASjPOYwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j/19LimzSziWa39pPmU3NKy0bpGY7bw5Rh3kkPAcWr8=;
 b=PBCsHr3I15RHruSEeCdFrOQN1+x1pn8UwNJZJXA0y9aojJ9212EM0GtZ/a+eTOLpzvNJiFBHOhpSeQVgGeBIHeU55rWZgP69yueJkainU6cqi95XhZClJ6SxkrIpk927k8fOacoJq3zQYZ7ra7XU5jVF3eNlKs+eQZb/tWB9QqTTMLTQbU4r/5fKXUx0+jWmc9VHNLmisfVEowoMn7bj9HIZcpAj4aJQNwI3PbuUTr2wu8waATv26TeTRhqkH4yCGkb009vpQnaOHnu3ffitb75U7fZlx7sW6f9IjdoKWTPFlyxTRM/uqZDsN0s3/xmlxqJmjNySsK44WvfOzRRJxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j/19LimzSziWa39pPmU3NKy0bpGY7bw5Rh3kkPAcWr8=;
 b=uN4mr99jpiivDYNYeJilswXGOdOwuyKLwH7PxCy8o4c5FR6fOZ60GwmAmIaRcEnuZlT3wFAFO0k0guIYEG9XyDh0itJN28ZoZBgTbbjSI3UPeC2ays4tG4g8xRv3mlhmlMN60Mdpe3s11SyOYDUljxVsF/eo6Ot2duXcdOHTTsk=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from CY4PR10MB1671.namprd10.prod.outlook.com (2603:10b6:910:8::21)
 by CY4PR1001MB2295.namprd10.prod.outlook.com (2603:10b6:910:40::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.25; Fri, 26 Mar
 2021 22:24:50 +0000
Received: from CY4PR10MB1671.namprd10.prod.outlook.com
 ([fe80::81d2:be2c:efee:1fe6]) by CY4PR10MB1671.namprd10.prod.outlook.com
 ([fe80::81d2:be2c:efee:1fe6%8]) with mapi id 15.20.3955.027; Fri, 26 Mar 2021
 22:24:50 +0000
Subject: Re: [PATCH v1] RAS/CEC: Memory Corrected Errors consistent event
 filtering
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-kernel@vger.kernel.org, Tony Luck <tony.luck@intel.com>,
        linux-edac@vger.kernel.org
References: <1616783429-6793-1-git-send-email-william.roche@oracle.com>
 <20210326190242.GI25229@zn.tnic>
From:   William Roche <william.roche@oracle.com>
Message-ID: <fac89612-e15c-2940-9d6d-70a812dbe99c@oracle.com>
Date:   Fri, 26 Mar 2021 23:24:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
In-Reply-To: <20210326190242.GI25229@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [2a02:6900:8208:1848::11d1]
X-ClientProxiedBy: AM0PR10CA0054.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:150::34) To CY4PR10MB1671.namprd10.prod.outlook.com
 (2603:10b6:910:8::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2606:b400:2b5b:89:8000::68] (2a02:6900:8208:1848::11d1) by AM0PR10CA0054.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:150::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.25 via Frontend Transport; Fri, 26 Mar 2021 22:24:49 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fb040abd-824f-4c92-7c12-08d8f0a5f867
X-MS-TrafficTypeDiagnostic: CY4PR1001MB2295:
X-Microsoft-Antispam-PRVS: <CY4PR1001MB2295C41640A74EFE8E20E50985619@CY4PR1001MB2295.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4fYB0vRkP6NngF/2IhP6tvC4wmadfV06hwmrNg1F0bW/5NXffIB8pUt9xA925Jey4YSAA1gADppQ4Gr7vpZJMwUn3BgVD9Eb3EtqGNI+Nu+N9S9q8qhjVKeIq6SWmO2O2dgQrJ9C5r4g7whOOic3dK8qaRUJJ8VMVB7H80cjx5qzVOUOoBXH86KQ+6wQIVN0dvK0mh/Wxo/c4K/oq0mv8ubIvuHsZU39+9hBcioRyLiKuj6/oGt0OZkLzIzpocEyacnLbrGd0+sMLoqb0rQpOXNAoCfRMl/F6an4UPSBU5q+JHmSbDMJlOKcrgvCn7bYNzuNX11dk3Pno5GT6NkZVqzQfT4hCDYO+4q58x6puHj7gJczykLsZ094QuExy6I1srWQUoRavSe3ZPU84pZDIqCck9HHrJv2fC4lB9g6+I/bKRZekji4/X5mpSWbfV4LkRiSn7UzTVvgGKmw1gys4Pt//gcrjH1L55bBwLgEDRYv6DtIqejQDN6a3KfeaqCtSHONAVX3OYy1kr1MT6ybEmgBe8T066svd7R+bXPM5gGIrxGwmUsxKmKZyMYpEAwuOXRB/FigU4H3xheGaU2T3VwzUCgvsezyUkRTLsRkUZIEaU4dBzxu2SRBRQbxguBX2I1MyqM6ppOK4MQX7pdG3ig8tUtoZDRYZ+RhzKQ+Lvb/H+NjChDYaM35zUqn3x01XeV7TuGfqFOKXervoJr9lPWGrohtHFtgVgieCI/JeVQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR10MB1671.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(136003)(366004)(376002)(39860400002)(346002)(36756003)(38100700001)(6666004)(2906002)(8676002)(5660300002)(66946007)(6916009)(66556008)(186003)(8936002)(4326008)(6486002)(16526019)(66476007)(478600001)(2616005)(53546011)(31686004)(31696002)(44832011)(316002)(86362001)(83380400001)(52116002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?TjBKcEZHNTlQNkxjVTZwVGVhQ2tOZ2tDeWg5UXEyemU5MGttcU5tbkEyOXVR?=
 =?utf-8?B?bUIwK0c5aFlnZmZZYWxaUmpSTFhFamU0SjVIUmtBa3Y2NHpGcWVrZmlEWVZ4?=
 =?utf-8?B?ZFJ3S2hUNWFGNGp5WGtQL2doRlNEQmZDaWdtcVhHZ0FtQ1FyakZQSjYrYzgy?=
 =?utf-8?B?UjVWMjFDQ2FiZHYxcm95YXZLL1FPajBCdkNydDMzQVpUdFcvMU4yN0RkNE5z?=
 =?utf-8?B?MzEwS0ZNWUJKVU9lRXlUeGVCdHNobkVzU1lqcStIU05OMWlvWWdhWnY5dENX?=
 =?utf-8?B?a0xpVzE1Yk1QUm5qTUxLQTVkdHZuS2x4dnQzUnBMTGNUTWlJYmRCY1VOUUJa?=
 =?utf-8?B?ZFJKMVlmaTAxcEFqT1o2bFFUQTNpeDNRYXNxaVpvaUgxeE9SQmE3b3lYQzRo?=
 =?utf-8?B?WSs5V0NlUTdGWEMvcTg4KzMvQnZXQ1RuZUNHZ2UwT0paQ0o2Ykx4c0kydkZm?=
 =?utf-8?B?VFRoY0RzSmVpdysvZDdwVzZpTEQ0blBCUDFWczlua01KVkovS09GNlpSeEd0?=
 =?utf-8?B?NXRPdFdCWFFiQWNBTWk5TXNuUkd4NStZNjk1ajl3UHd2UGZQVlFJbHZxYS9K?=
 =?utf-8?B?VDgwMk5scVhNYzFsL2Vka3hYS1ZkbGtBYkNEVHJ4d0o5dWZaZmlmTXNCQ0Z3?=
 =?utf-8?B?MUxvN29DY2RmRmVZbWNGaTNLYzU3elYyOW5PZWlTbUljVXYrcG4xY0NvUUpJ?=
 =?utf-8?B?VEZVR0VteXJFNlY5UVJiNWs0VnNDZmMyY3lEbE9uTHo1U0h6aWp4dnoyaVZs?=
 =?utf-8?B?ZU45cGVzUUd2Z3ZwQUFYbUFXMWR6VE50VjJFYm0rblozLzhsVzExUytZVXFs?=
 =?utf-8?B?UUt0NW94TUx2UlBEcDloUlVLNS9zUUNKNjA2eVdaWWk2ekxwb2oxcjRMdmhF?=
 =?utf-8?B?c0Q2dm9YM0wvckFVL3lJQUVCSXd0emVFR0xvMC9Mc0puOGRwL1kyM1hIMDNY?=
 =?utf-8?B?b2JuODhnY3ZpcnRENmgvY3FjWjlrVHUzVHp5U2dSSDhIbXMwS2xQYjg5VGoy?=
 =?utf-8?B?QXJIOFVpN2pkY01PL2tjWmtBYzVKMEoxS0x0OEZac2N1TVQzVk91L1kxWWJK?=
 =?utf-8?B?dk1oeWZBNDRaeDBsd3RYRVQ0MTFOczNNMFQrY09WYTlQV25lbWVkQ3J0ci9H?=
 =?utf-8?B?TXVuZkdlbEs0NElhQnhZSURmMmU1Tk5UeGRnNlFkZ1dON2RYSmNTU29pUXVS?=
 =?utf-8?B?MHAvTGNBblV5V2hybUsydFoydEtyUnMyWDVUaDNlQTZITWh6WVRQMTVLN01q?=
 =?utf-8?B?Y2JKREl3U2tPRVdtSllnNEhBNE1uUWF1ZlBCa0FMNDNjeG9aZXpOTTF3SEhj?=
 =?utf-8?B?NCtqVmVNbW1IRDgrd3BjY1NMY0szZWs2RXduT20wajI4bFdGVEIzKzV0eTBG?=
 =?utf-8?B?bUVEa255U294WHAyNUViSHcrNEVVVVlxZXJ3aTdJOGY5RVNTNVZlVVJnUWp4?=
 =?utf-8?B?MnhVUjdrTVN0MmZVS2lSdDFrWDBMbk1PWDFmVjhWNWFHK1dXQ1g4Q3N6NVha?=
 =?utf-8?B?SjVJWTlXWDZPaWtpWjVSektPMXNTZlkwTG56Z0g5OXZPVk5QZUNxRG5YYXJp?=
 =?utf-8?B?NmZVeXdGV1VlSkt4MlB1blFNRGVkNTgvbG56VXFkaU9rRy90anExVExzS21x?=
 =?utf-8?B?L1FRQS9NM0EvbW9Dd01yT2hlNGhZZ3JnU0JjaG5ROVZlclZ1eVlpNXVTYUJZ?=
 =?utf-8?B?bmVJUldHREpjYUpYbzhFcGVSMDN6eWt2ME9zWkhjQWxyR2VDdzhZUDh1M1Nr?=
 =?utf-8?B?QVF1WTdnaUFRNWJ1SFc0THpndjFsb0pncTJWb2lCeHJ0Z0pYYnVVN05HQ3Ir?=
 =?utf-8?B?bmRXNlNOQ25zY01QMDhoQT09?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb040abd-824f-4c92-7c12-08d8f0a5f867
X-MS-Exchange-CrossTenant-AuthSource: CY4PR10MB1671.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2021 22:24:50.2376
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: elPz5Kvy8M+T2iSUWGHjvimTm0lEHYQkUAVEyyrU5QJ78+qgQdWsy8Jx/qbLl45nZTh+H3fxqCxyUfeyVZ6CiEOUE4iyTuDnpqoKe9qxoo0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1001MB2295
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9935 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0 spamscore=0
 phishscore=0 adultscore=0 mlxscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2103250000
 definitions=main-2103260165
X-Proofpoint-GUID: 9L1yPmkvq1DMU9N-QH2LTfw76p3do9ws
X-Proofpoint-ORIG-GUID: 9L1yPmkvq1DMU9N-QH2LTfw76p3do9ws
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9935 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 mlxscore=0
 clxscore=1015 impostorscore=0 spamscore=0 malwarescore=0 adultscore=0
 phishscore=0 suspectscore=0 mlxlogscore=999 lowpriorityscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2103250000
 definitions=main-2103260164
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On 26/03/2021 20:02, Borislav Petkov wrote:
> On Fri, Mar 26, 2021 at 02:30:29PM -0400, “William Roche wrote:
>> From: William Roche <william.roche@oracle.com>
>>
>> The Corrected Error events collected by the cec_add_elem() have to be
>> consistently filtered out.
>> We fix the case where the value of find_elem() to find the slot of a pfn
>> was mistakenly used as the return value of the function.
>> Now the MCE notifiers chain relying on MCE_HANDLED_CEC would only report
>> filtered corrected errors that reached the action threshold.
>>
>> Signed-off-by: William Roche <william.roche@oracle.com>
>> ---
>>
>> Notes:
>>      Some machines are reporting Corrected Errors events without any
>>      information about a PFN Soft-offlining or Invalid pfn (report given by
>>      the EDAC module or the mcelog daemon).
>>      
>>      A research showed that it reflected the first occurrence of a CE error
>>      on the system which should have been filtered by the RAS_CEC component.
>>      We could also notice that if 2 PFNs are impacted by CE errors, the PFN
>>      on the non-zero slot gets its CE errors reported every-time instead of
>>      being filtered out.
>>      
>>      This problem has appeared with the introduction of commit
>>      de0e0624d86ff9fc512dedb297f8978698abf21a where the filtering logic has
>>      been modified.
>>      
>>      Could you please review this small suggested fix ?
>>      
>>      Thanks in advance for any feedback you could have.
>>      William.
>>
>>   drivers/ras/cec.c | 5 ++++-
>>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> AFAIU, I think you want something like the below untested hunk:
> 
> You set it to 0 when it cannot find an element and that "ret = 1" we can
> remove because callers don't care about the offlining threshold - the
> only caller that looks at its retval wants to know whether it added the
> VA successfully to note that it handled the error.
> 
> Makes sense?

What we want is to make cec_add_elem() to return !0 value only
when the given pfn triggered an action, so that its callers should
log the error.

This is what I understand from the code comment :

  * When an element reaches it's max count of action_threshold, we try 
to poison
  * it by assuming that errors triggered action_threshold times in a 
single page
  * are excessive and that page shouldn't be used anymore. 
action_threshold is
  * initialized to COUNT_MASK which is the maximum.
  *
  * That error event entry causes cec_add_elem() to return !0 value and thus
  * signal to its callers to log the error.

This is not what I understand from your the below suggestion, as 
find_elem returns the index of the pfn if found.

What I'm expecting from ras_cec is to "hide" CEs until they reach the 
action threshold where an action is tried against the impacted PFN, and 
it's now the time to log the error with the entire notifiers chain.

Am I missing something ?

> 
> ---
> diff --git a/drivers/ras/cec.c b/drivers/ras/cec.c
> index ddecf25b5dd4..a29994d726d8 100644
> --- a/drivers/ras/cec.c
> +++ b/drivers/ras/cec.c
> @@ -341,6 +341,8 @@ static int cec_add_elem(u64 pfn)
>   
>   		ca->array[to] = pfn << PAGE_SHIFT;
>   		ca->n++;
> +
> +		ret = 0;
>   	}
>   
>   	/* Add/refresh element generation and increment count */
> @@ -363,12 +365,6 @@ static int cec_add_elem(u64 pfn)
>   
>   		del_elem(ca, to);
>   
> -		/*
> -		 * Return a >0 value to callers, to denote that we've reached
> -		 * the offlining threshold.
> -		 */
> -		ret = 1;
> -
>   		goto unlock;
>   	}
> ---
> 
> Thx.


Thanks again for your feedback.
W.
