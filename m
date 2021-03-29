Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BE6834CD46
	for <lists+linux-edac@lfdr.de>; Mon, 29 Mar 2021 11:45:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231883AbhC2Jog (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 29 Mar 2021 05:44:36 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:60186 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231686AbhC2Jo2 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 29 Mar 2021 05:44:28 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12T9iH4l187866;
        Mon, 29 Mar 2021 09:44:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=UFPbjX+PEk29SrjoplwJ2Wy1XGcEvd6Iv4ibj7BYUKQ=;
 b=g+Fhws7Q7vfaF6QZYBIwgqAgh6z6YR5BSjE7ZkPgs4N6dwKXUbcKSkW2xMR44mq8jhTO
 YeZDf/AEiclq71NjEdGrPDnHD0CuQQiJQIL7M4lHUhN3DTgutabfQ2ap7mYnCooXcNlB
 oqsYUh27slWj6+Kro+WoWqVXYD39bNX8XFvruuzRCZ/O6xgDuOO07v3zwisKuwAH0F90
 YKuaH2eHBeVSRbWtb3NmmP4yblmhF/S3j9ky9jLrhL2oGlca+7vnUcwUGfsLoT5MQnEP
 cjOR//cRuO5uQIe5xqxjGjkJ3013FWuLHxcm3dn3uGqNttYGSeicRXFKsSntCnmfcPDG Ng== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 37hwbnax7p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 29 Mar 2021 09:44:17 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12T9PbSn068231;
        Mon, 29 Mar 2021 09:44:13 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2103.outbound.protection.outlook.com [104.47.70.103])
        by userp3030.oracle.com with ESMTP id 37jemvgg7d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 29 Mar 2021 09:44:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iKXiVk56wDHOVr2sgmprC5cH6W33/UQ1oM1Z1wugLxv47RbNLSyf5k+vGY7uJkTj10pRceTQzyAlu76wQvbhZKHkCXGoF6NvcJil7k8SGag6ApkX5JsttGYQzY28jLcjlZJQkLL8hM7RqxL3DbjtRmRan71PqfITLoO5aLOg+MzMWqLr4ACCLLZ+73r7Xr7M5BPjEEbJ8/6eqNI/jaSytdiWUq7MJwKG8OxnBeI0Pm2wIiJIXroeJjngQCFXUwdZO0AKED3OjNp4F78f9uQSV3KEKSTvNSxCaC7zkg14bKI5EUO2q6dufBUbx+51cnnatBJH60qTpy0i1auTxSdi3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UFPbjX+PEk29SrjoplwJ2Wy1XGcEvd6Iv4ibj7BYUKQ=;
 b=nhoCr+ELFhiRyOOSyV78mUoAhjepWswsodf1zaU4Ks2v49WUxO8CfD/bQ46EQ5dUxKeNy1bwDYCK4AztPAA6hkd1vo6piwgibmHM4ajdLA37tpImlN3V8JMtWcJ0Vv/kTxQ9Ihv0/x4ZxnlgPshOOUcMcJYVhLsOptCrYWR+vRuvdEcrWB80D0YPj517lvmy1u2qd+5yIQDq8EwWqUnMPAPqrctTS7JzWSWpKlbNGlEnw/+e6F7YDg4E7clPoyWwyTlj54jX3j2QQCF3PuUq5Pgmi7UkBNWfO/GqTdlHxrlGy9QrojInjy/rvzOilPWDClnWRO0iXxxB2MPt7aJkbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UFPbjX+PEk29SrjoplwJ2Wy1XGcEvd6Iv4ibj7BYUKQ=;
 b=V4H8/aEVLP7pjFHiT/tnZnCW5WwpHtP4nCtTq4Tnz8Z+Rpl0e+qD/JqJcfccnOKEV8PgLmc/6pYzgopWtznjwqHZnmaI8suGwpEjXtJH77qMVk0d/Tm8vi0kTZEzJXu81cgGfpIUaOCHuIx4t/Z96uClrvN4ScO0gGObdBprqFg=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from CY4PR10MB1671.namprd10.prod.outlook.com (2603:10b6:910:8::21)
 by CY4PR10MB1509.namprd10.prod.outlook.com (2603:10b6:903:2e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.24; Mon, 29 Mar
 2021 09:44:11 +0000
Received: from CY4PR10MB1671.namprd10.prod.outlook.com
 ([fe80::89ce:b0b2:e1ee:eab]) by CY4PR10MB1671.namprd10.prod.outlook.com
 ([fe80::89ce:b0b2:e1ee:eab%7]) with mapi id 15.20.3977.032; Mon, 29 Mar 2021
 09:44:11 +0000
Subject: Re: [PATCH v1] RAS/CEC: Memory Corrected Errors consistent event
 filtering
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-kernel@vger.kernel.org, Tony Luck <tony.luck@intel.com>,
        linux-edac@vger.kernel.org
References: <1616783429-6793-1-git-send-email-william.roche@oracle.com>
 <20210326190242.GI25229@zn.tnic>
 <fac89612-e15c-2940-9d6d-70a812dbe99c@oracle.com>
 <20210326224310.GL25229@zn.tnic>
From:   William Roche <william.roche@oracle.com>
Message-ID: <3ee5551c-d311-1939-315f-a4712e3821ff@oracle.com>
Date:   Mon, 29 Mar 2021 11:44:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
In-Reply-To: <20210326224310.GL25229@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2a02:6900:8208:1848::11d1]
X-ClientProxiedBy: AM4P190CA0008.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:200:56::18) To CY4PR10MB1671.namprd10.prod.outlook.com
 (2603:10b6:910:8::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2606:b400:2b5b:89:8000::f3f] (2a02:6900:8208:1848::11d1) by AM4P190CA0008.EURP190.PROD.OUTLOOK.COM (2603:10a6:200:56::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.25 via Frontend Transport; Mon, 29 Mar 2021 09:44:10 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: edd17ac9-33cd-490f-73b2-08d8f29734a3
X-MS-TrafficTypeDiagnostic: CY4PR10MB1509:
X-Microsoft-Antispam-PRVS: <CY4PR10MB1509FAC50A2F0D69462899E0857E9@CY4PR10MB1509.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: t/SsL2wPbiU5RE7ooKca8ZsDSiCAbQl9LMvOy5JqARDWEWxNxwtNJb1rpO1IsoA1pXiGU/AwNHDMraFSRu/b2nCRPLBBL08bJPXxBghi9kAcYzr3ffZG6v6+pkDBiTKbfgSAGnNvkre5lYI74dNrELxUJdi33fCi5Xgj8fh1e8FsElpnvPfUIHk3GhV7HvUhuJnxtRTTCjz2JnQq33WC4GJHWQk7jFBt89y+xQk9+cY+HaQCRkns4auQL6GEUWulnOsbP08QTZ2EysaV2/wUyaSivoqycI/1o+FYfIQeppkI/RCv3IIG9fVOCBKMa7pzOAh9szxK/OJVzDhbr5GMqG+pctfrywYNgeWkr8KGWaJctF80XNXCd+TELLTlL8ovMoDBBENMZBWzPks2x//AF4jbnKpFsnXA1pP3c37Nkmf2+/mnikr9zhWxlLJ8lvylQDJOnzCDl3uRn5ENck4g2AP4Bt8BNUQU6ZBb9YY/9q8JLriPJybRtfnx/VIRZOvelBoGDEok62J97ZLRqfyRne4238AfuEJDYTXtdI1tShmO82ue5UbS591ngS1OuMXy+Pirt0UgNwkyiyiBsTWzc5TWz072iXDRZ6z/+je8vwTWmwBgwlArbht2Vxn1sdjwjQJjl1Sb0WHqZVQq/tFoygLR5vWYs2ImXXtxyQJSmu/LkI+b1JbA6Laj+1HFgIsmu7ccswx4YP1maz/20VpUXJe88Ku3pdlS0Km8OMqn2bU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR10MB1671.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(39860400002)(346002)(396003)(366004)(136003)(6486002)(53546011)(6666004)(16526019)(2616005)(316002)(31696002)(2906002)(66946007)(66556008)(66476007)(4326008)(5660300002)(52116002)(8936002)(44832011)(31686004)(38100700001)(83380400001)(478600001)(86362001)(186003)(6916009)(36756003)(8676002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?aFJHOVFmRXEzbFRzaGl1alQxU2VPY2xBQ1B3dUVvb0FWUGtaYzZtN3Q2WVhV?=
 =?utf-8?B?NkVQRkhRaWliVG9zQ3pPUGRweFlnYkcyc3g2YUtMVTI1aHZXYXVwRnIzeXc0?=
 =?utf-8?B?Skd0aE82OVNBek5udStyc0U5THRxUU5hamJyWmFoRFhFK01VaVV5aFhTL1Vz?=
 =?utf-8?B?dHpCWENQU0tuZWtYQmF5SDlMeWY4bk5zcUxDWHBDZlQvdWFyYmFrQTN1OCsy?=
 =?utf-8?B?T09BUkdkVjNFVGtPcDVWUlZRcVVUd2RPUlA1cXpuRmUvSm1qeU11UGtXdWVE?=
 =?utf-8?B?Y05RZXdmVHIzd1BodEFyQkpFWU5vM09pT20zbkNJTFRDUnA2STIvVW1vMldh?=
 =?utf-8?B?SklVQUI0bUxSRUp5WlFKMjZhNXJPZk1tSG1HVEFNeng0QzlwNnZCMWtRRElS?=
 =?utf-8?B?VlR6NEdvaWFidUh4TktmSEdvWjYzZ3AyT3FXYkIyUzJaUDVHQ0toM2QyZG5k?=
 =?utf-8?B?d2hMOGZxZnRvQVYxa3RydEJTa2F0Yi9WSXBQUE91eFBPcFJjWFUxZk1XRi94?=
 =?utf-8?B?ZDkvYVNIamhJaWdMV2l2U0pyaXhIQWxpa09BbW1uUURWbXEra3loS0NSOThC?=
 =?utf-8?B?aGp0WGRuSlRiWTRFb1ZDNDg5SjFJQkxCekNHVSsyeEh6NTVCMlg3Um5YQVl2?=
 =?utf-8?B?RzRXVUlteGx3c1R6UU15ck5OT0ZnY0dhSWJXajVZMFlpQ20ralhNaXZnNkRJ?=
 =?utf-8?B?Nmpscy9LemhYdno5dmNGbDBQRklveVp5andrZzVEOTJmaFVZR253ei9uQ3Jh?=
 =?utf-8?B?b0c5UGV5SCsrZFRoaFBWZXlKZXg5cVBsM2FBRkh6b0o3TnZNNjQ3aHFTRnhP?=
 =?utf-8?B?d1NXNWxvcW5mRDZBZ2tjeXhTbDhjYVlXMU0vcXdISTZMNnRIRVlSZmE3aWp5?=
 =?utf-8?B?bHd1NkdaWmxJbUI4ckF0V2ZlWnlqTmlaeVlMV3UxRlhWVzFwRmF3N0I1WndQ?=
 =?utf-8?B?N2t5eTlkajM2TEhLWjdYSmVKMjdVSmNJQ0U0bFB4UUdtbUhabnEvQjhLWXcv?=
 =?utf-8?B?b2xrQlQ5TFlLWS80NTNpbEduRXE1ak1NS3V3Z3BkNThlWlE2UWVOSENSaGgv?=
 =?utf-8?B?SlRzY09uTTZSOEhXcUllN0k1em1jRGVoQUtmWDVGeG9NUDRIelJIK3pEcW9v?=
 =?utf-8?B?NHhjNVJPQ2svWXdoMFB2TEduZDhMZTQ2dUdCREpRMi91QWR0L1Q2dFpwcW4v?=
 =?utf-8?B?ejFJNTBERHl2MlV1ellGVmtHQlVOWnFtV21ERDhqVjBNODlGVG53dVRRUi9E?=
 =?utf-8?B?YWlwTXFib3N1ZjVLWjd1STZYb3ZRVm5mMVdURTcwNnRqVlZrdXpRNmtPYjlx?=
 =?utf-8?B?UTg1dzd0c0NLZ2lFeGRXNnl4QjR2dHYxcHF1Z1BPTWloU0RlRlpIUUFQNnBX?=
 =?utf-8?B?czc5MEpBaUxRSVpNczhORkFXQTZFbXAyemRnekp4UGpjbzgveFQyZkVYb1VH?=
 =?utf-8?B?MnU0QzlrUVY0bTdWcnNnVFZiRytBYjVrQ1RmQm1BUi9jQ043TnR3dVBDZXY1?=
 =?utf-8?B?VmhuREZlRW9lazFNZkpoelV1aExEOVNrRWNCbm5rNjN6QU1TYjNsT0Q1bjBq?=
 =?utf-8?B?VHhrN0NwdUpUbGZkS29TRnNJT1laemZqS3hCUU1KbEkrWUd2RmtNR2Z5dWxL?=
 =?utf-8?B?VXM1aTNNNHlDZWlRZmtCR2Vxb0RGYlJwQklPWHgzbW9KckhmRWNlc2czdkty?=
 =?utf-8?B?emxLN1VzdEtsV28rTDFCWWMrWCtDS3dteFJ4NFhZcE56UjA5bTUvTDY1c3Jo?=
 =?utf-8?B?WDRVUS9zeFBHZFY4dVplK292STVzQzJiOGk1V3VKNG5waHNXaldNV0RWeHd6?=
 =?utf-8?B?a2V6N0gzMmw5RlVnUG5pdz09?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: edd17ac9-33cd-490f-73b2-08d8f29734a3
X-MS-Exchange-CrossTenant-AuthSource: CY4PR10MB1671.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2021 09:44:11.1855
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IcBA6gyasD1cN07Ehyr8bvPUdIkp1tRnm/aDUJURzyw7D74cRK8uENfd2fKaXt4OBomGXCtP0j/f0NC1zGEPTMVMCezf0nFAF813//T/Y8I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB1509
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9937 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 spamscore=0
 suspectscore=0 adultscore=0 phishscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2103250000
 definitions=main-2103290073
X-Proofpoint-GUID: sWUrpibD98huD8iIWyt1WoMvH7iCEvE2
X-Proofpoint-ORIG-GUID: sWUrpibD98huD8iIWyt1WoMvH7iCEvE2
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9937 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 clxscore=1015
 phishscore=0 mlxscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0
 spamscore=0 bulkscore=0 priorityscore=1501 adultscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2103250000
 definitions=main-2103290074
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On 26/03/2021 23:43, Borislav Petkov wrote:
> On Fri, Mar 26, 2021 at 11:24:43PM +0100, William Roche wrote:
>> What we want is to make cec_add_elem() to return !0 value only
>> when the given pfn triggered an action, so that its callers should
>> log the error.
> 
> No, this is not what the CEC does - it collects those errors and when it
> reaches the threshold for any pfn, it offlines the corresponding page. I
> know, the comment above talks about:
> 
>    * That error event entry causes cec_add_elem() to return !0 value and thus
>    * signal to its callers to log the error.
> 
> but it doesn't do that. Frankly, I don't see the point of logging the
> error - it already says
> 
> 	pr_err("Soft-offlining pfn: 0x%llx\n", pfn);
> 
> which pfn it has offlined. And that is probably only mildly interesting
> to people - so what, 4K got offlined, servers have so much memory
> nowadays.
> 
> The only moment one should start worrying is if one gets those pretty
> often but then you're probably better off simply scheduling maintenance
> and replacing the faulty DIMM - problem solved.

I totally agree with you, and in order to schedule a replacement, MCEs
information (enriched by the notifiers chain) are more meaningful than
only PFN values.

> 
>> What I'm expecting from ras_cec is to "hide" CEs until they reach the
>> action threshold where an action is tried against the impacted PFN,
> 
> That it does.
> 
>> and it's now the time to log the error with the entire notifiers
>> chain.
> 
> And I'm not sure why we'd want to do that. It simply offlines the page.
> 
> But maybe you could explain what you're trying to achieve...

My little fix proposition as 2 goals:

1/ Giving back ras_cec a consistent behavior where the first occurrence
of a CE doesn't generate an MCE message from the MCE_HANDLED_CEC
notifiers, and a consistent behavior between the slot 0 and the other
pfn slots.

2/ Give the CE MCE information when the action threshold is reached to
help the administrator identify what generated the PFN "Soft-offlining"
or "Invalid pfn" message.

When ras_cec is enabled it hides most of the CE errors, but when the
action threshold is reached all notifiers can generate their indication
about the error that appeared too often.

An administrator getting too many action threshold CE errors can
schedule a replacement based on the indications provided by his EDAC
module etc...

> 
> Thx.
> 

I think it could be more useful this way than systematically hiding all CEs.

But this decision is yours :)

HTH.
