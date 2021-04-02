Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F4E2352D49
	for <lists+linux-edac@lfdr.de>; Fri,  2 Apr 2021 18:10:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236199AbhDBQBL (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 2 Apr 2021 12:01:11 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:33868 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236096AbhDBQBL (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 2 Apr 2021 12:01:11 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 132FxDCd011983;
        Fri, 2 Apr 2021 16:00:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=cKTtlwKTb6e3bHCC719XV2PxkkAPyNUoNXIxIC3hbEQ=;
 b=vaofoM7sbaekltt19/trLoGIJ1LMmj50FJ4Jzst7BC3ZoIDwdNYMepipZ1LCoEbPC7Nl
 uVkL2R0wAAp8u2cPgqvhFX3LvI7UowauWFYrsYxb8uZS7428MUDTK5QGrhVlhVuPoE4V
 /2n4gi0w33VZbpVL02j6WOfZ5pmB5hpsZZ2Zg0bd+oM/Z6W3gO0eiNmPyTy75wnFrXJK
 qSsyc3DjF9lcRF69Qz6oqhh7K6xCQj9ZWwOjIf3Gs+Q3PHlONXxHKywpNCz3QWgb3RS9
 eiPxp0ETmcBFEKujbkSrDfkIxIJeG71txDrB79jwu1uHv4hRUlBi/aUCmJBVdUMVZQ3R Yg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 37n30scyr1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 02 Apr 2021 16:00:57 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 132G0m99005633;
        Fri, 2 Apr 2021 16:00:57 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2171.outbound.protection.outlook.com [104.47.55.171])
        by userp3020.oracle.com with ESMTP id 37n2pbvta5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 02 Apr 2021 16:00:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=glCAYVmP6TpYdF5ftGCtjHH+lZxakrPPSJ3yiIuC2txVQAsWmEgisygV/C4qrqmCZ9JMlD7IQtGy9Gns81f/ZAd5KEoQeq3KfBXEtnY82l9s2ofKvyvdyKgg+gQrtPyiB4LD3nYFXKs0723SY7sP8im+VNWYL+Z/fNzVj12e7F4GEyrCy5A0kthpK44gBf2+kf0iFKdtvZd5PvX1wIPXjvgeEURULPvchkxSw4gEP8ESAOc4YfX/TrK7csgRB6xfUmK2QP7J7mqlpbvrfB5DW1w1mjUhxTnKGq7liCfF3JsFNzjICBHiVXRKymX28bdss7N2QmOeQD6h153O0p/TfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cKTtlwKTb6e3bHCC719XV2PxkkAPyNUoNXIxIC3hbEQ=;
 b=NcFTTaFzPxXnkOnUUqaKa34bvFA3sW93Q6FSRIIuXcBI+dK9ZqYhOyGIfncIJpAbi+XQHA8DaxnlMxaymf0PTxCS0ElzvpA1dms4u7iqHc7cpsx1ju1WWHfEC84nBFsPqmNIZcy02YXv3erElvImQlOU9ayOHQ/B9EEzb+OKnup7wnTh+/1I+Cez/mK5USfiRws/SVizVJWaVjJu0JlEtnrBnRlfq6Cj2nNcjes+jDsoXPt6Opdsmbm2aMxXyqglxtedsq9saYfeuV3YSAMMnBGA0m3DcnmFIncUolfNlq2/G/9YIOThyXryaWBs7mYu9iyKXRrp3mnOSbcPf1Zz3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cKTtlwKTb6e3bHCC719XV2PxkkAPyNUoNXIxIC3hbEQ=;
 b=pkrfHsrMZIDVUDwUj16/gnjNuKuCtsa0sl1nX+Hhe4r0ECS7R+hqOg3pTDFxEoL1MIk/eZ8dPSN0fYwlpEpmbkCGCcIr4zbzxRBaQxVhBl4ytBLgeYUiWOcpg/xj8bIjo0Yo88dBC7Svc4VzXnVKU9DzM0D6PjJw4yPhLgOeaTo=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from DM5PR10MB1676.namprd10.prod.outlook.com (2603:10b6:4:3::16) by
 DM8PR10MB5416.namprd10.prod.outlook.com (2603:10b6:8:3f::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3999.28; Fri, 2 Apr 2021 16:00:53 +0000
Received: from DM5PR10MB1676.namprd10.prod.outlook.com
 ([fe80::1903:9597:6b24:a24c]) by DM5PR10MB1676.namprd10.prod.outlook.com
 ([fe80::1903:9597:6b24:a24c%9]) with mapi id 15.20.3999.028; Fri, 2 Apr 2021
 16:00:53 +0000
Subject: Re: [PATCH v1] RAS/CEC: Memory Corrected Errors consistent event
 filtering
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-kernel@vger.kernel.org, Tony Luck <tony.luck@intel.com>,
        linux-edac@vger.kernel.org
References: <1616783429-6793-1-git-send-email-william.roche@oracle.com>
 <20210326190242.GI25229@zn.tnic>
 <fac89612-e15c-2940-9d6d-70a812dbe99c@oracle.com>
 <20210326224310.GL25229@zn.tnic>
 <3ee5551c-d311-1939-315f-a4712e3821ff@oracle.com>
 <20210401161237.GC28954@zn.tnic>
From:   William Roche <william.roche@oracle.com>
Message-ID: <5ba128f6-62f3-beb2-9f04-fdebaf411414@oracle.com>
Date:   Fri, 2 Apr 2021 18:00:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
In-Reply-To: <20210401161237.GC28954@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2a02:6900:8208:1848::11d1]
X-ClientProxiedBy: SG2PR02CA0061.apcprd02.prod.outlook.com
 (2603:1096:4:54::25) To DM5PR10MB1676.namprd10.prod.outlook.com
 (2603:10b6:4:3::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2606:b400:2b5b:88:8000::7fd] (2a02:6900:8208:1848::11d1) by SG2PR02CA0061.apcprd02.prod.outlook.com (2603:1096:4:54::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.26 via Frontend Transport; Fri, 2 Apr 2021 16:00:51 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9927ed31-509b-4952-81c4-08d8f5f07e5a
X-MS-TrafficTypeDiagnostic: DM8PR10MB5416:
X-Microsoft-Antispam-PRVS: <DM8PR10MB5416F7CB0CB12A66A41C2C36857A9@DM8PR10MB5416.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +0Tk1/VjnvyekpRTkyOSba3KH9mGubDDTushrAjvsKvkuFpJlvP6Ebvn/BsindSzyrJrKXz5Y8MCAxYa2bE6rhdsoZOVePoeDlu2bO0uRoM/vjT1C4Lacj0vZHwED1JI4YB/PnnGKWvbGh1NP6MWVBkHtladTN7v0I+MN0WP8GHP4l2kddqVDyfwL3uapnglTf0NDCni1fBptqkETnqboqlWZFub/vaOLGCdZ1pbKq09LE0ckW1ORztdGAjYw/yNwxAGSZqTkuRBPA+YFtikM6c40W6KsLWMaskuCJlct5CUYdTf/nYa2My4NIuAh0TwMUOb7jjMCUGDBXCwKbj9Ht/QXDMmpqXwQHGSEPDZPThejXKokpweGq/f/f2OkY+qpFyVPWrgDMzGn7XP5I+cZAbalWwjwvXPXUbGj9l9afBZuH23HNQbWVwaxwq2HWsaGBOHse+4i+XmD87/A8Lm1ZNKkxH3o1NUuCsQkmbX/ckYKXfJm9l03Zcm0m8pt6v896eaWARz/xsYk+DFbrpHSHfEqz6EHtYy2eFpg8Iz2pP2lyI+UQW39yjtwJE/+vlP9+TyZZ659OF9Nbhfv3udKrg081aTGVl7IgT2HyqzYMUzHixrFYBLXDYMTOgh/DFM9wf4DRKWtIE3CXgfnPfO/IPUqZEzqnpKHeV7eTIPQqJcKgeV/W60VuARMxa2wW3YF9ducPyHbUGyg/ppfS+UYeGzcmKFxIrGhpkOAvVe2yQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR10MB1676.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(366004)(346002)(396003)(376002)(39860400002)(6666004)(316002)(186003)(16526019)(478600001)(5660300002)(6486002)(2616005)(36756003)(38100700001)(31686004)(66476007)(31696002)(6916009)(53546011)(8676002)(2906002)(66556008)(8936002)(66946007)(52116002)(44832011)(86362001)(83380400001)(4326008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?OXRpbm5RSlF2MGRMUUQ4MmJ2UUtNcDcrSDRvbFJuWXZXMmltVVRXTkpaU3d6?=
 =?utf-8?B?WldhT04yQ0V6RStpdzdFc2pPY1ZWeFI3UFhJVGhuMkhVajh1blhPaFNlT1VJ?=
 =?utf-8?B?eTdoVmxRWVZ6VzhjOVRSWmlLQjFGRmpMTytaZ2hEWnY2TVJHOE1xTmh4Q0Jj?=
 =?utf-8?B?N2Uzc0JTQU5OSVRHZWFXVUVBbnZLeHRaQUI5WEJ0Q0dib2ljNFVsTk9lMTdU?=
 =?utf-8?B?Q0htd2FOdFlYL2tBMGU5OE1EZC9kTFgzVkF4Zi83WlNWenJjMFNBMmxGcW1G?=
 =?utf-8?B?NXQ5bE1rYWtrQmdsMXhGL0pwZjduK2huRWU2VldQNDNYQytCYmxpWUN0cTQ4?=
 =?utf-8?B?emJQL2cxU2V1ald1ZUhMSU91Znd2cDl1VDlyeTJPN1ltL0NySUJ0L09TZ1BF?=
 =?utf-8?B?dXdyZmt3Q1RIVjVEMmZRczFvMG52dnVreGxOZEZnejZOenZ3ZnNQWktjcjN1?=
 =?utf-8?B?RTZCTHFTNzVhOFl5TngvRmczbzBiN2JVeWZnVjNXNzEyVFB0QS9tWHBlV3NH?=
 =?utf-8?B?d0NVbVJ5V2FWT0ticCtETklSVWtLZVJacFMyMXorWjlnMFQ1YWMxWllNMWFt?=
 =?utf-8?B?Ri8zY0hRSW8zWDRVVzRKSUR0OWRhSGlNRUIvdUl6NGpBRkNqZmlucDRSSmdK?=
 =?utf-8?B?RjRHQ0ZKRnBFQmxOV3FYQWlPQWNjK0VHRWU3OXV3bDVWNGozb1ZWcVE5SGNr?=
 =?utf-8?B?cHYwQ1JHa2d1MmxIeXluSWR1VTcwbmlmZWpucUx2QjJLMDJnMFoyRjdDbjQ5?=
 =?utf-8?B?UkJDcTQwaERjRml3MkhKNkRycHFKeE02eWZPM2hScWlRT05mNlJJMTRPai9s?=
 =?utf-8?B?cmswdkdHSU1KZmF4QjUvcUxEc2JET1BZZ1NGNGpQdzhTODZ5VzhFSGJpRERa?=
 =?utf-8?B?VUc3UDJYNGgwOTZrZjNMZFhVMXcvWk5mdUUxWmg0dUV6NmlKOWhzZHYwWVVz?=
 =?utf-8?B?UVRjQWxIbEdmb2swclUrWkgvbHlvNU8rTmFRNzhSaGF3UUpNZFdvejkzd1Rn?=
 =?utf-8?B?aHpNOHZQckFYRVRNdU55dkJrSlZQcEYwS29aQUVucVo1M0x6RHB0UmZsblN1?=
 =?utf-8?B?QWVTRlY4d3VJcXlpc1NWUWZuOWR4WTVnUlFUT3pHb2RFb0FOd29zS2xEeHpJ?=
 =?utf-8?B?R2RQd2tKSEU1MlBtbmVMTGRtZVpzdzBLZHNqMGR4MnJtdkdRM2pmMDcwOGRr?=
 =?utf-8?B?aTQ3c3RyckRGdjBucWNreDhtWFJoUU55V3BrTGE4ZVZ0NHoweW5HQW1sQ2RL?=
 =?utf-8?B?T2NPUERRdUVVdFoxeEFla1lEU3l3TC9Fb2l6dlhkNjhzV1Q5QUpBc3hpM092?=
 =?utf-8?B?Y2ZKWnZCQjN4YU9xeVRWVGZhTkFpazIzK2F6YnIwejR6d3RjOGk4Q1VYcHVp?=
 =?utf-8?B?SDBlWC9jYnRNNGFuQ1JXU2ZLQmpSRmhheThzcjViNFVrU2MxYmVXOVhMZndM?=
 =?utf-8?B?YVR6eGVWR1Nac21MekloK3A0WnowTWRDVkZheWpNelcrZnp0NjdwUktBcXVj?=
 =?utf-8?B?NW9kOGgrZUtEbFNwUTg2WTVxQ3JRTjBHTGU4emZFZ1Z6UGp1TlIyS0FGTTZn?=
 =?utf-8?B?Z21DV3ZoVThsQzQ1NE1oSnF4RURQYVM4RS9Bem9LZ1dENVhqeXRDNmNXZXl0?=
 =?utf-8?B?b0djUk9ZMUtFaHBmNlZ1ZXJLMkREZWhWRXN0YUhDdGs3eS8zK0RZZURiK2RB?=
 =?utf-8?B?d1NObmpucDNhZzZuNTZNbWVRWmdXbUxjNjZqVytVVjdrazRvdzJkNFRkU1cy?=
 =?utf-8?B?QVMrcXBPUTlXbENxb0p6UXJONXhrUWFSQldWdElUOHMwaWpZblpjK2dZWjdC?=
 =?utf-8?B?eVQ0eXB3eVN2WFUvNjFaUT09?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9927ed31-509b-4952-81c4-08d8f5f07e5a
X-MS-Exchange-CrossTenant-AuthSource: DM5PR10MB1676.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2021 16:00:53.5571
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YHNog8umnN483u29IrT7tDlr8d8kQIKagaFVgeXVpHpRBcMcsvKeKN0HV/HcUNMlPB78mhlIjvUQ7MIgp85s+CCcWCdEzLP8+fccXRPiR6Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR10MB5416
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9942 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 adultscore=0 bulkscore=0 mlxscore=0 spamscore=0 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2103310000 definitions=main-2104020113
X-Proofpoint-GUID: LrxifEXicHtJOAWw7oVd7Q_nlqywnKUH
X-Proofpoint-ORIG-GUID: LrxifEXicHtJOAWw7oVd7Q_nlqywnKUH
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9942 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 impostorscore=0
 bulkscore=0 priorityscore=1501 suspectscore=0 mlxscore=0 spamscore=0
 clxscore=1015 mlxlogscore=999 malwarescore=0 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2103310000
 definitions=main-2104020113
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On 01/04/2021 18:12, Borislav Petkov wrote:
> On Mon, Mar 29, 2021 at 11:44:05AM +0200, William Roche wrote:
>> I totally agree with you, and in order to schedule a replacement, MCEs
>> information (enriched by the notifiers chain) are more meaningful than
>> only PFN values.
> 
> Well, if you want to collect errors and analyze patterns in order to
> detect hw going bad, you're probably better off disabling the CEC
> altogether - either disable it in Kconfig or boot with ras=cec_disable.

Corrected Errors are not the best indicators for a failing DIMM, and I
agree that enabling ras_cec is a good thing to have in production.


> 
>> 1/ Giving back ras_cec a consistent behavior where the first occurrence
>> of a CE doesn't generate an MCE message from the MCE_HANDLED_CEC
>> notifiers, and a consistent behavior between the slot 0 and the other
>> pfn slots.
> 
> If by this you mean the issue with the return value, then sure.
> 
> If you mean something else, you'd have to be more specific.

No I just want to fix the return value.
And I expressed the consequences of this fix.


> 
>> 2/ Give the CE MCE information when the action threshold is reached to
>> help the administrator identify what generated the PFN "Soft-offlining"
>> or "Invalid pfn" message.
>>
>> When ras_cec is enabled it hides most of the CE errors, but when the
>> action threshold is reached all notifiers can generate their indication
>> about the error that appeared too often.
>>
>> An administrator getting too many action threshold CE errors can
>> schedule a replacement based on the indications provided by his EDAC
>> module etc...
> 
> Well, this works probably only in theory.
> 
> First of all, the CEC sees the error first, before the EDAC drivers.
> 
> But, in order to map from the virtual address to the actual DIMM, you
> need the EDAC drivers to have a go at the error. In many cases not even
> the EDAC drivers can give you that mapping because, well, hw/fw does its
> own stuff underneath, predictive fault bla, added value crap, whatever,
> so that we can't even get a "DIMM X on processor Y caused the error."
> 
> I know, your assumption is that if a page gets offlined by the CEC, then
> all the errors' addresses are coming from the same physical DIMM. And
> that is probably correct in most cases but I'm not convinced for all.
> 
> In any case, what we could do - which is pretty easy and cheap - is to
> fix the retval of cec_add_elem() to communicate to the caller that it
> offlined a page and this way tell the notifier chain that the error
> needs to be printed into dmesg with a statement sayin that DIMM Y got
> just one more page offlined.

Let's just fix cec_add_elem() with this patch first.

I would love to have a mechanism indicating what physical DIMM had the
page off-lined but I know, as you said earlier, that "hw/fw does its
own stuff underneath" and that we may not have the right information in
the kernel.


> 
> Over time, if a DIMM is going bad, one should be able to grep dmesg and
> correlate all those offlined pages to DIMMs and then maybe see a pattern
> and eventually schedule a downtime.
> 
> A lot of ifs, I know. :-\
> 

For the moment we will have the CE MCE handled my the MCE_HANDLED_CEC
aware notifiers only when a page is off-lined, like it used to be.

Can we start with that small fix ?
