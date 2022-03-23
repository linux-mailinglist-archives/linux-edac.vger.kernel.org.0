Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F40D14E5631
	for <lists+linux-edac@lfdr.de>; Wed, 23 Mar 2022 17:18:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245432AbiCWQUW (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 23 Mar 2022 12:20:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238661AbiCWQUP (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 23 Mar 2022 12:20:15 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam07on2066.outbound.protection.outlook.com [40.107.212.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6ACF56236;
        Wed, 23 Mar 2022 09:18:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gmH/krdrU6RN/L118nLYO7OHglyvegpNo4xJ8J3+ZyPGWhZotiwh//5lsDJOChePZ/ZCQKoBJQRJ3HLmJMZTIXAH6IepOHLEPjoSEqWB2mU7YUUh3Bb5lqJlQCG384C1tGKoIV0oEI7t+Q+mn+DTaTMFFyYYzTunwwNqCGt/5wVUrWu+JtAz/+3D+yuC9V2NMvFWUbOZW1tDycVd38a955MeePCDOO72NZTJ+BLCuEdGXgBYGL5ejNWPtef6YQnqV6STSOt5Ptql6hgObFphONn+Y0D5kbkv7EYAtXImS9ijLee5WuKaIC5D3Q4sSw9AVWob5wwH4cQzIsW8X9mbEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9C05vyesuL74cBe+zJcycajKOYe9hd9gNpKNBvsCINU=;
 b=lxFutXKS3hdYaflXr2WI94RveSAXqGSpOibtG7NH1U2vjPVllOjFNyGOvZvgdy8arYSytQ8IYjCZa+ecjO2gNoZn9sJhVJ2w51KBJQqJSlcmAQkwx2jIQlr4u3NLW+k2hul0jq4/Jvrfw18IJ2kylA6eTBld6OCJ29/jGEMTOFefsTb4aJDZqQ7q60GE0hMWtlTA2hKFr7/WrLKdI6KJrTxOhSc58INuHoUxLJOjxdh1m8aufhu5LYELs700penXldFy53o23FBKLRBfIv3bhHekm6Rv7OjubKn4G6B/XJyuFJWXSTUliWrw77HDiBZ0rKAvF7G58rB84wflZq+Qlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9C05vyesuL74cBe+zJcycajKOYe9hd9gNpKNBvsCINU=;
 b=FVxsLgiwnrV0G7fSKFxRZmRcip6B/t9HR2+2KEHMnFYeytrWGU/i4k+qfeAoeWsA9+15FvxZc8nAULQzk3oTVo6FdcukzqNU5RQSarVDhTIgOogXZemu9rEj3FzhDDHYvMnX7F/Z/ERqnQCr07L6YeBBUyRSp+RtytDw10xal4Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5286.namprd12.prod.outlook.com (2603:10b6:208:31d::6)
 by BYAPR12MB2662.namprd12.prod.outlook.com (2603:10b6:a03:61::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.17; Wed, 23 Mar
 2022 16:18:41 +0000
Received: from BL1PR12MB5286.namprd12.prod.outlook.com
 ([fe80::c47b:31f3:4280:8cd]) by BL1PR12MB5286.namprd12.prod.outlook.com
 ([fe80::c47b:31f3:4280:8cd%9]) with mapi id 15.20.5102.017; Wed, 23 Mar 2022
 16:18:40 +0000
Message-ID: <7e96b7e9-55d9-0354-80cb-dd1c6fef618b@amd.com>
Date:   Wed, 23 Mar 2022 21:48:25 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [PATCH 1/1] x86/amd_nb: unexport amd_cache_northbridges()
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        linux-edac@vger.kernel.org, mingo@redhat.com, mchehab@kernel.org,
        airlied@linux.ie, Muralidhara M K <muralimk@amd.com>
References: <20220228161154.54539-1-nchatrad@amd.com>
 <YjDMvYOh8Vizq4xv@zn.tnic> <31759627-1754-8d5d-6d6a-df3010d3e8e0@amd.com>
 <Yjs9X4O3qwamG6ul@zn.tnic>
From:   "Chatradhi, Naveen Krishna" <nchatrad@amd.com>
In-Reply-To: <Yjs9X4O3qwamG6ul@zn.tnic>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BM1PR01CA0078.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:1::18) To BL1PR12MB5286.namprd12.prod.outlook.com
 (2603:10b6:208:31d::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2db2b6e4-dd2b-49e5-c20b-08da0ce8cb0b
X-MS-TrafficTypeDiagnostic: BYAPR12MB2662:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB2662FC7CCE6172452658319DE8189@BYAPR12MB2662.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2GtnpyXqgKb+L7OnLVuf6PBU9FoaoWJKYsod8Y/HidfjAJdvKYg01kursfC810jnnrcLVW0sDBgGGdJWgIFZZABBm0LMpqmbvGalxmxj57I0fc0qgAWPzXhLneSp4FPW3Dh/YHR19HUpWMMfzDVORFA6GAwDzYWfs5luZJ1s8CcOJE+LFpuA0Wc0IWmW3of1g4v5Y3h3uxa7SSb87hRg5Iz+7BIFfDqElOk2sLO7mrsC1ywpvUQ8BXwIBLOa0x5mozwPX6v8A8XXVp7lnyG4mMPS2XRe+nfvG/yUWEYdVW4zNm5xwNI11+ot4IjmsROjg3p4dbZ2LRxERJ4Lvpgfi1q8a/x5x0osmMCEt6fbIzsR6MEde4bDQvxQZ6KpXXKC9tSbhETlC5PQTLFhQFJ8+EepdV6JxVZegWbz/DZaK8tL7HkOTtovdby3Kwj4kUAvGHozCS0hGXx2VI3BTn4s6TRNgVuqQkzYa8qz6lJfFHq3i50Q9iXFNCLb4Mp/jzWdNsFGdyIW0iSiGN6/ZlSnjKWvSofu8hwgMSaIJTuTRPd23R8THfwXRyWgSenaaarL0Z9kyi/mZrJy5UHKeWTS0Zp/bcoEr6xTRUf3bY+fR7zYRVjWFDeO4wtoFFj05QzKvhrLc5s24Qgc5N1CMsVDJyHTIsSfZ8onb/VAON/bm8CNW4N2n9vZam4taGi2g7XU7IebggZGVJh6b6BCtY8ND4oMwMyGbz/sqHK1CuUjHUdUZ0h5l6Jfdl3vwvcn4IdjZmLNhDfS0bfdgJmx/Sy2bWdLqDe6w1CAl8n6N8bj7p3om6Ve8yTLYgurDam516ER5O1tm6Lo/kAFC9u4XQ8MyQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5286.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(508600001)(8676002)(4326008)(66476007)(66556008)(6506007)(53546011)(66946007)(966005)(83380400001)(38100700002)(6916009)(31696002)(6486002)(6666004)(45080400002)(316002)(26005)(6512007)(8936002)(31686004)(2616005)(5660300002)(36756003)(2906002)(186003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZVRzTURJTldiZFJDZS9OQ1FrTFBjZ0dsQldXeENjSFlYdEoramhZYTlQdlZR?=
 =?utf-8?B?UTF6MzVRbGZXT0tKNEdvZHZmdkIwRWkwVTdPTjh2ZjdVVzNoRGpQQmhZUXZX?=
 =?utf-8?B?bkRpZEhDTFpTV3prSkhsOHlDQzNJSkg0OWpHeDhDYUFVOEw4L3NncWdnc1Qr?=
 =?utf-8?B?RmpYNjB2V3ZBUE9mNlNRLzJFaFZidzlsNUtvc0lCdS9nZmt1bWVQMHRvMXNn?=
 =?utf-8?B?czlxZmRHSE5WZEc2N1VRRHB6Vk5pYVdXclh6amR3cTNLUXorNnZUZG9YOEZt?=
 =?utf-8?B?b2lweS9DemxuWXNjS28wRFczVG1hYWJzOWVlYmJCcGlpUndkVmJMdnhsZElN?=
 =?utf-8?B?TUJtd3NoVVhDUWc4d2hDV2JTdFJxb0trejNGZEJHeXZuSHhEZVR3SEJ3T0pr?=
 =?utf-8?B?enAzQTVlQWFnM2NZdTVGU3NvT3RDcklMb3plbWpIaGdYdDM3WmhjYVZWUi8v?=
 =?utf-8?B?c1hJSTRRQlg2OXJ2R2RLUjFPa3VFSjk2THBXR0hvU2YyM3JJWm9icjdHTGJX?=
 =?utf-8?B?MGVCZ3ZSL3owbG9IL0tudWMvQmt1SWdSS2pjcGRSZCtEKzExUW9mVE50YVVj?=
 =?utf-8?B?ZkM5aUplbVNDTE82cWtUeWp1NGo3NThhdlQrYWxqbDhXam1nVmtxR2orYmxs?=
 =?utf-8?B?YUN5TDcvMWVhMXVuMzByMXFCbUkwZlk5a2pLK1RPZ2VpeFhXWG53U0VBSTdV?=
 =?utf-8?B?T2lRZnJtbU5BbHFONWFIVXBDTlZudVZkZzVPSTM0M2p6ZUJoVmxpNERaUXNW?=
 =?utf-8?B?dmtVV3NEWWwxZXZqYnFFWldqK3ZTTEM0ZWpwOG1tb2x6MTYrL29kVDJYRWVq?=
 =?utf-8?B?QWRBSmc4L1Yxell4SGlpazMvME5uZGJ2NXU3YWZGWGVvWEZJWVAwcDlhYnJx?=
 =?utf-8?B?eWZmV1RXekFyaXZWcTRQU3Z3dDkyUy94bnEzQVh1T1RLem1qWVV0SDlJNVBE?=
 =?utf-8?B?VFpwOGJzTk02NjFUTHFWbjdGSEtCeC9abUtaQXF5bXNNU3pESEdZbFJ1S0Zu?=
 =?utf-8?B?VDhEQlJHeStRK0ZDUUZOQlUzM05BN1lGWjVCcTk5aHVZMHlIQ1dWUFdXTnJF?=
 =?utf-8?B?N2NmMzZoaHBhRnV3dGtLYUZibHJUVmZHRy95enlpVXlZWE02TDZKeGE3ZGdR?=
 =?utf-8?B?STJpdWYyM28xMTREYThFdnM1a3dWV2VWMVdOM09OL21qNmpydE15SHZGUGxx?=
 =?utf-8?B?bDhac2RYcm1Vb1UrNGlhay9VamQ0OTIzc2k0YVZlLzRtbm1LdlJkRVY5L3ZE?=
 =?utf-8?B?SUhXRFRvUXpHWVZpbGxMNWZBbFQ4d2NxdmpSK0hIQnNvRDdOMVJ4azFVUUpv?=
 =?utf-8?B?TGNjZ1FBNUpOeEswTitLV0tvTmtETUMwREt1NGc4ZEpFL3BkaG5NTURjVHFM?=
 =?utf-8?B?ZWhjVnlHOUFRNTRtenVSd2FLamtGYkdYMkFoWmo0V2J4YXBtZk9HSW9mVXcx?=
 =?utf-8?B?TjRpQWRMMG4rM1JyVmZkR3pRMTY0MTN6TXl4YkNGc2pDdDRrcUFpWUo0cWFK?=
 =?utf-8?B?T0FSSVBrNTNUN0JpTllDL09GOE1kQXp4V0p0bHk5elRWUDdhdHJLREt6S3RY?=
 =?utf-8?B?c09PSFlvWk5uUEpQdmJqWkxENnJDT2ltOTNqVmQwNHl4ZmJNWUNKMTJ0WXNs?=
 =?utf-8?B?WEVLSWVEUllyUFBMTlp5N2hDUTJhYVR1T1R0a2tzZGdlTE40cTlLVjR0Vm80?=
 =?utf-8?B?NFJScHZVdGF5VWF4N0NWNVZnWFR5bGVoazJhK3hGcTBzcDZIa2p0bGJBMmZk?=
 =?utf-8?B?aDhZclMrZE4wNlg4SzFRcnhieXU2NUNGeVJVQmJNamNmMnZYMnJ6R2N0YnB1?=
 =?utf-8?B?ak05dXVrTmhkeFNUWHVaTmo2clZaTkRuWUxWYXZGa3JSUnFMcU5qZmFmYXhU?=
 =?utf-8?B?VDJMYS9Pa3hzQ2JIZ2xITERINnE0Q0pTRDF3eU8vb01naDBFNG1FMnVOaHNa?=
 =?utf-8?Q?tMq3KKLdTlWquwW8EPW1xJDGiPvgxuJw?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2db2b6e4-dd2b-49e5-c20b-08da0ce8cb0b
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5286.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2022 16:18:40.8196
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tnKX7UCN7qsqRRYaFAyLSRlej4Dj0EFdhZanI2X9vmJAa2oMChIuOkh+9n7kT2TbwimM0ngLrPMID0RUE02zmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2662
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SCC_BODY_URI_ONLY,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org


On 3/23/2022 9:01 PM, Borislav Petkov wrote:
> [CAUTION: External Email]
>
> On Wed, Mar 23, 2022 at 08:54:20PM +0530, Chatradhi, Naveen Krishna wrote:
>> Modules that are using this API comes after the fs_initcall() is called.
> I don't need you to explain this to me - I need you to:
>
> "What I am missing in this commit message is why is it ok to do that?"
>
> I.e., pls explain in the commit message exactly why it is ok to do that
> so that people who read it, will know.
Got it, thanks. I will update the commit message.
>
> Thx.
>
> --
> Regards/Gruss,
>      Boris.
>
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fpeople.kernel.org%2Ftglx%2Fnotes-about-netiquette&amp;data=04%7C01%7CNaveenKrishna.Chatradhi%40amd.com%7Cb0cc43042e1d4b9cdb7208da0ce2419b%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637836463172288920%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=v4zF2o2W33F1rCEg6e0ZZRRqpvxM4BwkvtGSgGSY5cU%3D&amp;reserved=0
