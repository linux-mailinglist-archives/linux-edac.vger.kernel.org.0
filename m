Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F0DC477BB4
	for <lists+linux-edac@lfdr.de>; Thu, 16 Dec 2021 19:44:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233118AbhLPSoW (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 16 Dec 2021 13:44:22 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:36200 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232847AbhLPSoW (ORCPT
        <rfc822;linux-edac@vger.kernel.org>);
        Thu, 16 Dec 2021 13:44:22 -0500
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BGHV9Ra024466;
        Thu, 16 Dec 2021 18:44:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=9lyofT33PglZ8LmwW+clflKDX4p/g40oJCilPyiyelw=;
 b=PtEeFfGhezx/f9aCztZ/jglARp5CMY/VBUUiaZjtWCiU9n8yf1M7KzvFe8AmhaA01VXa
 BLdjV5G8hvcDvl2OQpWknNDZPZqgIaKZ0neQyZZ3vXHd/BFyKJjOxgpng7vA0I9coEN9
 gj/divEYXoRvEjr7p2ZqyOxpK9628fcYKEznFosgdfShslwfW5/1iEQncUtyZYyJIycA
 XHpsFM0eomP7zb6LudNYdX2h1cK05C27Ay6FEJowaHClZ68ffvCfpuabBzpFc8XctTZ6
 fmuXg9fbjJBlnaOZCCcJQrFm6qramXNuAUXX2hwI2aTYyO2GPrAcxVD58kMdRXnCGpZj ow== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cykmckm5w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Dec 2021 18:44:07 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1BGIVpkj004730;
        Thu, 16 Dec 2021 18:44:06 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam08lp2176.outbound.protection.outlook.com [104.47.73.176])
        by userp3020.oracle.com with ESMTP id 3cvneu5rnm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Dec 2021 18:44:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XRBeuVI/d/hT3CMnWc6qVWl460IwmkukbJ3EFSDagS4YkWu1eE03tonw2Ia7fddgvoTVlj6nAxffcnb2J841OF3cFnxZX97LDUzUDMMeArn1w1mRpHfwirmjIGm+pscPRoKDGcj44PDHth7bnKZ7+ZGJl4gGNft49gRm5eWgnful2GuPSY4oiiPl16s2Ut8+gyMxD5liuRjdZBEreXuJOOvyccCFuysG1ksAvzqnL1iv+Zm17j3+ptNkWR87CffEe7CSFvb0Ei6HYZ+W/m/VxKcDFUH3LBZDkfPN+B2SndseWC4w4+i4kmghJAvmOp+jd6yD96J1TLHnADG+3yKtGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9lyofT33PglZ8LmwW+clflKDX4p/g40oJCilPyiyelw=;
 b=oeR59Wa1GnGlNTwNJh3AcbuVLNYw8rwth6wV34+kJfV5TizNSxEKeJ4+QDb2Q7Vlm8R3gWqY270RF6qBs2X6VfjsOQzpCr6udKBxtuyLoOqXYH7HmK7cOL5rbiw/9kJ2bGd4qK0fAmVW2SDu7T8DMXOZmPND3RlqreUOc2pXbZYL65HXQIF91Bi/xMVidIQ5SNwQ+5DfhzkneQbwe9VgQ8RaTMnILiVkfjl9ru2htglXr/ZCroXoBg2O4VB9lsMuBL4699MPrcDa1oFbajUFKFHxeLHXvzcI1RgN94DCh5tocDxSisjI7sGFdQ0LMcSJTF+HrBMNiPNvjjJAaeWqOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9lyofT33PglZ8LmwW+clflKDX4p/g40oJCilPyiyelw=;
 b=thmfepQKTibNUX9ivatPD6d3vW/TLTQYJzyKi4vnI40ceGCBb+ZPW1GjzQmpoo2pTE0zC3J0fkxVtm00bxFLNlzxjSGN2TeNPT70HqvxLJHKtbc2m/DwtkZ83low3vYq/fbNT3JZMKErAT+7FJPHAOxzq2nLz0F6Rlziq2TvhV8=
Received: from PH0PR10MB5481.namprd10.prod.outlook.com (2603:10b6:510:ea::5)
 by PH0PR10MB5467.namprd10.prod.outlook.com (2603:10b6:510:d4::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.14; Thu, 16 Dec
 2021 18:44:03 +0000
Received: from PH0PR10MB5481.namprd10.prod.outlook.com
 ([fe80::18e7:1b9a:a547:38b3]) by PH0PR10MB5481.namprd10.prod.outlook.com
 ([fe80::18e7:1b9a:a547:38b3%7]) with mapi id 15.20.4801.014; Thu, 16 Dec 2021
 18:44:03 +0000
Message-ID: <cd5fb58d-1529-6c05-e49d-ec36f0337483@oracle.com>
Date:   Thu, 16 Dec 2021 19:43:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH v2 2/2] EDAC/amd64: Add new register offset support and
 related changes
Content-Language: en-US
To:     Yazen Ghannam <yazen.ghannam@amd.com>,
        Borislav Petkov <bp@alien8.de>
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        mchehab@kernel.org, tony.luck@intel.com, james.morse@arm.com,
        rric@kernel.org, Smita.KoralahalliChannabasappa@amd.com
References: <20211215155309.2711917-1-yazen.ghannam@amd.com>
 <20211215155309.2711917-3-yazen.ghannam@amd.com>
 <d327bbfe-a3c0-9b26-569d-43e17dba126d@oracle.com> <Ybou1VTJ8oced4Ge@zn.tnic>
 <YbtfcUmWAFDWMG9w@yaz-ubuntu>
From:   William Roche <william.roche@oracle.com>
In-Reply-To: <YbtfcUmWAFDWMG9w@yaz-ubuntu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM4P190CA0021.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:200:56::31) To PH0PR10MB5481.namprd10.prod.outlook.com
 (2603:10b6:510:ea::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 72d141a3-b82e-4233-eeed-08d9c0c407db
X-MS-TrafficTypeDiagnostic: PH0PR10MB5467:EE_
X-Microsoft-Antispam-PRVS: <PH0PR10MB5467AD05CE7DB08BD3A4CBD585779@PH0PR10MB5467.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /KrzXWqZaJ595KtUuiFBRXQXpI+ROPQAJaH0sS3UqlFCy2/ykzz/tHSiaOv7lMCy3tdwsI9P6Qc7wFmn2YQkBLfLVTBh1IJWnAlhB52cuOQjlIv8JFFfLVWKcWGSUiU5qy791aoL9tDvSZlFpls7mKAD8tQb7+zmQ4CEWYUoLHnQesqkKTqjijsSJmoB7q208LF3BkwXiKvFiLaGDCTYQOtC16X2jnfsMTNwr9ZVjbwx1BLvoWovmZtlXP5xgdN1uW79JcFnQCtd+DiD4yhsjoYr76GDkVh9mTg822lx8Ilm//YWMgF7uBDSzIWEwkyaziiT1acbUzqt37tmIRm6eK62+o1eN3v3Qw5qjHSNVqAqSa3Q3hWIp1c30fndZSG9Ydz4GXSJkNHg+z7T4CpLy+0AVg9bzl7YoKtt9T4xhlOAZcAp2XBCsmlVECt55NGUP9j3k3HsrZOZ98caCUB2oBKdwOtfQN+Bz1wwWvd4cMKXDA/4W5IHsCfPgy9oAGJyxi93xOShdy/98xBB4NsdyFnfVmSeyE1RwNh79JABNXVhTZjVZLgMyj48S2W6/ttP0FQEqAMeai14kQmOmzBMpcWrgd9nxZ+voEgVqlZO40lI6GSdqwap4wzh6PuRG0SZtL4ATTWOK9HE/mXvDrcpqu4MP+J/kz8KhHbggsBLdi0ADAy/dsjstrADoNvNtyUg1fT65LkuvAzilLPkLDxLdc3oc8+WWtnLM9oiaYPtRMk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5481.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(508600001)(53546011)(38100700002)(316002)(44832011)(6666004)(6486002)(186003)(8676002)(83380400001)(31686004)(8936002)(2616005)(86362001)(31696002)(5660300002)(6506007)(36756003)(6512007)(4326008)(2906002)(110136005)(66946007)(66476007)(52116002)(66556008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aDJtUlJZbExjQ2FYamJiVjRCRHQ1bzVwWTVrS2w5NFJvZHRtRWxGQldLeUtp?=
 =?utf-8?B?RWROclFVL0RNZzF1RUVDL2xNaFRxSnhYc1RJUk91YUhuWkxLV3ZDbWpBdlZO?=
 =?utf-8?B?Nk1uam56cGJWZXBtZy9yNTEwRlFxSzJJNXRDd2thTHFNQkdpYk41bG8ySjk4?=
 =?utf-8?B?WG4ydmVTb3BqdmNWWGhvNncySWlPVTlCRFhST3ZRdXpJUmNiVFhTdUpnVFhJ?=
 =?utf-8?B?VmZtM04waFJGYlR3Z29tOEVMZUFycXBheHcrWXlqbGFnR1paUUtpeEJSNGUy?=
 =?utf-8?B?Tms4SkZFaDBBWk5zTUlNSzBjL0pkQkhpRFUzRTk2OWVSVFhGdW02T2tXQUFU?=
 =?utf-8?B?dTJZQmxPdlVtcmg2ZFlnZUJoSFd4aTR0Y05qbmVlZE4rdDFLT1ZjNWZNNk45?=
 =?utf-8?B?QXRaOGFHZ1JNUE1YVU9qUU1DTjk0MUliZkFsOVhLMlZTc2RjcS9lT21NT2FW?=
 =?utf-8?B?eVNpZU9ZOXAyOEpvQXRKYjNSbHFjOTBLcm5scll0dXJsaXhHNElPSkxOMjBB?=
 =?utf-8?B?bU9LREVPYUx2bUdkUkVsZStrc1NEWFlKbk11UXNsbTloNnBCWnRIRE9ma1lv?=
 =?utf-8?B?bVIva283RzgxSGI0OG05TXhhcXFqdThHYmY3NXE3emNCYjlabnFnWkc2aC9X?=
 =?utf-8?B?MXpjU3BWcGx5M3E2UGtjRXVwb2FUdFduWFJZL01PM2Q0Z0FaSnBISnQ0WG90?=
 =?utf-8?B?SmZ5K1BzT2RobUpmWno3bE9jREQ3RUg0bFVEcTVvNHBNOUtGMmxuTHZLb2li?=
 =?utf-8?B?NEtQclpPbzc5TGRNTXBoUndIbXM3d2t0WVoxd2VCMVpnL1lTbGFNaHBvTVlL?=
 =?utf-8?B?RnlIWUlON3VjMkVqOUpHN1k2U0dpSjFDMjNOV2U5UXcvcTI3NVNoUWtzSmRZ?=
 =?utf-8?B?M2FnRE54OFgxTzdoazAwTFIwY1VOakhZbXhkeFZXYUhac2FSYXpYcU9GRjhj?=
 =?utf-8?B?VzFNT1VQNmEwMGpJeWdCUUVnZXcwMXNRWWdielJ6ZkJHamRIcEczZlRoMTVD?=
 =?utf-8?B?VHp2OVlZZWVTQzE3NjR6TDRYTFJHSUdyalI5OVd1WkpLVmJ3TTdQc1N4b0ds?=
 =?utf-8?B?VlRPN1JVQTFKcC9UeWlNNnJvMTExUVF1ekZxYlY4MmI2dm00ZFlXTXZEcktF?=
 =?utf-8?B?WGpoTnZScnBLRDZKSHhQbUpBL1drYWxRVk03aXI3NHVjeXEyVXZCaWpyNTRq?=
 =?utf-8?B?SkdVb0wzZWRRQ1BJVlgzenQxQkgvbzBZUVlqaUlDZzlrQlBra2tiaE9Edk9v?=
 =?utf-8?B?VWhMeDJJbGFqRzd1cTRjZWZla0htenVrczVKam55UGRjVzFybEg1UHE3cUVi?=
 =?utf-8?B?QmV5aWJMNWMyeVowc0ZjU3pGZlBqZ1RvKzc3ek9sTzJkc1dsYjJKVDBucU5H?=
 =?utf-8?B?WWlLQ3lDMHpEY0IvZ0xyUDdPdzVReHQ3T1Y5dkRLKyttRkJvUmdITzl1TmZx?=
 =?utf-8?B?bDFMRVRwMmg5YmhTa2Nub1hYVjZHQVdQWUpYYjJZMi91ek1heE9aRDBuTncx?=
 =?utf-8?B?TzNISkJnOEQ2OFlyMDhZYmxsa25XbERnZlNERUxyYkJkK3kzWEo4MjBpUDlw?=
 =?utf-8?B?ZVo3T3IxUU5KdzFiVnA3cDJHY01GLzlXTEVWOVJIQXpPQnl2Z3lIdWgzYlVU?=
 =?utf-8?B?RjlBTTlqVXBnSThiQXVtRnZwMms4U1NONnlxc0hqYkpmUDVNdURBc3BRR05T?=
 =?utf-8?B?VmYyNVRFZmlBM3ZLMys3QUpicDZhSENOLys3TTVsUWpWT3c0c0RUWklZZHZL?=
 =?utf-8?B?L2k4cnd1elRrdTdHR3IxajFQeUdBNVIra0YrcmxYeGZmak1HWlpyWU5tZXN0?=
 =?utf-8?B?aVdSSjlvWjJuK0VqckhRVENRMGVyZ0VsRlRkdi9iNENWcWpldHhuVVRoWThE?=
 =?utf-8?B?aUl5QzFSOUVsdGVtWnhUZVlpNFpYWTArTGJ2ckxkbDhkVThvVmM5SmQzb3VI?=
 =?utf-8?B?eW9zSXNCQkxVWjJpWjkxZ2hMNnVYYldiRUVueW0yMWozbmFScVU1YnBXL2pK?=
 =?utf-8?B?UzdiN2tHS3F5aVlkRW14YmxSbzNCOXZhSW9YTDIrOGV2VURVQWlQODRvTy9Q?=
 =?utf-8?B?T0lESnA1dVpoamVPZFBHQnlXMzBXelczOUF0QjhuaW9hYmI3ZXhBZHc5NGNs?=
 =?utf-8?B?WVh3YjgwVFRiZ2p3aVl4MTAzeHExRmoyb0xRUmRnYVlBaU1UZVVsMlBtT2xN?=
 =?utf-8?B?eXNZQytOYW4xazNUaTNjYklYaEkyemxrdEw2Qzl6eURzL0xvTW1EVHExeFdN?=
 =?utf-8?B?b3ZlRmozQ2RZV2JjUzlxVng0QnBGTXVRM1RLT0Y1VWFQQzlveGYyQytPdHh5?=
 =?utf-8?Q?Q5+K4hr5lPdL7Gg05p?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72d141a3-b82e-4233-eeed-08d9c0c407db
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5481.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2021 18:44:03.0269
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wAm1MuCCwGfe4jNXiP/j4Gjgf9bpuxW7R5miOPPISn/A5H2FrcGSJF1MRZ0Cy9nLyehz7loKVFApegYaq1NgszQPihED67Db2UnZfZCYEW8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5467
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10200 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 malwarescore=0 bulkscore=0 spamscore=0 mlxlogscore=999 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112160104
X-Proofpoint-ORIG-GUID: DzuQoxWIQbjYxToGOAxJHvbsmTglgtY8
X-Proofpoint-GUID: DzuQoxWIQbjYxToGOAxJHvbsmTglgtY8
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On 16/12/2021 16:46, Yazen Ghannam wrote:
> On Wed, Dec 15, 2021 at 07:07:17PM +0100, Borislav Petkov wrote:
>> On Wed, Dec 15, 2021 at 05:32:27PM +0100, William Roche wrote:
>>>> @@ -2174,8 +2215,13 @@ static int f17_addr_mask_to_cs_size(struct amd64_pvt *pvt, u8 umc,
>>>>    	 * There is one mask per DIMM, and two Chip Selects per DIMM.
>>>>    	 *	CS0 and CS1 -> DIMM0
>>>>    	 *	CS2 and CS3 -> DIMM1
>>>> +	 *
>>>> +	 *	Systems with newer register layout have one mask per Chip Select.
>>> Just a question about this comment: Can it be translated into this ?
>>>
>>> +	 * Except on systems with newer register layout where we have one Chip Select per DIMM.
>> Sure, but without the "we":
>>
>> 	...
>> 	* On systems with the newer register layout there is one Chip Select per DIMM.
>> 	*/
>>
> Hi William,
> Thanks for the suggestion, but it's not quite correct.

That's exactly what I wanted to know. Thanks.

>
> There are still two Chip Selects per DIMM module, i.e. the system can support
> dual-rank (2R) DIMMs. Current AMD systems can support upto 2 DIMMs per Unified
> Memory Controller (UMC). There are two "Address Mask" registers in each UMC,
> and each register covers an entire DIMM (and by extension the two Chip Selects
> available for each DIMM).
>
> Future systems will still support upto 2 DIMMs per UMC. However, the register
> space is updated so that there are now four "Address Mask" registers per UMC.
> And each of these registers is now explicitly related to one of the four Chip
> Selects available per UMC.

 From what I understand, future systems would still support the same 
number of dimms per UMC (2), the same number of Chip Select (2 per 
dimm), the only thing that changes is the number of Address Mask 
registers (going from 2 per UMC  to  4 per UMC).

So I'm confused, we deduce 'dimm' from csrow_nr, which would be in fact 
the Chip Select *masks* number (cs_mask_nr from the dbam_to_cs signature 
in struct low_ops), so why are we saying and dimm=csrow_nr in the case 
of the new layout, but dimm = csrow_nr / 2 in the case on the standard 
layout ?

Should we indicate what this 'dimm' value really is ?

Sorry if I'm missing something very obvious here.

Thanks,
William.


> Does this help? I can update the code comments with these details.
>
> Thanks,
> Yazen
